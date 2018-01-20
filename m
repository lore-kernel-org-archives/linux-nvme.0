From: dave@znu.io (David Zarzycki)
Date: Sat, 20 Jan 2018 05:47:06 -0500
Subject: Hang when running LLVM+clang test suite
Message-ID: <7F6A25BD-AA87-4800-886F-1A256FFD8967@znu.io>

Hello NVMe developers,

The LLVM+clang the test suite regularly (but not reliably) hangs the kernel (version 4.14.13-300.fc27.x86_64). I don?t see this hang when running the test suite in /tmp (tmpfs) or on a SATA SSD.

Here are photos of the console debug info, with the NVMe driver in the backtrace:

http://znu.io/dual8168hang.tar

Here is another instance of the hang, again with NVMe in the backtrace:

http://znu.io/IMG_0362.jpg

Here is the ?lspci -v? output:

45:00.0 Non-Volatile memory controller: Toshiba America Info Systems NVMe Controller (rev 01) (prog-if 02 [NVM Express])
	Subsystem: Toshiba America Info Systems Device 0001
	Flags: bus master, fast devsel, latency 0, IRQ 38, NUMA node 0
	Memory at 94200000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 00
	Capabilities: [b0] MSI-X: Enable+ Count=8 Masked-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [168] Alternative Routing-ID Interpretation (ARI)
	Capabilities: [178] #19
	Capabilities: [198] Latency Tolerance Reporting
	Capabilities: [1a0] L1 PM Substates
	Kernel driver in use: nvme
	Kernel modules: nvme


How can I help debug this?

Dave

________________________________________________________________________

Cross reference:

https://bugzilla.redhat.com/show_bug.cgi?id=1536480
