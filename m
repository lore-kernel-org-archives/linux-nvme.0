Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9414C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 14:51:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BBD20738
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 14:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BnEtQObV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fi9V2yvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BBD20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=20n1Q9fMEID9BKagFc76DefR4fznqnXA7VCdMft5Dmg=; b=BnEtQObVeekFi/yGj8odWtxzqO
	Qjj1OQDScGwjUxVlDEHOiiYQOMV9A/6gZNdQNDmegM44bLUpTsO81hPbpHogw5qQ1uorbPoqE5c4o
	zlcJu+ELA++n7ATJ7lmFmzTRak5XSwaBUeVWlJ1p1V/uHEXyPzDIKFHy3Up+XwCojo+q9oLnjl+ES
	Q91bC2stbLO54vfHhCROxFYUdU6cXmfLBnIBQ9oFgcQzkZKuvhO4boEmwUSYeKrhFq7E+d/Oyt+ye
	iZbAZiNdodvch8xPdw6rFT0/aKPY8YnN4Zj+nzKLAXIXLJOYeeEjBdl+cRg2kJ2Njs7aTXTKb69jq
	x/j9ffbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kY9HK-0002bU-L7; Thu, 29 Oct 2020 14:51:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kY9HI-0002bM-K2
 for linux-nvme@merlin.infradead.org; Thu, 29 Oct 2020 14:51:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=obxEWvN336dPaDHa6MJeNd09PKjNPNgrbqvoiKWiDiA=; b=Fi9V2yvmNP2/jBHyITiygG/kwD
 57me0XiysYc8ZpezPw1CLmKj4Z1ueRyNksn+KgNaEAw5e6ONQOhsk/mgT4F7VfsXF+h4F0m47fRfv
 6DIs6drTZa2PhXf/x40AXryrZwCdRGmITJsuynJiog/6UI5a1HPRSDaA27vQvXWcYK5+9wQVf2rYp
 hJIAiUZsTLbX1kEa7MQXp+fVrjCPKpCUD4knuzx+jNhUddVyRGSHU7nOI1rIoEOAm5POp1WihijOy
 xh+2yZuzH8G2X2QggGTIGLYRKEsC846Qeb/rpE6oQOHZcT3Xf7uCQIeMiTVL34bFPLVkmUEBHeqeX
 SUvWQzAQ==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kY9HF-0004jx-QR; Thu, 29 Oct 2020 14:51:46 +0000
Date: Thu, 29 Oct 2020 15:49:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.10
Message-ID: <20201029144934.GA143642@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit f255c19b3ab46d3cad3b1b2e1036f4c926cb1d0c:

  blk-cgroup: Pre-allocate tree node on blkg_conf_prep (2020-10-26 07:57:47 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-29

for you to fetch changes up to 3c3751f2daf6675f6b5bee83b792354c272f5bd2:

  nvmet: fix a NULL pointer dereference when tracing the flush command (2020-10-27 10:02:50 +0100)

----------------------------------------------------------------
nvme updates for 5.10:

 - improve zone revalidation (Keith Busch)
 - gracefully handle zero length messages in nvme-rdma (zhenwei pi)
 - nvme-fc error handling fixes (James Smart)
 - nvmet tracing NULL pointer dereference fix (Chaitanya Kulkarni)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: fix a NULL pointer dereference when tracing the flush command

James Smart (4):
      nvme-fc: track error_recovery while connecting
      nvme-fc: remove err_work work item
      nvme-fc: eliminate terminate_io use by nvme_fc_error_recovery
      nvme-fc: remove nvme_fc_terminate_io()

Keith Busch (1):
      nvme: ignore zone validate errors on subsequent scans

zhenwei pi (1):
      nvme-rdma: handle unexpected nvme completion data length

 drivers/nvme/host/core.c    |   2 +-
 drivers/nvme/host/fc.c      | 270 ++++++++++++++++++--------------------------
 drivers/nvme/host/rdma.c    |   8 ++
 drivers/nvme/target/core.c  |   4 +-
 drivers/nvme/target/trace.h |  21 ++--
 5 files changed, 127 insertions(+), 178 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
