From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 Aug 2017 00:33:13 -0700
Subject: [PATCH] nvmet_fc: use list_for_each_safe()
In-Reply-To: <20170817064023.daho5p5dncqhqdar@mwanda>
References: <20170817064023.daho5p5dncqhqdar@mwanda>
Message-ID: <20170817073313.GA28231@infradead.org>

On Thu, Aug 17, 2017@09:41:53AM +0300, Dan Carpenter wrote:
> We are freeing the list and the current code dereferences "deferfcp"
> after it's freed.  Let's use list_for_each_entry_safe() instead.

James already sent the same patch and I've got it queued up.
