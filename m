From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 13 May 2015 09:32:52 -0400
Subject: [PATCH] block:Change the function,nvme_alloc_queue to use
 -ENOMEM for when failing memory allocations
In-Reply-To: <1431474691-30469-1-git-send-email-xerofoify@gmail.com>
References: <1431474691-30469-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20150513133252.GW4003@linux.intel.com>

On Tue, May 12, 2015@07:51:31PM -0400, Nicholas Krause wrote:
> This changes the function,nvme_alloc_queue to use the kernel code,
> -ENOMEM for when failing to allocate the memory required for the
> nvme_queue structure pointer,nvme in order to correctly return
> to the caller the correct reason for this function's failing.

>  	if (!nvmeq)
> -		return NULL;
> +		return -ENOMEM;
>  

You didn't even compile-test this, did you?
