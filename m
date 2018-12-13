From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 09:51:04 +0100
Subject: sparse fixes
Message-ID: <20181213085107.17183-1-hch@lst.de>

Mostly endianess annoations in the new TCP code, but
nvme_poll_irqdisable didn't make sparse happy, so a small fix there
as well.
