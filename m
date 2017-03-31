From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 31 Mar 2017 00:09:50 -0700
Subject: [RFC 5/8] scatterlist: Modify SG copy functions to support io
 memory.
In-Reply-To: <1490911959-5146-6-git-send-email-logang@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-6-git-send-email-logang@deltatee.com>
Message-ID: <20170331070950.GA9059@infradead.org>

You're calling memcpy_{to,from}_iomem on non-__iomem pointers.  This
is a fundamental no-go as we keep I/O memory separate from kernel
pointers.
