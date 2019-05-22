From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 22 May 2019 10:46:48 -0700
Subject: [PATCH v2 4/4] nvme-pci: support thermal zone
In-Reply-To: <1558454649-28783-5-git-send-email-akinobu.mita@gmail.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-5-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190522174648.GA26477@infradead.org>

Is there any good reason why we need to call this from the PCIe driver
instead of handling it all in the core?

Sure non-PCIe devices are usually external, but so are some PCIe
devices, so if we really care about that we need some sort of flag
anyway.
