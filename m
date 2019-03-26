From: hch@lst.de (Christoph Hellwig)
Date: Tue, 26 Mar 2019 08:32:39 +0100
Subject: [PATCH 1/2] nvme: target: fix nvmet_file_init_bvec()
In-Reply-To: <20190326021627.GE30669@ming.t460p>
References: <20190325100708.24172-1-ming.lei@redhat.com>
 <20190325100708.24172-2-ming.lei@redhat.com> <20190325105231.GA24907@lst.de>
 <20190326013935.GC30669@ming.t460p>
 <a850ff6c-f006-9b1b-5425-19cc6a1693c7@grimberg.me>
 <20190326021627.GE30669@ming.t460p>
Message-ID: <20190326073239.GA21571@lst.de>

On Tue, Mar 26, 2019@10:16:28AM +0800, Ming Lei wrote:
> Also there is the same issue for block device backed target.
> 
> If no one objects, I'd like to take the approach of adjusting segment
> boundary mask.

Just go for the merge of your two patches.  That fixes the issue and
actually makes the code simpler.
