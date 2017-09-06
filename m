From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Sep 2017 12:30:26 +0200
Subject: [PATCH 1/3] nvmet-rdma: use srq pointer in rdma_cmd
In-Reply-To: <1504609157-3004-2-git-send-email-maxg@mellanox.com>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
 <1504609157-3004-2-git-send-email-maxg@mellanox.com>
Message-ID: <20170906103026.GA24667@lst.de>

This looks ok, but not very useful on it's own.  I'd be tempted to
just squash it into the next patch.
