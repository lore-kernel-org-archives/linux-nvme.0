From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 6 Nov 2012 16:03:56 -0500
Subject: [PATCH] NVMe: Initialize iod nents to 0
In-Reply-To: <1352228363-4937-1-git-send-email-keith.busch@intel.com>
References: <1352228363-4937-1-git-send-email-keith.busch@intel.com>
Message-ID: <20121106210356.GV4244@linux.intel.com>

On Tue, Nov 06, 2012@11:59:23AM -0700, Keith Busch wrote:
> For commands that do not map a scatter list, we need to initilaize the iod's
> number of sg entries (nents) to 0 and not unmap in this case.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Thanks; applied
