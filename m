From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 08:21:32 +0100
Subject: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <d0d76a09-7ec9-2018-d4ce-7a08d4ab4002@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181211233652.9705-5-sagi@grimberg.me> <20181212071140.GD28461@lst.de>
 <d0d76a09-7ec9-2018-d4ce-7a08d4ab4002@grimberg.me>
Message-ID: <20181212072132.GA28850@lst.de>

On Tue, Dec 11, 2018@11:19:22PM -0800, Sagi Grimberg wrote:
>> So we need to make sure in the block layer or I/O submitter that
>> REQ_HIPRI is only set if QUEUE_FLAG_POLL is supported.  I think it would
>> also help if we rename it to REQ_POLL to make this more obvious.
>
> It used to check for it, but was changed to look at nr_maps instead...
> So I think this is a regression...

blk_mq_map_queue looks at both QUEUE_FLAG_POLL and nr_maps for the
queue selection, but that doesn't help with the problem that we should
never pass poll requests through stacking devices.
