From: kbusch@kernel.org (Keith Busch)
Date: Mon, 6 May 2019 09:17:27 -0600
Subject: [PATCH] nvme-loop: Fix race between completions and shutdown
In-Reply-To: <0db7e312-0ff2-45f2-8ee1-7ad7b6fd3e5a@gmail.com>
References: <20190506145203.2851-1-minwoo.im.dev@gmail.com>
 <20190506145327.GA2164@localhost.localdomain>
 <0db7e312-0ff2-45f2-8ee1-7ad7b6fd3e5a@gmail.com>
Message-ID: <20190506151727.GB2164@localhost.localdomain>

On Tue, May 07, 2019@12:07:47AM +0900, Minwoo Im wrote:
> 
> If don't mind, can I ask how can blk_mq_tagset_busy_iter() make sure that no
> more requests are coming into this request_queue during this iteration ?

If a queue is frozen, there can't be any allocated tags, so calling
blk_mq_tagset_busy_iter for such a queue is a no-op.

I'm not sure you actually want to freeze in this path though. That may
block forever if a request needs to be requeued.
