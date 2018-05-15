From: hch@lst.de (Christoph Hellwig)
Date: Tue, 15 May 2018 10:11:31 +0200
Subject: [PATCHv2 1/5] nvme: fix lockdep warning in
 nvme_mpath_clear_current_path
In-Reply-To: <20180515074043.22843-2-jthumshirn@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-2-jthumshirn@suse.de>
Message-ID: <20180515081131.GA24332@lst.de>

Looks good, although I hate having the whole splat in the commit
message..

Reviewed-by: Christoph Hellwig <hch at lst.de>
