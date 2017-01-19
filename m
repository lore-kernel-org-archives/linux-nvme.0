From: jsmart2021@gmail.com (James Smart)
Date: Wed, 18 Jan 2017 18:45:46 -0800
Subject: [PATCH 03/17] lpfc: NVME Initiator: Base modifications Part B
In-Reply-To: <20170118101112.GC3514@linux-x5ow.site>
References: <587ec2ee.01djIfQsSlhQj6k1%jsmart2021@gmail.com>
 <20170118101112.GC3514@linux-x5ow.site>
Message-ID: <4c44ac81-e409-371e-7fa5-bc1946b6c650@gmail.com>



On 1/18/2017 2:11 AM, Johannes Thumshirn wrote:
> On Tue, Jan 17, 2017@05:20:46PM -0800, James Smart wrote:
>> NVME Initiator: Base modifications
>>
>> This is part B of parts A..F.
>>
>> Part B is limited to lpfc_attr.c: lpfc attribute modifications
>>
>> *********
>>
>> Refer to Part A for a description of base modifications
>>
>> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
>> Signed-off-by: James Smart <james.smart at broadcom.com>
>> ---
> [...]
>
>> +	len += snprintf(buf + len, PAGE_SIZE - len,
>> +			"%s%d WWPN x%llx WWNN x%llx DID x%06x %s\n",
>> +			"NVME LPORT lpfc",
> Is it the lack of coffee or should it be
> 			"NVME LPORT lpfc%d WWPN x%llx WWNN x%llx DID x%06x %s\n"
>
> I think you're doing it to not hit the 80 chars limit, but then there are
> way more offenders than that one, so...

The line split is certainly due to the 80 limit and have that issue a lot.

As for what the string name should be - I agree with you. something is 
confused.

>> +int
>> +lpfc_emptyq_wait(struct lpfc_hba *phba, struct list_head *q, spinlock_t *lock)
>> +{
>> +	int cnt = 0;
>> +
>> +	spin_lock_irq(lock);
>> +	while (!list_empty(q)) {
>> +		spin_unlock_irq(lock);
>> +		msleep(20);
>> +		if (cnt++ > 250) {  /* 5 secs */
>> +			lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
>> +					"0466 %s %s\n",
>> +					"Outstanding IO when ",
>> +					"bringing Adapter offline\n");
>> +				return 0;
>> +		}
>> +		spin_lock_irq(lock);
>> +	}
>> +	spin_unlock_irq(lock);
>> +	return 1;
>> +}
>> +
> Aren't you using lpc_emptyq_wait() in patches prior to that already? This
> breaks git bisect. Pleas test-build (ideally + checkpatch and sparse/smatch)
> each patch in the series individually.

I called out - in patch2 - that Patches 2 through 7, known as parts 
A..F, area really one big patch. They will not follow the git bisect 
rules.  I could have sent them in one huge patch, but chose to break 
them up. Unfortunately, the mods accumulated over time with lots of 
reworks - creating a base that was too intertwined to put into small 
functional patches without spending oodles of time to carve them up.   I 
hope you can bear with me on this set and review the 7 pieces as one big 
patch.

-- james
