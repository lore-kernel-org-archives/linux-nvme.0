From: hare@suse.com (Hannes Reinecke)
Date: Mon, 8 Jan 2018 09:59:28 +0100
Subject: [PATCH 5/5] dm mpath: Use blk_retryable
In-Reply-To: <20180104224623.8944-6-keith.busch@intel.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-6-keith.busch@intel.com>
Message-ID: <cc35a658-5a88-05e9-8c0b-a173037390a9@suse.com>

On 01/04/2018 11:46 PM, Keith Busch wrote:
> Uses common code for determining if an error should be retried on
> alternate path.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/md/dm-mpath.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
