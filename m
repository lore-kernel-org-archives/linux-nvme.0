From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 16 Jun 2016 07:57:24 -0700
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
Message-ID: <20160616145724.GA32635@infradead.org>

On Thu, Jun 16, 2016@09:53:45AM -0500, Steve Wise wrote:
> [11436.603807] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
> [11436.609866] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000050
> [11436.617764] IP: [<ffffffffa09c6dff>] nvmet_rdma_delete_ctrl+0x6f/0x100

Can you check using gdb where in the code this is?

This is the obvious crash we'll need to fix first.  Then we'll need to
figure out why the keep alive timer times out under this workload.
