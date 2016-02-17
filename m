From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Feb 2016 13:40:58 +0000
Subject: [PATCH 1/2] NVMe: Lock out shutdown during pci init
In-Reply-To: <20160217075913.GA14303@infradead.org>
References: <1455231626-7166-1-git-send-email-keith.busch@intel.com>
 <20160213095851.GA15206@infradead.org>
 <20160216184046.GA8415@localhost.localdomain>
 <20160217075913.GA14303@infradead.org>
Message-ID: <20160217134057.GA30059@localhost.localdomain>

On Tue, Feb 16, 2016@11:59:13PM -0800, Christoph Hellwig wrote:
> I always thought there was a deep reason we'd need to unmap it.  But
> if there isn't getting rid of the unmap should make the driver a lot
> more robust.

Remapping after each reset was prepping for a non-existent feature.
We'd like to create domains safe for the PCI core to reassign bus numbers
and memory windows on a live system for various hot plug scenarios,
but I don't see that happening soon.
