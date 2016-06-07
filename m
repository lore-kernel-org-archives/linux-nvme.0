From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:16 +0200
Subject: NVMe over Fabrics support for nvme-cli
Message-ID: <1465312767-10070-1-git-send-email-hch@lst.de>

Hi Keith,

the series below adds support for the discovery, connect, connect-all and
disconnect commands to nvme-cli, which are useful to support the NVMe over
Fabrics host code.  Most of the work is from Ming with various bits and
pieces from me.  I also did the final rebase to the latest master tree.
