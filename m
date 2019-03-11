From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Mar 2019 19:26:48 +0100
Subject: [PATCH 3/8] nvme/pci: Remove tag check in nvme_process_cq
In-Reply-To: <20190308174313.5134-3-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-3-keith.busch@intel.com>
Message-ID: <20190311182648.GC11448@lst.de>

On Fri, Mar 08, 2019@10:43:08AM -0700, Keith Busch wrote:
> Simplify processing completions by removing the check for the optional
> search tag. The timeout handling was the only place using this, but we
> can check the request state directly instead of searching the completion
> entries. There is a chance the command was not actually polled in this
> implementation, but we don't want to escalate error recovery in that
> case anyway, and the warning is still informative either way.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
