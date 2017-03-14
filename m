From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 14 Mar 2017 09:23:51 -0700
Subject: [PATCH] nvme-cli/format: use existing LBAF if none requested
In-Reply-To: <1489506857-24366-1-git-send-email-keith.busch@intel.com>
References: <1489506857-24366-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170314162351.GA21130@infradead.org>

This looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>

Btw, we really should do something about the global format behavior
bits in FNA - if bit 0 or 1 are set we should fail formats that
are specific to a namespace and not global with a warnings.
