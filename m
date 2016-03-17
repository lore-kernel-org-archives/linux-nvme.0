From: keith.busch@intel.com (Keith Busch)
Date: Thu, 17 Mar 2016 15:33:35 +0000
Subject: [PATCH RFC] nvme: rewrite discard support
In-Reply-To: <1458170132-16031-1-git-send-email-mlin@kernel.org>
References: <1458170132-16031-1-git-send-email-mlin@kernel.org>
Message-ID: <20160317153335.GB6217@localhost.lm.intel.com>

On Wed, Mar 16, 2016@04:15:32PM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> This rewrites nvme_setup_discard() similar as sd_setup_discard_cmnd().
> And moves it to common code so fabrics driver can also use it.

Initial thoughts on this, I see the appeal to having a generic NVMe
discard setup, but I liked the existing implementation not needing a
special case for discard check on every IO in the completion handler.

Allocating a page for just 16 bytes of data seems a bit wasteful even
if it is short-lived. When it was allocating 256b from the DMA pool,
the smaller amount of additional data seemed worth it for not creating
a conditional completion.
