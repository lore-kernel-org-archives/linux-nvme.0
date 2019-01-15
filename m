From: hch@lst.de (Christoph Hellwig)
Date: Tue, 15 Jan 2019 06:51:43 +0100
Subject: [PATCH] nvme-multipath: drop optimization for static ANA group IDs
In-Reply-To: <20190109184300.GC22070@lst.de>
References: <20190109084515.82076-1-hare@suse.de>
 <20190109184300.GC22070@lst.de>
Message-ID: <20190115055143.GA21603@lst.de>

On Wed, Jan 09, 2019@07:43:00PM +0100, Christoph Hellwig wrote:
> Isn't the real bug that we always clear groups_only in nvme_ana_work,
> and we could simply make the conditional instead?

Hannes, can you look into this?
