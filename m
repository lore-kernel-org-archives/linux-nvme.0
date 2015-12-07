From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 7 Dec 2015 15:30:20 -0800
Subject: [PATCHv2] NVMe: Add pci error handlers
In-Reply-To: <1449527431-23749-1-git-send-email-keith.busch@intel.com>
References: <1449527431-23749-1-git-send-email-keith.busch@intel.com>
Message-ID: <20151207233020.GA26585@infradead.org>

On Mon, Dec 07, 2015@03:30:31PM -0700, Keith Busch wrote:
> Requests enabling pcie aer support. Shuts down the controller on error
> detected with io frozen state prior to requesting slot reset; resumes
> controller after reset completes.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
