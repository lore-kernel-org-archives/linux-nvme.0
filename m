From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 18 May 2017 18:13:55 -0700
Subject: [PATCH] nvme: Change our APST table to be no more aggressive than
 Intel RSTe
In-Reply-To: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
Message-ID: <CALCETrUYutdtp5U7oYwf7-eNuB0MrwoC18mG5-S8iOP4ZEVDuA@mail.gmail.com>

On Thu, May 11, 2017@9:06 PM, Andy Lutomirski <luto@kernel.org> wrote:
> It seems like RSTe is much more conservative with transition timing
> that we are.  According to Mario, RSTe programs APST to transition from
> active states to the first idle state after 60ms and, thereafter, to
> 1000 * the exit latency of the target state.
>

I pondered this a bit, and I want to NAK my own patch.  This patch
stinks -- there's mounting evidence that what it really does is to
make any problems show up more rarely.  If a system is broken, I want
it to be obviously broken.

Here are two options to move forward:

a) Leave the Dell quirk in place until someone from Dell or Samsung
figures out what's actually going on.  Add a blanket quirk turning off
the deepest sleep state on all Intel devices [1] at least until
someone from Intel figures out what's going on -- Hi, Keith!  Deal
with any other problems as they're reported.

b) Turn off the deepest state across the board and add a whitelist.
Populate the whitelist a bit.  The problem is that I don't even know
what to whitelist.  My system works great, but does that mean that my
particular laptop is fine?  My particular disk is certainly *not* fine
when installed in other laptops.

Ideas?  (a) is a bit simpler to implement, I think, and may be good enough.

[1] There are problems on Intel NUC machines with Intel SSDs, for
crying out loud.  I realize that the team that designs the NUC is
probably totally unrelated to the SSD team, but they're both Intel and
it shouldn't be *that* hard for someone at Intel to get it debugged.
See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1686592
