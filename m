Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF94C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:42:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D99020884
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zcFgrVVM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ofzxJvLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D99020884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E3rf2SvS58onk5nVj7I2EjEz6DcR+1YnEfqSm3POUa8=; b=zcFgrVVMYSNnBm2wKPYBk6y0uV
	CeIlWZxvdqqYDnxk1JLIsHDSzx/l8Vf0vUdKwfxweHZXC53v3c6WnHgUehv1sPb2WrcRuVBUlH3Og
	Y/k52t2DQ21FUBBty1c1orYtI5IHpe/mI/icpasIAyI8eDFeoWgazJqmtmZHDeHaHidEFyMpKc1Bd
	XlQmiitUKpRODhhlWhr/zCLN4imOLs8MIXFdbW+QCukqz8S+AadPYAiBQPU/4fZ+a+OQHxNdIebAj
	nwNl2Fjx/VS+pB0Z+4Vq5J2chY4U1XkDFQmQdXMd4fPCu01YHR2afdGNY2LPHzuDB3FSbpQOm5qU2
	gYP6uPlg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqunO-0003LN-Ab; Thu, 02 Jul 2020 08:42:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqunM-0003Kn-JS
 for linux-nvme@merlin.infradead.org; Thu, 02 Jul 2020 08:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=HqyIXCxX5IGbvY8zL762FuGxgBm61N76zi3FqGJ89lc=; b=ofzxJvLWyvRGoUt/NZ6PzEAf3A
 ezsXEv/OThq9nola+E2s/ZsB46dIJOKMYoWroQp6JV+U3SNUwvIQ8wDTy9qBWgxG0VKOpj1kSLpi1
 ArLyL1VxEoKltC8FoP9QbGfVEX1kJzif8BFgOVEfawxXnas7YgcjqGj6lWRJlAUvVEA/0zL0qTND5
 Ym+x3gxSMMHpjwB+HFNZ200PhFSMRTbQEDQ+N/veauAeytwiREkNXbcyAAHMaEQ8OSQu1EpKLDz2d
 9iupGk8D0U29QQfrdK9b92kMQtB3/9Qnc6StCR7sIZML9hORY6ELzMGNJ6lK3vlcKuoDpq6hjYnOz
 vxaHw5hA==;
Received: from [213.208.157.36] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqunJ-0001Be-Ka; Thu, 02 Jul 2020 08:42:10 +0000
Date: Thu, 2 Jul 2020 10:42:07 +0200
From: Christoph Hellwig <hch@infradead.org>
To: axboe@kernel.dk
Subject: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200702084207.GA3718469@infradead.org>
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

The following changes since commit e7eea44eefbdd5f0345a0a8b80a3ca1c21030d06:

  virtio-blk: free vblk-vqs in error path of virtblk_probe() (2020-06-30 19:02:58 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 72d447113bb751ded97b2e2c38f886e4a4139082:

  nvme: fix a crash in nvme_mpath_add_disk (2020-07-02 10:38:00 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: fix a crash in nvme_mpath_add_disk

Sagi Grimberg (1):
      nvme: fix identify error status silent ignore

 drivers/nvme/host/core.c      | 12 +++++++++---
 drivers/nvme/host/multipath.c |  7 ++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
