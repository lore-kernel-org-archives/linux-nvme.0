From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Jun 2017 09:42:19 +0200
Subject: [PATCH v6 02/10] nvmet: use NVME_IDENTIFY_DATA_SIZE
In-Reply-To: <20170607094536.32419-3-jthumshirn@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170607094536.32419-3-jthumshirn@suse.de>
Message-ID: <20170608074219.GB13953@lst.de>

Looks good, but we should also use this for BUILD_BUG_ON
checks on the identify payloads, bug I can fix that up.

Reviewed-by: Christoph Hellwig <hch at lst.de>
