Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D1606A320
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HSi/AyyD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bSXar4kg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=anvLIQ/gAVabMUhFwRkaKGx6MGoQfQXTcBbd/iuWriU=; b=HSi/AyyDh0Ij9Da638wamhWm4i
	pS5h2HVrLNCIPKaLBKl3mGtUW528nodGvNbzKcLl6IFaqJaqQGSM0AvVDp8NRNJOTEvRN3S9GePVF
	KM+G1cIKb4TyMvwl4b7z3iEFC+tqCJmqH6FQqeno6y3LPInZYupkXpYnTS6vbMDw35NWs6o/K/gpX
	7iXdI3UFIcHeifpTH1c3g5cCbujQizQZnWRelwegFtB/K9v+lB6AXMxfR4tWOhf9CXQXaDOg2kr5R
	QHihQfsyrLMemtn08jJkjLSrSMyUjHKREKxoyxY5ioaDkp9tK4LKKaaOmDUFW09xN6hnJCeLt4VKz
	vBo/nlsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUwGQ-00000000e0E-0CJ3;
	Sun, 22 Nov 2026 01:21:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUwGN-00000000dzZ-1YYE
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 01:21:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795310462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=anvLIQ/gAVabMUhFwRkaKGx6MGoQfQXTcBbd/iuWriU=;
	b=bSXar4kgoYEVeGVXPVW7bbVw7Zw8/yjw2GBrIN9i9PtGyzFUSUe6V4FGqnOlQkPIHeDZ/w
	OVRteYx7fgw69fkzFKbvgnHUMg4NdrA9F1ctHtGDZXw7Ww//IIF75FgcJxBJUIsxvwqXTl
	U6PNOfLERvEQYZeIT9X7VBRLgAZGyUE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-5zWvLQCYMx-y__GcH6rhNg-1; Sun,
 22 Nov 2026 01:19:12 +0000
X-MC-Unique: 5zWvLQCYMx-y__GcH6rhNg-1
X-Mimecast-MFC-AGG-ID: 5zWvLQCYMx-y__GcH6rhNg_1795310351
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31602180035E;
	Sun, 22 Nov 2026 01:19:10 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFC0D3003E88;
	Sun, 22 Nov 2026 01:19:05 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>,
	Chris Leech <cleech@redhat.com>,
	Seiji Nishikawa <snishika@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] nvme-tcp: remove the direct send path
Date: Sun, 22 Nov 2026 10:18:24 +0900
Message-ID: <20261122011826.1959697-1-snishika@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: iPBcJu04tm_IkQP2maqIX7AhDkOp2tgwViD78xIR2HQ_1795310351
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261121_172103_560662_13F04986 
X-CRM114-Status: GOOD (  13.65  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hannes suggested removing the direct send path in
nvme_tcp_queue_request() while reviewing commit 5db358f3a7f9 ("nvme-tcp:
fix io_work priority inversion when send_mutex is held"). This series
does that, on top of nvme-7.4.

Patch 1 removes the direct send path, so io_work is the only sender.
Patch 2 removes send_mutex, which has nothing left to protect after
patch 1.

The direct send path was added to cut latency when the queue is idle,
so I measured it on two machines with 1Gb NICs. The target is nvmet-tcp
backed by null_blk (irqmode=0). The host runs fio like this, 60 seconds
per run and 3 runs per case:

  fio --name=qd1 --filename=/dev/nvme0n1 --direct=1 --ioengine=libaio \
      --bs=4k --rw=randread --iodepth=1 --numjobs=1 --cpus_allowed=2 \
      --time_based --runtime=60 --ramp_time=5

Average of the 3 runs at queue depth 1, latency in usec, "patched" is
this series:

                      IOPS   slat   clat    lat  clat p99
  randread   base     4153    7.1  232.3  239.3       277
             patched  4154    4.7  234.7  239.4       280
  randwrite  base     2472   24.5  375.6  400.1       553
             patched  2460   14.3  387.6  402.0       570

The send time moves from slat to clat. With the direct send path,
io_submit() itself sends the command on the socket, so that time is
counted in slat. Without it, io_submit() only queues the request and
returns, and io_work sends it, so the same time is counted in clat. lat
is the sum of the two, and it changes by 0.1 usec for randread and 1.9
usec (+0.5%) for randwrite.

At queue depth 32 with 4 jobs, both kernels reach the 1Gb link limit
(28.2k IOPS), so there is no difference there.

On the same two machines, I also ran 5 controller resets during a 120
second randrw fio run on the patched kernel, and fio finished with no
errors. Separately, blktests nvme over tcp on a VM with an nvmet tcp
loopback target gives the same results with and without this series.

On a 1Gb network one I/O takes about 240 us, so a difference of a few
microseconds is easy to miss. Numbers from faster networks would show
whether it matters there. I am posting this as RFC so the performance
side can be discussed on the list.

Seiji Nishikawa (2):
  nvme-tcp: remove the direct send path
  nvme-tcp: remove send_mutex

 drivers/nvme/host/tcp.c | 60 +++++++----------------------------------
 1 file changed, 9 insertions(+), 51 deletions(-)


base-commit: 68099cf27253a8c89d703a282d3d811446d9453b
-- 
2.56.1


