From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sat, 4 May 2019 13:20:50 +0900
Subject: [PATCH 0/4] nvme-pci: support device coredump
In-Reply-To: <20190503122035.GA21501@lst.de>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <20190502125722.GA28470@localhost.localdomain>
 <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
 <20190503121232.GB30013@localhost.localdomain> <20190503122035.GA21501@lst.de>
Message-ID: <CAC5umyiGbDNCtzhJioR_2EV6-6xMuZXOMThCizwJEMHi+KqxAw@mail.gmail.com>

2019?5?3?(?) 21:20 Christoph Hellwig <hch at lst.de>:
>
> On Fri, May 03, 2019@06:12:32AM -0600, Keith Busch wrote:
> > Could you actually explain how the rest is useful? I personally have
> > never encountered an issue where knowing these values would have helped:
> > every device timeout always needed device specific internal firmware
> > logs in my experience.

I agree that the device specific internal logs like telemetry are the most
useful.  The memory dump of command queues and completion queues is not
that powerful but helps to know what commands have been submitted before
the controller goes wrong (IOW, it's sometimes not enough to know
which commands are actually failed), and it can be parsed without vendor
specific knowledge.

If the issue is reproducible, the nvme trace is the most powerful for this
kind of information.  The memory dump of the queues is not that powerful,
but it can always be enabled by default.

> Yes.  Also not that NVMe now has the 'device initiated telemetry'
> feauture, which is just a wired name for device coredump.  Wiring that
> up so that we can easily provide that data to the device vendor would
> actually be pretty useful.

This version of nvme coredump captures controller registers and each queue.
So before resetting controller is a suitable time to capture these.
If we'll capture other log pages in this mechanism, the coredump procedure
will be splitted into two phases (before resetting controller and after
resetting as soon as admin queue is available).
