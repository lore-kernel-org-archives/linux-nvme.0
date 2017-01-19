From: jsmart2021@gmail.com (James Smart)
Date: Wed, 18 Jan 2017 18:14:35 -0800
Subject: [PATCH 06/17] lpfc: NVME Initiator: Base modifications Part E
In-Reply-To: <cefa5f07-a3f3-c5dc-2d3a-ddd410d1ffa4@suse.de>
References: <587ec2f1.pGgoAJWGU6FWMEv6%jsmart2021@gmail.com>
 <cefa5f07-a3f3-c5dc-2d3a-ddd410d1ffa4@suse.de>
Message-ID: <cc0b019e-19e9-dfaa-314d-98a8545e7542@gmail.com>



On 1/17/2017 11:34 PM, Hannes Reinecke wrote:
> Is this ever reset?
> I don't see it here ...

the lpfc_sli4_hba_setup(), which resets the function and reinits, clears 
the flag.

>
> [ .. ]
>> @@ -4380,9 +4469,12 @@ lpfc_sli_chipset_init(struct lpfc_hba *phba)
>>    * configured.
>>    **/
>>   int
>> -lpfc_sli_hbq_count(void)
>> +lpfc_sli_hbq_count(struct lpfc_hba *phba)
>>   {
>> -	return ARRAY_SIZE(lpfc_hbq_defs);
>> +	int i;
>> +
>> +	i = ARRAY_SIZE(lpfc_hbq_defs);
>> +	return i;
>>   }
>>   
>>   /**
> The point of this change being ...?

I don't know - will collapse it.

-- james
