From: hch@lst.de (Christoph Hellwig)
Date: Fri, 11 May 2018 08:37:24 +0200
Subject: [PATCH] nvme-pci: Avoid use of goto in nvme_reset_work()
In-Reply-To: <20180510164645.19559-1-mr.nuke.me@gmail.com>
References: <20180510164645.19559-1-mr.nuke.me@gmail.com>
Message-ID: <20180511063724.GA8368@lst.de>

On Thu, May 10, 2018@11:46:33AM -0500, Alexandru Gagniuc wrote:
> This patch started as a challenge from Keith relating to code
> structuring with goto vs return. I think the final result improves
> readability on two counts:
> First, it clarifies the separation between work struct and nvme_dev.
> Second, it makes it clearer what error is being passed on:
> 'return -ENODEV' vs 'goto out', where 'result' happens to be -ENODEV

I think this actually makes the code much less readable.  The only real
improvement the code needs is to replace the "out" label name with
something more descriptive like "remove_controller".
