From: keith.busch@intel.com (Keith Busch)
Date: Thu, 30 Nov 2017 14:40:44 -0700
Subject: [PATCH] nvme-cli: replace values of all namespaces with
 NVME_NSID_ALL
In-Reply-To: <1512053359-15141-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1512053359-15141-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20171130214043.GC31358@localhost.localdomain>

On Thu, Nov 30, 2017@11:49:19PM +0900, Minwoo Im wrote:
> Replace all magic numbers(0xffffffff) which means all namespaces
> with NVME_NSID_ALL applied by a commit
> c5a1120("nvme-cli: resync nvme.h with the kernel's").
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>

Thanks, applied.
