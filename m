From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Feb 2016 23:58:19 +0000
Subject: NVMe and IRQ Affinity
In-Reply-To: <CACo6K_YGiH2ER4s21OzmD69LDL+ES0PO54jJ_efcSFw7pHADvQ@mail.gmail.com>
References: <CACo6K_bSDJwt61mnKDpYvcXjCVA9UKGO17pythzcJ8Rnjh19sA@mail.gmail.com>
 <20160202234540.GA21046@localhost.localdomain>
 <CACo6K_YGiH2ER4s21OzmD69LDL+ES0PO54jJ_efcSFw7pHADvQ@mail.gmail.com>
Message-ID: <20160202235818.GB21046@localhost.localdomain>

On Wed, Feb 03, 2016@12:50:06AM +0100, Mark Jacobson wrote:
> Output is below. I'm aware the distro hints are fairly invalid.

They're all invalid. This kernel must have forked before the affinity
hints were fixed for a blk-mq nvme driver. A more optimal affinity hint
would match the mq's cpu_list, which is how it looks upstream.

I guess your platform strongly prefers CPU 0 when allowed. You can
either manually override the smp_affinity, use an out-of-tree driver
with a fix and let irqbalance handle it.
