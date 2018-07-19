From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Jul 2018 16:35:55 +0200
Subject: [PATCH 3/5] nvme-multipath: fixup crash during disconnect
In-Reply-To: <20180719143150.GC19339@lst.de>
References: <20180716105837.101125-1-hare@suse.de>
 <20180716105837.101125-4-hare@suse.de> <20180719143150.GC19339@lst.de>
Message-ID: <20180719143555.GA20010@lst.de>

On Thu, Jul 19, 2018@04:31:50PM +0200, Christoph Hellwig wrote:
> This doesn't match the current version of __nvme_find_path that was
> in the last posted series or the git tree.  What tree do you work against?

Actually, error on my side - the tree on this laptop wasn't uptodate,
sorry.  Applied for the next version.
