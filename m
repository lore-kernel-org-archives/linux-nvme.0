From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 Aug 2017 12:49:35 +0200
Subject: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170816104935.GA30525@lst.de>

Did you get a chance to take a look at converting PCIe over?

A lot of the design decisions seem to be driven by allowing PCIe
as well, and I'd like to see if that's possible / useful to start
with.
