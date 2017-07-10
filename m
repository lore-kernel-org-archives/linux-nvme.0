From: james.smart@broadcom.com (James Smart)
Date: Mon, 10 Jul 2017 16:12:42 -0700
Subject: [PATCH 1/7] nvme/fc: There is only one AEN request
In-Reply-To: <1499444581-28268-2-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-2-git-send-email-keith.busch@intel.com>
Message-ID: <1f6ac597-ed8a-1a87-7b87-dbaf88982bff@broadcom.com>

On 7/7/2017 9:22 AM, Keith Busch wrote:
> This patch removes the multiple AEN request handling. There can be
> only one.
>

Looks fine, although my style would have defined a local variable of 
aen_op rather than continued use of ctrl->aen_op.

Reviewed-By: James Smart <james.smart at broadcom.com>

-- james
