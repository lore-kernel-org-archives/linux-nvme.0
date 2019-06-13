From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Jun 2019 10:44:58 +0200
Subject: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi
 host
In-Reply-To: <cd713506efb9579d1f69a719d831c28d@mail.gmail.com>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-11-hch@lst.de>
 <cd713506efb9579d1f69a719d831c28d@mail.gmail.com>
Message-ID: <20190613084458.GB13221@lst.de>

So before I respin this series, can you help with a way to figure out
for mpt3sas and megaraid if a given controller supports NVMe devices
at all, so that we don't have to set the virt boundary if not?
