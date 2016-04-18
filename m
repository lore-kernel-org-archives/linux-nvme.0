From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 Apr 2016 15:28:01 +0000
Subject: [PATCH] nvme: add helper nvme_cleanup_cmd()
In-Reply-To: <1460871346-10811-1-git-send-email-mlin@kernel.org>
References: <1460871346-10811-1-git-send-email-mlin@kernel.org>
Message-ID: <20160418152800.GB4640@localhost.localdomain>

On Sat, Apr 16, 2016@10:35:46PM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> This hides command cleanup into core.c and fabrics drivers will
> also use it.

Can we just make this a static inline in nvme.h instead of adding a
new export?
