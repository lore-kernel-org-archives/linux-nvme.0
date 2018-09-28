From: hch@lst.de (Christoph Hellwig)
Date: Fri, 28 Sep 2018 17:17:32 +0200
Subject: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
In-Reply-To: <20180928061723.13180-3-hare@suse.de>
References: <20180928061723.13180-1-hare@suse.de>
 <20180928061723.13180-3-hare@suse.de>
Message-ID: <20180928151732.GC8079@lst.de>

On Fri, Sep 28, 2018@08:17:20AM +0200, Hannes Reinecke wrote:
> We should be registering the ns_id attribute as default sysfs
> attribute groups, otherwise we have a race condition between
> the uevent and the attributes appearing in sysfs.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
