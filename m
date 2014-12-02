From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 2 Dec 2014 16:36:07 -0500
Subject: [PATCH] NVMe: Update SCSI Inquiry VPD 83 translation
In-Reply-To: <alpine.LNX.2.00.1412022059180.4225@localhost.lm.intel.com>
References: <1417550176-14775-1-git-send-email-keith.busch@intel.com>
 <20141202205015.GW11522@wil.cx>
 <alpine.LNX.2.00.1412022059180.4225@localhost.lm.intel.com>
Message-ID: <20141202213607.GY11522@wil.cx>

On Tue, Dec 02, 2014@09:13:30PM +0000, Keith Busch wrote:
> On Tue, 2 Dec 2014, Matthew Wilcox wrote:
> >On Tue, Dec 02, 2014@12:56:16PM -0700, Keith Busch wrote:
> >>+	if (readl(&dev->bar->vs) >= 0x10100) {
> >
> >I think we want an NVME_VERSION() macro that maybe looks something like this:
> >
> >#define NVME_VERSION(major, minor) (((major) << 16) | ((minor) << 8))
> >
> >Then you can make this:
> >
> >	if (readl(&dev->bar->vs) >= NVME_VERSION(1, 1))
> >
> >What do you think?
> 
> I didn't even know what a 1.1 revision was supposed to look like until
> 1.2 clarified that, so a macro to hide the weirdness sounds good.

That was actually fixed in 1.1b ... but, yeah, there was argument within
the committee about exactly what a version number was, whether 1.12 was
greater or less than 1.2, and how we encoded versions.  I was adamant
that no matter what we settled on, the simple comparison had to work;
parsing the version to determine whether it was an earlier or later
version of the spec was not acceptable.
