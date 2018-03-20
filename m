From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Mar 2018 09:48:02 +0100
Subject: [PATCH] nvme: Skip checking heads without namespaces
In-Reply-To: <20180319165350.9879-1-keith.busch@intel.com>
References: <20180319165350.9879-1-keith.busch@intel.com>
Message-ID: <20180320084802.GA16371@lst.de>

On Mon, Mar 19, 2018@10:53:50AM -0600, Keith Busch wrote:
> If a task is holding a reference to a namespace on a removed controller,
> the head will not be released. If the same controller is added again
> later, its namespaces may not be successfully added. Instead, the user
> will see kernel message "Duplicate IDs for nsid <X>".
> 
> This patch fixes that by skipping heads that don't have namespaces when
> considering if a new namespace is safe to add.

Delayed reference strike once again, sigh.

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
