From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 May 2017 17:42:48 -0400
Subject: [PATCH] nvme: Change our APST table to be no more aggressive
 than Intel RSTe
In-Reply-To: <CALCETrWCLAZp4yn7gAm2WMMPgsWLzb_5g9_r66a_bKOsDcwGnA@mail.gmail.com>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
 <CALCETrUYutdtp5U7oYwf7-eNuB0MrwoC18mG5-S8iOP4ZEVDuA@mail.gmail.com>
 <20170519063505.GA15980@infradead.org>
 <20170519141834.GB6015@localhost.localdomain>
 <CALCETrWCLAZp4yn7gAm2WMMPgsWLzb_5g9_r66a_bKOsDcwGnA@mail.gmail.com>
Message-ID: <20170519214248.GE7850@localhost.localdomain>

On Fri, May 19, 2017@11:24:39AM -0700, Andy Lutomirski wrote:
> On Fri, May 19, 2017@7:18 AM, Keith Busch <keith.busch@intel.com> wrote:
> > On Thu, May 18, 2017@11:35:05PM -0700, Christoph Hellwig wrote:
> >> On Thu, May 18, 2017@06:13:55PM -0700, Andy Lutomirski wrote:
> >> > a) Leave the Dell quirk in place until someone from Dell or Samsung
> >> > figures out what's actually going on.  Add a blanket quirk turning off
> >> > the deepest sleep state on all Intel devices [1] at least until
> >> > someone from Intel figures out what's going on -- Hi, Keith!  Deal
> >> > with any other problems as they're reported.
> >>
> >> I think we should just blacklist the 60p entirely.  It also seems to
> >> corrupt data 100% reliable when used with XFS.
> >
> > I assume you're talking about the 600p/p3100. That family of devices
> > prefer 4k alignment, and patch below will enforce that, fixing all
> > access issues. I wasn't planning to post it because my understanding is
> > an imminent f/w update will make it unnecessary.
> >
> > I understand there is a different issue specific to the KBL NUC platforms
> > that exposes some other errata, but I don't know much about that.
> 
> We can quirk by firmware version.  The report said:
> 
> vid : 0x8086
> ssvid : 0x8086
> sn : BTPY63850F281P0H
> mn : INTEL SSDPEKKW010T7
> fr : PSF104C
> 
> Any chance you can check what firmware versions have the issue?

All publicly available f/w's may experience the reported issues. The
update that is believed to resolve all known isues is currently in the
validation process and will be released with an update tool as soon as
that completes, but I have not been provided a specific release date.
