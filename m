From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Jun 2017 01:11:29 +0200
Subject: nvme defintions not used in the kernel
Message-ID: <20170628231129.GA20902@lst.de>

Hi all,

currently nvme-cli supports various nvme features that are not
needed in the kernel and keeps them in its own nvme.h file,
in addition to pulling in the kernel one.

Do we want to keep it that way in the long run, or just add
things to nvme.h in the kernel even if they are not used to
keep things in a single place.

To me the latter would seem a little nicer, especially as it
doesn't involve a whole lot of defintion.
