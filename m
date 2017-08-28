From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 28 Aug 2017 11:34:54 +0300
Subject: blk_mq_reinit_tagset during NVMEoF port toggling
In-Reply-To: <e47ee442-0361-eb7c-6da3-e3b9f61015d5@grimberg.me>
References: <85228a2d-053f-cf79-292e-725aad6ee5fa@mellanox.com>
 <e47ee442-0361-eb7c-6da3-e3b9f61015d5@grimberg.me>
Message-ID: <72b1ad70-707e-7f2f-b2a7-55bd21754c57@mellanox.com>

On 8/28/2017 10:40 AM, Sagi Grimberg wrote:
>> Hi guys,
>
> Hi Max, CCing linux-nvme.
Hi Sagi,
>
>> we have encountered a bug during our port toggling test with MP using 
>> NVMEoF over RDMA (1 IO queue repro it quickly).
>> We have been receiving local protection errors dumps after failing 
>> back to the port that became active again (it's not the 
>> retransmission issue we fixed in the past). After debugging it we saw 
>> that the requests have been doing a reinit process (dereg_mr/alloc_mr).
>> But somehow the req->mr->need_inval is still true in the beginning of 
>> nvme_rdma_queue_rq function. This shouldn't happen since we should 
>> have perform the dereg_mr/alloc_mr in the reinit func and set it to 
>> false.
>> We don't see this issue in kernel older than 4.11 so before bisecting:
>
> Which code base is this max?
The code base is kernel 4.13.0-rc3.
>
> is commit 842594c8775b585c58459e044708c0335b6aa6b7 applied?
Yes.
>
> if so, maybe it is possible that not all requests are being 
> reinitialized.
> Can you reproduce with the following applied:
We reproduced this issue with similar prints and we didn't see them.
blk_mq_reinit_tagset() went over all the the static requests.

Thanks,
Israel.
