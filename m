From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 30 May 2017 16:20:07 +0200
Subject: [PATCH 5/7] nvmet: implement namespace identify descriptor list
In-Reply-To: <9b6c3281-fcc0-c999-1694-b1503cafde4f@mellanox.com>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <f18b0bd18d171e7ca824925ff3136b20f9bb132e.1496131397.git.jthumshirn@suse.de>
 <9b6c3281-fcc0-c999-1694-b1503cafde4f@mellanox.com>
Message-ID: <be4201e6-6d2b-f47e-9dc9-dc037ddea8b4@suse.de>

On 05/30/2017 01:04 PM, Max Gurtovoy wrote:
>> +static void nvmet_execute_identify_desclist(struct nvmet_req *req)
>> +{
>> +    static const int buf_size = 4069;
> 
> Shouldn't it be 4096 ?
> 

Good catch, thanks. Should probably change all to SZ_4K.

[...]

>> +    if (memchr_inv(ns->uuid, 0, sizeof(ns->uuid))) {
>> +        ns_nid = (struct nvme_ns_nid *)p;
>> +        ns_nid->nidt = NVME_NIDT_UUID;
>> +        ns_nid->nidl = 16;
> 
> maybe define NVME_NIDT_UUID_LEN instead of 16 ?
> this way you can use it in the host side too.
> 

Good point, will do in v2.


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
