From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Dec 2014 18:09:04 +0000 (UTC)
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <5499AC69.2010706@fb.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <5495B2BF.8070602@fb.com> <5495CDFE.3060404@fb.com>
 <alpine.LNX.2.00.1412221543240.4026@localhost.lm.intel.com>
 <54984B10.6060907@fb.com>
 <alpine.LNX.2.00.1412221807560.4026@localhost.lm.intel.com>
 <549860A9.7060106@fb.com> <54987A43.9000807@fb.com>
 <alpine.LNX.2.00.1412222053120.4026@localhost.lm.intel.com>
 <alpine.LNX.2.00.1412222303100.4026@localhost.lm.intel.com>
 <5499AB17.6060805@fb.com> <5499AC69.2010706@fb.com>
Message-ID: <alpine.LNX.2.00.1412231759340.4026@localhost.lm.intel.com>



On Tue, 23 Dec 2014, Jens Axboe wrote:
> On 12/23/2014 10:49 AM, Jens Axboe wrote:
>> On 12/22/2014 06:34 PM, Keith Busch wrote:
>>> Is there something available to call that I'm missing or do I need to
>>> add more removal handling?
>> 
>> So that's actually a case where having the queues auto-started on
>> requeue run is harmful, since we should be able to handle this situation
>> by stopping queues, requeueing, and then having a helper to eventually
>> abort pending requeued work, if we have to. But if you simply requeue
>> them and defer kicking the requeue list it might work. At that point
>> you'd either kick the requeues (and hence start processing them) if
>> things went well on the reset, or we could have some
>> blk_mq_abort_requeues() helper that'd kill them with -EIO instead. Would
>> that work for you?
>
> Something like this.

That's very close to where I was trying to taking this, but you beat me
to it! At least I was going the right direction. :)

I'll test this with my driver bits and resend when it works.

If anyone's interested, I'm testing by queueing lots of IO then taking
the link down. I don't have a hotplug capable machine, so using pcie
trickery to force it offline.

Here's my 'fio' commandline:

   # fio --name=global --filename=/dev/nvme0n1 --direct=1 --bs=4k \
     --rw=randrw --ioengine=libaio --iodepth=128 --name=foobar

And then taking the link down with pci link control. My nvme controller
is connected to bridge downstream port 00:03.2.

   # setpci -s 00:03.2 CAP_EXP+10.b=10:10

That should almost immediately trigger reset handling since reading CSTS
returns -1 in the polling thread, which will of course fail to recover
and request removal.
