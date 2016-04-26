From: rafael.antognolli@intel.com (Rafael Antognolli)
Date: Tue, 26 Apr 2016 14:33:49 -0700
Subject: [PATCH 0/2] Add Opal unlock support to NVMe.
In-Reply-To: <94D0CD8314A33A4D9D801C0FE68B40295C43485D@G9W0745.americas.hpqcorp.net>
References: <1461366732-31779-1-git-send-email-rafael.antognolli@intel.com>
 <20160425082408.GA13629@infradead.org>
 <94D0CD8314A33A4D9D801C0FE68B40295C43485D@G9W0745.americas.hpqcorp.net>
Message-ID: <20160426213349.GA17078@intel.com>

On Mon, Apr 25, 2016@08:29:22PM -0700, Elliott, Robert (Persistent Memory) wrote:
> 
> 
> > -----Original Message-----
> > From: linux-block-owner at vger.kernel.org [mailto:linux-block-
> > owner at vger.kernel.org] On Behalf Of Christoph Hellwig
> > Sent: Monday, April 25, 2016 3:24 AM
> > To: Rafael Antognolli <rafael.antognolli at intel.com>
> > Cc: linux-nvme at lists.infradead.org; linux-kernel at vger.kernel.org;
> > linux-block at vger.kernel.org
> > Subject: Re: [PATCH 0/2] Add Opal unlock support to NVMe.
> >
> > On Fri, Apr 22, 2016@04:12:10PM -0700, Rafael Antognolli wrote:
> > > This patch series implement a small set of the Opal protocol for
> > > self encrypting devices. It's implemented only what is needed for
> > > saving a password and unlocking a given "locking range". The
> > > password is saved on the driver and replayed back to the device
> > > on resume from suspend to RAM. It is specifically supporting
> > > the single user mode.
> 
> Passwords stored in memory are subject to cold boot attacks.
> 
> Could you tie this into the keyring infrastructure, so it would
> least be no worse than other kernel modules?  This would allow
> support for TPM-based keys (if present) to resist more attacks.
> If register-based key storage or other techniques prove viable,
> they would probably show up there first.

I'll take a look at it.

> > > It is not planned to implement the full Opal protocol (at least
> > > not for now).
> >
> > I think the OPAL code should be a generic library outside the NVMe
> > code so that we can use it for SATA and SAS as well, just with a
> > little glue code for the Security Send / Receive commands to wire
> > it up to NVMe.
> 
> NVDIMMs would benefit from that as well.

Yes, I can definitely change it to be that generic.

Thank you,
Rafael
