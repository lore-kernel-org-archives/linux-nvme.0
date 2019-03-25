From: hch@lst.de (Christoph Hellwig)
Date: Mon, 25 Mar 2019 11:52:31 +0100
Subject: [PATCH 1/2] nvme: target: fix nvmet_file_init_bvec()
In-Reply-To: <20190325100708.24172-2-ming.lei@redhat.com>
References: <20190325100708.24172-1-ming.lei@redhat.com>
 <20190325100708.24172-2-ming.lei@redhat.com>
Message-ID: <20190325105231.GA24907@lst.de>

On Mon, Mar 25, 2019@06:07:07PM +0800, Ming Lei wrote:
> There isn't sg iterator helper for building bvec, so invent one
> and fix the issue in nvmet_file_init_bvec().
> 
> The issue is that one sg may include multipge continuous pages, and
> only the 1st .bv_offset isn't zero, also the length for the last bvec
> has to consider the remained length.

The scatterlist in the nvme target is always allocated by the nvmet
code itself an thus never contains multi-page sg list entries.
