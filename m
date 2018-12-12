From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 09:29:26 +0100
Subject: [PATCH] nvme-ioctl: clear rae for discovery log pages
In-Reply-To: <20181207220530.30310-1-sagi@grimberg.me>
References: <20181207220530.30310-1-sagi@grimberg.me>
Message-ID: <20181212082926.GB29996@lst.de>

On Fri, Dec 07, 2018@02:05:30PM -0800, Sagi Grimberg wrote:
> The discovery controller should now be able to send
> us discovery log change events so we need to clear the
> rae bit for that.

Btw, I really think we need to clear the RAE bit in the kernel with
a small whitelist for those AENs that we pass on to userspace so that
we don't accidentally get the bit cleared.  What do you think?
