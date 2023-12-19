Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB188C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 07:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CbzZaVwxeaoZX3VoBKZgbQvFfUJDB1Tzc26hE6/mkMs=; b=Oh52zBg0i7aLfVE3BBmcEUG1uC
	FecLzRzRgtMRnnvCQQW3+7NxPuqll/cHOnhBd+eFfTVKavZM0Hb4Ti0/aN0ovJJ7xl4iHVXHTR3LK
	c+kDuUronU01ZuRROJTk/w2pbujAvZ4rmbpAAoaMEgwyDzJDeaO+C9fUZmUzDr+qN5IGl3+U0WHYm
	+M5jy5yyRpMO12NON/qVVnA0+uo0OYgDBHdH7rmJPmHR+VbmsT5QXk/4z21cb7ehjUefJGN+JRKaI
	ALr2xKSxrb4jHusiSq9vZ9ItNktVhwW8jDn+dsz2D8svunpfC6bJY597KYSeUfjuZM3Ogkd6Ixf6a
	lCi7Nujw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUal-00D6lr-2T;
	Tue, 19 Dec 2023 07:32:39 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUaj-00D6lH-06
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 07:32:38 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vyq1GKU_1702971145;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Vyq1GKU_1702971145)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 15:32:30 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kbusch@kernel.org,
	kch@nvidia.com,
	axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: [RFC PATCH V2 0/2] *** use rdma device capability to limit queue size  ***
Date: Tue, 19 Dec 2023 15:32:23 +0800
Message-Id: <1702971145-111009-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_233237_247297_E8EF188D 
X-CRM114-Status: UNSURE (   7.21  )
X-CRM114-Notice: Please train this message.
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

Hi guys,

Currently, the queue size if nvme over rdma is limited with a depth
of 128, we can use rdma device capability to limit it.

Changes from v1 to v2:
- use nvmet_ctrl's port to find rdma's nvmet_rdma_queue without change
  get_max_queue_size's param.
- additional clarification that the queue depth will be controlled within
  1024, rather than being very large.

Guixin Liu (2):
  nvmet: rdma: utilize ib_device capability for setting max_queue_size
  nvme: rdma: use ib_device's max_qp_wr to limit sqsize

 drivers/nvme/host/rdma.c   | 14 ++++++++------
 drivers/nvme/target/rdma.c | 17 ++++++++++++++++-
 include/linux/nvme-rdma.h  |  2 +-
 3 files changed, 25 insertions(+), 8 deletions(-)

-- 
1.8.3.1


