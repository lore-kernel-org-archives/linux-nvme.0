From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 08:44:41 -0700
Subject: [PATCH v3 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <yq1a7eeusa5.fsf@oracle.com>
References: <20190617161222.253849-1-bvanassche@acm.org>
 <20190617161222.253849-3-bvanassche@acm.org> <yq1a7eeusa5.fsf@oracle.com>
Message-ID: <68786de5-cdd8-c6d8-98a7-8a4310dac789@acm.org>

On 6/18/19 9:13 PM, Martin K. Petersen wrote:
> 
> Bart,
> 
>> +	/*
>> +	 * Physical blocks per logical block, 0's based. Is it possible to
>> +	 * extract this information from the filesystem properties?
>> +	 */
>> +	const __le16 ppl0b = cpu_to_le16(0);
> 
> Maybe report the filesystem block size here?
> 
> Otherwise OK.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

Hi Martin,

Thanks for the review.

Are you perhaps referring to the parameter that can be specified as 
command-line option -b to mkfs? I'm not sure that we should report that 
size as the physical block size since that parameter can be set to a 
value that is much larger than the physical block size of the storage 
medium (in the target system). I'd like to make sure that writes with a 
size of what is reported as physical block size are atomic because that 
is what filesystems (at the initiator side) expect.

Bart.
