From: a.bockholdt@precitec-optronik.de (Bockholdt Arne)
Date: Tue, 25 Sep 2018 07:31:40 +0000
Subject: [REGRESSION] DELL XPS 9550 with SM951 NVME SSD quits the bus in
 battery mode (new in 4.18/4.19)
Message-ID: <87f25c53846dd3a6f6d747edc46f9589234ac9a2.camel@precitec-optronik.de>

Hi all,

I've noticed a regression in the 4.18/4.19 kernel lines with my Dell
XPS 9550 laptop and the SM951 NVME SSD. Only in battery mode the SSD
seems to quit from the PCIe bus and I need to reboot the device. The
laptop is updated to the latest BIOS 1.80. When the device is connected
to AC power the error seems to vanish. It seems to be easily
reproducible by starting a VM via Qemu/KVM, after some seconds the
device and the file system vanishes.
I've tried to disable APST completely by kernel command line parameter
"nvme_core.default_ps_max_latency_us=0" but it doesn't seem to help. 

4.17 doesn't seem to be affected, tested with 4.18.6 and 4.19-rc5.

Is this a known regression? If you need more information, please let me
know.

Kind regards,

	Arne Bockholdt
