From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Mar 2017 10:20:38 -0700
Subject: [PATCH] nvme: make nvme error status codes converted to errno
 detailed
In-Reply-To: <20170330172236.GG20181@localhost.localdomain>
References: <1490782103-14668-1-git-send-email-guanjunxiong@huawei.com>
 <20170330081107.GA2991@infradead.org>
 <e81a210c-a911-b275-eb53-51ee9f3f7c5e@huawei.com>
 <20170330172236.GG20181@localhost.localdomain>
Message-ID: <20170330172038.GA6037@infradead.org>

On Thu, Mar 30, 2017@01:22:37PM -0400, Keith Busch wrote:
> I don't see a problem having more appropriate errno's here. The block
> layer looks okay to accept any value, and the spec folks might be happy
> to see their thought out status codes don't all become EIO. :)

The block layer accepts all and treats a few magically.  That's why I
want to get rid of errno values in the block layer entirely and replace
the with a few status codes that make the special casing obvious.

> But just so we all know, the majority of those statuses are only possible
> to encounter with passthrough, and those are not translated to errno.

Exactly.
