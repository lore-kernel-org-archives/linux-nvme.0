Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE774C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:30:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F5A207F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lbfyRaqQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHgcih2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F5A207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=73lpMFcqr0A6i/BWs13StFchqAGO2nJvXcHaxDBaLkI=; b=lbfyRaqQHF9OkxjGLsJ/QjVocQ
	tPEB9uv35MDrEMfMDeWPrHfzSahsp5001S0OvGWMT2PVhcEC8p1Gogv+a0a5HHW5ivg6q/xuazfTD
	TeZ5ZSlenAV8MQojsAyd+L+EeunMetTaLoSqYROJxPCUB2XazQTq68TKyvqSxzFpA3AkizizBbvhc
	eHmuIksu8gtcCNqlBKEmHJUqsXC/sp2exJT0s2usCCxZwRLVdMkU6ASCiYcP5p7jc1rqsNOsyXF33
	euXEPA+qcQgaC/8EnTmsurX3ypIAuj2qhRwVe/rhqTaXf/+J0OtcG2Y+yqoRsR9lsP1fAaFKv1k3P
	xaSinEkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0pu9-00009P-RV; Wed, 29 Jul 2020 17:30:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0pu8-000096-V6
 for linux-nvme@merlin.infradead.org; Wed, 29 Jul 2020 17:30:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=8+DbFmLONb9RPRXJafuIV7buNQfBxWlf9Ys9UE/QO2I=; b=jHgcih2eGtVJCHGOkdDLjN+5iz
 P2Lp3xTMDAIzFCcwiE4O1soVvp9KBnHjXngtbk1Zk35phm+grFVAt248Xhm8Aa8Oc86Gdejh72Fvh
 Nq9rUm7wZZynf3rH67iec9k7YhZ9V/J6Xc/W2xBjlAwuunRSJ3WFApW8LXhDyAaYMsHtE1N3xknWd
 XQgYWpusDkQIP6ZaN4Fn1kYUcQ5dwG6n7XsQ5LMQUhPFS9YOAgZZiTGmwuyLheAw3TBLvQEjicrDk
 z+frH63QSsWdnoRu7O4SapJE6bU09+OkaqrpzD4z94YNnqvxOdSTDK0bxqOmXJ7qNFAHSbU9jBw4p
 XcaJVGEg==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0pu7-0003Vv-Ae; Wed, 29 Jul 2020 17:30:11 +0000
Date: Wed, 29 Jul 2020 19:30:10 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200729173010.GA25167@infradead.org>
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

The following changes since commit 1f273e255b285282707fa3246391f66e9dc4178f:

  Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8 (2020-07-16 08:58:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a:

  nvme: add a Identify Namespace Identification Descriptor list quirk (2020-07-29 08:05:44 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: add a Identify Namespace Identification Descriptor list quirk

Kai-Heng Feng (1):
      nvme-pci: prevent SK hynix PC400 from using Write Zeroes command

Sagi Grimberg (1):
      nvme-tcp: fix possible hang waiting for icresp response

 drivers/nvme/host/core.c | 15 +++------------
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  |  4 ++++
 drivers/nvme/host/tcp.c  |  3 +++
 4 files changed, 17 insertions(+), 12 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
