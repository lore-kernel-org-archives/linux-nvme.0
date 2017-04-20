From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 19 Apr 2017 22:47:09 -0700
Subject: NVMe over fabrics - Caching controller Identity data
In-Reply-To: <603f53f6-1211-3b5f-31c8-dfa1e8700c26@oracle.com>
References: <603f53f6-1211-3b5f-31c8-dfa1e8700c26@oracle.com>
Message-ID: <20170420054709.GB18181@infradead.org>

On Fri, Apr 14, 2017@10:49:10AM -0700, Steve Blightman wrote:
> As I understand it, the linux initiator caches the controller Identity data
> and some other values.  These only get loaded when it first connects, or
> when the controller is reset.  Now If a target wishes to change any of these
> values, capsule size for instance, it might set the new values and restart
> itself, but when the initiator reconnects to an existing controller, it
> still has the old values. Is there a way for the target to force the
> initiator to reload these values somehow?

Identify controller is supposed to be static data for a controller.

If your controller has changed you need to reject the reconnect and
present a new controller.
