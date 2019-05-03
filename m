From: maxg@mellanox.com (Max Gurtovoy)
Date: Fri, 3 May 2019 22:00:54 +0300
Subject: [PATCH v2 06/10] nvme/core: add mdev interfaces
In-Reply-To: <20190503122902.GA5081@infradead.org>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190502114801.23116-7-mlevitsk@redhat.com>
 <20190503122902.GA5081@infradead.org>
Message-ID: <d1c0c7ae-1a7d-06e5-d8bb-765a7fd5e41d@mellanox.com>


On 5/3/2019 3:29 PM, Christoph Hellwig wrote:
> On Thu, May 02, 2019@02:47:57PM +0300, Maxim Levitsky wrote:
>> If the mdev device driver also sets the
>> NVME_F_MDEV_DMA_SUPPORTED, the mdev core will
>> dma map all the guest memory into the nvme device,
>> so that nvme device driver can use dma addresses as passed
>> from the mdev core driver
> We really need a proper block layer interface for that so that
> uring or the nvme target can use pre-mapping as well.

I think we can also find a way to use nvme-mdev for the target offload 
p2p feature.

Don't see a big difference of taking NVMe queue and namespace/partition 
to guest OS or to P2P since IO is issued by external entity and pooled 
outside the pci driver.

thoughts ?


>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
