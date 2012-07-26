From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 26 Jul 2012 12:23:55 -0400
Subject: [PATCH] NVMe: Fix nvme module init when nvme_major is set
In-Reply-To: <1343253918-32481-1-git-send-email-keith.busch@intel.com>
References: <1343253918-32481-1-git-send-email-keith.busch@intel.com>
Message-ID: <20120726162355.GE22985@linux.intel.com>

On Wed, Jul 25, 2012@04:05:18PM -0600, Keith Busch wrote:
> register_blkdev returns 0 when given a valid major number.

Thanks, applied.
