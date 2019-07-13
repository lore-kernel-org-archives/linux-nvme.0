From: hare@suse.de (Hannes Reinecke)
Date: Sat, 13 Jul 2019 09:09:13 +0200
Subject: [PATCH] nvme-vendor: fix c99 declarations in vendor plugins
In-Reply-To: <20190712153457.13877-1-sschricker@suse.de>
References: <20190712153457.13877-1-sschricker@suse.de>
Message-ID: <d1bbc2ed-0b84-4be8-0d0d-055260877c21@suse.de>

On 7/12/19 5:34 PM, Simon Schricker wrote:
> We can't use c99 declarations with older compilers.
> 
> Signed-off-by: Simon Schricker <sschricker at suse.de>
> ---
>   plugins/micron/micron-nvme.c   | 3 ++-
>   plugins/toshiba/toshiba-nvme.c | 9 ++++++---
>   2 files changed, 8 insertions(+), 4 deletions(-)
> One should be doing a whitespace cleanup on those, but otherwise:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
