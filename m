From: james.smart@broadcom.com (James Smart)
Date: Tue, 17 Oct 2017 07:19:30 -0700
Subject: [PATCH v2] nvmet: protect sqhd update by a lock
In-Reply-To: <20171017064306.GA16133@infradead.org>
References: <20171016151820.14766-1-jsmart2021@gmail.com>
 <20171017064306.GA16133@infradead.org>
Message-ID: <65999d52-2f65-2d9c-4cc4-db9d17fd9cab@broadcom.com>

On 10/16/2017 11:43 PM, Christoph Hellwig wrote:
>>   	if (status)
>>   		nvmet_set_status(req, status);
>>   
>> +	spin_lock_irqsave(&req->sq->sqhd_lock, flags);
>>   	if (req->sq->size)
>>   		req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
>>   	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd);
>> +	spin_unlock_irqrestore(&req->sq->sqhd_lock, flags);
> What performance impact does this have?   I'm really reluctant to put
> an irq disabling spinlock into a hot path for a feature that
> theoretically is in the spec but ignored by every host.
>
> I'd much rather play games with cmpxchg or similar here.

It's not ignored by every host. Its ignored by the linux host. There are 
other hosts out there that follow the spec and pay attention to sqhd - 
and the linux target would like to be used with them.

I'm open to other alternatives, but in the past, with pci adapter 
interfaces with similar "ring" index updates, the increment followed by 
modulo has always proven to be an issue for such tricks.

-- james
