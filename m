From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 01:27:45 +0300
Subject: [PATCH 12/17] nvme-rdma: Introduce nvme_rdma_set_keyed_sgl helper
 func
In-Reply-To: <20180528072640.GK5618@lst.de>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-13-git-send-email-maxg@mellanox.com>
 <20180528072640.GK5618@lst.de>
Message-ID: <53c5c275-5efe-7fd4-bca2-cd9dcfdf5b61@grimberg.me>


>> This function will be used to avoid code duplication while
>> setting keyed sgl fields.
> 
> Does this really buy us anything?
> 
>>
>> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
>> ---
>>   drivers/nvme/host/rdma.c | 34 +++++++++++++++++++---------------
>>   1 file changed, 19 insertions(+), 15 deletions(-)
> 
> Because the diffstate doesn't look very promising, and the code isn't
> really more readable either.

Can't say I like it either...
