From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 11 Sep 2018 00:19:52 -0700
Subject: [PATCH V2] nvme-core: add async event trace helper
In-Reply-To: <20180829221922.23539-1-chaitanya.kulkarni@wdc.com>
References: <20180829221922.23539-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180911071952.GA8988@infradead.org>

On Wed, Aug 29, 2018@03:19:22PM -0700, Chaitanya Kulkarni wrote:
> This patch adds a new event for nvme async event notification.
> We print the async event in the decoded format when we recognize
> the event otherwise we just dump the result.

I don't like the reason_str handling.  The normal way to do this
would be to but the binary reason (i.e. what we switch on) into
the trace buffer, and then use __print_symbolic in the TP_printk
statement.
