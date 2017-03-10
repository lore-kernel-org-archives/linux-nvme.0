From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 10 Mar 2017 13:51:11 +0100
Subject: [PATCH 25/47] nvme: don't take the I/O queue q_lock in
 nvme_timeout
In-Reply-To: <1448037342-18384-26-git-send-email-hch@lst.de>
Message-ID: <1489150271.26967.6.camel@infradead.org>

> There is nothing it protects, but it makes lockdep unhappy in many different
> ways.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

This is commit 4c9f748f0ee88447b28546991f60f43a7319aafd in 4.5.

Doesn't it want to be applied to 4.4 stable too?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170310/d0a700bf/attachment.bin>
