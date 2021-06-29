Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BEFC11F68
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 07:50:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682A561DC2
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 07:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682A561DC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WsE6BDs3vVth0rysvDA4XZCKdtwT0HUqpt72j9U89sE=; b=2qTCdFUBHW6+pK
	gOj03FSPVQwYPiffLlkkVAVYbdRDnUgxTyqG/FXTre5CMuOaBQSPDLFJoYvnm/6QYSvRcZqt0VOMd
	R6wzP7JXquKAXW7cdREDSca6G+pXDEctDDTJKgrx58UCScYbUlroztPzZOC5p9ns2F0A6RyeMTCDP
	QQXnMVouDjzT4Vn/+pJd+MM01BtBCZz1Xb/JkmM7Z0aTP8Tw16ONjZGsQpx75PQqHIu1U+TjYT05s
	VzWuUTbBvkwq/9MsPUm17iSsLguGjlIbNx83Pz7ZNtN8q8sDCl3YMS5vjlzO9t/Wtf0XFtuxG+hpt
	ngQvq0Z4Xh6KMqswZx/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ly8Vf-00A6G2-NQ; Tue, 29 Jun 2021 07:50:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ly8Vc-00A6Et-I3
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 07:50:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624953015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eYdPUpXHyBcnfyXYfLQSlAwhq5QQG5cRwiJRI/9Ji40=;
 b=dKOtffN6phQ5F8SnCM9kSsYcyAOi6cUQAjfKsmPSMtlPwc/r9ILG+ZXzwixbQSnhaOC91H
 xuX2SlIsMDW/WY64BtNlXLBogDhWarvZP20gkXna3ODIFoF95m8RWWiOuFfFFYmV7tfkQt
 v2n29lNikpdM66OJZqRsak3fsIFvNXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ZOYQ5WixPdmd7i_ApKj3pw-1; Tue, 29 Jun 2021 03:50:12 -0400
X-MC-Unique: ZOYQ5WixPdmd7i_ApKj3pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4D83C73A1;
 Tue, 29 Jun 2021 07:50:10 +0000 (UTC)
Received: from localhost (ovpn-13-8.pek2.redhat.com [10.72.13.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BD9B5D9FC;
 Tue, 29 Jun 2021 07:50:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
Date: Tue, 29 Jun 2021 15:49:49 +0800
Message-Id: <20210629074951.1981284-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_005016_735004_D652AD8B 
X-CRM114-Status: GOOD (  14.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

blk_mq_alloc_request_hctx() is used by NVMe fc/rdma/tcp/loop to connect
io queue. Also the sw ctx is chosen as the 1st online cpu in hctx->cpumask.
However, all cpus in hctx->cpumask may be offline.

This usage model isn't well supported by blk-mq which supposes allocator is
always done on one online CPU in hctx->cpumask. This assumption is
related with managed irq, which also requires blk-mq to drain inflight
request in this hctx when the last cpu in hctx->cpumask is going to
offline.

However, NVMe fc/rdma/tcp/loop don't use managed irq, so we should allow
them to ask for request allocation when the specified hctx is inactive
(all cpus in hctx->cpumask are offline).

Fix blk_mq_alloc_request_hctx() by adding/passing flag of
BLK_MQ_F_NOT_USE_MANAGED_IRQ. 


Ming Lei (2):
  blk-mq: not deactivate hctx if the device doesn't use managed irq
  nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for fc/rdma/tcp/loop

 block/blk-mq.c             | 6 +++++-
 drivers/nvme/host/fc.c     | 3 ++-
 drivers/nvme/host/rdma.c   | 3 ++-
 drivers/nvme/host/tcp.c    | 3 ++-
 drivers/nvme/target/loop.c | 3 ++-
 include/linux/blk-mq.h     | 1 +
 6 files changed, 14 insertions(+), 5 deletions(-)

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: John Garry <john.garry@huawei.com>


-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
