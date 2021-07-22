Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6683CC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 18:57:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC0B60E74
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 18:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1DC0B60E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C3xlep3V6bOlk3rRmrpmVD+uZFZfsA7dD8kyz3lhkus=; b=i/2TsVLauD9hS5
	2bruK/oceN8kzIOBf8LxC3NzaQQ6iSnk4PcQOLnH5eBA3O/oqp2YIRVkdBKvGQtttYcDIZpU/rNCL
	mEU3yL8KPKXzMNiMJF5fyOxhM+aEzSUtc7n/VAxqDyISSEMtzLiyIhHIWJ8p/1bh6app5Nn+VBGG5
	9l0QKl9h1jeOIRJO7fZo8EcanNzPL9EVprMPHbHHfnwalIEBtCDQf4j5U/w1vGsRyPPpVVspcMl79
	ChE9vOYu9r8P7kFXbnFQmLRqH1hxXFgbo13ljE4kVJZNEQ0/Z8SsBiNZdKjKTBsV3fIU6MmT/ku8L
	kkCCHuADeiDQjOuG2Okg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6dsZ-002SQf-Ek; Thu, 22 Jul 2021 18:57:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6dsY-002SQQ-7p
 for linux-nvme@bombadil.infradead.org; Thu, 22 Jul 2021 18:57:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=vPzicTsQNqzpGuhcoSCNUmZQidereeyfqguWHkqWm6U=; b=WBQSD29hHDGyqKeKwTFSs2KFho
 Yzez0oJCjMaXx/1JmNW7WPOhLJpLlpQMuLFmNfzKzqIXs9uDHsSnSZrd2M38IT2iyVGHKQZaDOFnF
 HNDR8ArI3tjPe5KA1LvxRnumhKKdsSR5mvTvbrSNyxw0LgnRxIBmqoAizRYY8k1wtWCWMLfmEDtJ+
 KpvPCGK51S7SZjYLsBxdGtMh3OzAg4ZQgZ3BlvUrLugwlKvs5fj+cvvrigECxh2dygVLaElQCBNdL
 ekxC5s33w7JQE21soMgSW97sNGiO5Xo2PKNayzZcBqbbDLsIaaDwN2s2xadyPyldPIjHc67apSoar
 vqJcM6iQ==;
Received: from [2001:4bb8:193:7660:c4c4:42f6:7449:aaf8] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6dsK-00Aaka-Lp; Thu, 22 Jul 2021 18:56:57 +0000
Date: Thu, 22 Jul 2021 20:56:48 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.14
Message-ID: <YPm/cHUBGJpVOS4n@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
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

The following changes since commit ec645dc96699ea6c37b6de86c84d7288ea9a4ddf:

  block: increase BLKCG_MAX_POLS (2021-07-17 13:07:24 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.14-2021-07-22

for you to fetch changes up to aaeb7bb061be545251606f4d9c82d710ca2a7c8e:

  nvme: set the PRACT bit when using Write Zeroes with T10 PI (2021-07-21 17:24:10 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.14:

 - tracing fix (Keith Busch)
 - fix multipath head refcounting (Hannes Reinecke)
 - Write Zeroes vs PI fix (me)
 - drop a bogus WARN_ON (Zhihao Cheng)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: set the PRACT bit when using Write Zeroes with T10 PI

Hannes Reinecke (1):
      nvme: fix refcounting imbalance when all paths are down

Keith Busch (1):
      nvme: fix nvme_setup_command metadata trace event

Zhihao Cheng (1):
      nvme-pci: don't WARN_ON in nvme_reset_work if ctrl.state is not RESETTING

 drivers/nvme/host/core.c      | 19 +++++++++++++++----
 drivers/nvme/host/multipath.c |  9 ++++++++-
 drivers/nvme/host/nvme.h      | 11 ++---------
 drivers/nvme/host/pci.c       |  4 +++-
 drivers/nvme/host/trace.h     |  6 +++---
 5 files changed, 31 insertions(+), 18 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
