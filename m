From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 Mar 2016 20:40:52 +0000
Subject: [PATCH v2 0/4] rewrites discard support
In-Reply-To: <1458631486-14120-1-git-send-email-mlin@kernel.org>
References: <1458631486-14120-1-git-send-email-mlin@kernel.org>
Message-ID: <20160322204051.GB4188@localhost.localdomain>

On Tue, Mar 22, 2016@12:24:42AM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> This rewrites nvme_setup_discard() with blk_add_request_payload().
> And moves it to common code so fabrics driver can also use it.

Looks fine, for the series.

Reviewed-by: Keith Busch <keith.busch at intel.com>
