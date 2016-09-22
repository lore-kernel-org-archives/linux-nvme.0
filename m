From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 22 Sep 2016 08:09:04 -0600
Subject: [PATCH] nvmet: Use direct IO for writes
In-Reply-To: <20160922135707.GA14645@lst.de>
References: <1474481450-5036-1-git-send-email-sagi@grimberg.me>
 <20160922135707.GA14645@lst.de>
Message-ID: <369f64ac-7059-ca5a-24aa-6775985e049e@kernel.dk>

On 09/22/2016 07:57 AM, Christoph Hellwig wrote:
> On Wed, Sep 21, 2016@11:10:50AM -0700, Sagi Grimberg wrote:
>> We're designed to work with high-end devices where
>> direct IO makes perfect sense. We noticed that we
>> context switch by scheduling kblockd instead of going
>> directly to the device without REQ_SYNC for writes.
>
> This looks reasonable.  But I still wonder why we bother to inject delay
> for any fast blk-mq device (background: Sagi told me he is observing
> issues without this on a NVMe PCIe card backend)

Batching/merging. It's not like we're doing a calculated explicit delay,
it's just async running the queue.

-- 
Jens Axboe
