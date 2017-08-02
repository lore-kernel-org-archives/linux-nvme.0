From: jsmart2021@gmail.com (James Smart)
Date: Wed, 2 Aug 2017 07:32:36 -0700
Subject: [PATCH 2/2] lpfc: support nvmet_fc defer_rcv callback
In-Reply-To: <20170802083220.GE4256@linux-x5ow.site>
References: <20170801221240.31723-1-jsmart2021@gmail.com>
 <20170801221240.31723-3-jsmart2021@gmail.com>
 <20170802083220.GE4256@linux-x5ow.site>
Message-ID: <fe17a99f-ad17-53ba-7c25-79e4c4545c14@gmail.com>

On 8/2/2017 1:32 AM, Johannes Thumshirn wrote:
>>   		len += snprintf(buf+len, PAGE_SIZE-len,
>> -				"FCP: Rcv %08x Release %08x Drop %08x\n",
>> +				"FCP: Rcv %08x Defer %08x Release %08x "
>> +				"Drop %08x\n",
> 
> Please don't split the string across lines, it makes grepping hard.
> Checkpatch actually warns you about that.

The indentation and length of the string exceeds the 80 chararacters. so 
has to be split.  lpfc is littered with this in the debug path. It'll be 
one of the things we address in the efct refactoring. For now, this 
style has been grandfathered in.

-- james
