From: hare@suse.de (Hannes Reinecke)
Date: Tue, 13 Aug 2019 18:56:58 +0200
Subject: [PATCHv3] nvme: Return BLK_STS_TARGET if the DNR bit is set
In-Reply-To: <5c6ec6e6-d2ae-2e3b-0adc-e30cbcce528b@grimberg.me>
References: <20190812075147.79598-1-hare@suse.de>
 <a8b400cf-94ef-a4a1-e196-a74e115357ea@intel.com>
 <1f2025d7-b79e-ad46-df73-66fdff1b5f28@grimberg.me>
 <20190813141510.GB32686@localhost.localdomain>
 <5c6ec6e6-d2ae-2e3b-0adc-e30cbcce528b@grimberg.me>
Message-ID: <ceea7aaf-9537-ea19-8abe-bda525582170@suse.de>

On 8/13/19 6:37 PM, Sagi Grimberg wrote:
> 
>> We need to override the default nvme_error_status() to BLK_STS_TARGET
>> when DNR is set to prevent upper layers from their own retries/failover.
>> I suggested adding that check in the existing unlikely() case, but maybe
>> it's more obvious if we teach nvme_error_status() to default to return
>> BLK_STS_TARGET for this condition?
>>
>> ---
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 8f3fbe5ca937..50adcdde44d5 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -199,6 +199,9 @@ static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
>> ? static blk_status_t nvme_error_status(struct request *req)
>> ? {
>> +??? if (unlikely(nvme_req(req)->status & NVME_SC_DNR))
>> +??????? return BLK_STS_TARGET;
>> +
>> ????? switch (nvme_req(req)->status & 0x7ff) {
>> ????? case NVME_SC_SUCCESS:
>> ????????? return BLK_STS_OK;
>> -- 
> 
> Makes sense to me, Hannes does this address your issue?
Oh, yes, it does.
I was slightly worried as we would override other non-retryable status 
codes, but as there is no definite mapping which status codes are 
retryable we can go with this one.

I'll be sending a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
