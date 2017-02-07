From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 7 Feb 2017 12:06:05 +0100
Subject: [PATCH v2] nvme: make nvmf_register_transport require a
 create_ctrl callback
In-Reply-To: <20170127080345.5676-1-jthumshirn@suse.de>
References: <20170127080345.5676-1-jthumshirn@suse.de>
Message-ID: <340627ba-0ca9-b807-efde-8bd3a3b9e338@suse.de>

On 01/27/2017 09:03 AM, Johannes Thumshirn wrote:
> nvmf_create_ctrl() relys on the presence of a create_crtl callback in the
> registered nvmf_transport_ops, so make nvmf_register_transport require one.
> 
> Update the available call-sites as well to reflect these changes.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>

Any comments?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
