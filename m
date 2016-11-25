From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 24 Nov 2016 23:53:54 -0800
Subject: [PATCH] Use rsps_lock in nvmet_rdma_free_rsp
In-Reply-To: <923efced268f42a19eb96d593894d141@TGXML382.toshiba.local>
References: <781668ff60b040b3a56e104f489c3ea9@TGXML382.toshiba.local>
 <20161122074153.GC5497@infradead.org>
 <923efced268f42a19eb96d593894d141@TGXML382.toshiba.local>
Message-ID: <20161125075354.GA14095@infradead.org>

On Fri, Nov 25, 2016@05:00:26AM +0000, Tomita.Haruo@toshiba-sol.co.jp wrote:
> Hi Christoph,
> 
> Thank you for your reply.
> 
> > what are you trying to protect against during device teardown?
> 
> I'm trying to protect nvmet_rdma_get_rsp and nvmet_rdma_put_rsp.
> In these functions, queue->free_rsps is protected by rsps_lock.
> rsp->free_list is also protected at the same time.

If we can invoke these functions concurrently with nvmet_rdma_free_rsp
we have sever life time rule error.  Under what circumstances do you
see such concurrency?

> I am investigating whether there is a race issue on the target of nvme.
> For another function, I also think of the following patch.

What do you try to protect against with this patch?
