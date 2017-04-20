From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 09:37:12 +0200
Subject: [PATCH-v1 11/22] Fix driver unload/reload operation.
In-Reply-To: <20170420044641.10657-12-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420044641.10657-12-jsmart2021@gmail.com>
Message-ID: <20170420073712.GL6217@linux-x5ow.site>

On Wed, Apr 19, 2017@09:46:30PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> There are couple of different load/unload issues fixed with this patch.
> One of the issues was reported by Junichi Nomura, a patch was submitted
> by Johannes Thumsrhirn which did fix one of the problems but the fix in
> this patch separates the pring free from the queue free and does not set
> the parameter passed in to NULL.
> 
> issues:
> (1) driver could not be unloaded and reloaded without some Oops or
>  Panic occurring.
> (2) The driver was panicking because of a corruption in the Memory
> Manager when the iocb list was getting allocated.
> 
> Root cause for the memory corruption was a double free of the Work Queue
> ring pointer memory - Freed once in the lpfc_sli4_queue_free when the CQ
> was destroyed and again in lpfc_sli4_queue_free when the WQ was destroyed.
> 
> The pring free and the queue free were separated, the pring free was moved
> to the wq destroy routine because it a better fit logically to delete the
> ring with the wq.
> 
> The checkpatch flagged several alignmenet issues that were also corrected
> with this patch.
> 
> The mboxq was never initialed correctly before it was used by the driver
> this patch corrects that issue.
> 
> Reported-by: Junichi Nomura <j-nomura at ce.jp.nec.com>
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

But I'd really like to see a Tested-by from Junichi here.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
