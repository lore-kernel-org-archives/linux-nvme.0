From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Mar 2019 16:35:53 +0100
Subject: [PATCH v4 1/3] nvme: set 0 capacity if namespace block size
 exceeds PAGE_SIZE
In-Reply-To: <20190312143231.GA1149@lst.de>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-2-sagi@grimberg.me> <20190312143231.GA1149@lst.de>
Message-ID: <20190312153553.GA2252@lst.de>

And while we are at it - Dave Chinner has been actively working on
blocksize > PAGE_SIZE support for XFS.  So we might be able to use
"too large" sectors sizes very soon.
