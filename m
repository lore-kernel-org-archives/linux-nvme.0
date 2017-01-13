From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 13 Jan 2017 23:42:29 +0200
Subject: nvmef target login hangs
In-Reply-To: <CY1PR12MB07742E08D08352B7413B06F8BC780@CY1PR12MB0774.namprd12.prod.outlook.com>
References: <CY1PR12MB07742E08D08352B7413B06F8BC780@CY1PR12MB0774.namprd12.prod.outlook.com>
Message-ID: <9bc2ade1-95ef-5060-fb6c-7e11f4cd86bf@grimberg.me>

Hi Raju,

I think you need the fix from Christoph:

[PATCH] nvme-rdma: fix nvme_rdma_queue_is_ready

It's sent for 4.10-rc3.
