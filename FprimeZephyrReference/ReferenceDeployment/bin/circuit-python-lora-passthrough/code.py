"""
CircuitPython Feather RP2350 LoRa Radio forwarder

This code will forward any received LoRa packets to the serial console (sys.stdout). It cycles through neo pixel colors
to indicate packet reception.
"""
import time
import board
import digitalio
import neopixel
import adafruit_rfm9x
import usb_cdc

# Set up NeoPixel.
pixel = neopixel.NeoPixel(board.NEOPIXEL, 1)
pixel.brightness = 0.5
color_values = [
    (255, 0, 0),
    (0, 255, 0),
    (0, 0, 255),
]

# Radio constants
RADIO_FREQ_MHZ = 915.0
CS = digitalio.DigitalInOut(board.D9)
RESET = digitalio.DigitalInOut(board.D6)

rfm95 = adafruit_rfm9x.RFM9x(board.SPI(), CS, RESET, RADIO_FREQ_MHZ)
rfm95.spreading_factor = 8
rfm95.signal_bandwidth = 125000
rfm95.coding_rate = 5
rfm95.preamble_length = 8
color_index = 0
time_start = time.time()
packet_count = 0
print("[INFO] LoRa Receiver receiving packets")
while True:
    # Look for a new packet - wait up to 5 seconds:
    packet = rfm95.receive(timeout=5.0)
    # If no packet was received during the timeout then None is returned.
    if packet is not None:
        usb_cdc.data.write(packet)
        pixel.fill(color_values[color_index])
        color_index = (color_index + 1) % len(color_values)
        packet_count += 1
    time_delta = time.time() - time_start
    if time_delta > 10:
        print(f"[INFO] Packets received: {packet_count}")
        time_start = time.time()
    rfm95.send(b"Hi from ground!")