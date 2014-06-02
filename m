From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 2 Jun 2014 03:11:40 -0700
Subject: [PATCH v4] basic conversion to blk-mq
In-Reply-To: <1401400285-25003-1-git-send-email-m@bjorling.me>
References: <1401400285-25003-1-git-send-email-m@bjorling.me>
Message-ID: <20140602101140.GA16892@infradead.org>

There also should be patch to switch nvme to the block layer SG_IO
implementation and BLOCK_PC requests instead of it's own implemenation.

Not that I see any point at all in having all that cruft in nvme-scsi
to start with..
