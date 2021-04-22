Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB15C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 14:15:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D073260FDB
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 14:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D073260FDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oVlg8c28FGUqFpU+BL9t+ydsNOPUpS7etT5TJakAYWg=; b=Ce0wxtmnu8rDMwz6BEqcQD22gc
	QgYj5duA3mSezbKnvu2w13CJ+c0YJAdllzMSc/KSY/gkX8pOrwwa5dWnFMOgBLT5fqMxVsNSdbVtB
	jYdSV7RKIu7ZU4f5M8/mOEkD7DSIkl1mwYzsP8Tgo0YzkjTbB1KCTrfmjJn3rqLS+BwmkydSrYsdn
	27ngZ/fd1ItlE+Z9kvFEeMRoAtHuJ4SgOkgglPoDkrkQISHBgoaSWmdPet2g16Xs3fesYcyE3lvvF
	QobpyRxgZ1C1duMNq0pPRT69pwUdaoHagMjKsiOdTarP3i71MaDAxSJ445DijwD9nBlOIh7u0nfrF
	a2pXqZ0Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZa7D-00Grg2-Ku; Thu, 22 Apr 2021 14:15:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZa6v-00Grfq-2E
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 14:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=F8NMnIEX/BAYPz90VJgRLYD8ulo3eabExPoF+jKA5eE=; b=aafr7cBr2009wwNCr2QTcjdZDB
 Jxe0usenJjDaH/0eBYN4l4HqCM36YVJsVac7CvGPcRspXWqcNhR0fk1Ojeq81lL3+CAvIJaWbNWEq
 2/gwGTfXtx8NzldEYNlcLaMrkk2T14ltQGz0FV1h5lhlf+gElrRVz68IMgUTQu5cuO4YI5Ujd3pkH
 OvVByvTcxqTE3WUBBQsSh3IqgtoAryHPG/4vWvy3rpZIbSycs+3ynCYUxKl2ezG7RcJz3ffE0tari
 yHqOaTQjLph0C59viL9ypSyiXVqFCZGZtVV+zoh41BVnejHX3kxZ9W0bAKlBEcAlSigqIM0NkzlTJ
 0IoEWhFw==;
Received: from [2001:4bb8:19b:f845:4eeb:727b:c6de:39f1] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lZa6t-00DkW0-1K; Thu, 22 Apr 2021 14:15:15 +0000
Date: Thu, 22 Apr 2021 16:15:12 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] third round of nvme updates for Linux 5.13
Message-ID: <YIGE8ORkKryOdxtE@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

The following changes since commit b777f4c47781df6b23e3f4df6fdb92d9aceac7bb:

  ataflop: fix off by one in ataflop_probe() (2021-04-21 09:15:27 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-22

for you to fetch changes up to 2637baed78010eeaae274feb5b99ce90933fadfb:

  nvme: introduce generic per-namespace chardev (2021-04-22 07:25:17 +0200)

----------------------------------------------------------------
 - add support for a per-namespace character device (Minwoo Im)
 - various KATO fixes and cleanups (Hou Pu, Hannes Reinecke)
 - APST fix and cleanup

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: do not try to reconfigure APST when the controller is not live
      nvme: cleanup nvme_configure_apst

Hannes Reinecke (2):
      nvme: sanitize KATO setting
      nvme: add 'kato' sysfs attribute

Hou Pu (1):
      nvmet: avoid queuing keep-alive timer if it is disabled

Minwoo Im (1):
      nvme: introduce generic per-namespace chardev

 drivers/nvme/host/core.c        | 258 +++++++++++++++++++++++++++-------------
 drivers/nvme/host/fabrics.c     |   4 +-
 drivers/nvme/host/ioctl.c       |  38 +++++-
 drivers/nvme/host/multipath.c   |  51 +++++++-
 drivers/nvme/host/nvme.h        |  14 ++-
 drivers/nvme/target/admin-cmd.c |  10 +-
 6 files changed, 276 insertions(+), 99 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
