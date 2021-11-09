Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FF9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 07:12:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3265761156
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 07:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3265761156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P6uvsw2qEEoPf+gh+bzaIzonmWnOB7YX0hJHz6V9IKE=; b=irqAK02dHY7HoXDPBAg927wZNP
	Sl9yZivypZEME4kdH1PrXbAQOgJNnhMG4Ch0QHb2UDwEmi24ahJt+S3yD7yHdILaZ0bBGLlKT+fZ+
	MOUhWZgUZuHR8/pMLHTgLRmsIYuAqbAFG1d/K4O9FYNTAxEw9aBhr/2wWRBhZB+De+yv+J0fsf1NU
	ev0Js7/LEctCXUj8qbmWJU1e9Bftcq9b9hkZ6biDZS8hltLuXoyxdu2FvWZV0rP33bfG71ev0sZku
	pre5SrnuSqTxMsySkMBXCcD9USEqSte6hheIb7NqDOdlqPZSBPo/ZxRsXkb8JZndGhTqHESwFZe0L
	eYSOAoiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkLIi-000q8E-CO; Tue, 09 Nov 2021 07:12:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkLIf-000q7j-9B
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 07:12:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636441927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=P6uvsw2qEEoPf+gh+bzaIzonmWnOB7YX0hJHz6V9IKE=;
 b=AeKmYzZOOf8JT7NhDkfQBdDhyUUdRM+vbDi+SGPcmARDzC2kZB9pCn3S+PheAgUSsn+gcu
 zO+JVOwFMb3/jQOSia6Y1+5hWgbY14k345YQy7k4o7zvNPG9qz0z8Vp3KSulmds2yfKcTw
 WXB4Fae+E2kYbNSz89Ch/XZKmXRqfeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-WQ5yB0iQMH2nb3nu46EsPg-1; Tue, 09 Nov 2021 02:12:04 -0500
X-MC-Unique: WQ5yB0iQMH2nb3nu46EsPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF8BD802C8F;
 Tue,  9 Nov 2021 07:12:02 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03B9377E26;
 Tue,  9 Nov 2021 07:11:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/4] block: fix concurrent quiesce
Date: Tue,  9 Nov 2021 15:11:40 +0800
Message-Id: <20211109071144.181581-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_231209_442616_794988EC 
X-CRM114-Status: GOOD (  10.94  )
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

Hi Jens,

Convert SCSI into balanced quiesce and unquiesce by using atomic
variable as suggested by James, meantime fix previous nvme conversion by
adding one new API because we have to wait until the started quiesce is
done.

V2:
	- add comment on scsi's change, as suggested by James, 3/4
	- add reviewed-by tag, 4/4

Ming Lei (4):
  blk-mq: add one API for waiting until quiesce is done
  scsi: avoid to quiesce sdev->request_queue two times
  scsi: make sure that request queue queiesce and unquiesce balanced
  nvme: wait until quiesce is done

 block/blk-mq.c             | 28 ++++++++++++-----
 drivers/nvme/host/core.c   |  4 +++
 drivers/scsi/scsi_lib.c    | 62 ++++++++++++++++++++++++--------------
 include/linux/blk-mq.h     |  1 +
 include/scsi/scsi_device.h |  1 +
 5 files changed, 66 insertions(+), 30 deletions(-)

-- 
2.31.1


