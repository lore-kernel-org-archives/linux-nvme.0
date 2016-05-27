From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 27 May 2016 00:41:14 -0700
Subject: [PATCH] NVMe: Fix removal in case of active namespace list
 scanning method
In-Reply-To: <1464261642-17578-1-git-send-email-sunad.s@samsung.com>
References: <1464261642-17578-1-git-send-email-sunad.s@samsung.com>
Message-ID: <20160527074114.GC950@infradead.org>

> +		if (ns->ns_id > nsid) {
> +			nvme_ns_remove(ns);
> +		}

no need for this set of curly braces.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
