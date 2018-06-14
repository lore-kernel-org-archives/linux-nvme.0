From: hch@lst.de (Christoph Hellwig)
Date: Thu, 14 Jun 2018 12:20:01 +0200
Subject: Requirement to get BAR pci_bus_address in user space
In-Reply-To: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
Message-ID: <20180614102001.GA20836@lst.de>

The only safe way to use PCI(e) devices in userspace is through vfio.
I think that is where you need to take your inquiries.
