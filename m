From: hch@lst.de (Christoph Hellwig)
Date: Thu, 17 May 2018 19:00:45 +0200
Subject: RFC: handle completions outside the queue lock and split the
 queue lock
In-Reply-To: <20180517165546.GE23555@localhost.localdomain>
References: <20180517163152.23155-1-hch@lst.de>
 <20180517165546.GE23555@localhost.localdomain>
Message-ID: <20180517170045.GA4945@lst.de>

On Thu, May 17, 2018@10:55:46AM -0600, Keith Busch wrote:
> On Thu, May 17, 2018@06:31:45PM +0200, Christoph Hellwig wrote:
> > Mostly the previous work from Jens, just with random cleanups from me
> > thrown in.  Based on nvme/nvme-4.18 minus the two top-most commits,
> > very lightly tested.
> 
> Looking good. I can force push a rebase removing the current top-two
> commits. Sound okay?

Yes, let's do that for now, and let pending series settle for another
day or two.
