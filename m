From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Apr 2018 17:14:05 +0200
Subject: [PATCH 1/1] nvmet-rdma: Add error flow for post_recv failures
In-Reply-To: <1523885152-20800-1-git-send-email-maxg@mellanox.com>
References: <1523885152-20800-1-git-send-email-maxg@mellanox.com>
Message-ID: <20180417151405.GA24654@lst.de>

On Mon, Apr 16, 2018@04:25:52PM +0300, Max Gurtovoy wrote:
> Posting receive buffer operation can fail, thus we should
> make sure there is no memory leakage in that flow.

This looks reasonable, but can you explain the memory leak a bit
better?  In general once posting a WR fails we should be tearing
down the QP rather sooner than later, where are we leaking memory?
