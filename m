From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Aug 2016 09:01:24 +0200
Subject: [PATCH nvme-cli 3/4] fabrics: Remove redundant build_options
In-Reply-To: <1470572365-20674-4-git-send-email-sagi@grimberg.me>
References: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
 <1470572365-20674-4-git-send-email-sagi@grimberg.me>
Message-ID: <20160808070124.GC12598@lst.de>

On Sun, Aug 07, 2016@03:19:24PM +0300, Sagi Grimberg wrote:
> We call it again in do_discover.

Do we?  At least in my copy of the tree we don't, and given that
connect_ctrl builds the argstr differently that would be a bad idea..
