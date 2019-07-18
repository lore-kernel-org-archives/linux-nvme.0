From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 18 Jul 2019 11:31:26 +1000
Subject: Duplicate tag error with 5.2
In-Reply-To: <CAOSXXT5jh0Yi0xPbsLu9V=KVmee_Pto6KNRWxUbfk_8=UGGU3A@mail.gmail.com>
References: <0007d555cf4586c4ae43fdca66766b6b11863078.camel@kernel.crashing.org>
 <dbb6572c3d0b8ad1f20fd5f89ee112995676375b.camel@kernel.crashing.org>
 <CAOSXXT5jh0Yi0xPbsLu9V=KVmee_Pto6KNRWxUbfk_8=UGGU3A@mail.gmail.com>
Message-ID: <2ab311ca8c4d3052248a1183577e246886bc0b3c.camel@kernel.crashing.org>

On Thu, 2019-07-18@10:21 +0900, Keith Busch wrote:
> 
> On Thu, Jul 18, 2019, 10:13 AM Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Thu, 2019-07-18@10:41 +1000, Benjamin Herrenschmidt wrote:
> > > Hi !
> > > 
> > > So I'm getting occasional abrupt shutdowns on the Mac Mini 2018. I
> > > found out that it's the T2 chip that is panic'ing and shutting the
> > > system down.
> > > 
> > > Interestingly, when booting into MacOS, we can get some kind of error
> > > log of what happened. It looks like the NVME implementation on that
> > > thing is a SW emulation done by the T2 chip :-) It's failing on an
> > > assert due to a duplicate tag error...
> > > 
> > > Does that ring any bell ? Any idea what might be causing that ? (tag
> > > is
> > > tag 8 if that means anything).
> > 
> > Note: It seems to happen often during boot, when systemd starts all
> > services... It looks like a service hangs for a few seconds (I see the
> > systemd "waiting for service..." prompt show up for a bit, then the
> > machine dies abruptly.
> > 
> > I have yet to find a way to reproduce this on a successfully booted
> > system however. Once it's gone all the way, it's been stable so far, at
> > least doing plenty of -j5 kernel compiles.
> > 
> > Trying various stressers now...
> > 
> > Also the tag number changes from occurrence to occurrence, no pattern.
> > The IO queue depth is 129
> 
> Does this one need that QD1 quirk?

You mean queue depth 1 ? I suppose it would help but it would kill
performance :-) From the reverse engineering guy, it looks like MacOS
is happily using the whole queue. See my other message, I seem to have
caught us sending a duplicate tag indeed, though it's unclear how that
happened.

Cheers,
Ben.
