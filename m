From: idryomov@gmail.com (Ilya Dryomov)
Date: Tue, 28 Feb 2017 09:19:14 +0100
Subject: blk_integrity_revalidate() clears BDI_CAP_STABLE_WRITES
In-Reply-To: <yq1fuj44geq.fsf@oracle.com>
References: <CAOi1vP8M91kiF-FnT=EoJgTxfstMEsC-nhLY5KtRkrKROjWPWA@mail.gmail.com>
 <yq1efyq25y2.fsf@oracle.com>
 <CAOi1vP-amFyFHbPV3FhG3F1Tp+df6V7a4mcP8LLWY0GZx+JsFw@mail.gmail.com>
 <yq1fuj44geq.fsf@oracle.com>
Message-ID: <CAOi1vP_g-MMe9XvWDgkVL4R6UjckMQVC_CDF9+hQEpZbxwx0Jw@mail.gmail.com>

On Fri, Feb 24, 2017 at 12:49 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Ilya" == Ilya Dryomov <idryomov at gmail.com> writes:
>
> Ilya,
>
> Ilya> Well, blk_integrity_revalidate() doesn't clear the profile, it
> Ilya> just clears the stable pages flag.  Whoever calls
> Ilya> blk_integrity_unregister() to clear the profile can also clear the
> Ilya> stable pages flag -- why not let blk_integrity_unregister() clear
> Ilya> the flag like I suggested?
>
> That's what it used to do.
>
> blk_integrity_revalidate() was obviously introduced to overcome some
> problem. Unfortunately, I can't recall what that was and Google isn't
> being particularly helpful. I suspect it was either in the NVDIMM or
> NVMe camps since that's where the churn was.

Adding more people from 25520d55cdb6 -- does anyone remember the story
behind blk_integrity_revalidate()?

>
> I don't have a problem with your patch as long as we're sure there are
> no regressions. I would carry the gendisk check over, though.

I spent quite some time trying to do basic tests on nvme, since it uses
both nop_profile and real integrity profiles.  Unfortunately I don't
have access to an nvme card with separate-metadata capability and
upstream qemu driver doesn't support any metadata capabilities at all,
so I turned to https://github.com/OpenChannelSSD/qemu-nvme.  It lets
you configure mc and multiple lbafs, but

    commit ff646a5841f743fdd9cfef138ac6be1f0ba4fbfb
    Author: Keith Busch <keith.busch at intel.com> Thu Oct 23 20:02:44 2014

    As part of this, I am removing all meta-data support. It's not well
    supported in any immediatly available operating system, so the code
    is not well tested.

In the end I got it into a semi-working state by checking out an old
version and dropping some sanity checks.  I formatted the namespace in
a number of ways -- bdi/stable_pages_required and integrity/format
behaved as expected ("none", "nop", "T10-DIF-TYPE1-CRC").

Given the above, I'm not sure what the baseline is -- blk_integrity
code isn't invoked for data-only lbafs.  Could nvme folks please look
at this?  rbd regression caused by integrity revalidate change goes
back to 4.4 and I'd really like to get it fixed.  The proposed patch
is attached to my earlier reply on linux-block.

Thanks,

                Ilya
