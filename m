Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9459BC388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 11:00:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0F12192A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 11:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BQ4M+Rjh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qn6C/eVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0F12192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jvx3y2I7vJokd3NI8CKrwlQRArXmejLTzU5gECfl4Rs=; b=BQ4M+RjhjVW9YLAodF7JBd7CU+
	/zXVJkTuVefk+ZV3iNZ6vmUCwJAfWEfrtFFhiZKy9OXc/H1s44PA/bV/36+dsykODR02xLmvGK1wQ
	qe4L1AZY9JPG4m/476FBbrtObzMWMaud60ZeBPO00Jxqpj1X9dQ5e63cnv2LOZbj37q4nuFTlluvm
	9fvbWSmPyBtwDmhU7gJroiVt/jqHQ2XSruBvioUHptErakVKUsJeRmNoFBFAB5JZ1xz2ogcLmoqlq
	jN3O+zboWTqU+yrHN2OsgBjke/+dr1oOXYW7B57wQXkqFHCjO5EBCvx7HZuybYKrmEUF8oLya8Sa6
	bncvRxpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVuoM-0006b5-5l; Fri, 23 Oct 2020 11:00:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVuoK-0006at-C4
 for linux-nvme@merlin.infradead.org; Fri, 23 Oct 2020 11:00:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=u+eKJ66BtwRzfpZO0koRnDJYiwMP68LngP9eep3gWf8=; b=Qn6C/eVxnjrOzLG9NQ8WpWBiCx
 7TnNDpql5SUh0VMFXYTYkc2EoK2I+5fdHiC56T+juTeTMict1E0fjiPBKFyYI/VvXNP/ETGd0KASw
 ui0iyfnZd6tq7uaZzQwPt5+JOCgOJYDLYTLkNbQGc2TeRHRLKCZj2xQA7CjUy3zYJXPFvoQhboqL5
 AjgRh2d7yN/dVLMJp9gYSp1B8EiXtFWrbtGasuSd+Ry75VpvelkpYF2cxFF7Y1tCIH4SNtKON4Lyh
 0+KpkTaselHWRBoEPUbQETcUcyU4xdc8wFuphQ58uCzymuaLhQ41UkA1nzclSQCMO6VyqkGI67gKz
 v3LGUWyw==;
Received: from [2001:4bb8:18c:20bd:88ad:7c9d:e85e:89ca] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVuoI-00057p-Lg; Fri, 23 Oct 2020 11:00:39 +0000
Date: Fri, 23 Oct 2020 13:00:35 +0200
From: Christoph Hellwig <hch@infradead.org>
To: axboe@kernel.dk
Subject: [GIT PULL] nvme fixes for 5.10-rc1
Message-ID: <20201023110035.GA3504312@infradead.org>
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

The following changes since commit cb3a92da231bcf55c243d00fa619ee36281b0001:

  block: remove unused members for io_context (2020-10-20 07:10:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-23

for you to fetch changes up to f673714a1247669bc90322dfb14a5cf553833796:

  nvme-fc: shorten reconnect delay if possible for FC (2020-10-23 12:54:45 +0200)

----------------------------------------------------------------
nvme fixes for 5.10

 - rdma error handling fixes (Chao Leng)
 - fc error handling and reconnect fixes (James Smart)
 - fix the qid displace when tracing ioctl command (Keith Busch)
 - don't use BLK_MQ_REQ_NOWAIT for passthru (Chaitanya Kulkarni)
 - fix MTDT for passthru (Logan Gunthorpe)
 - blacklist Write Same on more devices (Kai-Heng Feng)
 - fix an uninitialized work struct (zhenwei pi)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: don't use BLK_MQ_REQ_NOWAIT for passthru

Chao Leng (2):
      nvme-rdma: fix crash when connect rejected
      nvme-rdma: fix crash due to incorrect cqe

James Smart (4):
      nvme-fc: fix io timeout to abort I/O
      nvme-fc: fix error loop in create_hw_io_queues
      nvme-fc: wait for queues to freeze before calling update_hr_hw_queues
      nvme-fc: shorten reconnect delay if possible for FC

Kai-Heng Feng (1):
      nvme-pci: disable Write Zeroes on Sandisk Skyhawk

Keith Busch (1):
      nvme: use queuedata for nvme_req_qid

Logan Gunthorpe (2):
      nvmet: limit passthru MTDS by BIO_MAX_PAGES
      nvmet: cleanup nvmet_passthru_map_sg()

zhenwei pi (1):
      nvmet: fix uninitialized work for zero kato

 drivers/nvme/host/fc.c         | 138 ++++++++++++++++++++++++++++-------------
 drivers/nvme/host/nvme.h       |   2 +-
 drivers/nvme/host/pci.c        |   2 +
 drivers/nvme/host/rdma.c       |   6 +-
 drivers/nvme/target/core.c     |   3 +-
 drivers/nvme/target/passthru.c |  18 ++++--
 6 files changed, 115 insertions(+), 54 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
