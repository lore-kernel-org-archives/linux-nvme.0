From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 12 Nov 2017 19:43:43 +0200
Subject: [PATCH 1/1] nvme-rdma: Introduce
 nvme_rdma_configure_blk/nvme_rdma_destroy_blk
In-Reply-To: <20171108181754.GA471@lst.de>
References: <1510060989-10391-1-git-send-email-maxg@mellanox.com>
 <20171108181754.GA471@lst.de>
Message-ID: <c957ffa3-6c55-e892-c0b3-3e9094a1d4bf@mellanox.com>



On 11/8/2017 8:17 PM, Christoph Hellwig wrote:
> On Tue, Nov 07, 2017@03:23:09PM +0200, Max Gurtovoy wrote:
>> Create new helpers to avoid code and logic duplication between admin/IO
>> block layer resources creation and destruction.
> 
> How is this going to interact with Sagi's refactoring in this area?
> 

I'll send an updated version over nvme/for-4.15
