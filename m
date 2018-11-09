From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Nov 2018 16:13:27 -0800
Subject: [PATCH] nvme-core: add work elements to struct nvme_ctrl
In-Reply-To: <20181108093839.GA4853@lst.de>
References: <20181108003021.28624-1-sagi@grimberg.me>
 <20181108093839.GA4853@lst.de>
Message-ID: <412d2c64-2d19-6d3c-ebee-aaeec59e1040@grimberg.me>


>> connect_work and err_work can be reused rdma, fc and by other future
>> transports so share those in nvme_ctrl.
> 
> Hmm.  I'm not sure moving things to common code just because they
> exist in the fabrics transports is an all that good idea.  For one
> PCIe, which to some extent is the most performance critical doesn't
> use them.

Its in the back of nvme_ctrl so it doesn't hurt anyone.

> Second having a structure in common code that is only
> used in the transports seems a little odd and makes reading the code
> harder.  If on the other hand we actually use them from common or
> generic fabrics code moving them might make a lot more sense.

I'm hoping we can gradually move towards having a common error recovery
logic in nvme. rdma, fc and tcp are using them for the same things so I
think it is useful to start moving commonality to common structures.
