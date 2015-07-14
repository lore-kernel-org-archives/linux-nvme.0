From: axboe@fb.com (Jens Axboe)
Date: Tue, 14 Jul 2015 12:49:25 -0600
Subject: [PATCH] NVMe: Reread partitions on metadata formats
In-Reply-To: <1436896668-27373-1-git-send-email-keith.busch@intel.com>
References: <1436896668-27373-1-git-send-email-keith.busch@intel.com>
Message-ID: <55A559B5.2000303@fb.com>

On 07/14/2015 11:57 AM, Keith Busch wrote:
> This patch has the driver automatically reread partitions if a namespace
> has a separate metadata format. Previously revalidating a disk was
> sufficient to get the correct capacity set on such formatted drives,
> but partitions that may exist would not have been surfaced.

Looks sane to me. Paul, does this fix your issue?


-- 
Jens Axboe
