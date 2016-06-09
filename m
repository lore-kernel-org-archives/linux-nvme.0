From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 9 Jun 2016 06:25:41 -0700
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <575936F0.9000600@lightbits.io>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <575936F0.9000600@lightbits.io>
Message-ID: <20160609132541.GB5105@infradead.org>

> I got the same bug report, it looks like we're might
> be facing a double-free condition.
> 
> Does this patch help?

Ah, thanks - this looks like a good fix.  I'll add it to the queue for
the next iteration.
queue.
