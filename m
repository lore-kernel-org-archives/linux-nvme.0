From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 28 Jun 2016 01:32:48 -0700
Subject: [PATCH 3/3] nvme: Put invalid namespaces on removal list
In-Reply-To: <1466702946-13065-4-git-send-email-keith.busch@intel.com>
References: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
 <1466702946-13065-4-git-send-email-keith.busch@intel.com>
Message-ID: <20160628083248.GC32618@infradead.org>

> +		if (ns->ns_id > nsid) {
> +			list_del_init(&ns->list);
> +			list_add_tail(&ns->list, &rm_list);
> +		}

This should use list_move_tail instead of the list_del_init /
list_add_tail combination.
