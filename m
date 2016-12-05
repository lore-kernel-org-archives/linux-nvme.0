From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Dec 2016 16:40:39 +0100
Subject: [PATCH 1/3] nvmet: delete controllers deletion upon subsystem
 release
In-Reply-To: <1480936146-6406-2-git-send-email-sagi@grimberg.me>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-2-git-send-email-sagi@grimberg.me>
Message-ID: <20161205154039.GC6529@lst.de>

On Mon, Dec 05, 2016@01:09:04PM +0200, Sagi Grimberg wrote:
> No reason for them to be kept around if we are
> deleting the subsystem, so instead of passively
> wait for the host to disconnect, actively delete
> the controllers.

Looks fine, but I'd really love to see a testcase for this in some form..

Reviewed-by: Christoph Hellwig <hch at lst.de>
