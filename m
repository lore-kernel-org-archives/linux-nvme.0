From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sat, 4 May 2019 23:36:44 +0900
Subject: [PATCH 0/4] nvme-pci: support device coredump
In-Reply-To: <61bf6f0b-4087-cfb3-1ae6-539f18b5b6ea@gmail.com>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <20190502125722.GA28470@localhost.localdomain>
 <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
 <20190503121232.GB30013@localhost.localdomain> <20190503122035.GA21501@lst.de>
 <CAC5umyiGbDNCtzhJioR_2EV6-6xMuZXOMThCizwJEMHi+KqxAw@mail.gmail.com>
 <61bf6f0b-4087-cfb3-1ae6-539f18b5b6ea@gmail.com>
Message-ID: <CAC5umygP5cQHQk2ytpNbV5yY-tQ1E-FayMugOfg5gTmnpYtnjQ@mail.gmail.com>

2019?5?4?(?) 18:40 Minwoo Im <minwoo.im.dev at gmail.com>:
>
> Hi Akinobu,
>
> On 5/4/19 1:20 PM, Akinobu Mita wrote:
> > 2019?5?3?(?) 21:20 Christoph Hellwig <hch at lst.de>:
> >>
> >> On Fri, May 03, 2019@06:12:32AM -0600, Keith Busch wrote:
> >>> Could you actually explain how the rest is useful? I personally have
> >>> never encountered an issue where knowing these values would have helped:
> >>> every device timeout always needed device specific internal firmware
> >>> logs in my experience.
> >
> > I agree that the device specific internal logs like telemetry are the most
> > useful.  The memory dump of command queues and completion queues is not
> > that powerful but helps to know what commands have been submitted before
> > the controller goes wrong (IOW, it's sometimes not enough to know
> > which commands are actually failed), and it can be parsed without vendor
> > specific knowledge.
>
> I'm not pretty sure I can say that memory dump of queues are useless at all.
>
> As you mentioned, sometimes it's not enough to know which command has
> actually been failed because we might want to know what happened before and
> after the actual failure.
>
> But, the information of commands handled from device inside would be much
> more useful to figure out what happened because in case of multiple queues,
> the arbitration among them could not be represented by this memory dump.

Correct.

> > If the issue is reproducible, the nvme trace is the most powerful for this
> > kind of information.  The memory dump of the queues is not that powerful,
> > but it can always be enabled by default.
>
> If the memory dump is a key to reproduce some issues, then it will be
> powerful
> to hand it to a vendor to solve it.  But I'm afraid of it because the
> dump might
> not be able to give relative submitted times among the commands in queues.

I agree that only the memory dump of queues don't help much to reproduce
issues.  However when analyzing the customer-side issues, we would like to
know whether unusual commands have been issued before crash, especially on
admin queue.

> >> Yes.  Also not that NVMe now has the 'device initiated telemetry'
> >> feauture, which is just a wired name for device coredump.  Wiring that
> >> up so that we can easily provide that data to the device vendor would
> >> actually be pretty useful.
> >
> > This version of nvme coredump captures controller registers and each queue.
> > So before resetting controller is a suitable time to capture these.
> > If we'll capture other log pages in this mechanism, the coredump procedure
> > will be splitted into two phases (before resetting controller and after
> > resetting as soon as admin queue is available).
>
> I agree with that it would be nice if we have a information that might not
> be that powerful rather than nothing.
>
> But, could we request controller-initiated telemetry log page if
> supported by
> the controller to get the internal information at the point of failure
> like reset?
> If the dump is generated with the telemetry log page, I think it would
> be great
> to be a clue to solve the issue.

OK.  Let me try it in the next version.
