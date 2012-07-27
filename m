From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 27 Jul 2012 14:26:06 -0400
Subject: [PATCH] NVMe: Fix uninitialized iod compiler warning
In-Reply-To: <1343411608-16133-1-git-send-email-keith.busch@intel.com>
References: <1343411608-16133-1-git-send-email-keith.busch@intel.com>
Message-ID: <20120727182605.GN22985@linux.intel.com>

On Fri, Jul 27, 2012@11:53:28AM -0600, Keith Busch wrote:
> -	struct nvme_iod *iod;
> +	struct nvme_iod *uninitialized_var(iod);

Thanks, applied.
