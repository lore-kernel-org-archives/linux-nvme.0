Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D1DCA6012
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 02:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FK9q3mI/smjlpXK27adCfd32tCuGO0ujIRGbl2MfJLU=; b=UR6EHy6Pw860zeFxaDNil7y5fD
	f/0+SLz+fjTnEdSAaK3PTYEyfRY2v3Czy3lhokAzdNdEZ5jao0OREdIwNf+ONRSXKoRVrYMPM1MkN
	0CV7laj+KDYzKAr9Nn9T5y8hAdvqFEakbMsf8MrRnkgUgILUMaiLfgIlMDJkrr8Q+WIDrDn3bY0ph
	06veM+hrzaXXHMNQtHPxtYZ8TN8o/EkA2K1kM6/Hu8T2LziXeWUMsYFxQ4JhE/QHzc1u/u+bcNkO5
	FrGMyIg5x9cWOCjk/Zy3i16pfrws2XFwPpN0+2UjPaQMv8gGq++857qbFnBN+HEzQEHjMj/gKlcXY
	n1nWsVTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEzvv-00000005GUV-3AgT;
	Fri, 09 Oct 2026 02:02:03 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEzvq-00000005GU4-0qlv
	for linux-nvme@lists.infradead.org;
	Fri, 09 Oct 2026 02:01:59 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-3535a54bed9so1090073eec.1
        for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2026 19:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1791511317; x=1792116117; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FK9q3mI/smjlpXK27adCfd32tCuGO0ujIRGbl2MfJLU=;
        b=hqmuD4w60W2Pf324ds1uHqm4L/iUwwbo+nQvTNJSrFQYXQpmcBlWYTdmugjtOoTW5u
         v3Y77mIZKXFx8ADr6iH0FdJTYQPbwxL1OXOn0IJzP9LvQlpYPxizrkxrXr5+hW2oBm5m
         K6xSAofIz54+zEjMX81AlNxhcEn+p/oyiR85FVEl5pRjGKHegPUw+TuZu0PIP3Rwn4dH
         LozEqrHQTxgglT88lgTjjXld1IYSjf1JceofHyBRiZHUuFDmNAJLaPila9c/MGcKvz3X
         2FMxLKxduST93b0ljm8wjiYfkrq0KgwLRzhRi513WKdg/40LKTruIHgYer8UM3qdL9Ov
         hQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791511317; x=1792116117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FK9q3mI/smjlpXK27adCfd32tCuGO0ujIRGbl2MfJLU=;
        b=R7ryTfhD4CvQuggr+vm7ZpZUbndjzRY5A97pkclWmugJ8w11E3hQJ57DkTPXzXOgxV
         DxgxdwrZTn9AcCi77Gcd6JBM7bPqesoSp3Iv0fO3xcJCNeWFg14i6bAbrNJz2cNb5wpF
         LGMi6gs4LU0aDu5MavYaX0PbErPv5LvUzJf7XnfsT/7vc8vLyexnFmqQZaQG4VT/SH5j
         1uQsZkZFtAm1qsFvqK1+zw3LNL+otfG/+UU5Gf1qALTlJ5eZrW2aOw25KQDJky7EQOMl
         LemrtzllvHgDfaE6oSzjh4vW3/lQArzuSKy33UU1V8B8u/e922uNxDXXmyp6W59OXP+s
         F8uQ==
X-Forwarded-Encrypted: i=1; AKwUvByAlMlsQgHhOuaOIYut/Dgc5VbHB3yEWb/JNrtMxZpn5QIrEpl8K+28+4xlo+/A8b24hYj5DVQSH+5i@lists.infradead.org
X-Gm-Message-State: AFuF++kaa+uzyEvH1NQgUptp78YqQ6yap5izQER7kNOl6x8fzbHnnaIr
	tVyfnvyNYHgFVC6Ye3zq9EzV5FoCwcZdW7MsU4a/HaAdj9JKA9qE5ejUrXNdst+N1LY=
X-Gm-Gg: AYBFou20yDWnFbd+uBZU/P1SuWKo8oc3yN09lTcM5XPe/x9z/fEYMZpB5aN8kXjTgtS
	vv0xFQ6KReZV+hI2kZ9fO4sixmuvBAwumgieh1E9T7++Ok34hutP5uYoHARbjsBdbZjG75l3Rni
	C7RQocfK6kcUGRB9vRN4qrUtNlGyzslEkmlcBWB9mgOfSaMGDaOmBRLCD848Cn+XAnmMREkF9uf
	7qrAXu0gspGUO1Dv8bAqFLV3Bk1L0hhH0xBr8qceKR8ISwL7UpWKH4R0m9j6JnyULGODOOJr+1a
	cujsHZUVSW+jlqlJ+PfGsENYxOGK0KkNw3ac9WM4GUcTYiHNaIJv7FrNFYXsvb6ze5EXx4gteM5
	Re47zTQAz5pFyW2kZPa04JRy+oGYnix73gRRYCu7/oDWuqFfKprUyn2Weg12WDg/rXY01mtJbMl
	HC/UpEeKjpG+9x4h9B6ur1ckx9tgIEqQU5GovQG/K2hLYOM8/4OxqcPKOQLBmbgfl3Q988RPvCI
	Zfo6vTICdtOf8+bTi1SImK923QoKq0POnQYZxxtZa1S
