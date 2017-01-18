From: rajur@chelsio.com (Raju  Rangoju)
Date: Wed, 18 Jan 2017 04:36:24 +0000
Subject: nvmef target login hangs
In-Reply-To: <9bc2ade1-95ef-5060-fb6c-7e11f4cd86bf@grimberg.me>
References: <CY1PR12MB07742E08D08352B7413B06F8BC780@CY1PR12MB0774.namprd12.prod.outlook.com>,
 <9bc2ade1-95ef-5060-fb6c-7e11f4cd86bf@grimberg.me>
Message-ID: <CY1PR12MB0774E6F32888B838D3396F0ABC7F0@CY1PR12MB0774.namprd12.prod.outlook.com>

Hi Sagi,

Thanks for the quick response.

Christoph's fix resolves our issue. nvme target login works fine now.

Thanks,
Raju
________________________________________
From: Sagi Grimberg <sagi@grimberg.me>
Sent: Saturday, January 14, 2017 3:12 AM
To: Raju Rangoju; linux-nvme at lists.infradead.org
Cc: SWise OGC
Subject: Re: nvmef target login hangs 
?
Hi Raju,

I think you need the fix from Christoph:

[PATCH] nvme-rdma: fix nvme_rdma_queue_is_ready

It's sent for 4.10-rc3.
