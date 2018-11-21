From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 14:28:59 -0800
Subject: [PATCH v2 07/14] nvme-core: add work elements to struct nvme_ctrl
In-Reply-To: <20181121130432.GB1373@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-9-sagi@grimberg.me> <20181121130432.GB1373@lst.de>
Message-ID: <7833b3a4-cce5-238a-eef3-70702c443931@grimberg.me>


>> connect_work and err_work will be reused by nvme-tcp so
>> share those in nvme_ctrl for rdma and fc to share.
> 
> As said before when you sent this invididually:  I'd rather not move
> struct members to the common struture until we actually start using
> it there.  So for now please add it to the containing TCP-specific
> structure, although I'm looking forward to actually see code around
> it consolidated eventually.

FFFine....
