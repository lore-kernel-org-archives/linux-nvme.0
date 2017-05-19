From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Fri, 19 May 2017 01:32:55 +0000
Subject: [PATCH] nvme: Change our APST table to be no more aggressive than
 Intel RSTe
In-Reply-To: <CALCETrUYutdtp5U7oYwf7-eNuB0MrwoC18mG5-S8iOP4ZEVDuA@mail.gmail.com>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>,
 <CALCETrUYutdtp5U7oYwf7-eNuB0MrwoC18mG5-S8iOP4ZEVDuA@mail.gmail.com>
Message-ID: <1495157575349.14067@Dell.com>

> I pondered this a bit, and I want to NAK my own patch.  This patch
> stinks -- there's mounting evidence that what it really does is to
> make any problems show up more rarely.  If a system is broken, I want
> it to be obviously broken.
>
> Here are two options to move forward:
>
> a) Leave the Dell quirk in place until someone from Dell or Samsung
> figures out what's actually going on.  Add a blanket quirk turning off
> the deepest sleep state on all Intel devices [1] at least until
> someone from Intel figures out what's going on -- Hi, Keith!  Deal
> with any other problems as they're reported.
>
> b) Turn off the deepest state across the board and add a whitelist.
> Populate the whitelist a bit.  The problem is that I don't even know
> what to whitelist.  My system works great, but does that mean that my
> particular laptop is fine?  My particular disk is certainly *not* fine
> when installed in other laptops.
> 
> Ideas?  (a) is a bit simpler to implement, I think, and may be good enough.
>
Until we have a proper solution for XPS 9550/Precision 5510 I agree that quirk should stay in place.
Of those two options I think A is better.  There are lots of machines this patch has helped that haven't been mentioned in this content.  Please make sure that it's not too aggressive on ITPT for PS4 if you're not aligning to RST behavior (should at "least" be 6s).

Kai-Heng and the Canonical team have also been looking at a lot of SSD/machine combinations with these various patches.  I hope they can speak up on what they've been finding.

> [1] There are problems on Intel NUC machines with Intel SSDs, for
> crying out loud.  I realize that the team that designs the NUC is
> probably totally unrelated to the SSD team, but they're both Intel and
> it shouldn't be *that* hard for someone at Intel to get it debugged.
> See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1686592

I would second this and love if Intel could speak up here on what direction they recommend to bring the NVME driver for APST.
