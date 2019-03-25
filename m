From: hare@suse.de (Hannes Reinecke)
Date: Mon, 25 Mar 2019 08:18:10 +0100
Subject: [PATCH V2 8/8] blk-mq: remove blk_mq_tagset_busy_iter
In-Reply-To: <1553492318-1810-9-git-send-email-jianchao.w.wang@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-9-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <47fe0e2a-f427-0e3e-e15b-a9e2bffb502f@suse.de>

On 3/25/19 6:38 AM, Jianchao Wang wrote:
> As nobody uses blk_mq_tagset_busy_iter, remove it.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> ---
>   block/blk-mq-tag.c     | 95 --------------------------------------------------
>   include/linux/blk-mq.h |  2 --
>   2 files changed, 97 deletions(-)
> 
Please, don't.

I'm currently implementing reserved commands for SCSI and reworking the 
SCSI error handling where I rely on this interface quite heavily.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
