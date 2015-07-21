From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 21 Jul 2015 09:40:53 -0600
Subject: [PATCHv5 0/2] NVMe: Enable SQes on the CMB
In-Reply-To: <1437408849-4099-1-git-send-email-jonathan.derrick@intel.com>
References: <1437408849-4099-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <55AE6805.6080308@kernel.dk>

On 07/20/2015 10:14 AM, Jon Derrick wrote:
> This set unifies the command submission path, enables the cmb, and  maps
> submission queues onto the controller memory buffer.
>
> Applies against axboe's linux-block/master

Applied for 4.3.

-- 
Jens Axboe
