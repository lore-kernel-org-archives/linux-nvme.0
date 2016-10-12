From: keith.busch@intel.com (Keith Busch)
Date: Wed, 12 Oct 2016 15:23:30 -0400
Subject: nvme-cli documentation updates
In-Reply-To: <1476261953-23119-1-git-send-email-hch@lst.de>
References: <1476261953-23119-1-git-send-email-hch@lst.de>
Message-ID: <20161012192329.GA12827@localhost.localdomain>

On Wed, Oct 12, 2016@10:45:50AM +0200, Christoph Hellwig wrote:
> [third try, I'm really got as using the wrong list address today.  Sorry Jay.. :)]
> 
> This series improves the nvme-discover manpage a bit, and adds a new
> one for nvme-connect-all.  I would have preferred to share a page for
> both commands as there is a lot of duplication, but I couldn't find a way
> to do that.

I applied them all and regenerated the man and html pages. I had to make
one minor change to connect-all.txt to get asciidoc to understand the
header portion.

I had to fixup the multipart conent type in patches 2/3 and 3/3, and
missed J's comments while doing that. I'll apply updates on top of the
current master if we need to change any wording.
