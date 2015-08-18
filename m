From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 18 Aug 2015 11:56:53 -0600
Subject: [RESEND PATCH 1/2] NVMe: Add nvme subsystem reset support
In-Reply-To: <1439241641-3444-1-git-send-email-keith.busch@intel.com>
References: <1439241641-3444-1-git-send-email-keith.busch@intel.com>
Message-ID: <55D371E5.3090804@kernel.dk>

On 08/10/2015 03:20 PM, Keith Busch wrote:
> Controllers part of an NVMe subsystem may be reset by any other controller
> in the subsystem. If the device is capable of subsystem resets, this
> patch adds detection for such events and performs appropriate controller
> initialization upon subsystem reset detection.
>
> The register bit is a RW1C type, so the driver needs to write a 1 to the
> status bit to clear the subsystem reset occured bit during initialization.

Applied 1+2.


-- 
Jens Axboe
