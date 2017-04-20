From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 09:15:54 +0200
Subject: [PATCH-v1 02/22] Fix nvme unregister port timeout.
In-Reply-To: <20170420044641.10657-3-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420044641.10657-3-jsmart2021@gmail.com>
Message-ID: <20170420071554.GC6217@linux-x5ow.site>

On Wed, Apr 19, 2017@09:46:21PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> During some link event testing it was observed that the
> wait_for_completion_timeout in the lpfc_nvme_unregister_port
> was timing out all the time.
> 
> The initiator is claiming the nvme_fc_unregister_remoteport upcall is
> not completing the unregister in the time allotted.
> [ 2186.151317] lpfc 0000:07:00.0: 0:(0):6169 Unreg nvme wait failed 0
> 
>  The wait_for_completion_timeout returns 0 when the wait has
> been outstanding for the jiffies passed by the caller.  In this error
> message, the nvme initiator passed value 5 - meaning 5 jiffies -
> and this is just wrong.
> 
> Calculate 5 seconds in Jiffies and pass that value
> from the current jiffies.
> 
> Also the log message for the unregister timeout was reduced
> because timeout failure is the same as timeout.
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
