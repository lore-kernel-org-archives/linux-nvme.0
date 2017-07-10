From: james.smart@broadcom.com (James Smart)
Date: Mon, 10 Jul 2017 16:44:12 -0700
Subject: [PATCH 3/7] nvme/fc: remove unused "queue_size" field
In-Reply-To: <1499444581-28268-4-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-4-git-send-email-keith.busch@intel.com>
Message-ID: <87b2851b-07f8-c24d-789c-ddc3e3d6cd0e@broadcom.com>

On 7/7/2017 9:22 AM, Keith Busch wrote:
> This was being saved in a structure, but never used anywhere. The queue
> size is obtained through other means, so there's no reason to duplicate
> this without a user for it.
>
Looks good

Reviewed-by:  James Smart <james.smart at broadcom.com>
