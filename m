From: hch@lst.de (Christoph Hellwig)
Date: Thu, 17 May 2018 18:31:45 +0200
Subject: RFC: handle completions outside the queue lock and split the queue
 lock
Message-ID: <20180517163152.23155-1-hch@lst.de>

Mostly the previous work from Jens, just with random cleanups from me
thrown in.  Based on nvme/nvme-4.18 minus the two top-most commits,
very lightly tested.
