From: keith.busch@intel.com (Keith Busch)
Date: Thu, 23 Jun 2016 13:44:57 -0400
Subject: [PATCH 0/3] Namespace iteration fixes
In-Reply-To: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
References: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160623174457.GK1448@localhost.localdomain>

Just correcting Sagi's email in the CC. I copy/pasted from a review in
an different message(*), but was missing some letters there too. :)

  * https://lkml.org/lkml/2016/6/23/529

On Thu, Jun 23, 2016@11:29:03AM -0600, Keith Busch wrote:
> Patch 1/3 cleanly applies to linux-block/for-linus and for-next. The
> other two only apply to for-next.
> 
> The first fixes a bug introduced in 4.7 and hoping this can be applied
> to 4.7. It's version 2 of this patch. The reset of the series is targeted
> to 4.8. 
> 
> The second patch fixes issues where buffered writers block removal
> from proceeding.
> 
> The third locks the namespace mutex when searching for invalid
> namespaces. While it doesn't appear necessary in the existing paths that
> use it, it makes this function safe for potential future use.
> 
> Keith Busch (3):
>   nvme: Remove RCU namespace protection
>   nvme: Kill detached namespaces prior to removal
>   nvme: Put invalid namespaces on removal list
> 
>  drivers/nvme/host/core.c | 112 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 67 insertions(+), 45 deletions(-)
> 
> -- 
> 2.7.2
