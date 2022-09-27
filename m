Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AB5C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lt53ulAG45+migm8dVtavCSEVWpcAwnGXYDwkTO4kFc=; b=QzF9YPCEoiMCZ417p3dmGo4+lv
	jPAGLHwY/xRAd4HZvvvMpTV643aMh8oAWb15UnuCRAmZVBGSsH9FTxRf906PHHYuc+lEms92Lh0Ms
	YevV/rDqqGAugMUEuI9LvhLqXvGiUpyHL46JEFiAuqjq+6YM8nLiYARMD0ZcEti4fiVwtx8DelVwC
	5mknh49xtjwyr4UqHk+JONRwYhQQYTJqKF+PjoBgAD2ndy5vreCsi5Zv/f+6GLUXuAYkURuJ+kmxw
	9XR5/+KPY/oXAGp2JZznj39LyfjhOUInYB8QVP6f//uPswJRucbQhzjVWDYbXlqTuE2FUnnrr5I27
	bnX3zd1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od9Op-00APDs-AT; Tue, 27 Sep 2022 12:09:19 +0000
Received: from [2001:4bb8:180:b903:ade8:c5dc:3782:5ee0] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od9On-00APCj-Em; Tue, 27 Sep 2022 12:09:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: stop poking into the request queue in nvmet
Date: Tue, 27 Sep 2022 14:09:13 +0200
Message-Id: <20220927120915.280166-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Just some minor cleanups for now.

Diffstat:
 io-cmd-bdev.c |   11 +++++------
 zns.c         |    3 +--
 2 files changed, 6 insertions(+), 8 deletions(-)

