From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Oct 2015 05:59:32 -0700
Subject: [PATCH 1/2] NVMe: Reference count open namespaces
In-Reply-To: <1443741251-13274-2-git-send-email-keith.busch@intel.com>
References: <1443741251-13274-1-git-send-email-keith.busch@intel.com>
 <1443741251-13274-2-git-send-email-keith.busch@intel.com>
Message-ID: <20151002125932.GA11175@infradead.org>

Shouldn't each namesapce have a reference on the nvme_dev while we're at
it?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
