From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 7 Jun 2017 09:00:50 +0200
Subject: [PATCH v5 1/9] scatterlist: add sg_zeroout_area() helper
In-Reply-To: <eef19233-47d6-9ea3-9f03-d846ce578ef7@grimberg.me>
References: <20170606143617.32143-1-jthumshirn@suse.de>
 <20170606143617.32143-2-jthumshirn@suse.de>
 <eef19233-47d6-9ea3-9f03-d846ce578ef7@grimberg.me>
Message-ID: <0778ec96-8396-143e-9925-55f9c7d39239@suse.de>

On 06/06/2017 08:26 PM, Sagi Grimberg wrote:
> 
>> +    while ((offset < buflen) && sg_miter_next(&miter)) {
>> +        unsigned int len;
>> +
>> +        len = min(miter.length, buflen - offset);
>> +        memset(miter.addr, '\0', len);
> 
> Why '\0' and not 0?

Shouldn't be a difference, should it? ascii(7) says
'000   0     00    NUL '\0' (null character)'


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
