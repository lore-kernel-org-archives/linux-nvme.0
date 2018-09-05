From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Sep 2018 23:13:51 +0200
Subject: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
In-Reply-To: <c41c802c-9235-5383-2dfa-af9c1553f11b@deltatee.com>
References: <20180905195647.GA1626@lst.de>
 <bcc1b3cf-2fd9-fa61-9cfb-b0e4d84e5d94@kernel.dk>
 <20180905201152.GA1893@lst.de>
 <eb42fb94-9da6-955b-8524-0a0f5ac4bd19@deltatee.com>
 <2a3394bd-5f13-4818-43f4-dfc61f501e05@kernel.dk>
 <e3ef26e6-6c8d-25b8-fa64-14594a51263c@deltatee.com>
 <3af4d1d4-da07-c0a6-8464-9ddc1378f2f4@kernel.dk>
 <f9e660cd-b597-bb6e-56a2-82fe71cb3649@deltatee.com>
 <34d9b2f7-9e6d-4a0a-77e5-ec0e99610f5c@kernel.dk>
 <c41c802c-9235-5383-2dfa-af9c1553f11b@deltatee.com>
Message-ID: <20180905211351.GA2927@lst.de>

On Wed, Sep 05, 2018@03:03:18PM -0600, Logan Gunthorpe wrote:
> There is no special p2p submission process. In the nvme-of case we are
> using the existing process and with the code in blk-core it didn't
> change it's process at all. Creating a helper will create one and I can
> look at making a pci_p2pdma_submit_bio() for v6; but if the developer
> screws up and still calls the regular submit_bio() things will only be
> very subtly broken and that won't be obvious.

I thought about that when reviewing the previous series, and even
started hacking it up.  In the end I decided against it for the above
reason - it just adds code, but doesn't actually help with anything
as it is trivial to forget, and not using it will in fact just work.
