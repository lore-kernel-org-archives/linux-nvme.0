From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Jun 2015 03:46:03 -0700
Subject: abort question
Message-ID: <20150611104603.GA1754@infradead.org>

Don't we need to reserve a request and SQ entry to that we can
always send an abort?  Otherwise a lockded up controller will never
send a abort and always just reset the timer, and never escalate
to a controller reset.
