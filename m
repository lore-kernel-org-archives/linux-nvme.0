From: hch@lst.de (Christoph Hellwig)
Date: Wed, 20 Jun 2018 10:52:35 +0200
Subject: [PATCH 0/7] few nvme-rdma fixes for 4.18
In-Reply-To: <306127fb-c15e-a5c7-70cf-b4e39c328979@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180620084011.GC3284@lst.de>
 <306127fb-c15e-a5c7-70cf-b4e39c328979@grimberg.me>
Message-ID: <20180620085235.GA3880@lst.de>

On Wed, Jun 20, 2018@11:40:22AM +0300, Sagi Grimberg wrote:
> 4 is needed to prevent a theoretical hang in controller removal, but
> never encountered.

This one I'm indeed a little concerned about as I remember various
issues in this area in PCIe.  And RDMA is just different enough that
it doesn't look very similar.

> 5 is theoretical to a case where a dynamic controller changes its
> attributes.

5 looks simple enough (famous last words).

> So 4-5 can safely be included in 4.19

Ok, I've dropped 4 for now.
