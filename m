From: mr.nuke.me@gmail.com (Alex G.)
Date: Thu, 5 Apr 2018 17:21:29 -0500
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <20180405212205.33dqwqck2co25a3x@sbauer-Z170X-UD5>
References: <5d6d1a8c-6490-4046-0fba-da0a0df3d00c@gmail.com>
 <20180405213847.GG10098@localhost.localdomain>
 <20180405212205.33dqwqck2co25a3x@sbauer-Z170X-UD5>
Message-ID: <719ea777-e57d-511e-52c5-cf83027d1fd0@gmail.com>

On 04/05/2018 04:22 PM, Scott Bauer wrote:
> On Thu, Apr 05, 2018@03:38:47PM -0600, Keith Busch wrote:
>> On Thu, Apr 05, 2018@03:51:38PM -0500, Alex G. wrote:
>>> Hi Keith,
>>>
>>> The NULL pointer dereference strikes yet again, but in a different
>>> place. I think you'll love this one, as we can get it with native AER.
>>> I'm not sure what to make of it, or why we get an invalid opcode with
>>> the package, but the error is consistently tied to nvme.
>>
>> Interesting indeed.
>>
>> Invaild opcode is a BUG_ON triggering a kernel panic when it evaluates
>> to true:
>>
>>   [  938.971059] kernel BUG at mm/slub.c:296!
>>
>> Which is this:
>>
>>   static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
>>   {
>> 	unsigned long freeptr_addr = (unsigned long)object + s->offset;
>>
>>   #ifdef CONFIG_SLAB_FREELIST_HARDENED
>> 	BUG_ON(object == fp); /* naive detection of double free or corruption */
>>   #endif
>>
>> 	*(void **)freeptr_addr = freelist_ptr(s, fp, freeptr_addr);
>>   }
>>
>> So the code thinks it's found memory corruption. Maybe it has.
> 
> Alex, are you able to build with KASAN? Assuming it is memory corruption KASAN can provide
> us the location of the first free which may assist in debugging.
> 

All you have to do is say CONFIG_KASAN=y. It took almost no time at all
to trigger. The serial port is still stuck spewing out the logs, but the
ssh logger has them.

I've had to put the full log somewhere else[1], as it's way too big for
an email.

Alex
http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180405-1705.log

-------------- next part --------------
A non-text attachment was scrubbed...
Name: log-20180405-1705-trimmed.log
Type: text/x-log
Size: 99000 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180405/0943fa3d/attachment-0001.bin>
