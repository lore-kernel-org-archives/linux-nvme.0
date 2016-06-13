From: keith.busch@intel.com (Keith Busch)
Date: Mon, 13 Jun 2016 18:08:09 -0400
Subject: [PATCH] NVMe:Support for Host Memory Buffer(HMB)
In-Reply-To: <1465565964-7167-1-git-send-email-a.dawn@samsung.com>
References: <1465565964-7167-1-git-send-email-a.dawn@samsung.com>
Message-ID: <20160613220808.GI12766@localhost.localdomain>

On Fri, Jun 10, 2016@07:09:24PM +0530, Arnav Dawn wrote:
> +		if (hmb_allocated < (dev->hmb.host_mem_min << 10))
> +			goto release_hmb;

The spec allows HMMIN be 0, meaning no minimum requirement, so need to
account for that.
