From: wnukowski@google.com (Michal Wnukowski)
Date: Tue, 14 Aug 2018 18:35:16 -0700
Subject: [PATCH] Bugfix for handling of shadow doorbell buffer.
In-Reply-To: <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
References: <20180814221735.62804-1-wnukowski@google.com>
 <20180814225716.GA3224@localhost.localdomain>
 <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
Message-ID: <d57e77d8-88e2-b92a-9545-7118de4d8065@google.com>



On 08/14/2018 04:16 PM, Linus Torvalds wrote:
> On Tue, Aug 14, 2018@03:17:35PM -0700, Michal Wnukowski wrote:
>>
>> With memory barrier in place, the volatile keyword around *dbbuf_ei is
>> redundant.
> 
> No. The memory barrier enforces _ordering_, but it doesn't enforce
> that the accesses are only done once. So when you do
> 
>>              *dbbuf_db = value;
> 
> to write to dbbuf_db, and
> 
>>    *dbbuf_ei
> 
> to read from dbbuf_ei, without the volatile the write (or the read)
> could be done multiple times, which can cause serious confusion.
> 

I got confused after comaring disassembly of this code with and 
without volatile keyword. Thanks for the correction.

> 
> However, there's a more serious problem with your patch:
> 
>> +             /*
>> +              * Ensure that the doorbell is updated before reading
>> +              * the EventIdx from memory
>> +              */
>> +             mb();
> 
> Good comment. Except what about the other side?
> 
> When you use memory ordering rules, as opposed to locking, there's
> always *two* sides to any access order. There's this "write dbbuf_db"
> vs "read dbbuf_ei" ordering.
> 
> But there's the other side: what about the side that writes dbbuf_ei,
> and reads dbbuf_db?
> 
> I'm assuming that's the actual controller hardware, but it needs a
> comment about *that* access being ordered too, because if it isn't,
> then ordering this side is pointless.
> 

The other side in this case is not actual controller hardware, but 
virtual one (the regular hardware should rely on normal MMIO 
doorbells). I spent some time going through the code of internal 
hypervisor and double-checking all guarantees around memory access 
before asking the same question: "what about the other side?". This 
execution ordering is mentioned in NVMe spec under "Controller 
Architecture", and it turned out that the NVMe driver itself had 
missing memory barrier. 


Thanks,
Michal
