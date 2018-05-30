From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 00:45:42 +0300
Subject: [PATCH v3 3/3] nvmet-rdma: support 16K inline data
In-Reply-To: <01000163b1bd094e-8a191404-8725-40c0-9af5-c4b69f324a1d-000000@email.amazonses.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <55c82aa5730c05017a58641ad9550b6c0f0e16b2.1527618402.git.swise@opengridcomputing.com>
 <01000163b1bd094e-8a191404-8725-40c0-9af5-c4b69f324a1d-000000@email.amazonses.com>
Message-ID: <2d10d67d-9504-b66b-b795-b69d536e39ad@grimberg.me>


>> @@ -200,17 +204,17 @@ static int nvmet_rdma_alloc_cmd(struct nvmet_rdma_device *ndev,
>>   	c->sge[0].length = sizeof(*c->nvme_cmd);
>>   	c->sge[0].lkey = ndev->pd->local_dma_lkey;
>>
>> -	if (!admin) {
>> +	if (!admin && inline_data_size) {
>>   		c->inline_page = alloc_pages(GFP_KERNEL,
>> -				get_order(NVMET_RDMA_INLINE_DATA_SIZE));
>> +				get_order(inline_data_size));
> 
> Now we do higher order allocations here. This means that the allocation
> can fail if system memory is highly fragmented. And the allocations can no
> longer be satisfied from the per cpu caches. So allocation performance
> will drop.

That was my first thought as well. I'm not too keen on having
higher-order allocations on this, not at all. nvmet-rdma will
allocate a whole bunch of those. I think we should try to be
good citizens. I don't think its too complicated to do is it?
