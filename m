From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 26 Jul 2012 10:50:57 -0400
Subject: [PATCH] NVMe: fix uninitialized iod compiler warning
In-Reply-To: <1343253869-30836-1-git-send-email-keith.busch@intel.com>
References: <1343253869-30836-1-git-send-email-keith.busch@intel.com>
Message-ID: <20120726145057.GC22985@linux.intel.com>

On Wed, Jul 25, 2012@04:04:29PM -0600, Keith Busch wrote:
>  	int status, length;
> -	struct nvme_iod *iod;
> +	struct nvme_iod *iod = NULL;
>  

So this is a compiler bug.  And it's not present in every compiler
version; it didn't occur on my machine until I upgraded gcc recently.
There's no way that iod can be used uninitialised.  The correct way to
indicate this is:

+	struct nvme_iod *uninitialized_var(iod);
