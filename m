From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Feb 2016 09:21:46 +0100
Subject: [PATCH v2 0/5] split pci module out of core module
In-Reply-To: <1455062873-18392-1-git-send-email-mlin@kernel.org>
References: <1455062873-18392-1-git-send-email-mlin@kernel.org>
Message-ID: <20160210082146.GA9171@lst.de>

Patch 3 still says "export more symbols" while it exports the first
symbols.  Maybe it's better to just gold patch 3 into patch 5 where
the exports are use?

Otherwise looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
