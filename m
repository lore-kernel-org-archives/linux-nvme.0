From: hare@suse.com (Hannes Reinecke)
Date: Sat, 4 May 2019 13:34:00 +0200
Subject: [PATCH] nvme-fc: trace sq head updates
In-Reply-To: <d72fb9fe-f142-7e29-8de5-72a471cfc43e@broadcom.com>
References: <20190503141459.111641-1-hare@suse.de>
 <d72fb9fe-f142-7e29-8de5-72a471cfc43e@broadcom.com>
Message-ID: <6fb209dd-9387-c412-f942-19d33660aecd@suse.com>

On 5/3/19 7:58 PM, James Smart wrote:
> 
> 
> On 5/3/2019 7:14 AM, Hannes Reinecke wrote:
>> FC-NVMe has some detailed rules if and when SQ head pointer updates
>> should be send, but the spec is a tad unclear about the values.
>> So add tracing to the FC-NVMe driver to track this.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>> ? drivers/nvme/host/fc.c | 8 +++++++-
>> ? 1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 6d8451356eac..755c93a0c664 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -12,6 +12,7 @@
>> ? #include "nvme.h"
>> ? #include "fabrics.h"
>> +#include "trace.h"
>> ? #include <linux/nvme-fc-driver.h>
>> ? #include <linux/nvme-fc.h>
>> @@ -35,7 +36,8 @@ struct nvme_fc_queue {
>> ????? u32??????????? qnum;
>> ????? u32??????????? rqcnt;
>> ????? u32??????????? seqno;
>> -
>> +??? u16??????????? sq_head;
>> +??? u16??????????? sq_tail;
>> ????? u64??????????? connection_id;
>> ????? atomic_t??????? csn;
>> @@ -1653,6 +1655,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>> ????????????? status = cpu_to_le16(NVME_SC_INTERNAL << 1);
>> ????????????? goto done;
>> ????????? }
>> +??????? queue->sq_head = cpu_to_le16(cqe->sq_head);
>> ????????? result = cqe->result;
>> ????????? status = cqe->status;
>> ????????? break;
>> @@ -1675,6 +1678,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>> ????? }
>> ????? __nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
>> +??? trace_nvme_sq(rq, queue->sq_head,
>> +????????????? queue->sq_tail % ctrl->ctrl.sqsize);
>> ????? nvme_end_request(rq, status, result);
>> ? check_error:
>> @@ -2215,6 +2220,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, 
>> struct nvme_fc_queue *queue,
>> ????? op->fcp_req.rcv_rsplen = 0;
>> ????? op->fcp_req.status = NVME_SC_SUCCESS;
>> ????? op->fcp_req.sqid = cpu_to_le16(queue->qnum);
>> +??? queue->sq_tail++;
>> ????? /*
>> ?????? * validate per fabric rules, set fields mandated by fabric spec
> 
> this is fine, but....?? to make this be meaningful/work, you're going to 
> need to queue/serialize the processing of ERSP IU's based on the 
> response sequence number (rsn).? Otherwise, there's no guarantee that 
> sqhd comes back in the proper sequential order.?? And I'd recommend, as 
> there's no other reason for ERSP serialization, that you don't hold up 
> the completion but move the rsn/sqhd values to sideband tracking with 
> the tracking doing the serializing and updating of sqhd.
> 
Right, see, what you mean.
Would also have the beauty of moving sqhd tracking off the hot path; 
after all, we don't have to be 100% correct in tracking sqhd, and can 
allow for lazy updates.

Will be working on an updated patch.

Cheers,

Hannes
