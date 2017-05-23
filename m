From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 23 May 2017 00:15:28 -0700
Subject: [PATCH v3 2/3] nvmet_fc: Reduce work_q count
In-Reply-To: <20170522222844.22494-3-jsmart2021@gmail.com>
References: <20170522222844.22494-1-jsmart2021@gmail.com>
 <20170522222844.22494-3-jsmart2021@gmail.com>
Message-ID: <20170523071528.GB16776@infradead.org>

On Mon, May 22, 2017@03:28:43PM -0700, James Smart wrote:
> Instead of a work_q per controller queue, use system workqueues.
> Create "work lists" per cpu that driver ISR posts to and workqueue
> pulls from.

Why?  The whole point of workqueues is to avoid this sort of open coded
work lists in drivers.  To me it seems like you should simply make
the existing workqueue global, and maybe mark it as cpu itensive based
on profiling, but that's about it.
