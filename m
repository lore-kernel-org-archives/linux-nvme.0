From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 Nov 2015 23:34:48 -0800
Subject: [PATCH] NVMe: Split shutdown work
In-Reply-To: <1448302665-9703-1-git-send-email-keith.busch@intel.com>
References: <1448302665-9703-1-git-send-email-keith.busch@intel.com>
Message-ID: <20151124073448.GA17979@infradead.org>

On Mon, Nov 23, 2015@11:17:45AM -0700, Keith Busch wrote:
> Setting the queue count has a special check for a disabled device in
> order to set an appropriate return code as this command may legitimately
> fail.

Btw, I've tried to understand this as the explanation didn't make sense
to me.  I think I finally found the culprit, and it's this text:

"This feature shall only be issued during initialization prior to creation
 of any I/O Submission and/or Completion Queues. The value allocated shall
 not change between resets."

To be this doesn't indicated that it can legitimately fail. but rather
that we must not even submit it during a reset or resume.  One more
reason for a proper state model..
