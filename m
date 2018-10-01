From: a.bockholdt@precitec-optronik.de (Bockholdt Arne)
Date: Mon, 1 Oct 2018 09:03:21 +0000
Subject: [REGRESSION] DELL XPS 9550 with SM951 NVME SSD quits the bus in
 battery mode (new in 4.18/4.19)
In-Reply-To: <20180925140438.GA11633@localhost.localdomain>
References: <87f25c53846dd3a6f6d747edc46f9589234ac9a2.camel@precitec-optronik.de>
 <20180925140438.GA11633@localhost.localdomain>
Message-ID: <56b14c92bba20fd8a63cfb6986356ed604e41d2c.camel@precitec-optronik.de>


On Tue, 2018-09-25@08:04 -0600, Keith Busch wrote:
> On Tue, Sep 25, 2018@07:31:40AM +0000, Bockholdt Arne wrote:
> 
> Hi all,
> 
> I've noticed a regression in the 4.18/4.19 kernel lines with my Dell
> XPS 9550 laptop and the SM951 NVME SSD. Only in battery mode the SSD
> seems to quit from the PCIe bus and I need to reboot the device. The
> laptop is updated to the latest BIOS 1.80. When the device is
> connected
> to AC power the error seems to vanish. It seems to be easily
> reproducible by starting a VM via Qemu/KVM, after some seconds the
> device and the file system vanishes.
> I've tried to disable APST completely by kernel command line
> parameter
> "nvme_core.default_ps_max_latency_us=0" but it doesn't seem to help. 
> 
> 4.17 doesn't seem to be affected, tested with 4.18.6 and 4.19-rc5.
> 
> Is this a known regression? If you need more information, please let
> me
> know.
> 
> This regression sounds external to the nvme driver. Would it be
> possible
> to bisect between 4.17 and 4.18?


This regression happens on my day to day working laptop only and it
would be to time intensive and dangerous to bisect it, sorry. Maybe I
could provide log files if you point me to the right one and tell me if
I should enable some kind of debug flags.

Thanks,

   Arne
