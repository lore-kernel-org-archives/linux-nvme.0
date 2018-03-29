From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 29 Mar 2018 16:07:39 +0300
Subject: nvme-rdma corrupts memory upon timeout
In-Reply-To: <ecc2b48a-f49f-9e2a-17a2-d68edf780b51@grimberg.me>
References: <CAF9HSintgS0U2X=E=_uJnU4y95HDcCUnyCKBDF_tNaDcY9pucg@mail.gmail.com>
 <65c6d928-dd82-70b6-79a7-481dc629c3db@grimberg.me>
 <9569a169-76cb-cd49-e31a-f33978fe2025@grimberg.me>
 <CAF9HSin0W-PcsK-ADENviGeydirrhjyTVnWpnjBpZCeZWaJ0ng@mail.gmail.com>
 <cefc1ef2-4ffb-5d6c-c047-d6233a189843@grimberg.me>
 <ecc2b48a-f49f-9e2a-17a2-d68edf780b51@grimberg.me>
Message-ID: <f60b9676-e999-5303-14d8-e5f059bac59e@mellanox.com>



On 3/1/2018 11:12 AM, Sagi Grimberg wrote:
> 
>>> This patch still returns to userspace after queuing work and may
>>> result in corruption.
>>
>> That's probably that one request being timed out as we complete
>> it earlier.
>>
>> Does this patch on top help?
>> -- 
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index e793b0899d4e..50bbf88b82f6 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1590,10 +1590,7 @@ nvme_rdma_timeout(struct request *rq, bool 
>> reserved)
>> ???????? /* queue error recovery */
>> ???????? nvme_rdma_error_recovery(req->queue->ctrl);
>>
>> -?????? /* fail with DNR on cmd timeout */
>> -?????? nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
>> -
>> -?????? return BLK_EH_HANDLED;
>> +?????? return BLK_EH_RESET_TIMER;
>> ??}
>>
>> ??/*
>> -- 
> 
> Did this help?

it helped in our setup. Can we push this ?
regarding the stopping/draining the qp before the calling the 
blk_mq_tagset_busy_iter, it seems right to me also since we want to stop 
getting completions from the HCA before we cancel all the inflight requests.

We are completing the request from various contexts and can get NULL 
dereference nvme_rdma_process_nvme_rsp (in req->mr).
We added a debug prints to see if the rq is inflight during 
nvme_rdma_process_nvme_rsp and it was't (other context "complete" the 
request already).

-Max.

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7Cd9e8d94af2a948c67a7108d57f549415%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636554923592413828&sdata=%2BbaaFQTsG8TU9NUSfr6adRhrk3VTMBfHHjr9hM%2BxdfE%3D&reserved=0 
> 
