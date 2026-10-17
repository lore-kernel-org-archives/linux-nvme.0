Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED511CCA46C
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Oct 2026 02:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZROtWBtn7Em4KQUcWsy9pq8PmRRT29SnOSczBb7KaLk=; b=xKD33ZHA15loo/oLXkZ58ZkTkK
	xBChNt3l54fJPcXsnt4+Is3Am+G4BSQ3rGehrVOB3X3zb60nw95kFACrlKGDRqK1UeHnLg4pXoTb+
	+WTWDYSEjeI2nAK+24V+5fGY3WBhPP/z4VzwE2qpB739YLG9PO4qGcKS96nM2kfnmz2d0Lrk0EDS3
	zMC+i0wL4/Hc7s0EOr9Rp058g9e0uLy0YU9ZRq183Mo2iAqb0mt6VM1DDdsJImfUsiSe45arYmefL
	G07G0SNe1c9zUuuBRhFPa8oxC8npr/JsyGcEOoJDXdsofq8n66vyMxu2p5daFF2GZnOjWlw4dX0IO
	dJoTNDdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHuGB-00000004Lfo-48qT;
	Sat, 17 Oct 2026 02:34:59 +0000
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHuG3-00000004LfF-1AH5
	for linux-nvme@lists.infradead.org;
	Sat, 17 Oct 2026 02:34:52 +0000
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-3282db206d3so1336641eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 19:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792204489; x=1792809289; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZROtWBtn7Em4KQUcWsy9pq8PmRRT29SnOSczBb7KaLk=;
        b=fc/eqxBWOaJE0w/qNJNerFa8+lIL2s5oVCdnERR75MQHe5K+uVcEkGAaQQFp566wro
         8uIgDhrri6IiGDopoMC1XtkBIYChj7s7Tk2fNiybELi3aluzRp+wCW52WmDZp88rz1TM
         +/dguo575Uw9x4+TqWBj/bL+lzsHbq5nOApgLco6i3hJBOpv73Pv7A8aN5KWOV8G4Ljo
         QEjxCdyiW+BNIr7n160E6zJ3vTLmuLahpBRktdTLWj0F9z49LOssaL2Mk27JRBbfN016
         Gef++b9UT+vbWLPU7t5xJ4Qlt4Vdix2H2zuq9w/5GLUKtr9+LvdxoyNh/cnSfa/MaMJU
         j9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792204489; x=1792809289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZROtWBtn7Em4KQUcWsy9pq8PmRRT29SnOSczBb7KaLk=;
        b=NGjPQSL93gTdbWrTp+oVKp93fmPLrRc6mQucjtmeS7yEZ7SyIPlmqcS3ZhWTt2j4fs
         SVQrLTc/gVr0vTNfy6aWGnj+Qkxe3Y5AETSCEO78ZihfsIakW5XFHmvaotu4W/z3BnLe
         3S/PT5UEblqJCY/bXW3BKnGegml36a5BPsF8z7TY2JzBFP7J1TZsK54C/7RIEk//tpeR
         AzLzo38W75o4jWsh0nX/+sfoOTGz0mKSadLA0GoXNXv6roCaNYkDbBLsyQytF9QrHnD8
         NMnSV1eYAv1cIXC1PN4QqHCWWFAoZkozdmJxr2s/JTewwL7OyUE4H3QfFzEVcL8TRjK1
         BlIA==
X-Forwarded-Encrypted: i=1; AKwUvBwHPn4amwPF+NQJL5oiU3unHL+yXakOkpI7qUl0w5nEeuAi/ZLtA5rJUypaA5RSYyG4iORxpY+OlC2J@lists.infradead.org
X-Gm-Message-State: AFq9FYKsbS2D9Hbneuo+rOCI8dgdytqtw/Qasc4ZdkyKcNHHm9wUVZjP
	N3kUEaMkUhitC1bbV/FIOAgAfvyHc3bqhy9uirJiNhBwKxfg25yZu0/kewVOZRzyCZE=
X-Gm-Gg: AYBFou0bdg/xUz/honhkFucxs17mtlTTA3RFRwwuFLitmEbl+xlvaz1vZ1nvmEVDOGU
	KDzc4Rb3gh0M9NWzzz2VrZPGlh3Ojo2bG6fU793SxVzHr8jnXfk8HER9QyAqfx5evBP4VqaEfM1
	ASbJk3/hL4z3gv3QnxomyRMWCcsuUUXa1BC+WGavrO9Bk4yzu1RUqu+sGIMVnKj9qhhHUsHrlEB
	AabDuZsUb8WiVwYjMrvrNW6P+nbDa/raA1oG8h+RyxQvn8lJQmTeLO6p2+RZvSIUbpQD7U941Rk
	tKg3KtrLvJFk8+z3mIoosm/TR5+luNcGLb7Z+0Hqgmhb2CpyD+dmIt1w5ZJyUJI8fxxZMR5kqsy
	1OsNS6IOMZj4KCDbq6nQh94+ZWnoPmShqr505Uo43Gj/rwBthdCSkkzMGCa8kJMLlVZv5lkDtCV
	bmCvWrv0QVnOIjiIaUj9zYYROSyGs4gx6yi8/qb3BxQdKntMuWSJeXg0fMhWzcQl4PJOmaLFR4g
	mUabOofMp3QgOU9tLqmwellSc1SAf1bFG/JEKXxKHa0
