From: hch@lst.de (Christoph Hellwig)
Date: Sun, 23 Apr 2017 09:43:04 +0200
Subject: [PATCH 2/7] nvme/fc: don't byte swap command_id
In-Reply-To: <769f8c7a-4d95-3140-1e6f-817a0e7f97b4@broadcom.com>
References: <20170421085005.5945-1-hch@lst.de>
 <20170421085005.5945-3-hch@lst.de>
 <769f8c7a-4d95-3140-1e6f-817a0e7f97b4@broadcom.com>
Message-ID: <20170423074304.GA20750@lst.de>

On Fri, Apr 21, 2017@06:10:28PM -0700, James Smart wrote:
> On 4/21/2017 1:50 AM, Christoph Hellwig wrote:
>> The command ID is a field for host only use and thus always is in
>> native endian.
>>
>> Found by sparse.
>>
>> Signed-off-by: Christoph Hellwig <hch at lst.de>
>> ---
>>   drivers/nvme/host/fc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 63819b12c1da..68887818801e 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -1274,7 +1274,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>>   			     be32_to_cpu(op->rsp_iu.xfrd_len) !=
>>   					freq->transferred_length ||
>>   			     op->rsp_iu.status_code ||
>> -			     op->rqno != le16_to_cpu(cqe->command_id))) {
>> +			     op->rqno != cqe->command_id)) {
>>   			status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
>>   			goto done;
>>   		}
>
> This check was replaced in the following patch, obsoleting this change:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009259.html

Can you please resend this and the two patches related to it?  They had
non-trivial conflicts with the error status rework.
