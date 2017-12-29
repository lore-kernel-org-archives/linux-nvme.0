From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 10:28:22 +0100
Subject: [PATCH] nvme-pci: don't open-code nvme_reset_ctrl
In-Reply-To: <20171225133717.4557-1-sagi@grimberg.me>
References: <20171225133717.4557-1-sagi@grimberg.me>
Message-ID: <20171229092822.GA23197@lst.de>

This looks ok, but I really having real functionality inside a WARN_ON
statement as that obsufcate? things.  But I don't think we even really
need the WARN_ON here at all.
