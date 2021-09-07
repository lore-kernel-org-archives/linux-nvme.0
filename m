Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAC8C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 14:11:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1406109D
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 14:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C1406109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Pg+oAPk32TB4eYS9npynnvFlBsmJOjTUDIfFINSS804=; b=XDKlXXPkqUtUS6
	dLTqOVvJFj+3BXd4UlEe+ETXiHFJLjL5ckOKxF7yKWG2PIuAb4ylTnqcj9r3c3NEGkDVbEy0m5v4p
	F89xwV2/ehdQjRHvdMbO2zlmhnCHj1KfvxvyveVK9JlW4vW5ByXkMfj61+um20Bf5LDFo1oNgwC7o
	X//SnptSz3A2bqdlpYr0izjFM5OhzDH54EVBxpJfZ7+vqko2IVH3dhyzTs9w/Lo8DB0sISGmyDWVY
	kNIypFxK36P15etlhafbBwoyZ892BE3SMe/ZcbCvfH9G5Bmzbk+YqfQzCnuLBHOp3bjZ3fhObnvt6
	3X0CZqGf46xGq6/MN3GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNbo1-003poT-LA; Tue, 07 Sep 2021 14:10:33 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNbnz-003poJ-5T
 for linux-nvme@bombadil.infradead.org; Tue, 07 Sep 2021 14:10:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=joojLOVghtAY4SpDPhudBjFXh84mnGtADh74ijXfAho=; b=o9uh0TquyjFTy1lV/gGcfDlOEc
 FASgWAq1SQhjDtRnH59ar1FyQRj6n+gAaGdB/j/9MREa5OeUdWbEraXmXnlYxIsBLRYneLPS0I9W4
 LkYqjRmKgcapGGwG7utJsm8+Yw8vyFP0wvuCuOtIbMtjMpEFWK+HYffvKw4r94OADZRZ1zqx4vXfQ
 8NqElyVc0wwSVMsMHe4BaYVEfrk2yIsMjTaXU7dYRZq8/ZV+3ZwUAfFkVMLzV/iwgu/3jWCSghY/Q
 bI5FfSTcKKBvGlWwsWqtqtbUvtk1YJBsVDG9R6R3kffE/k9cUYA5fzyrenFtpVSxr73ZqO6qpCRCy
 quxocanw==;
Received: from 089144201074.atnat0010.highway.a1.net ([89.144.201.74]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNbnZ-007vh6-R0; Tue, 07 Sep 2021 14:10:10 +0000
Date: Tue, 7 Sep 2021 16:10:03 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.15
Message-ID: <YTdyu/Y/d9woHINJ@infradead.org>
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

The following changes since commit 1c500ad706383f1a6609e63d0b5d1723fd84dab9:

  loop: reduce the loop_ctl_mutex scope (2021-09-03 22:14:40 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-07

for you to fetch changes up to aff959c2840858d55d9ee155d555b3aa7e068b32:

  nvme: update MAINTAINERS email address (2021-09-06 10:08:09 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.15

 - fix nvmet command set reporting for passthrough controllers
   (Adam Manzanares)
 - updated
 - update a MAINTAINERS email address (Chaitanya Kulkarni)
 - set QUEUE_FLAG_NOWAIT for nvme-multipth (me)
 - handle errors from add_disk() (Luis Chamberlain)
 - update the keep alive interval when kato is modified (Tatsuya Sasaki)
 - fix a buffer overrun in nvmet_subsys_attr_serial (Hannes Reinecke)
 - do not reset transport on data digest errors in nvme-tcp (Daniel Wagner)
 - only call synchronize_srcu when clearing current path (Daniel Wagner)
 - revalidate paths during rescan (Hannes Reinecke)

----------------------------------------------------------------
Adam Manzanares (2):
      nvme: move nvme_multi_css into nvme.h
      nvmet: looks at the passthrough controller when initializing CAP

Chaitanya Kulkarni (1):
      nvme: update MAINTAINERS email address

Christoph Hellwig (2):
      nvme-multipath: set QUEUE_FLAG_NOWAIT
      nvmet: return bool from nvmet_passthru_ctrl and nvmet_is_passthru_req

Daniel Wagner (2):
      nvme-tcp: Do not reset transport on data digest errors
      nvme: only call synchronize_srcu when clearing current path

Hannes Reinecke (2):
      nvme-multipath: revalidate paths during rescan
      nvmet: fixup buffer overrun in nvmet_subsys_attr_serial()

Luis Chamberlain (1):
      nvme: add error handling support for add_disk()

Tatsuya Sasaki (1):
      nvme: update keep alive interval when kato is modified

 MAINTAINERS                     |  2 +-
 drivers/nvme/host/core.c        | 68 ++++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/multipath.c   | 19 +++++++++++-
 drivers/nvme/host/nvme.h        | 10 ++++++
 drivers/nvme/host/tcp.c         | 22 ++++++++++---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/configfs.c  |  5 +--
 drivers/nvme/target/core.c      | 10 +++---
 drivers/nvme/target/nvmet.h     | 11 ++++---
 drivers/nvme/target/passthru.c  | 14 +++++++--
 10 files changed, 132 insertions(+), 31 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
