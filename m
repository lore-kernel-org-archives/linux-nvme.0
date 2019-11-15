Return-Path: <SRS0=/3pY=ZH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA9C432C3
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D28320748
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hxF9k71s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOz6/7wM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D28320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=u+sRTbJkyWVlQTi6T4pit2U6LshjOkVV7nazFnXvQr4=; b=hxF9k71sW8Q7bb
	pVDJIVyDfRES3EyfnIkdQpu8pwxjNZAiuhfBZngYUcCQ9I/H1k2vJ1ODOM+EC0irCOLSya4GIc4Dv
	1/i6Kg2Zj+A4Bv01U+zbqROmCz2x74Cy4O3JpzdCTOt6lKgwuEW77XkP/+90J8sbK3zHpcHHIrMTc
	mqlkkcDxaK/NMRb9nkVC6DQau/GQB8zsHhLya1Y93M9CPE36fk4dKLjvkKn0Mbmvyn9DhiuDrUjy2
	RgK8KC+A4tIR8iRyea+yDFAR8gxESgewAGAer+reNkehcz+9ZBbW2YElaVfSI2OY7aXt7Ug+BtQLs
	p68auBQAzRhH0bez94Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iVZ4E-0002Fo-5b; Fri, 15 Nov 2019 10:43:06 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iVZ4B-0002El-DZ
 for linux-nvme@lists.infradead.org; Fri, 15 Nov 2019 10:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573814580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hZQNt4i5tbZeI/K7Y736TeIuVYSACoxkrpk+iD4NB2w=;
 b=IOz6/7wMGlW8c3KiVvbgOziOChFsdrsiwioInm2fF15hrMKk6EJOJU1lWo+WLSAds3zdel
 55Qn3HDAq8By6FKoOBVpMgKneBKoXIYWwjtyRKMSGrs3lrP9ipkabaqsF7tnqGnXim3OEC
 vp/FYZyDFYNv7lCNHKkeah/l7dOSv9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-lLE-SJQMMZCtEb6c1YNvPw-1; Fri, 15 Nov 2019 05:42:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35EB2477;
 Fri, 15 Nov 2019 10:42:55 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02E7369183;
 Fri, 15 Nov 2019 10:42:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for NVMe's
 connect request
Date: Fri, 15 Nov 2019 18:42:35 +0800
Message-Id: <20191115104238.15107-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: lLE-SJQMMZCtEb6c1YNvPw-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191115_024303_533107_BC852339 
X-CRM114-Status: UNSURE (   7.42  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Use blk_mq_alloc_request() for allocating NVMe loop, fc, rdma and tcp's
connect request, and selecting transport queue runtime for connect
request.

Then kill blk_mq_alloc_request_hctx(). 


Ming Lei (3):
  block: reuse one scheduler/flush field for private request's data
  nvme: don't use blk_mq_alloc_request_hctx() for allocating connect
    request
  blk-mq: kill blk_mq_alloc_request_hctx()

 block/blk-mq.c             | 46 --------------------------------------
 drivers/nvme/host/core.c   |  9 +++-----
 drivers/nvme/host/fc.c     | 10 +++++++++
 drivers/nvme/host/rdma.c   | 40 ++++++++++++++++++++++++++++++---
 drivers/nvme/host/tcp.c    | 41 ++++++++++++++++++++++++++++++---
 drivers/nvme/target/loop.c | 42 +++++++++++++++++++++++++++++++---
 include/linux/blk-mq.h     |  3 ---
 include/linux/blkdev.h     |  6 ++++-
 8 files changed, 132 insertions(+), 65 deletions(-)

Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>

-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
