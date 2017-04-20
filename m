From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 09:42:51 +0200
Subject: [PATCH-v1 16/22] Fix crash after issuing lip reset
In-Reply-To: <20170420044641.10657-17-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420044641.10657-17-jsmart2021@gmail.com>
Message-ID: <20170420074251.GQ6217@linux-x5ow.site>

On Wed, Apr 19, 2017@09:46:35PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> When RPI is not available, driver sends WQE with invalid RPI value and
> rejected by HBA.
> lpfc 0000:82:00.3: 1:3154 BLS ABORT RSP failed, data:  x3/xa0320008
> and
> lpfc :2753 PLOGI failure DID:FFFFFA Status:x3/xa0240008
> 
> In this case, driver accesses rpi_ids array out of bounds.
> 
> Fix:
> Check return value of lpfc_sli4_alloc_rpi(). Do not allocate
> lpfc_nodelist entry if RPI is not available.
> 
> When RPI is not available, we will get discovery timeouts and
> command drops for some of the vports as seen below.
> 
> 
> lpfc :0273 Unexpected discovery timeout, vport State x0
> lpfc :0230 Unexpected timeout, hba link state x5
> lpfc :0111 Dropping received ELS cmd Data: x0 xc90c55 x0
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
