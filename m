From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 Aug 2017 10:13:46 +0200
Subject: nvme-4.14 rebased
Message-ID: <20170816081346.GA18770@lst.de>

Hi all,

I've rebased the nvme-4.14 branch on top of the nvme-4.13 branch
to avoid conflicts.  As part of that I made the timestamp set features
return an error similar to the other reset fixes.

Jon: can you double check the change is correct?
