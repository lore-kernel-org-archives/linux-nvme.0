From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 18 Jul 2019 11:29:58 +1000
Subject: Duplicate tag error with 5.2
In-Reply-To: <dbb6572c3d0b8ad1f20fd5f89ee112995676375b.camel@kernel.crashing.org>
References: <0007d555cf4586c4ae43fdca66766b6b11863078.camel@kernel.crashing.org>
 <dbb6572c3d0b8ad1f20fd5f89ee112995676375b.camel@kernel.crashing.org>
Message-ID: <6e4b08daaa0482bd863b63cc5a85fa58ed871045.camel@kernel.crashing.org>

On Thu, 2019-07-18@11:13 +1000, Benjamin Herrenschmidt wrote:
> 
> Note: It seems to happen often during boot, when systemd starts all
> services... It looks like a service hangs for a few seconds (I see the
> systemd "waiting for service..." prompt show up for a bit, then the
> machine dies abruptly.
> 
> I have yet to find a way to reproduce this on a successfully booted
> system however. Once it's gone all the way, it's been stable so far, at
> least doing plenty of -j5 kernel compiles.
> 
> Trying various stressers now...
> 
> Also the tag number changes from occurrence to occurrence, no pattern.
> The IO queue depth is 129.

Allright, might have caught us red handed ... unless I'm missing a path
where we recycle IDs. So this is with 5.1.16. I've added printk's to
nvme_setup_cmd() and to nvme_process_cq() printing the command_id of
the commands we setup and the commands we find completions for.

Now, I dont' have a serial console or a working netconsole on that
thing, so I'm just copying the last few entries from a screenshot taken
with my phone camera...

 setup id 5
 setup id 37
 setup id 6
 setup id 4
 got id 37
 got id 6
 got id 4
 setup id 7
 setup id 5 <---- duplicate
 setup id 38
 got id 5 <--- probably completing the first one

At this point, we see a handful more setup id but no more interrupt nor
completion from the device, and it then abruptly kills the box.

Later, booting into MacOS, I retreived the log, and the duplicate tag
it's complaining about is ... guess what ? 5 !

Any idea what might be going on here ? Can we recycle tags via some
other path ?

Cheers,
Ben.
 
