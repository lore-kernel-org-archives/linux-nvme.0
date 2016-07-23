From: james.smart@broadcom.com (James Smart)
Date: Sat, 23 Jul 2016 08:52:18 -0700
Subject: [PATCH] add u64 number parser
In-Reply-To: <5e325cbb-a140-8f26-7402-5dc1a2cd07ea@sandisk.com>
References: <5792b919.0C1gyf+dF4XKu6Zj%james.smart@broadcom.com>
 <5e325cbb-a140-8f26-7402-5dc1a2cd07ea@sandisk.com>
Message-ID: <09649a75-e9a1-11d7-37e2-48f4e93a3b2e@broadcom.com>


On 7/22/2016 6:32 PM, Bart Van Assche wrote:
> On 07/22/16 17:23, James Smart wrote:
>> +    buf = kmalloc(len + 1, GFP_KERNEL);
>> +    if (!buf)
>> +        return -ENOMEM;
>> +    memcpy(buf, s->from, len);
>> +    buf[len] = '\0';
>
> Hello James,
>
> Have you considered to combine the above kmalloc() and memcpy() calls 
> into a single kasprintf(GFP_KERNEL, "%.*s", len, s->from) call?
>
> Bart.
>

No, I followed the example of existing parse functions in the file.

-- james
