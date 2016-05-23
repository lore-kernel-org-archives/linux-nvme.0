From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 May 2016 03:52:59 -0700
Subject: [PATCH 2/2] nvme/pci: Enable SR-IOV capabilities
In-Reply-To: <1463521199-16604-2-git-send-email-keith.busch@intel.com>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <1463521199-16604-2-git-send-email-keith.busch@intel.com>
Message-ID: <20160523105259.GA26331@infradead.org>

Doesn't look fine (because the API is a mess), but the best we can do
for now:

Reviewed-by: Christoph Hellwig <hch at lst.de>
