From: james.smart@broadcom.com (James Smart)
Date: Wed, 7 Mar 2018 13:52:58 -0800
Subject: [PATCH] nvme_fc: minor fixes on sqsize
In-Reply-To: <20180307154640.GF30975@localhost.localdomain>
References: <20180306045524.3474-1-jsmart2021@gmail.com>
 <20180307154640.GF30975@localhost.localdomain>
Message-ID: <37e33bac-cb87-beee-2401-aadd0c9afbb4@broadcom.com>

On 3/7/2018 7:46 AM, Keith Busch wrote:
> On Mon, Mar 05, 2018@08:55:24PM -0800, James Smart wrote:
>>   	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[0], 0,
>> -				NVME_AQ_BLK_MQ_DEPTH);
>> +				NVME_AQ_BLK_MQ_DEPTH + 1);
> A bit of a nit, but I think you'd prefer to use NVME_AQ_DEPTH here
> instead of assuming the +1.
NP.?? I'll address it. I need to rework the patch as I found another 
area when we tune for controller limits that isn't right either.

-- james
