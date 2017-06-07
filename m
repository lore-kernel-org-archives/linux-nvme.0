From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 7 Jun 2017 08:57:56 +0200
Subject: [PATCH v5 7/9] nvme: get list of namespace descriptors
In-Reply-To: <deea2259-e2df-189d-f299-7ec915406570@grimberg.me>
References: <20170606143617.32143-1-jthumshirn@suse.de>
 <20170606143617.32143-8-jthumshirn@suse.de>
 <deea2259-e2df-189d-f299-7ec915406570@grimberg.me>
Message-ID: <d051c2d0-2591-936a-7c8b-1a3b7afe5b14@suse.de>

On 06/06/2017 08:30 PM, Sagi Grimberg wrote:
> 
>> +    if (ns->ctrl->vs >= NVME_VS(1, 3, 0)) {
>> +         /* Don't treat error as fatal we potentially
>> +          * already have a NGUID or EUI-64
>> +          */
>> +        if (nvme_identify_ns_descs(ns, ns->ns_id))
>> +            dev_warn(ns->ctrl->dev,
> 
> ctrl->device

Gah I though I have all of 'em in my series.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
