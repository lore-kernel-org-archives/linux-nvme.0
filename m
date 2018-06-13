From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Jun 2018 09:53:11 +0200
Subject: nvme-cli code quality
Message-ID: <20180613075311.GA22867@lst.de>

Hi Keith,

can we please enforce linux-nvme list based reviews for nvme-cli?

It seems like a lot of code gets merged really quickly while still in
horrible shape (e.g. the recent seagate plugin, not that other plugins
are that great either).

I think we should try to enforce our normal quality requirements instead
of letting it turn into a huge mess.  Especially as reviews on a closed
platform like github just don't seem to work at all.
