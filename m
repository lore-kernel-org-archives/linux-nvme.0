From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Oct 2015 08:16:03 +0200
Subject: [PATCH 17/18] nvme: move namespace scanning to common code
In-Reply-To: <1444976054.18781.2.camel@hasee>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-18-git-send-email-hch@lst.de>
 <1444976054.18781.2.camel@hasee>
Message-ID: <20151016061603.GA2739@lst.de>

On Thu, Oct 15, 2015@11:14:14PM -0700, Ming Lin wrote:
> Should nvme_core_{init,exit} be called in core.c?

We can't do that until core.c is built into a separate module.  Your
patch will only work when NVMe is built into the kernel.

I want to defer the split until it can actually be used in tree.
