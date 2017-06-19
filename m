From: axboe@kernel.dk (Jens Axboe)
Date: Sun, 18 Jun 2017 20:53:46 -0600
Subject: [RESEND PATCH] nvme: host: unquiesce queue in nvme_kill_queues()
In-Reply-To: <20170619022108.21902-1-ming.lei@redhat.com>
References: <20170619022108.21902-1-ming.lei@redhat.com>
Message-ID: <65e6c1c0-ebe1-a9c1-7dfd-a85fa619d274@kernel.dk>

On 06/18/2017 08:21 PM, Ming Lei wrote:
> When nvme_kill_queues() is run, queues may be in
> quiesced state, so we forcibly unquiesce queues to avoid
> blocking dispatch, and I/O hang can be avoided in
> remove path.
> 
> Peviously we use blk_mq_start_stopped_hw_queues() as
> counterpart of blk_mq_quiesce_queue(), now we have
> introduced blk_mq_unquiesce_queue(), so use it explicitly.

Thanks for updating it, added.

-- 
Jens Axboe
