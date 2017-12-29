From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 10:44:14 +0100
Subject: [PATCH 1/3] nvme/pci: Start request after doorbell ring
In-Reply-To: <20171221204636.2924-2-keith.busch@intel.com>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
Message-ID: <20171229094414.GA24043@lst.de>

Looks fine, although I agree a comment on the q_lock exclusion would
be useful.
