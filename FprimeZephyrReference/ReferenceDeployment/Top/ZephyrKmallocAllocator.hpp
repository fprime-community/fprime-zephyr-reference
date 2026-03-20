#ifndef REFERENCEDEPLOYMENT_ZEPHYRKMALLOCALLOCATOR_HPP
#define REFERENCEDEPLOYMENT_ZEPHYRKMALLOCALLOCATOR_HPP

#include <Fw/Types/MemAllocator.hpp>

#include <cstddef>

namespace ReferenceDeployment {

class ZephyrKmallocAllocator final : public Fw::MemAllocator {
  public:
    ZephyrKmallocAllocator() = default;
    ~ZephyrKmallocAllocator() override = default;

    void* allocate(FwEnumStoreType identifier,
                   FwSizeType& size,
                   bool& recoverable,
                   FwSizeType alignment = alignof(std::max_align_t)) override;

    void deallocate(FwEnumStoreType identifier, void* ptr) override;

  private:
    static bool isPowerOfTwo(FwSizeType value);
    static FwSizeType normalizeAlignment(FwSizeType alignment);
};

}  // namespace ReferenceDeployment

#endif
