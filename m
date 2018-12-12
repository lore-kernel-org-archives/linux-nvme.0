From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 23:29:33 -0800
Subject: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <20181212072132.GA28850@lst.de>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181211233652.9705-5-sagi@grimberg.me> <20181212071140.GD28461@lst.de>
 <d0d76a09-7ec9-2018-d4ce-7a08d4ab4002@grimberg.me>
 <20181212072132.GA28850@lst.de>
Message-ID: <f134d4e7-5d0e-7345-0414-9aa3524c75e9@grimberg.me>


>>> So we need to make sure in the block layer or I/O submitter that
>>> REQ_HIPRI is only set if QUEUE_FLAG_POLL is supported.  I think it would
>>> also help if we rename it to REQ_POLL to make this more obvious.
>>
>> It used to check for it, but was changed to look at nr_maps instead...
>> So I think this is a regression...
> 
> blk_mq_map_queue looks at both QUEUE_FLAG_POLL and nr_maps for the
> queue selection, but that doesn't help with the problem that we should
> never pass poll requests through stacking devices.

Yea I agree.. Would probably make better sense to forbid it in the core,
but I'm not entirely sure how this is possible make_request drivers...
