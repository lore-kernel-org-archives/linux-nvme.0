From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 11 Jun 2015 09:12:54 -0400
Subject: abort question
In-Reply-To: <20150611104603.GA1754@infradead.org>
References: <20150611104603.GA1754@infradead.org>
Message-ID: <20150611131254.GM2729@linux.intel.com>

On Thu, Jun 11, 2015@03:46:03AM -0700, Christoph Hellwig wrote:
> Don't we need to reserve a request and SQ entry to that we can
> always send an abort?  Otherwise a lockded up controller will never
> send a abort and always just reset the timer, and never escalate
> to a controller reset.

Aborts are sent on the admin queue, not the IO queue.  There should
always be plenty of space on the admin queue.
