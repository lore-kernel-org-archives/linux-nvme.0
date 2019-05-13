From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 May 2019 08:25:08 +0200
Subject: detect duplicate cntlids v2
Message-ID: <20190513062510.756-1-hch@lst.de>

Hi all,

this series detects duplicate cntlids in a subsystems.  It is
based on a patch from Hannes.

Changes since v1:
 - add a lockdep check for a held lock
 - improve printk format
