From: james.smart@broadcom.com (James Smart)
Date: Fri, 9 Nov 2018 10:57:34 -0800
Subject: [PATCH] nvme-core: add work elements to struct nvme_ctrl
In-Reply-To: <412d2c64-2d19-6d3c-ebee-aaeec59e1040@grimberg.me>
References: <20181108003021.28624-1-sagi@grimberg.me>
 <20181108093839.GA4853@lst.de>
 <412d2c64-2d19-6d3c-ebee-aaeec59e1040@grimberg.me>
Message-ID: <17389488-ba18-9276-05d4-af7de2226f4b@broadcom.com>


On 11/8/2018 4:13 PM, Sagi Grimberg wrote:
> I'm hoping we can gradually move towards having a common error recovery
> logic in nvme. rdma, fc and tcp are using them for the same things so I
> think it is useful to start moving commonality to common structures. 

I think we'll get there, but will be adding more transport ops instead. 
Like the stop_ctrl, or the recent scan_work deadlock makes me believe 
we'll have an queue_terminate op.

-- james
