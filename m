Return-Path: <SRS0=ODQg=OO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1556C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7197060F48
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7197060F48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5zn/i5hLTfQ5ezbOJJ87fDIoAgAZKh+7/r/P3UfpPVE=; b=MhJO3nrcjOwQNj
	dgbfA6FLrOdFeXhMI+5E2R7zcVQ4mhNaQ95lDucG8HkaEsNqKDSZi/0LCJ6RS3PodP0C8U4+tmglt
	HitgPownNBhzoQrObbmzzPqWXuGNOVIGWoGqzUAVYc94VvyiKjmAaG0N1RiHHjcwpSsjPty3858xj
	Olkqf01I9LmHmyr7QMq8X95sSXpJCJAdzWsqzgI/+KWhAvRSB353dKmG5nO7Z4V/ZM1oGM9YIwBt2
	DQEHw2TIpB17zYBc6YuJNyrF+1ilrbfz16srZcL51uyTdazkJPwnC1qutLDH4UC8XN/nK3/AA/WFW
	iYCtCp+XzrSGYH/izHdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTepq-00DATQ-QW; Fri, 24 Sep 2021 06:37:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTepp-00DATK-A4
 for linux-nvme@bombadil.infradead.org; Fri, 24 Sep 2021 06:37:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=E88Z00ZlAwLBAUITmbRn6M8Pl/W09ZjXCUecGA0cccs=; b=sULAqj+uLXdWuZvG6CmAxm76wZ
 qGj1GhWwQfOfIe4OtN9F8vHBAxiqfDhG5knui07tRIq+LCsofnkxQguHU7lVOwnPIhjRVxoIfUUZs
 uM8Kt/BpPk6o3uAnzCrDdaj1UGSO3qxtu4FWNPRT8OstJPoED6ioIJipL7LoUkNAPp8IfHGQ3n23h
 8BL3sUa/9QAk+D83h2kLHs9fE0XfSWjeGhqekEcWuWzcyfxaOekgEMrDx+E2tbL4IH1V7TDW8SFZ3
 i28IVSTRpx8tqIfj0My8hr3Ztnwuu+A+nVcCA+qbQlkqtmtLQp8cZ+KyZQcCFgEw0cqQR0jXBZBw4
 wgOOeP9g==;
Received: from [2001:4bb8:184:72db:7155:a6da:d23f:c65d] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTepM-006vTg-4w; Fri, 24 Sep 2021 06:37:03 +0000
Date: Fri, 24 Sep 2021 08:36:54 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.15
Message-ID: <YU1yBgH+CqJu9h5u@infradead.org>
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

The following changes since commit 858560b27645e7e97aca37ee8f232cccd658fbd2:

  blk-cgroup: fix UAF by grabbing blkcg lock before destroying blkg pd (2021-09-15 12:03:18 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-24

for you to fetch changes up to 298ba0e3d4af539cc37f982d4c011a0f07fca48c:

  nvme: keep ctrl->namespaces ordered (2021-09-21 09:17:15 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.15:

 - keep ctrl->namespaces ordered (me)
 - fix incorrect h2cdata pdu offset accounting in nvme-tcp
   (Sagi Grimberg)
 - handled updated hw_queues in nvme-fc more carefully (Daniel Wagner,
   James Smart)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: keep ctrl->namespaces ordered

Daniel Wagner (1):
      nvme-fc: update hardware queues before using them

James Smart (2):
      nvme-fc: avoid race between time out and tear down
      nvme-fc: remove freeze/unfreeze around update_nr_hw_queues

Sagi Grimberg (1):
      nvme-tcp: fix incorrect h2cdata pdu offset accounting

 drivers/nvme/host/core.c | 33 +++++++++++++++++----------------
 drivers/nvme/host/fc.c   | 18 +++++++++---------
 drivers/nvme/host/tcp.c  | 13 ++++++++++---
 3 files changed, 36 insertions(+), 28 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
