From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Wed, 21 Nov 2018 15:01:11 +0300
Subject: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <20181120030019.31738-16-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me>
Message-ID: <8736rufxmg.fsf@solarflare.com>

Sagi Grimberg <sagi at grimberg.me> writes:
 > +static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req)
 > +{
 > +	struct nvme_tcp_queue *queue = req->queue;
 > +
 > +	spin_lock_bh(&queue->lock);
 > +	list_add_tail(&req->entry, &queue->send_list);
 > +	spin_unlock_bh(&queue->lock);
 > +
 > +	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 > +}

May be I missing something, but why bother with bottom half version of
locking?

There are few places where this lock could be accessed:

 (1) From ->queue_rq() call;
 (2) From submitting new AEN request;
 (3) From receiving new R2T;

Which one if these originates from bottom half? Not 100% about queue_rq
data path, but (2) and (3) looks perfectly safe for me.

Possibly just a relic of some previous iterations of experimenting?

Mikhail Skorzhinskii
