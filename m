From: axboe@fb.com (Jens Axboe)
Date: Thu, 15 Oct 2015 13:40:46 -0600
Subject: [PATCH] NVMe: Fix memory leak on retried commands
In-Reply-To: <alpine.LNX.2.00.1510151904520.27742@localhost.lm.intel.com>
References: <1444774416-12648-1-git-send-email-keith.busch@intel.com>
 <alpine.LNX.2.00.1510151904520.27742@localhost.lm.intel.com>
Message-ID: <5620013E.9020109@fb.com>

On 10/15/2015 01:34 PM, Keith Busch wrote:
> On Tue, 13 Oct 2015, Keith Busch wrote:
>> Resources are reallocated for requeued commands, so unmap and release
>> the iod for the failed command.
>
> Hi Jens,
>
> Since you're applying changes for 4.3, can you add this one? It's a
> pretty bad memory leak and causes a kernel hang if you remove a drive
> because of a busy dma pool. You'll get messages spewing like this:
>
>    nvme 0000:xx:xx.x: dma_pool_destroy prp list 256, ffff880420dec000 busy
>
> and lock up pci and the driver since removal never completes while
> holding a lock.

Yeah, it's applied. It's hand applied since it no longer applied after 
the error fixup from Christoph:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=0dfc70c33409afc232ef0b9ec210535dfbf9bc61

> I think this should go into stable back to 4.0. I'm not entirely sure how
> to do that. Will the Cc on the original achieve that when this is merged?

I think your patch is fine, it's marked stable and with 4.0 and up. So 
should be no need to do anything else.

-- 
Jens Axboe
