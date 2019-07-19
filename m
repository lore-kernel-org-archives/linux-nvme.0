From: hch@lst.de (Christoph Hellwig)
Date: Fri, 19 Jul 2019 14:28:59 +0200
Subject: [PATCH v3] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
In-Reply-To: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
Message-ID: <20190719122859.GA30193@lst.de>

Yikes, that things looks worse and worse.  I think at this point we'll
have to defer the support to 5.4 unfortunately as it is getting more
and more involved..
