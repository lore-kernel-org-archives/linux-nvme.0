From: james.smart@broadcom.com (James Smart)
Date: Mon, 24 Sep 2018 10:57:41 -0700
Subject: [PATCH] nvme: call nvme_complete_rq on NVME_MPATH failures
In-Reply-To: <24baa855-d70a-55bc-5231-9f273e65d392@grimberg.me>
References: <20180921184920.12902-1-jsmart2021@gmail.com>
 <24baa855-d70a-55bc-5231-9f273e65d392@grimberg.me>
Message-ID: <2403152e-f27e-e172-1a97-05d593fb4c42@broadcom.com>

On 9/23/2018 8:59 PM, Sagi Grimberg wrote:
>
>> +??? struct nvme_request *nvmerq = nvme_req(rq);
>> +
>
> Maybe simply call it req?

Doesn't really matter. req vs rq, and having both, was too close for me. 
But not an issue if you want it something else.

>
>> ????? if (ctrl->state != NVME_CTRL_DELETING &&
>> ????????? ctrl->state != NVME_CTRL_DEAD &&
>> ????????? !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>> ????????? return BLK_STS_RESOURCE;
>> -??? nvme_req(rq)->status = NVME_SC_ABORT_REQ;
>> +
>> +??? nvmerq->status = NVME_SC_ABORT_REQ;
>
> Not introduced in this patch, but should be le16_to_cpu() >> 1,
> but I guess the problem is that we need to open-code status setting
> here...
>
>> +??? nvmerq->result.u64 = 0;
>> +??? if (rq->cmd_flags & REQ_NVME_MPATH) {
>> +??????? blk_mq_start_request(rq);
>> +??????? nvme_complete_rq(rq);
>
> Why not calling nvme_end_request() directly instead?

Well, I did both of these in the 1st iteration of the patch which I 
didn't post.? The issue was that nvme_end_request() ends up calling 
blk_mq_complete_request(), which calls the transport complete() routine. 
And the transport complete() routine is doing things assuming it went 
through its queue_rq() routine when, in this case, that never happened. 
For example, FC does some sglist cleanup and some put references, but 
the gets hadn't been done. I thought it better to completely ignore the 
transport all together since the transport never did anything on the 
request.? Thus, I collapsed the logic in nvme_end_request() with 
nvme_complete_rq().??? (note: normally transport does status<<1 while 
nvme_end_request does status >> 1 before calling nvme_complete_rq).

When following the calling sequences with blk-mq, I was really surprised 
that the blk-mq layer went back to the bio routine without involving 
multipath.c.? Perhaps we should be setting some end_io routine so that 
does happen, but I am not comfortable with the bio to request to request 
transitions taking place to go down that route.

But what was clear is - we shouldn't be returning an ABTS status. We 
should be returning a TRANSPORT_DISRUPTED status, so that multipath 
(nvme_complete_rq()) knows that it doesn't have to reset the controller 
(we're likely having errors for illegal state transitions if in 
connecting state), doesn't have to increment the retry counter, and can 
use it to possibly select an alternate path if desired.

-- james
