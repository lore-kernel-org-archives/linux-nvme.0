From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 24 Jun 2015 05:19:42 -0700
Subject: [PATCH] NVMe: Make nvme_meta_noop to supress Sparse warning
In-Reply-To: <1435006888-13851-1-git-send-email-jonathan.derrick@intel.com>
References: <1435006888-13851-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20150624121941.GA14590@infradead.org>

On Mon, Jun 22, 2015@03:01:28PM -0600, Jon Derrick wrote:
> Supresses warning emitted by Sparse.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>

Looks good, but the subject line seems be be missing a "static"
somewhere :)

Reviewed-by: Christoph Hellwig <hch at lst.de>
