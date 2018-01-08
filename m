From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Jan 2018 11:14:17 +0100
Subject: [PATCH 2/2] nvme: Fix subsystem multiple controllers support check
In-Reply-To: <1515081374-22328-2-git-send-email-maxg@mellanox.com>
References: <1515081374-22328-1-git-send-email-maxg@mellanox.com>
 <1515081374-22328-2-git-send-email-maxg@mellanox.com>
Message-ID: <20180108101417.GB5234@lst.de>

device model refcounting bites again..

I don't really like the loop to much, but for now can't come up with
anything better.

Applied to nvme-4.16.
