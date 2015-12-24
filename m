From: hch@lst.de (Christoph Hellwig)
Date: Thu, 24 Dec 2015 12:40:40 +0100
Subject: [PATCH 3/3] nvme: make SG_IO support optional
In-Reply-To: <567BD794.2020607@dev.mellanox.co.il>
References: <1450952155-8693-1-git-send-email-hch@lst.de>
 <1450952155-8693-4-git-send-email-hch@lst.de>
 <567BCB6C.6000502@dev.mellanox.co.il> <20151224111248.GB15268@lst.de>
 <567BD794.2020607@dev.mellanox.co.il>
Message-ID: <20151224114040.GA17820@lst.de>

On Thu, Dec 24, 2015@01:31:32PM +0200, Sagi Grimberg wrote:
> OK, I see what you mean. We can look at having multipathd ioctl'ing
> identify_ns at some point...

block/for-next has the nguid available as a sysfs attribute, that's
all we should need.
