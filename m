From: keith.busch@intel.com (Keith Busch)
Date: Mon, 25 Apr 2016 21:35:43 +0000
Subject: [PATCH v2] nvme: add helper nvme_cleanup_cmd()
In-Reply-To: <1461620000-18707-1-git-send-email-mlin@kernel.org>
References: <1461620000-18707-1-git-send-email-mlin@kernel.org>
Message-ID: <20160425213542.GC21270@localhost.localdomain>

On Mon, Apr 25, 2016@02:33:20PM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> This hides command cleanup into nvme.h and fabrics drivers will
> also use it.
> 
> Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
