From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 16 May 2017 05:48:21 -0700
Subject: [PATCH v2 06/10] nvmet_fc: Reduce work_q count
In-Reply-To: <20170516001024.5281-7-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-7-jsmart2021@gmail.com>
Message-ID: <20170516124821.GG28689@infradead.org>

On Mon, May 15, 2017@05:10:20PM -0700, James Smart wrote:
> Instead of a work_q per controller queue, make 1 per cpu and have
> controller queues post work elements to the work_q.

Having per-cpu workqueues doesn't make any sense at all as workqueues
already are per-cpu underneath.  Please use a global workqueue
instead.  That also avoids the sort of messy interactions with
CPU hotplug that would have to be added to this patch otherwise.
