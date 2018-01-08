From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Jan 2018 11:16:26 +0100
Subject: [PATCH 2/2] nvme: Fix subsystem multiple controllers support check
In-Reply-To: <1515081374-22328-2-git-send-email-maxg@mellanox.com>
References: <1515081374-22328-1-git-send-email-maxg@mellanox.com>
 <1515081374-22328-2-git-send-email-maxg@mellanox.com>
Message-ID: <20180108101626.GA5383@lst.de>

Btw, I suspect we'll need to to do something interesting here for
the multipath case as well.  Can you investigate that?
