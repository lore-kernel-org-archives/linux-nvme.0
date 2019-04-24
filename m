From: kbusch@kernel.org (Keith Busch)
Date: Wed, 24 Apr 2019 14:44:17 -0600
Subject: [PATCH v2 0/2] Adding per-controller timeout support to nvme
In-Reply-To: <983e5d039dce9de1d32c71d28fd59bbc01c3fee5.camel@infradead.org>
References: <20190403123506.122904-1-mheyne@amazon.de>
 <fb33a464-af65-abec-5ff1-15925e7669a4@grimberg.me>
 <20190424200706.GB15412@localhost.localdomain>
 <983e5d039dce9de1d32c71d28fd59bbc01c3fee5.camel@infradead.org>
Message-ID: <20190424204417.GC15412@localhost.localdomain>

On Wed, Apr 24, 2019@10:30:08PM +0200, David Woodhouse wrote:
> It isn't that the media is slow; the max timeout is based on the SLA
> for certain classes of "fabric" outages. Linux copes *really* badly
> with I/O errors, and if we can make the timeout last long enough to
> cover the switch restart worst case, then users are a lot happier.

Gotchya. So the default timeout is sufficient under normal operation,
but temporary intermittent outages may exceed it. It'd be a real
dissappointment if the command times out with an error anyway after
waiting for the extended time, but we ought to cover the worst case
time for a successful completion.
