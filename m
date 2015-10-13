From: mlin@kernel.org (Ming Lin)
Date: Tue, 13 Oct 2015 10:44:11 -0700
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard, write_same}
In-Reply-To: <20151013115011.GA6546@infradead.org>
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
Message-ID: <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>

On Tue, Oct 13, 2015@4:50 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Aug 12, 2015@12:07:15AM -0700, Ming Lin wrote:
>> From: Ming Lin <ming.l at ssi.samsung.com>
>>
>> The split code in blkdev_issue_{discard,write_same} can go away
>> now that any driver that cares does the split. We have to make
>> sure bio size doesn't overflow.
>>
>> For discard, we set max discard sectors to (1<<31)>>9 to ensure
>> it doesn't overflow bi_size and hopefully it is of the proper
>> granularity as long as the granularity is a power of two.
>
> This ends up breaking discard on NVMe devices for a me.  An mkfs.xfs
> which does a discard of the whole device now hangs the system.
> Something in here makes it send discard command that the device doesn't
> like and the aborts don't seem to help either, although that might be
> an issue with the abort handling in the driver.
>
> Just a heads up for now, once I get a bit more time I'll try to collect
> a blktrace to figure out how the commands sent to the driver look
> different before and after the patch.

I just did a quick test with a Samsung 900G NVMe device.
mkfs.xfs is OK on 4.3-rc5.

What's your device model? I may find a similar one to try.
