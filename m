From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 11:18:06 +0200
Subject: [PATCH] nvme: free pre-allocated queue if create ioq goes wrong
In-Reply-To: <1515914131-12725-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1515914131-12725-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <d4a85f57-a499-a580-ba39-8eea6e5c9712@grimberg.me>

Minwoo,

> If either create-sq or create-cq is failed with an NVMe status,
> nvme_init_queue() is invoked which was not expected to be called in
> nvme_create_queue().
> To prevent this inconsistency of queue_count, free queue(s) already
> allocated in nvme_create_io_queues() when it goes wrong in
> nvme_create_queue().

The fix looks good, but I think it would be better to cleanup the queue
in the call site where nvme_alloc_queue is called, having it here is a
bit awkward IMO.
