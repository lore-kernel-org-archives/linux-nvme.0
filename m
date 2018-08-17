From: hare@suse.com (Hannes Reinecke)
Date: Fri, 17 Aug 2018 12:06:19 +0200
Subject: [PATCH 4/6] nvme-discover: Retry discovery log if the generation
 counter changes
In-Reply-To: <20180817081147.GD13230@lst.de>
References: <20180817072908.56784-1-hare@suse.de>
 <20180817072908.56784-5-hare@suse.de> <20180817081147.GD13230@lst.de>
Message-ID: <51730351-2e33-c4de-0987-3bd864421c3f@suse.com>

On 08/17/2018 10:11 AM, Christoph Hellwig wrote:
> On Fri, Aug 17, 2018@09:29:06AM +0200, Hannes Reinecke wrote:
>> If the generation counter changes we need to validate if the number
>> of records has changed, too.
>> If so we need to retry retrieving the discovery log to the most recent
>> values. The retry will be terminated after MAX_DISC_RETRIES (currently
>> set to 30) to avoid infinite recursion.
> 
> 30 retries seems pretty crazy.
> 
So what would be a good choice then?

>> @@ -311,6 +312,7 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
>>  		goto out_free_log;
>>  	}
>>  
>> +retry_log:
>>  	/* check numrec limits */
>>  	*numrec = le64_to_cpu(log->numrec);
>>  	genctr = le64_to_cpu(log->genctr);
>> @@ -346,7 +348,12 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
>>  		goto out_free_log;
>>  	}
>>  
>> -	if (*numrec != le32_to_cpu(log->numrec) || genctr != le64_to_cpu(log->genctr)) {
>> +	if (genctr != le64_to_cpu(log->genctr) &&
>> +	    *numrec != le32_to_cpu(log->numrec) &&
>> +	    ++retries < max_retries)
>> +		goto retry_log;
> 
> Any way we could factor this into a do { } while loop?
> 
I'll be checking.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
