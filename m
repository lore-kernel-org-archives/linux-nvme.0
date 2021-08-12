Return-Path: <SRS0=ZjMq=ND=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30A2C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 07:48:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4036360FC4
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 07:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4036360FC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=56U1hBD/2jRnTqc8k8bo/202m4mPmgjZXbZoh2Ft8Z0=; b=Y5NETs2he7XDks
	g5CnfPlcaUuLQEr/ETb3dI8YJzIyDsvdwLVgPuAKYtroXKt3PRlOWsXlPMDNocvELwxZisOQFRSfG
	iy/xmBtDIrKLfJdQnltMeqsGi2qwiJV6zPX1vjVtxqvfsxaOZvv6lDK984lR08y33ci+acBO43rWV
	UzzcOMQSg000YhcbHyQDDbPnh1fDuwPShSL8dZMJPOaQhPi+VJApHQ7YLVMQCNcacvwjPpUSrqTpL
	Fql5AT7ZQgexN29BgCfFU46iBXhDkLkROR+xgE9L2EL2CCIx6VxsC3P+G2FfSbsoE6jDtLzy0rSso
	XBLosdeERgJD77FIClyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mE5RC-008yhh-Uu; Thu, 12 Aug 2021 07:47:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mE5R7-008ygz-U5
 for linux-nvme@bombadil.infradead.org; Thu, 12 Aug 2021 07:47:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=B4RfsAuEaf/XY8TwrKDqgJkTJwlrQq1GUBTudpvyGbs=; b=CuF15s7J55bvbBZtk4F3Bj1I75
 tvhuMDSR3PEce6l3vQ3HaQcHl64Suzbnoc/mJHbRS5fMyACOEXLmrDHsy5kYALzvKFY0W/0Y6qM+B
 hRJI7qha0ruw9oObhmz3L/XDlWtNTrVSurH8Z20TST2NzBlvzU5y/4oV0lREaZPdBSLAzrrcYWXIk
 kuQMqTx1Xt4KLEeSNujUzqayatrevZMEz5is6+7dg4JzAYlbEKnh24zoqgKZqfM8XfHUyj2V/I6R8
 F2DQYufqV8ovxmlHFFtohA0ciX3XYJE6JaB3K+HFAPQwcDmDzLvqHoHQc7fMGX5WW32so2uzMnM/a
 ZX2csPtw==;
Received: from [2001:4bb8:184:6215:d7d:1904:40de:694d] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mE5QI-00EIjT-V7; Thu, 12 Aug 2021 07:47:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: ensure each gendisk always has a request_queue reference
Date: Thu, 12 Aug 2021 09:46:34 +0200
Message-Id: <20210812074642.18592-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Hi Jens,

this is the final batch of the gendisk interface cleanup series.  This
remove the last uses of the legacy alloc_disk interface and ensures we
always have a request_queue reference for a gendisk.

Diffstat:
 block/blk-mq.c                  |    6 ++--
 block/genhd.c                   |   31 ++++++++++---------------
 drivers/nvme/host/core.c        |   33 ++++++++++----------------
 drivers/s390/block/dasd_genhd.c |    7 ++++-
 drivers/scsi/sd.c               |    6 +++-
 drivers/scsi/sg.c               |   32 +++++++-------------------
 drivers/scsi/sr.c               |    7 ++++-
 drivers/scsi/st.c               |   49 +++++++++-------------------------------
 drivers/scsi/st.h               |    2 -
 include/linux/blk-mq.h          |   10 ++------
 include/linux/genhd.h           |   30 +++---------------------
 11 files changed, 72 insertions(+), 141 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
