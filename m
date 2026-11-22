Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC79606A320
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nW54+tZz;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mx5IjgUB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uT1GKmOpOEmDr3TcXo7O2Gx87y3WQ7fIKW+zuqBtBT8=; b=nW54+tZzuyc9z3sAghUL2T7DN5
	rZGI/V7z7RfQlc17VWfyyADD+dTCduOq5+R2UpzUX97gYDO05qdjOuJO40QPy4S/8MdES3JDQ9Y/C
	PT29fBty/zzDlUerLig5fYhrvFMvGoJkjdAhX2dg+xpgn/9eYY9v4ugLuYWXxaQicT1yRUh/W0oaP
	jG3M4WHqXvxw9xKPdCK1fR+ZxedXdWuPL08Q226bSZJ7rqCMq4CieZDMDqCCJzDyY5bft+b8pLnZa
	K/oxoPX0WbKm7jxETVw/ao8GzrCJeMQh86Tz3WkjPtSuOOG4UDmVxVFa4admnYK93nARMs/gTQJKm
	qVOgdJgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUzKp-00000000je4-25Ff;
	Sun, 22 Nov 2026 04:37:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUzKn-00000000jdY-0NUv
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 04:37:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795322267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uT1GKmOpOEmDr3TcXo7O2Gx87y3WQ7fIKW+zuqBtBT8=;
	b=Mx5IjgUBB/00Gy+FaLKRRwLxlaYnEll7oUsUEGwykIWCfn51uLusqlANf860w9w6TQGIoO
	sa6CQDmy40hMwzaCdSL6+052piERxQyNyjECUQDt12G4axTNcFRkFvDt3AcXQ+ORCm2X0h
	zM9yvffTC9ZlvXzoh2ebyI15oT7Rw9Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-1cwIQmz0N7axuHD_9XaDGg-1; Sun,
 22 Nov 2026 04:37:41 +0000
X-MC-Unique: 1cwIQmz0N7axuHD_9XaDGg-1
X-Mimecast-MFC-AGG-ID: 1cwIQmz0N7axuHD_9XaDGg_1795322260
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D56D518004F6;
	Sun, 22 Nov 2026 04:37:39 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B48330000E3;
	Sun, 22 Nov 2026 04:37:35 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chris Leech <cleech@redhat.com>,
	Seiji Nishikawa <snishika@redhat.com>
Subject: Re: [RFC PATCH 1/2] nvme-tcp: remove the direct send path
Date: Sun, 22 Nov 2026 13:37:32 +0900
Message-ID: <20261122043732.2002424-1-snishika@redhat.com>
In-Reply-To: <sashiko-outbox-227628@kernel.org>
References: <sashiko-outbox-227628@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K8-lsWe__BMF5rJpaxOYX1ztHXMqRnFJ-NSLbDSAYKs_1795322260
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261121_203749_409121_1B8FD86C 
X-CRM114-Status: GOOD (  10.97  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 10:49 AM <sashiko-bot@kernel.org> wrote:
> [Severity: Medium]
> Does removing the inline send from nvme_tcp_queue_request() break polled
> I/O on HCTX_TYPE_POLL queues?
[ ... ]
> For SCHED_NORMAL tasks on queue->io_cpu, waking
> the WQ_HIGHPRI worker sets TIF_NEED_RESCHED, causing blk_hctx_poll() and
> io_iopoll_check() to abort polling on need_resched() or forcing two
> context switches per polled I/O.

This is right. I ran the test with poll queues on the same two machines.
The host connects with --nr-poll-queues=4, and fio runs with io_uring and
--hipri, 4k random I/O at queue depth 1, on the io_cpu of a poll queue.
Average of 3 runs of 60 seconds, latency in usec, ctx is the number of
context switches of fio in one run:

                     IOPS   slat    clat     lat      ctx
randread   base      5017   4.72  193.95  198.67      553
           patched   4179   9.35  229.70  239.05  251,318
randwrite  base      3619   5.60  269.94  275.54      542
           patched   3621  10.62  264.53  275.16  217,806

For randread, lat goes up by 40 usec (20%) and IOPS goes down by 17%.
ctx shows why. Without the direct send path, fio is switched out for the
io_work kworker once per I/O. With it, fio stays on the CPU and keeps
polling. randwrite shows no difference.

So removing the direct send path costs about 20% for polled reads at
queue depth 1 on this setup. One way to avoid this is to keep the direct
send path only for poll queues. Poll queues then still have 2 senders,
so send_mutex stays and patch 2 goes away.

I will send a v2 that does this, unless the list prefers to remove the
direct send path for all queues and take this cost.

Thanks,
Seiji


