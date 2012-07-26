From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 26 Jul 2012 13:43:58 -0400
Subject: [PATCH] NVMe: Set block queue max sectors
In-Reply-To: <1343323797-11369-1-git-send-email-keith.busch@intel.com>
References: <1343323797-11369-1-git-send-email-keith.busch@intel.com>
Message-ID: <20120726174358.GI22985@linux.intel.com>

On Thu, Jul 26, 2012@11:29:57AM -0600, Keith Busch wrote:
> Set the max hw sectors in a namespace's request queue if the nvme device
> has a max data transfer size.

Thanks, committed.  There was trailing whitespace that I fixed up.
