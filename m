From: keith.busch@intel.com (Keith Busch)
Date: Wed, 3 Feb 2016 14:30:56 +0000
Subject: NVMe and IRQ Affinity
In-Reply-To: <CACo6K_Zry4303xcvjoqMCCnzmxAVrWgT1+JPWGqXObGu9LnU1g@mail.gmail.com>
References: <CACo6K_bSDJwt61mnKDpYvcXjCVA9UKGO17pythzcJ8Rnjh19sA@mail.gmail.com>
 <20160202234540.GA21046@localhost.localdomain>
 <CACo6K_YGiH2ER4s21OzmD69LDL+ES0PO54jJ_efcSFw7pHADvQ@mail.gmail.com>
 <20160202235818.GB21046@localhost.localdomain>
 <CACo6K_Zry4303xcvjoqMCCnzmxAVrWgT1+JPWGqXObGu9LnU1g@mail.gmail.com>
Message-ID: <20160203143055.GA23910@localhost.localdomain>

On Wed, Feb 03, 2016@01:13:23AM +0100, Mark Jacobson wrote:
> 1. When you say out-of-tree, do you mean a loadable kernel module?
> (My understanding is that the NVMe driver is now part of the mainline
> Linux kernel source tree, so I'm a bit confused as to where to nab
> that from.)

Yes, a loadable kernel module or a package that can build one. I am not
aware of any publicly available. Perhaps your vendor provides one.

> 2. Does the upstream 4.4.1 kernel have any of these fixes if I were to
> build it myself with the appropriate support ticked off?

The 4.3 kernel has the fixes, and anything newer than that should also
work. I think it was just the 4.2 kernel that had this wrong (will see
if there's are any stable patch candidates).
