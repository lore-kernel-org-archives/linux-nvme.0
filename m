From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 28 Jun 2018 18:02:20 +0300
Subject: [PATCH v2 1/1] nvmet-rdma: Add error flow for post_recv failures
In-Reply-To: <40da9af2-9adb-62d4-223e-62d94186269b@grimberg.me>
References: <1530100713-24247-1-git-send-email-maxg@mellanox.com>
 <40da9af2-9adb-62d4-223e-62d94186269b@grimberg.me>
Message-ID: <0b19a461-12dc-bbd1-86a7-61321090134e@mellanox.com>



On 6/28/2018 5:38 PM, Sagi Grimberg wrote:
> 
>> Posting receive buffer operation can fail, thus we should
>> make sure there is no memory leakage in that flow. Also add
>> an error log in case of a failure.
> 
> What memory leak? resulting from post_recv errors?

We are missing error flows in nvmet_rdma_create_queue_ib and 
nvmet_rdma_init_srq. I can remove the leakage from change log as I see 
that we should be ok (unless of some unexpected bahaviour) in the 
current code when we ignore failure of post_recv.
