From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 9 May 2017 09:26:53 +0200
Subject: [PATCH v2] nvmet_fc: Add queue create and delete callbacks in
 LLDD api
In-Reply-To: <20170508214851.28690-1-jsmart2021@gmail.com>
References: <20170508214851.28690-1-jsmart2021@gmail.com>
Message-ID: <f60d818d-3053-1a51-0702-882f59bdd702@suse.de>

On 05/08/2017 11:48 PM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> To facilitate LLDD resource management on nvme queue creation and
> deletion, add optional callbacks queue_create and queue_delete.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
> v2: require queue_delete if queue_create entrypoint present

Thanks,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
