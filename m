From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 9 Nov 2018 13:55:36 -0800
Subject: [PATCH] nvme-core: add work elements to struct nvme_ctrl
In-Reply-To: <17389488-ba18-9276-05d4-af7de2226f4b@broadcom.com>
References: <20181108003021.28624-1-sagi@grimberg.me>
 <20181108093839.GA4853@lst.de>
 <412d2c64-2d19-6d3c-ebee-aaeec59e1040@grimberg.me>
 <17389488-ba18-9276-05d4-af7de2226f4b@broadcom.com>
Message-ID: <1d0a76ef-892d-672e-76ec-0f43c0103619@grimberg.me>


>> I'm hoping we can gradually move towards having a common error recovery
>> logic in nvme. rdma, fc and tcp are using them for the same things so I
>> think it is useful to start moving commonality to common structures. 
> 
> I think we'll get there, but will be adding more transport ops instead. 
> Like the stop_ctrl, or the recent scan_work deadlock makes me believe 
> we'll have an queue_terminate op.

I had several prototypes doing something along these lines [1].
Was never able to follow up on them for the time being...

http://git.infradead.org/users/sagi/linux.git/shortlog/refs/heads/nvme-central-reset-delete-err2
