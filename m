From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 15:04:23 +0200
Subject: [PATCHv3 7/9] nvme-pci: Attempt reset retry for IO failures
In-Reply-To: <20180524203500.14081-8-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-8-keith.busch@intel.com>
Message-ID: <20180525130423.GI23463@lst.de>

On Thu, May 24, 2018@02:34:58PM -0600, Keith Busch wrote:
> If the reset failed due to a non-fatal error, this patch will attempt
> to reset the controller again, with a maximum of 4 attempts.

What kind of non-fatal errors do you see that this tries to handle?
