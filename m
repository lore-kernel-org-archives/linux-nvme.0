From: mark_jacobson@stackvelocity.com (Mark Jacobson)
Date: Wed, 3 Feb 2016 01:13:23 +0100
Subject: NVMe and IRQ Affinity
In-Reply-To: <20160202235818.GB21046@localhost.localdomain>
References: <CACo6K_bSDJwt61mnKDpYvcXjCVA9UKGO17pythzcJ8Rnjh19sA@mail.gmail.com>
 <20160202234540.GA21046@localhost.localdomain>
 <CACo6K_YGiH2ER4s21OzmD69LDL+ES0PO54jJ_efcSFw7pHADvQ@mail.gmail.com>
 <20160202235818.GB21046@localhost.localdomain>
Message-ID: <CACo6K_Zry4303xcvjoqMCCnzmxAVrWgT1+JPWGqXObGu9LnU1g@mail.gmail.com>

In that case, please forgive the silly questions, as I am not an
experienced kernel developer by any means...  (I'm just looking for
enough information go Googling. I won't ask much more down that line
of questioning, as I know this list is not for that purpose.)

1. When you say out-of-tree, do you mean a loadable kernel module?
(My understanding is that the NVMe driver is now part of the mainline
Linux kernel source tree, so I'm a bit confused as to where to nab
that from.)
2. Does the upstream 4.4.1 kernel have any of these fixes if I were to
build it myself with the appropriate support ticked off?

Also, thank you very much for the quick response and assistance. I
really appreciate the help. :)
Thank you,

Mark Jacobson
Software Test Engineer
Stack Velocity


On Wed, Feb 3, 2016@12:58 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Feb 03, 2016@12:50:06AM +0100, Mark Jacobson wrote:
>> Output is below. I'm aware the distro hints are fairly invalid.
>
> They're all invalid. This kernel must have forked before the affinity
> hints were fixed for a blk-mq nvme driver. A more optimal affinity hint
> would match the mq's cpu_list, which is how it looks upstream.
>
> I guess your platform strongly prefers CPU 0 when allowed. You can
> either manually override the smp_affinity, use an out-of-tree driver
> with a fix and let irqbalance handle it.
