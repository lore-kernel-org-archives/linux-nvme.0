From: hch@lst.de (Christoph Hellwig)
Date: Tue, 7 Jun 2016 22:27:27 +0200
Subject: NVMe over Fabrics RDMA transport drivers
In-Reply-To: <6ed161c3-d7d2-909f-6f17-7d75c36ed5b2@opengridcomputing.com>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <5756B695.5020305@grimberg.me>
 <9C6B67F36DCAFC479B1CF6A967258A8C7DDCB23D@ORSMSX115.amr.corp.intel.com>
 <6ed161c3-d7d2-909f-6f17-7d75c36ed5b2@opengridcomputing.com>
Message-ID: <20160607202727.GA16366@lst.de>

On Tue, Jun 07, 2016@03:14:22PM -0500, Steve Wise wrote:
> It would be great to make sure and CC linux-rdma on v2 of all 4 series, so 
> interested folks can review and/or test out the whole enchilada.

Just go for the git tree at

	git://git.infradead.org/nvme-fabrics.git nvmf-all

to make your life easier for that..  I'll include the list on the next
repost, although I hope the first series with it's mostly protocol header
changes can go in before needing to repost the rest, they are all pretty
trivial.
