From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 6 Jun 2019 10:38:08 +0300
Subject: [PATCH 1/1] nvme-rdma: use dynamic dma mapping per command
In-Reply-To: <20190606064537.GE27033@lst.de>
References: <1559749293-32649-1-git-send-email-maxg@mellanox.com>
 <20190606064537.GE27033@lst.de>
Message-ID: <7db16b61-f29a-2fe9-5e58-8f84d208016e@mellanox.com>


On 6/6/2019 9:45 AM, Christoph Hellwig wrote:
>> Fixes: 87fd125344d6 ("nvme-rdma: remove redundant reference between ib_device and tagset")
>> Suggested-by: Sagi Grimberg <sagi at grimberg.me>
>> Tested-by: Jim Harris <james.r.harris at intel.com>
> Shouldn't this also have a reported-by?

Yes we can, actually we saw it also in our labs even before Jim did and 
I sent a different fix before Sagi's dma map/unmap proposal.

I'll add reported-by Jim.


>
>> -static void nvme_rdma_free_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
>> -		size_t capsule_size, enum dma_data_direction dir)
>> +static void nvme_rdma_free_mapped_qe(struct ib_device *ibdev,
>> +		struct nvme_rdma_qe *qe, size_t capsule_size,
>> +		enum dma_data_direction dir)
>>   {
>>   	ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
>>   	kfree(qe->data);
>>   }
>>   
>> -static int nvme_rdma_alloc_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
>> -		size_t capsule_size, enum dma_data_direction dir)
>> +static int nvme_rdma_alloc_mapped_qe(struct ib_device *ibdev,
>> +		struct nvme_rdma_qe *qe, size_t capsule_size,
>> +		enum dma_data_direction dir)
> I agree with Sagi that we probably should drop the renames.

ok.


> Can you write out the explanation somewhere why the AEN SQE doesn't
> need this treatment?  Especially as that would actually allow moving
> the DMA mapping into nvme_rdma_post_send and clean things up a bit.

Yes I'll add some comment.

But I'm not sure we would like to move it to post_send and add more 
if/else on the fast path.

We already added more operations (map/unmap) on the fast path...
