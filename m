From: yi.zhang@redhat.com (Yi Zhang)
Date: Mon, 20 Nov 2017 01:36:06 -0500 (EST)
Subject: IO error observed with dd operation on NVMe Protection Information
 enabled Type 1/2/3
In-Reply-To: <1784269489.28561099.1511158307451.JavaMail.zimbra@redhat.com>
Message-ID: <691751929.28564157.1511159766589.JavaMail.zimbra@redhat.com>

Hi

After enable Protection Information Type1/2/3 on NVMe SSD, I found some IO error with dd operation, is this reasonable? thanks.

+ nvme format /dev/nvme0n1 --lbaf=1 --pil=0 --ms=0 --pi=0
Success formatting namespace:1
+ dd if=/dev/urandom of=/dev/nvme0n1 bs=2M oflag=direct count=4096
4096+0 records in
4096+0 records out
8589934592 bytes (8.6 GB) copied, 42.8494 s, 200 MB/s
+ dmesg -c
+ nvme format /dev/nvme0n1 --lbaf=1 --pil=0 --ms=0 --pi=1
Success formatting namespace:1
+ dd if=/dev/urandom of=/dev/nvme0n1 bs=2M oflag=direct count=4096
4096+0 records in
4096+0 records out
8589934592 bytes (8.6 GB) copied, 42.8563 s, 200 MB/s
+ dmesg -c
[ 1439.628577] print_req_error: I/O error, dev nvme0n1, sector 3125627392
[ 1439.635985] print_req_error: I/O error, dev nvme0n1, sector 3125627392
[ 1439.643268] Buffer I/O error on dev nvme0n1, logical block 390703424, async page read
+ nvme format /dev/nvme0n1 --lbaf=1 --pil=0 --ms=0 --pi=2
Success formatting namespace:1
+ dd if=/dev/urandom of=/dev/nvme0n1 bs=2M oflag=direct count=4096
4096+0 records in
4096+0 records out
8589934592 bytes (8.6 GB) copied, 42.8543 s, 200 MB/s
+ dmesg -c
[ 1486.007426] print_req_error: I/O error, dev nvme0n1, sector 3125627392
[ 1486.014842] print_req_error: I/O error, dev nvme0n1, sector 3125627392
[ 1486.022126] Buffer I/O error on dev nvme0n1, logical block 390703424, async page read
+ nvme format /dev/nvme0n1 --lbaf=1 --pil=0 --ms=0 --pi=3
Success formatting namespace:1
+ dd if=/dev/urandom of=/dev/nvme0n1 bs=2M oflag=direct count=4096
4096+0 records in
4096+0 records out
8589934592 bytes (8.6 GB) copied, 42.8545 s, 200 MB/s
+ dmesg -c
[ 1532.401531] print_req_error: I/O error, dev nvme0n1, sector 3125627392
[ 1532.408923] print_req_error: I/O error, dev nvme0n1, sector 3125627392
[ 1532.416198] Buffer I/O error on dev nvme0n1, logical block 390703424, async page read
+ nvme format /dev/nvme0n1 --lbaf=1 --pil=0 --ms=0 --pi=2
Success formatting namespace:1
+ dd if=/dev/urandom of=/dev/nvme0n1 bs=2M oflag=direct count=4096
4096+0 records in
4096+0 records out
8589934592 bytes (8.6 GB) copied, 42.8553 s, 200 MB/s
+ dmesg -c
[ 1578.782066] print_req_error: I/O error, dev nvme0n1, sector 3125627392
[ 1578.789462] print_req_error: I/O error, dev nvme0n1, sector 3125627392
[ 1578.796744] Buffer I/O error on dev nvme0n1, logical block 390703424, async page read

# uname -r
4.14.0-rc7

# lspci -s 06:00.0 -v
06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller 172X (rev 01) (prog-if 02 [NVM Express])
	Subsystem: Dell Express Flash NVMe PM1725 1.6TB AIC
	Flags: bus master, fast devsel, latency 0, IRQ 33, NUMA node 0
	Memory at 92000000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit+
	Capabilities: [70] Express Endpoint, MSI 00
	Capabilities: [b0] MSI-X: Enable+ Count=129 Masked-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [148] Device Serial Number 83-0b-00-71-95-38-25-00
	Capabilities: [158] Power Budgeting <?>
	Capabilities: [168] Alternative Routing-ID Interpretation (ARI)
	Capabilities: [178] #19
	Capabilities: [1d8] Latency Tolerance Reporting
	Kernel driver in use: nvme
	Kernel modules: nvme



Best Regards,
  Yi Zhang
