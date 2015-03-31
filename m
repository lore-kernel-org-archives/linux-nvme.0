From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 31 Mar 2015 10:38:01 -0600
Subject: [PATCH] NVMe: Freeze admin queue on device failure
In-Reply-To: <1427399373-19746-1-git-send-email-keith.busch@intel.com>
References: <1427399373-19746-1-git-send-email-keith.busch@intel.com>
Message-ID: <551ACD69.7050501@kernel.dk>

On 03/26/2015 01:49 PM, Keith Busch wrote:
> This fixes a race accessing an invalid address when a controller's admin
> queue is in use during a reset for failure or hot removal occurs. The
> admin queue will be frozen to prevent new users from entering prior to
> the doorbell queue being unmapped.

Applied for 4.1.

-- 
Jens Axboe
