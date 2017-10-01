From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 1 Oct 2017 01:39:32 -0700
Subject: [PATCH] nvmet_fc: Reduce work_q count
In-Reply-To: <e86009d5-2ca6-8de3-d142-781724bf00d8@gmail.com>
References: <20170927040958.5981-1-jsmart2021@gmail.com>
 <90b9711d-e279-443d-1693-dad24524cc74@grimberg.me>
 <e86009d5-2ca6-8de3-d142-781724bf00d8@gmail.com>
Message-ID: <20171001083932.GA878@infradead.org>

On Sat, Sep 30, 2017@11:32:39AM -0700, James Smart wrote:
> Because we're still trying to get cpu affinity on the connection resources
> that will be shared by the io on the same queue.

And that's exactly what plain queue_work will give you.  If it doesn't
do exactly what your open code logic does it has a bug that needs to
be fixed.
