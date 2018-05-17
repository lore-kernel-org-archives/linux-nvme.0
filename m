From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 17 May 2018 10:55:46 -0600
Subject: RFC: handle completions outside the queue lock and split the
 queue lock
In-Reply-To: <20180517163152.23155-1-hch@lst.de>
References: <20180517163152.23155-1-hch@lst.de>
Message-ID: <20180517165546.GE23555@localhost.localdomain>

On Thu, May 17, 2018@06:31:45PM +0200, Christoph Hellwig wrote:
> Mostly the previous work from Jens, just with random cleanups from me
> thrown in.  Based on nvme/nvme-4.18 minus the two top-most commits,
> very lightly tested.

Looking good. I can force push a rebase removing the current top-two
commits. Sound okay?
