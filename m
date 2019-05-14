From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 14 May 2019 13:30:17 +0300
Subject: [PATCH] nvme-rdma: remove redundant reference between ib_device
 and tagset
In-Reply-To: <c162fcdf-9ae5-93bb-e1f2-5179acef3083@grimberg.me>
References: <1557139675-2469-1-git-send-email-maxg@mellanox.com>
 <c162fcdf-9ae5-93bb-e1f2-5179acef3083@grimberg.me>
Message-ID: <16c44835-dfc6-81b3-9d80-04571cdb19fb@mellanox.com>


On 5/12/2019 6:26 PM, Sagi Grimberg wrote:
> This looks good max.
>
> On 5/6/19 3:47 AM, Max Gurtovoy wrote:
>> In the past, before adding f41725bb ("nvme-rdma: Use mr pool") commit,
>> we needed a reference on the ib_device as long as the tagset
>> was alive, as the MRs in the request structures needed a valid 
>> ib_device.
>> Now, we allocate/deallocate MR pool per QP and consume on demand.
>>
>> Also remove nvme_rdma_free_tagset function and use blk_mq_free_tag_set
>> instead, as it unneeded anymore.
>>
>> This commit also fixes a memory leakage and possible segmentation fault.
>> When configuring the system with NIC teaming (aka bonding)
>
> Question, what about sqe dma mappings? don't they need to be remapped as
> well?


Yes, I'm looking into the block layer to find a function that does 
exit_request for each hctx and init_request for each hctx..
