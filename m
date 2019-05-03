From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Fri, 3 May 2019 12:38:08 +0900
Subject: [PATCH 0/4] nvme-pci: support device coredump
In-Reply-To: <20190502125722.GA28470@localhost.localdomain>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <20190502125722.GA28470@localhost.localdomain>
Message-ID: <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>

2019?5?2?(?) 22:03 Keith Busch <keith.busch at intel.com>:
>
> On Thu, May 02, 2019@05:59:17PM +0900, Akinobu Mita wrote:
> > This enables to capture snapshot of controller information via device
> > coredump machanism, and it helps diagnose and debug issues.
> >
> > The nvme device coredump is triggered before resetting the controller
> > caused by I/O timeout, and creates the following coredump files.
> >
> > - regs: NVMe controller registers, including each I/O queue doorbell
> >         registers, in nvme-show-regs style text format.
>
> You're supposed to treat queue doorbells as write-only. Spec says:
>
>   The host should not read the doorbell registers. If a doorbell register
>   is read, the value returned is vendor specific.

OK.  I'll exclude the doorbell registers from register dump.  It will work
out without the information if we have snapshot of the queues.