X-Received: by 2002:a05:7301:2727:b0:343:fb75:a5f2 with SMTP id 5a478bee46e88-361a1865981mr2187452eec.9.1792204488444;
        Fri, 16 Oct 2026 19:34:48 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm11007439eec.7.2026.10.16.19.34.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 19:34:47 -0700 (PDT)
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
Date: Fri, 16 Oct 2026 19:34:38 -0700
Message-ID: <20261017023442.63620-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e3bd727d-869b-470d-84dc-fccae61ca499@linux.ibm.com>
References: <20260927070925.47209-1-saravanand@crusoe.ai> <20260927070925.47209-3-saravanand@crusoe.ai> <51a451fe-fdf6-4e8f-afbd-c595f3c6de2c@linux.ibm.com> <20261009020145.64651-1-saravanand@crusoe.ai> <e3bd727d-869b-470d-84dc-fccae61ca499@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_193451_349626_3D5C3366 
X-CRM114-Status: GOOD (  27.21  )
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

On 10/11/26 1:27 PM, Nilay Shroff wrote:
> On 10/9/26 7:31 AM, Saravanan D wrote:
[...]
>> Annotating io_cpu with __guarded_by(&ctrl->io_cpu_lock) would need
>> context_unsafe() around each of those hot path reads, so I'd rather
>> document the lockless readers next to the field. Happy to add the
>> annotation if you prefer it.
>
> Yes, reading io_cpu locklessly in the I/O hot path is intentional. However,
> to avoid KCSAN splat, we should mark read and write access with READ_ONCE()
> and WRITE_ONCE() respectively.
>
> Unfortunately, the Clang context analyzer cannot currently model a lock that
> serializes writers while allowing readers to access the protected variable
> without holding that lock. Annotating io_cpu with __guarded_by() would therefore
> require us to annotate lockless reads with context_unsafe() or data_race(),
> which I think we'd prefer to avoid.
>
> I suggest introducing two helpers: one to read io_cpu and another to update it:
>
> static inline int nvme_tcp_queue_io_cpu(struct nvme_tcp_queue *queue)
> {
> 	return READ_ONCE(queue->io_cpu);
> }
>
> static inline void nvme_tcp_queue_change_io_cpu(struct nvme_tcp_queue *queue,
> 		int cpu)
> 	__must_hold(&queue->ctrl->io_cpu_lock)
> {
> 	WRITE_ONCE(queue->io_cpu, cpu);
> }
>
> All readers could then access queue->io_cpu through nvme_tcp_queue_io_cpu(),
> while all writes would go through nvme_tcp_queue_change_io_cpu(). The __must_hold()
> annotation on the update helper would allow the Clang context analyzer to verify
> that callers hold io_cpu_lock when modifying io_cpu, without requiring annotations
> for the intentional lockless reads.

Agreed. v5 adds both helpers as you wrote them. Every reader goes
through nvme_tcp_queue_io_cpu(), and the two writers, the cpu
selection at connect and the sysfs store, go through
nvme_tcp_queue_change_io_cpu() with io_cpu_lock held.

[...]
>> (3) The user managed side has no unbound state. A -1 written by the
>>      user is the same state as a queue the driver has not bound yet,
>>      so managed reads 1 and the next connect binds it again. Also,
>>      nvme_tcp_wq is a per-cpu workqueue, so an unbound io_work runs
>>      on the cpu that queued it rather than on a cpu chosen by the
>>      workqueue.
>>
> May not be true always when nvme_tcp_wq is inited with wq_unbound. We
> have a module option using which we could toggle this behavior.

You're right, that holds only for the default per-cpu nvme_tcp_wq.
With wq_unbound the workqueue picks the cpu as you describe, and
nvme_tcp_set_queue_io_cpu() leaves every driver managed queue unbound.
A user written io_cpu still selects the worker pool for that cpu, so
how closely io_work follows it depends on the affinity_scope of
nvme_tcp_wq. With affinity_scope=cpu and affinity_strict=1, io_work
runs on that cpu, provided the cpu is in the cpumask of nvme_tcp_wq.
With the default cache_shard scope, io_work starts on a cpu in the
same shard, and the scheduler may move it afterwards.
v5 documents this in the ABI entry.

[...]
>> 	mutex_lock(&ctrl->io_cpu_lock);
>> 	old = xchg(&queue->io_cpu, cpu);
>> 	set_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags);
>> 	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
>> 		atomic_dec(&nvme_tcp_cpu_queues[old]);
>> 	if (cpu != WORK_CPU_UNBOUND &&
>> 	    test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags)) {
>> 		atomic_inc(&nvme_tcp_cpu_queues[cpu]);
>> 		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
>> 	}
>> 	mutex_unlock(&ctrl->io_cpu_lock);
>>
>> Does that work for you?
>>
> This looks good. However, I wonder why we need to check NVME_TCP_Q_ALLOCATED
> here? If the user can update io_cpu only while the queue's sysfs directory
> exists, and that directory is created and removed along with the queue's
> allocation and teardown, shouldn't we be able to drop this check?

Agreed, v5 drops the check. nvme_tcp_free_queue() removes the
directory before it clears NVME_TCP_Q_ALLOCATED, so no store can run
on a freed queue. The SET backstop stays after the removal, for a
store that lands between the queue stop and the free.

Thanks,
Saravanan D.

