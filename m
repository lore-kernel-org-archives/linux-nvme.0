From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 12 Apr 2016 12:02:52 -0700
Subject: [PATCHv2] NVMe: Skip async events for degraded controllers
In-Reply-To: <1460481191-19012-1-git-send-email-keith.busch@intel.com>
References: <1460481191-19012-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160412190252.GF32482@infradead.org>

On Tue, Apr 12, 2016@11:13:11AM -0600, Keith Busch wrote:
> If the controller is degraded, the driver should stay out of the way so
> the user can recover the drive. This patch skips driver initiated async
> event requests when the drive is in this state.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
