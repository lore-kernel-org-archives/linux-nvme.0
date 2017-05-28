From: hch@lst.de (Christoph Hellwig)
Date: Sun, 28 May 2017 11:40:43 +0200
Subject: [PATCH V3] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170526201351.GA21847@dhcp-216.srv.tuxera.com>
References: <20170526201351.GA21847@dhcp-216.srv.tuxera.com>
Message-ID: <20170528094043.GA14199@lst.de>

Hi Rkesh,

this looks reasonable, but we'll need to also adopt the non-PCI
driver to the new state machine.  I can give this a spin.

At that point we probably want to move nvme_reset into common
code somehow.
