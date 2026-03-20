#include <FprimeZephyrReference/ReferenceDeployment/Top/ZephyrKmallocAllocator.hpp>

#include <zephyr/kernel.h>

namespace ReferenceDeployment {

bool ZephyrKmallocAllocator::isPowerOfTwo(const FwSizeType value) {
    return (value != 0U) && ((value & (value - 1U)) == 0U);
}

FwSizeType ZephyrKmallocAllocator::normalizeAlignment(FwSizeType alignment) {
    const auto pointerAlignment = static_cast<FwSizeType>(sizeof(void*));
    if (alignment < pointerAlignment) {
        return pointerAlignment;
    }
    return alignment;
}

void* ZephyrKmallocAllocator::allocate(const FwEnumStoreType identifier,
                                       FwSizeType& size,
                                       bool& recoverable,
                                       FwSizeType alignment) {
    static_cast<void>(identifier);

    recoverable = false;
    if (size == 0U) {
        return nullptr;
    }

    alignment = normalizeAlignment(alignment);
    if (!isPowerOfTwo(alignment)) {
        return nullptr;
    }

    if (alignment <= static_cast<FwSizeType>(sizeof(void*))) {
        return k_malloc(size);
    }

    return k_aligned_alloc(alignment, size);
}

void ZephyrKmallocAllocator::deallocate(const FwEnumStoreType identifier, void* ptr) {
    static_cast<void>(identifier);
    k_free(ptr);
}

}  // namespace ReferenceDeployment
