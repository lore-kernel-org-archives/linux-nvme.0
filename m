Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CF8C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 06:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SK739iIKdoZ6B+C0RJ84ijpJut1wnQ0Erc+UrIsd6To=; b=ePIOBZLZIPImwa2EtAEdh2v27d
	DbxFP+reZNW4fPD8f97I9IM6NgreP9617eyB5hxnwXfctT6jSOKCfltBXDIydQEWUeZ6NQI2wL69K
	UVQL89h+DU4TrO9mTczvZXOC9buGfjhqmn3YBRtUMa2m+Bc7j6uq/OtgytrE6CRdjFS9zgVjFX20U
	4tulUQ4L4CWapy0KLX3alZ+E0gKIjLXEXAoRKckkld1lUEaBp1bJl3HpJR+Uy8i7LiXNcnbMPbcAR
	UNECr5aly1EAYaKRT/zPhd5bv1t/YApQvRK/uEZcBmueMSFsEOxb2uQUewl2eX0IyQ+/ETG74TWh0
	k3dyOS8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDInv-00Dn3S-1R;
	Wed, 13 Dec 2023 06:33:11 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIns-00Dmzd-0Q
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 06:33:10 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyP6OCK_1702449172;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VyP6OCK_1702449172)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 14:32:59 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 0/5] *** bugfixes and code refactoring for nvme target ***
Date: Wed, 13 Dec 2023 14:32:47 +0800
Message-Id: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_223308_307163_048B7D3B 
X-CRM114-Status: UNSURE (   6.39  )
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

This series of patches includes bugfixes and code refactoring.

Guixin Liu (5):
  nvmet: fix wrong error handling approach in nvmet_install_queue
  nvmet: allow identical cntlid_min and cntlid_max settings
  nvmet: remove cntlid_min and cntlid_max check in nvmet_alloc_ctrl
  nvmet: relocate the cntlid_ida to the internal of subsystem
  nvmet: return invalid filed when check fctype fails

 drivers/nvme/target/configfs.c    |  4 ++--
 drivers/nvme/target/core.c        | 11 ++++-------
 drivers/nvme/target/fabrics-cmd.c |  5 ++---
 drivers/nvme/target/nvmet.h       |  2 ++
 4 files changed, 10 insertions(+), 12 deletions(-)

-- 
1.8.3.1


