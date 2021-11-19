Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDE9C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 02:19:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EC961266
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 02:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2EC961266
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G3vphndXa84gadtSR/MBQRGNnIZdeiOYY+1xED06sog=; b=my16w2+orRuSqYJCREl42x2cHY
	xiu3dbGD7q0PjgEDVvobpRbZvrw1EBOkI1oJsaiD1gqAYcbHpMw+HmBs217yZ4TpRFLDGalvQgpIi
	rOrv3S9kaDOtUBnFY+4EStmnAjoYuzFiPc5PMJiVkKXI5Dum3uoOXP9Rf2/zUjnGa5tVPcuhyQstp
	WKvAa4efXQOTeQmEIJ+n9aITxYOsjTzSbp55Wo0BDBcmUtdzaT4SyP6v/aVk1qtI/hzsqSW8DEPPf
	Y2beV9wKWzLl8n5xFQKzghPjiK39hUMJ6R23wONzBXlaKSMwBVjuc8GFDJmnj+sUNgIE3N4jAyXDE
	H+/4qzuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mntUf-009EXS-NI; Fri, 19 Nov 2021 02:19:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mntUd-009EWb-1W
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 02:19:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637288348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=G3vphndXa84gadtSR/MBQRGNnIZdeiOYY+1xED06sog=;
 b=ARny4Mz2qpILiF0a2vJta78sXp4xxsZxb/RHMmPweUG4OKlnNPMR4jSGLzYdAnqvJqU7iX
 veLNawIy77T8XBktzLFt/cAZ4JJdjCReZSELgAvztJBFmqY96qA1kQ6NMPwmKPXGwpdEui
 ADHWmUu10LypEPS+TNCDtWTGjqbO0VU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-QGfrQ-zzN_-l3982l7SRMQ-1; Thu, 18 Nov 2021 21:19:06 -0500
X-MC-Unique: QGfrQ-zzN_-l3982l7SRMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E884C180831C;
 Fri, 19 Nov 2021 02:19:03 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C94D74ABA9;
 Fri, 19 Nov 2021 02:18:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/5] blk-mq: quiesce improvement
Date: Fri, 19 Nov 2021 10:18:44 +0800
Message-Id: <20211119021849.2259254-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_181911_182552_294D7429 
X-CRM114-Status: GOOD (  11.08  )
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

Hi,

The 1st two patches moves srcu from blk_mq_hw_ctx to request_queue.

The other patches add one new helper for supporting quiesce in parallel.


Ming Lei (5):
  blk-mq: move srcu from blk_mq_hw_ctx to request_queue
  blk-mq: rename hctx_lock & hctx_unlock
  blk-mq: add helper of blk_mq_global_quiesce_wait()
  nvme: quiesce namespace queue in parallel
  scsi: use blk-mq quiesce APIs to implement scsi_host_block

 block/blk-core.c         | 23 +++++++++---
 block/blk-mq-sysfs.c     |  2 --
 block/blk-mq.c           | 78 +++++++++++++++++-----------------------
 block/blk-sysfs.c        |  3 +-
 block/blk.h              | 10 +++++-
 block/genhd.c            |  2 +-
 drivers/nvme/host/core.c |  9 +++--
 drivers/scsi/scsi_lib.c  | 16 ++++-----
 include/linux/blk-mq.h   | 21 ++++++-----
 include/linux/blkdev.h   |  8 +++++
 10 files changed, 98 insertions(+), 74 deletions(-)

-- 
2.31.1


