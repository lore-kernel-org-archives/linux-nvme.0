From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 20 Oct 2017 03:27:21 -0700
Subject: [REPOST PATCH] nvmet: Fix fatal_err_work deadlock
In-Reply-To: <20171019200236.15892-1-jsmart2021@gmail.com>
References: <20171019200236.15892-1-jsmart2021@gmail.com>
Message-ID: <20171020102721.GA20587@infradead.org>

Why can't we just switch to flush_work instead of cancel_work_sync?

fatal_err_work never requeues itself, although we might need
protection against queueing more up once we enter nvmet_ctrl_free.
