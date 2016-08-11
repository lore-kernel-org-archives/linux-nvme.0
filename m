From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Aug 2016 14:02:03 -0700
Subject: [PATCH] nvme-fabrics: set sqe.command_id in core, not transports
In-Reply-To: <5792b918.ManFlYqqCmUKB4ry%james.smart@broadcom.com>
References: <5792b918.ManFlYqqCmUKB4ry%james.smart@broadcom.com>
Message-ID: <20160811210203.GB18013@infradead.org>

This needs to cover the loop and PCI driver a swell.
