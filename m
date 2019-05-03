From: kbusch@kernel.org (Keith Busch)
Date: Fri, 3 May 2019 06:12:32 -0600
Subject: [PATCH 0/4] nvme-pci: support device coredump
In-Reply-To: <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <20190502125722.GA28470@localhost.localdomain>
 <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
Message-ID: <20190503121232.GB30013@localhost.localdomain>

On Fri, May 03, 2019@12:38:08PM +0900, Akinobu Mita wrote:
> 2019?5?2?(?) 22:03 Keith Busch <keith.busch at intel.com>:
> > On Thu, May 02, 2019@05:59:17PM +0900, Akinobu Mita wrote:
> > > This enables to capture snapshot of controller information via device
> > > coredump machanism, and it helps diagnose and debug issues.
> > >
> > > The nvme device coredump is triggered before resetting the controller
> > > caused by I/O timeout, and creates the following coredump files.
> > >
> > > - regs: NVMe controller registers, including each I/O queue doorbell
> > >         registers, in nvme-show-regs style text format.
> >
> > You're supposed to treat queue doorbells as write-only. Spec says:
> >
> >   The host should not read the doorbell registers. If a doorbell register
> >   is read, the value returned is vendor specific.
> 
> OK.  I'll exclude the doorbell registers from register dump.  It will work
> out without the information if we have snapshot of the queues.

Could you actually explain how the rest is useful? I personally have
never encountered an issue where knowing these values would have helped:
every device timeout always needed device specific internal firmware
logs in my experience.
