From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 13 Feb 2017 09:17:18 +0100
Subject: [PATCH v3 03/16] lpfc: minor code cleanups
In-Reply-To: <58a0d91b.VLyGPk7S2XWliQJD%jsmart2021@gmail.com>
References: <58a0d91b.VLyGPk7S2XWliQJD%jsmart2021@gmail.com>
Message-ID: <e5172378-b70e-75ae-3818-d92a8430414c@suse.de>

On 02/12/2017 10:52 PM, James Smart wrote:
> 
> This contains code cleanups that were in the prior patch set.
> This allows better review of real changes later.
> 
> minor code cleanups:
>  fix indentation, punctuation, line length
>  addition/reduction of whitespace
>  remove unneeded parens, braces
>  lpfc_debugfs_nodelist_data: print as u64 rather than byte by byte
>  covert printk(KERN_ERR to pr_err
>  small print string deltas
>  use num_present_cpus() rather than count them
>  comment updates
>  rctl/type names moved to module variable, not on stack
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
