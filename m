From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 Feb 2017 09:30:54 +0100
Subject: [PATCH v3 03/16] lpfc: minor code cleanups
In-Reply-To: <58a0d91b.VLyGPk7S2XWliQJD%jsmart2021@gmail.com>
References: <58a0d91b.VLyGPk7S2XWliQJD%jsmart2021@gmail.com>
Message-ID: <158bf3bb-4ae9-d834-e1dc-d40940a50c3e@suse.de>

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
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
