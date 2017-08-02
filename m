From: jsmart2021@gmail.com (James Smart)
Date: Wed, 2 Aug 2017 07:29:45 -0700
Subject: [PATCH 1/2] nvmet_fc: add defer_req callback for deferment of cmd
 buffer return
In-Reply-To: <20170802081617.GD4256@linux-x5ow.site>
References: <20170801221240.31723-1-jsmart2021@gmail.com>
 <20170801221240.31723-2-jsmart2021@gmail.com>
 <20170802081617.GD4256@linux-x5ow.site>
Message-ID: <705523d4-8452-814c-0486-71ddde698e73@gmail.com>

On 8/2/2017 1:16 AM, Johannes Thumshirn wrote:
>> +	for (;;) {
>> +		deferfcp = list_first_entry_or_null(&queue->pending_cmd_list,
>> +				struct nvmet_fc_defer_fcp_req, req_list);
>> +		if (!deferfcp)
>> +			break;
> 
>          while ((deferfcp = list_first_entry_or_null(&queue->pending_cmd_list,
> 				struct nvmet_fc_defer_fcp_req,
> 				req_list)) != NULL) {
> ?

To me - this is harder to read. But not a big deal.

-- james
