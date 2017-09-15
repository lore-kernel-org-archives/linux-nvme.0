From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Sep 2017 20:07:01 +0200
Subject: [PATCH 00/10] nvme multipath support on top of nvme-4.13 branch
In-Reply-To: <20170912042048.pdbyl6vsoeui6bnp@haynes>
References: <20170912042048.pdbyl6vsoeui6bnp@haynes>
Message-ID: <20170915180701.GA8981@lst.de>

Hi Anish,

I looked over the code a bit, and I'm rather confused by the newly
added commands.  Which controller supports them?  Also the NVMe
working group went down a very different way with the ALUA approch,
which uses different grouping concepts and doesn't require path
activations - for Linux we'd really like to stick to only standardized
multipath implementations.
