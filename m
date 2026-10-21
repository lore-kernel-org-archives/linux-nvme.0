Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422F606A324
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HLJzgWFk;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cIgu92Op;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=S2VzEQSE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cIgu92Op;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=S2VzEQSE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FSkifS5g9sRs2dk1uWfgPOLlW8mQhgnvvl6vZQyqxXE=; b=HLJzgWFkXGwkqjQNlsn6X0a3Qf
	OE60rKJtCcPBBkWUF2q9SXWZZaJ3pe3dky003MJczRjE3jK2KHp9yyGDBB4mlkbHRq5gHxKHYBfbg
	gNhTo2JEPqaUINHvkK3AOte8nNpaUQyj4LCRxC0TDIx3QdXlIRGHyw27FUw+/O8qNx+UWeRRsR7KQ
	MXntLRU/DCilEuUSeLXr6dqByh+YJ9UbC8lw0SiRlWzEtFlQgI3LW6VcgNp5exTmwkHgy4yAK+MoJ
	JVtf1MU6gVNQulbPyX0AdEk9QTUNgiAbVbcMz5P7EJvS7qbOFhPqcOWMw2OJkc2rXBTkSUmVBIogC
	LyjhajsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJTBP-0000000BYzO-2Ayf;
	Wed, 21 Oct 2026 10:04:31 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJTBN-0000000BYyr-23kA
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 10:04:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82A8621B6A;
	Wed, 21 Oct 2026 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792577067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSkifS5g9sRs2dk1uWfgPOLlW8mQhgnvvl6vZQyqxXE=;
	b=cIgu92OpUOYOgYiKqYMZS6dyGPqdaQC75nNW8p8TDGhFa/NniOmEvs3Uq5QzjVFRzshETj
	dcIswELzeYAMNIdb0oQGlb6/kbCnx13cXlrRZnKbP4h/7PA5G2NVN5sHBPpdbWek+mTpWJ
	NoKF0l0uJ68NH/4LVWH1Ej++idiqH+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792577067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSkifS5g9sRs2dk1uWfgPOLlW8mQhgnvvl6vZQyqxXE=;
	b=S2VzEQSEf8kOS15C3nnrqSGQ3jUYk/8VajCEkwmT4im2coHF0wmI7r9FMk50jBWZPMWgZC
	k6Dt813GXMTYy2Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792577067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSkifS5g9sRs2dk1uWfgPOLlW8mQhgnvvl6vZQyqxXE=;
	b=cIgu92OpUOYOgYiKqYMZS6dyGPqdaQC75nNW8p8TDGhFa/NniOmEvs3Uq5QzjVFRzshETj
	dcIswELzeYAMNIdb0oQGlb6/kbCnx13cXlrRZnKbP4h/7PA5G2NVN5sHBPpdbWek+mTpWJ
	NoKF0l0uJ68NH/4LVWH1Ej++idiqH+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792577067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSkifS5g9sRs2dk1uWfgPOLlW8mQhgnvvl6vZQyqxXE=;
	b=S2VzEQSEf8kOS15C3nnrqSGQ3jUYk/8VajCEkwmT4im2coHF0wmI7r9FMk50jBWZPMWgZC
	k6Dt813GXMTYy2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4889F134FD;
	Wed, 21 Oct 2026 10:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id axTVByuO2Gr0OQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Oct 2026 10:04:27 +0000
Message-ID: <526673b4-a090-47a4-9181-e30813a8cbe5@suse.de>
Date: Wed, 21 Oct 2026 12:04:26 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: fix io_work priority inversion when send_mutex
 is held
To: Seiji Nishikawa <snishika@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@kernel.org>, Chris Leech <cleech@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261014064524.4015025-1-snishika@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261014064524.4015025-1-snishika@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_030429_683020_672D402D 
X-CRM114-Status: GOOD (  33.54  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 8:45 AM, Seiji Nishikawa wrote:
> Commit f42d4796ee10 ("nvme-tcp: fix I/O stalls on congested sockets")
> added a check in nvme_tcp_io_work() that sets pending to true when the
> queue has pending requests and the socket is writeable. The check is
> placed after the mutex_trylock() block, so it also runs when
> mutex_trylock(&queue->send_mutex) failed and io_work did not send
> anything.
> 
> When .queue_rq sends a request directly from its own context, it holds
> send_mutex and can give up the CPU in lock_sock_nested() when another
> task needs the CPU, for example the io_work kworker of the same queue,
> which runs on the same CPU. Then io_work cannot take send_mutex, but
> the requests are still on req_list and the socket is writeable, so
> pending is set to true. io_work loops until the deadline and queues
> itself again on io_cpu, without sleeping.
> 
> This is a priority inversion. io_work runs on the high priority
> nvme_tcp_wq and cannot make progress until send_mutex is released, but
> it keeps running. The task holding send_mutex runs at normal priority
> and needs the CPU to release it. The scheduler keeps giving the CPU to
> io_work, so the task holding send_mutex may not run again, and the
> requests on the queue are not sent and time out.
> 
> This is the same problem that commit 70f437fb4395 ("nvme-tcp: fix
> io_work priority inversion") fixed. That commit removed
> "pending = !llist_empty(&queue->req_list)" from the path where
> mutex_trylock() fails, and let the task holding send_mutex queue
> io_work again in nvme_tcp_queue_request() after it releases the mutex.
> The new check brings back the same behavior in a different form.
> 
> Two things make this easier to hit. nvme_tcp_queue_request() sends
> directly only when it runs on io_cpu, so the task that takes send_mutex
> is on the same CPU as the io_work kworker of that queue when it takes
> the mutex. Also, when the tasks are in a cgroup with the cpu controller
> enabled, the whole group competes with the nice -20 kworker as one
> entity, so each task in the group gets even less CPU time.
> 
> We hit this on a 6 CPU VM running a database on nvme-tcp storage. In
> the vmcore, 2 tasks held send_mutex of 2 queues and were runnable in
> lock_sock_nested() for 103 seconds, while the kworkers for those queues
> kept running io_work on their CPUs. All database tasks were in one
> cgroup, which got only about 0.3% of the CPU against the nice -20
> kworker. Requests timed out, and blk_mq_timeout_work() waited in
> synchronize_srcu() for the tasks still in .queue_rq.
> 
How very interesting. I don't think you could craft a blktest for this?

> Only do the pending check if io_work could take send_mutex. If it could
> not, the task holding send_mutex sends what it can in
> nvme_tcp_send_all(), and queues io_work again after it releases the
> mutex if requests are still pending, so no request is left behind.
> 

The direct send path again. I really wonder if we need it at all, or
whether we cannot simply delete it.

Can you try if you see a regression with this patch?

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..2c59b550e13f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -405,17 +405,6 @@ static inline void nvme_tcp_queue_request(struct 
nvme_tcp_request *req,
         empty = llist_add(&req->lentry, &queue->req_list) &&
                 list_empty(&queue->send_list) && !queue->request;

-       /*
-        * if we're the first on the send_list and we can try to send
-        * directly, otherwise queue io_work. Also, only do that if we
-        * are on the same cpu, so we don't introduce contention.
-        */
-       if (queue->io_cpu == raw_smp_processor_id() &&
-           empty && mutex_trylock(&queue->send_mutex)) {
-               nvme_tcp_send_all(queue);
-               mutex_unlock(&queue->send_mutex);
-       }
-
         if (last && nvme_tcp_queue_has_pending(queue))
                 queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
  }

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

