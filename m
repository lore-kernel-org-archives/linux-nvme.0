From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 21 Feb 2016 08:18:20 -0800
Subject: [PATCH-4.6 1/3] NVMe: Use simple ida interface
In-Reply-To: <1455837677-23248-1-git-send-email-keith.busch@intel.com>
References: <1455837677-23248-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160221161820.GC21896@infradead.org>

On Thu, Feb 18, 2016@04:21:15PM -0700, Keith Busch wrote:
> This is an easier interface to use and removes one of the overloaded
> dev_list_lock uses.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> Feature was originally posted by Lee Duncan last October, but this missed
> being applied.

So is Lee's patch or yours?

Either way it looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
