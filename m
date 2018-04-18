From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Apr 2018 17:07:10 +0200
Subject: [PATCH] nvme: fix the suspicious RCU usage warning in
 nvme_mpath_clear_current_path
In-Reply-To: <20180418144524.GL11513@localhost.localdomain>
References: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180418144524.GL11513@localhost.localdomain>
Message-ID: <20180418150710.GB7862@lst.de>

On Wed, Apr 18, 2018@08:45:25AM -0600, Keith Busch wrote:
> Nothing against this patch. This just doesn't look correct even from
> before since nvme_find_path can set head->current_path right back to
> this namespace that we're trying to clear.
> 
> Christoph, am I missing something here or does this need additional
> checks/synchronization?

Yes, we should probably call it after removing the namespace from
the ns_head list, instead of right before.