X-Received: by 2002:a05:7301:152f:b0:351:7dc1:7aba with SMTP id 5a478bee46e88-3537e12becbmr729997eec.32.1791511316923;
        Thu, 08 Oct 2026 19:01:56 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm2120931eec.5.2026.10.08.19.01.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 19:01:56 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	dwagner@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai
Subject: Re: [PATCH v4 2/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Thu,  8 Oct 2026 19:01:42 -0700
Message-ID: <20261009020145.64651-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <51a451fe-fdf6-4e8f-afbd-c595f3c6de2c@linux.ibm.com>
References: <20260927070925.47209-1-saravanand@crusoe.ai> <20260927070925.47209-3-saravanand@crusoe.ai> <51a451fe-fdf6-4e8f-afbd-c595f3c6de2c@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_190158_260496_21FD2726 
X-CRM114-Status: GOOD (  35.12  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/8/26 2:45 AM, Nilay Shroff wrote:
[...]
>> The queue directories register on the first connect and persist while
>> the queues cycle across reconnects, so a write can arrive while a
>> queue is torn down. The io_cpu changes and their accounting therefore
>> serialize under a controller level lock rather than the queue lock,
>> which is destroyed with the queue, and the controller teardown waits
>> for the last kobject release before the queue array is freed.
>>
> I understand based on your requirement you may want to persist io_cpu
> changes (when managed by user) during controller reconnect. However
> in case num of queues changes after reconnect (assume it's 32 at first
> connect but after controller reconnects it's reduced to 16) keeping
> those 32 queues entries under queues/<qid>/ looks bit odd and not
> correct. I'd expect queues entries under queue/<qid>/ to be also
> adjusted based on the controller queue count.

Agreed. In v5 the queue directory follows the queue's connected
lifetime. nvme_tcp_alloc_queue() adds it and nvme_tcp_free_queue()
removes it, so queues/<qid>/ matches the queue count after every
reconnect, as blk-mq does for mq/<n> when nr_hw_queues changes. A user
assigned io_cpu is kept in the nvme_tcp_queue, which persists across
reconnects, so it applies again when the queue comes back. A write
while the controller is reconnecting fails with ENOENT.

[...]
>> @@ -171,6 +173,11 @@ struct nvme_tcp_ctrl {
>>   	struct delayed_work	connect_work;
>>   	struct nvme_tcp_request async_req;
>>   	u32			io_queues[HCTX_MAX_TYPES];
>> +	/* serializes io_cpu changes and their nvme_tcp_cpu_queues accounting */
>> +	struct mutex		io_cpu_lock;
>
> The io_cpu_lock protect updates to queue->io_cpu and as we now support clang
> context annotations for NVMe host driver, I'd suggest you annotate the
> queue->io_cpu with __guarded_by(...) so that clang context analyzer can
> validate each access to queue->io_cpu. Furthermore, I see that queue->io_cpu
> could be concurrently accessed from both control path and I/O hotpath. So how
> would we protect it while it's being accessed from I/O path and concurrently
> updated from sysfs path?

The I/O path reads io_cpu without the lock by design, and a stale read
is benign. Each queue_work_on() call reads io_cpu once, so a call that
races with the store queues io_work on the old cpu one last time and
later calls use the new one. io_work is a single work item, so it
never runs on both cpus at once. The inline send in
nvme_tcp_queue_request() only compares io_cpu with the current cpu and
is serialized by send_mutex. v5 marks the lockless reads with
READ_ONCE() and the writes with WRITE_ONCE().

Annotating io_cpu with __guarded_by(&ctrl->io_cpu_lock) would need
context_unsafe() around each of those hot path reads, so I'd rather
document the lockless readers next to the field. Happy to add the
annotation if you prefer it.

>> +	unsigned int		nr_queue_infos;
>> +	atomic_t		qinfo_refs;
>> +	struct completion	qinfo_release;
>>   };
>
> I think the qinfo_refs and qinfo_release are added for tracking the
> lifecycle of nvme_queue_info object. But do we really need to do
> that ?
> When a nvme_queue_info->kobj is initialized/added, its parent kobject
> is referenced by the kobject infrastructure. Therefore, as long as a
> queue-info kobject exists, its parent queues_kobj remains alive, which
> in turn keeps ctrl->device->kobj alive. This should already prevent the
> controller object from being released while a queue-info kobject still
> exists. Could we therefore avoid maintaining a second qinfo_refs
> reference count and completion? It seems that entire kobject parent
> chain already provides the lifetime dependency that qinfo_refs is
> trying to enforce.

Agreed. With the directory removed in nvme_tcp_free_queue(), no queue
directory outlives its queue, and the kobject release only frees its
own allocation, so the parent chain is enough. v5 drops qinfo_refs,
the completion and nr_queue_infos. Each connection allocates its own
kobject, so a reconnect never reuses one.

[...]
> This look overly complicated. In a simple scheme can't we get rid off
> NVME_QUEUE_INFO_IO_CPU_USER and instead use NVME_TCP_Q_IO_CPU_SET as an
> indicator for differentiating between io_cpu is managed by user or driver?
> For instance,
>
> NVME_TCP_Q_IO_CPU_SET = 1
>      - driver has selected a specific io_cpu
>
> NVME_TCP_Q_IO_CPU_SET = 0 && io_cpu != WORK_CPU_UNBOUND
>      - user has selected a specific io_cpu
>
> NVME_TCP_Q_IO_CPU_SET = 0 && io_cpu == WORK_CPU_UNBOUND
>      - unbound; workqueue chooses the execution CPU and so it's driver managed

I drew your scheme as a state diagram to compare it with v4.

              DRIVER MANAGED          |         USER MANAGED
   (SET=1, or SET=0 && UNBOUND)       |     (SET=0 && io_cpu=c)
                                      |
 connect +--------------------+ store(c)  +--------------------+
 ------->| A  driver chosen   |-------+-->| C  user pin        |
         |    io_cpu=c, SET=1 |       |   |    io_cpu=c, SET=0 |
         |    counted         |       |   |    not counted (1) |
         +--------------------+       |   +--------------------+
           | stop, SET=0 and          |     |
           | io_cpu must be reset (2) |     | store(-1)
           v                          |     |
         +--------------------+       |     |
         | B  unbound         |<------+-----+
         |    io_cpu=UNBOUND  |       |
         |    SET=0           |       |   +- - - - - - - - - - +
         |    also where a    |       |   : D  user unbound    :
         |    user -1 lands(3)|       |   :    not reachable,  :
         |                    |       |   :    see (3)         :
         +--------------------+       |   +- - - - - - - - - - +
           | next connect, reselect   |
           +--> A                     |

(1) A user pin has SET=0, so it drops out of nvme_tcp_cpu_queues.
    When the driver selects io_cpu for other queues and other
    controllers in nvme_tcp_set_queue_io_cpu(), it sees that cpu as
    idle and keeps placing queues on it. v4 counts every bound queue
    regardless of who assigned it.

(2) SET clears at stop. Unless the stop path also resets io_cpu to
    WORK_CPU_UNBOUND once io_work is cancelled, a driver chosen io_cpu
    reads as a user pin after the reconnect and the driver never
    selects a cpu for that queue again. In v4 only the sysfs store
    sets the USER bit, so connect and stop never touch ownership.

(3) The user managed side has no unbound state. A -1 written by the
    user is the same state as a queue the driver has not bound yet,
    so managed reads 1 and the next connect binds it again. Also,
    nvme_tcp_wq is a per-cpu workqueue, so an unbound io_work runs
    on the cpu that queued it rather than on a cpu chosen by the
    workqueue.

The USER bit records who owns io_cpu and survives reconnects, while
SET records whether io_cpu is in the ledger and follows connect and
stop. I'd like to keep both, with USER moved into nvme_tcp_queue flags
as you asked on patch 1. The complexity you point at is the extra
branch in the store, which collapses to a single path with the same
behavior in v5.

	mutex_lock(&ctrl->io_cpu_lock);
	old = xchg(&queue->io_cpu, cpu);
	set_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags);
	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
		atomic_dec(&nvme_tcp_cpu_queues[old]);
	if (cpu != WORK_CPU_UNBOUND &&
	    test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags)) {
		atomic_inc(&nvme_tcp_cpu_queues[cpu]);
		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
	}
	mutex_unlock(&ctrl->io_cpu_lock);

Does that work for you?

> Other that what sashiko provided in the review feedback, above are my
> few additional comments.

Thanks for the review. v5 also fixes the Sashiko findings.

Thanks,
Saravanan D.

