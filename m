From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 May 2019 16:02:46 +0200
Subject: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
In-Reply-To: <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190513140246.GB24840@lst.de>

Usage of a scatterlist here is rather bogus as we never use
it for dma mapping.  Why can't you store the various pages in a
large bio_vec and then just issue that to the device in one
get log page command?  (or at least a few if MDTS kicks in?)
