From: hch@lst.de (Christoph Hellwig)
Date: Tue, 14 May 2019 07:58:32 +0200
Subject: PROBLEM: call trace triggered in 5.1.1 in
 drivers/nvme/host/pci.c, 5.0.11 ok
In-Reply-To: <CAC=wYCFhKR5YrAwL1agz=USg3DAkx5BtXAfv64nOfTrwTji40Q@mail.gmail.com>
References: <CAC=wYCGgPQPjUUjQTZh4H7b8WRQFGmbKCBRAq75g1BXjBR0L0Q@mail.gmail.com>
 <20190514052027.GB6294@lst.de>
 <CAC=wYCFhKR5YrAwL1agz=USg3DAkx5BtXAfv64nOfTrwTji40Q@mail.gmail.com>
Message-ID: <20190514055832.GA6843@lst.de>

On Tue, May 14, 2019@03:52:37PM +1000, Adam Carter wrote:
> How's this;

Better, as this prints the invalid sgls.  Not good enough yet because
it doesn't contain the early boot time information on what iommu
instance is used.
