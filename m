From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Jun 2019 08:10:38 +0200
Subject: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
In-Reply-To: <20190620051333.2235-3-drake@endlessm.com>
References: <20190620051333.2235-1-drake@endlessm.com>
 <20190620051333.2235-3-drake@endlessm.com>
Message-ID: <20190620061038.GA20564@lst.de>

Please give up on this route.  We will not accept messing the NVMe
driver for Intels fucked up chipsets that are so bad that even they
are not allowed to talk about it anymore.

The Linux NVMe driver will deal with NVMe as specified plus whatever
minor tweaks we'll need for small bugs.  Hiding it behind an AHCI
device is completely out of scope and will not be accepted.
