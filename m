From: hch@lst.de (Christoph Hellwig)
Date: Wed, 30 Aug 2017 10:14:43 +0200
Subject: [PATCHv2 1/4] nvme: factor metadata handling out of
 __nvme_submit_user_cmd
In-Reply-To: <d885cc92-38e0-5f61-9b1e-5cd0fdd40d32@mellanox.com>
References: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
 <1504043164-5398-2-git-send-email-keith.busch@intel.com>
 <d885cc92-38e0-5f61-9b1e-5cd0fdd40d32@mellanox.com>
Message-ID: <20170830081443.GA17819@lst.de>

> did we move the kfree(meta) here in porpose ?
> I think we'll leak in the "write" case.

Oops, my fault.

> In general, I prefer allocating and freeing the meta buffer in the same 
> function but maybe it make sense to act otherwise here.

Think of nvme_add_user_metadata as the memory allocator, given
that it returns the buffer :)
