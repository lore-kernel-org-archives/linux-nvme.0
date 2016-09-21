From: hch@lst.de ('Christoph Hellwig')
Date: Wed, 21 Sep 2016 16:01:32 +0200
Subject: [PATCH] nvme-rdma: Fix early queue flags settings
In-Reply-To: <a46d0da7-0695-3745-1bc9-8faf4383fa19@grimberg.me>
References: <1474397848-19013-1-git-send-email-sagi@grimberg.me>
 <20160920200803.GA839@lst.de>
 <013901d2137b$8f329e10$ad97da30$@opengridcomputing.com>
 <a46d0da7-0695-3745-1bc9-8faf4383fa19@grimberg.me>
Message-ID: <20160921140132.GA19942@lst.de>

On Tue, Sep 20, 2016@08:38:52PM -0700, Sagi Grimberg wrote:
>> Maybe this changelog?
>>
>>     nvme-rdma: only clear queue flags after successful connect
>>
>>     Otherwise, nvme_rdma_stop_and_clear_queue() will incorrectly
>>     try to stop/free rdma qps/cm_ids that are already freed.
>
> I can modify the change log, Christoph do you still want a
> comment in the code?

Honestly there more I look into this the less I'm happy with the patch.
queue->flags is an atomic, and as the patch shows we can get
nvme_rdma_init_queue caled on a queue that still has visibility in
other threads  So I think we really should not even do that simple
queue->flags = 0 assignment at all.  We'll need to use clear_bit to
atomically clear anything that might be set, and we need to be careful
where we do that.  I think this whole situation that we can get an
*_init_* function called on something that already is live and visible
to other threads need to be well documented at least because it's just
waiting for sucker like me that don't expect that.
