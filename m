From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 8 May 2017 13:03:21 +0200
Subject: [PATCH] nvme_fc: correct port role bits
In-Reply-To: <20170505231302.31578-1-jsmart2021@gmail.com>
References: <20170505231302.31578-1-jsmart2021@gmail.com>
Message-ID: <8c2c1c9b-3a61-916b-1fb4-8fc0953b6208@suse.de>

On 05/06/2017 01:13 AM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> FC Port roles is a bit mask, not individual values.
> Correct nvme definitions to unique bits.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

Although it really should be merged into scsi/scsi_transport_fc.h some day.



-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
