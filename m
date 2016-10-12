From: axboe@fb.com (Jens Axboe)
Date: Wed, 12 Oct 2016 08:40:57 -0600
Subject: [PATCH] nvme: Stop probing a removed device
In-Reply-To: <1476207118-10113-1-git-send-email-keith.busch@intel.com>
References: <1476207118-10113-1-git-send-email-keith.busch@intel.com>
Message-ID: <01aeea30-b515-6d9d-0676-2fa00743bc32@fb.com>

On 10/11/2016 11:31 AM, Keith Busch wrote:
> There is no reason the nvme controller can ever return all 1's from
> reading the CSTS register. This patch returns an error if we observe
> that status. Without this, we may incorrectly proceed with controller
> initialization and unnecessarilly rely on error handling to clean this.

Applied for this series.

Due to being away for a bit, I'm currently a bit behind on patches. I'll
be going over those today. But if you, or anyone else, have things
pending that I haven't picked up yet, do send me a ping.

-- 
Jens Axboe
