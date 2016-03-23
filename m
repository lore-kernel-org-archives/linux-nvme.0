From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 23 Mar 2016 00:44:28 -0700
Subject: [PATCHv2] NVMe: Fix reset/remove race
In-Reply-To: <1458683375-27496-1-git-send-email-keith.busch@intel.com>
References: <1458683375-27496-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160323074428.GA12829@infradead.org>

This looks ok:

Reviewed-by: Christoph Hellwig <hch at lst.de>

But this just shows we'll finally need a real state machine for the
NVMe controller instead of the flags.  Sagi did a really nice one
for the Fabrics driver, and I'll plan to lift it to common code for
4.7.
