From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 18 Oct 2017 00:45:23 -0700
Subject: How to improve long suspend time in `nvme_shutdown_ctrl`
In-Reply-To: <72b666c9-dd57-ef87-e89e-ba280f34e90c@molgen.mpg.de>
References: <72b666c9-dd57-ef87-e89e-ba280f34e90c@molgen.mpg.de>
Message-ID: <20171018074523.GA20872@infradead.org>

On Tue, Oct 17, 2017@10:33:56PM +0200, Paul Menzel wrote:
> Is that the right register to read? Can this be improved? If not, is that a
> firmware bug?

Take a look at nvme_shutdown_ctrl - it's pretty simple.

It asks the device to shut down, and then polls the controller status
register every 10 milliseconds if the shutdown has completed.

So the drive performs as expected, but it is indeed rather slow.
