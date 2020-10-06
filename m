Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3349AC4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:36:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8992087E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A0ratwBb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QAi4zEMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8992087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ve+KXX0bi0dAKhZMojP72gohUpnSPJ1/6RiKIzF4XHA=; b=A0ratwBbojgk+ubpavSUGUsvuz
	aEcYYTLAwlSh0FPkqldBGMerFkYEQE9cVjB6mHMQpG56twniX48Hxt0V0qlVw5v+PoclqDF46hs9a
	XQSjX9VWXJpRFtx9C+zIbsbNN7KiRjs7kF7Q2psTpRN/djiWmWzwMCC+Cnf0vKg8a33oOWW9MirWV
	ddBtG5EOsVOEDe048GVW2ie+7pAt6vj2w+dcLwkYXO1Us8RLBc+2llU+8ZiOojf9RvdxOSruWtVvB
	k1lciiWUNK1nNfZSUR5UBExbCPe4W5pXEfS7DQmlHQDo/YGCqs+UFpKZRMFmNFMQueMSQ8s79+oex
	bL65hcpg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwVp-0007Fs-8b; Tue, 06 Oct 2020 23:36:53 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwVn-0007FH-AC
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:36:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602027412; x=1633563412;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MFAFabt4nJ9MaAHuAx0u8BHnqsuBeKGhpuX0D8gJXck=;
 b=QAi4zEMspFK5OCrl9Af8vCKKj7Fr7aJTn/VkjFi0+/tgPN/1/eciI/ZZ
 sJkPmdMeUDtzmPd5QV2oDdBwGVz9nWa0Z7fDW5PaxINmmMWEUnNrjc9IB
 u/m+L2Ba/3LXlWAoPCxZ80u2RhU+7WP6eGK4guL//avyY3ggbezc1u29m
 OJ7JuBSWQSCrnOaWpWTRjvrGkpEgZ+oGA3wbnpFpJ1HpRDNBzCZCDZcNj
 bki53ldom8CnYXzzT+WOfdUMNGIJutRo1Ovhymyody39kAfNlXU7kIDNp
 t4I513IXpIpo/ax9I1jy7PgjiPN9ejLqtXU8R7+gQTYK1PqjZ7sIeLNFM A==;
IronPort-SDR: j7RlzFruuMp3uLdoowFAFfjs+YwSa167S5CwHgWACzEE87D3Cci1mmvPf2hAt7qg1IYx/lMCv0
 RUwkgW3f+/W1vDBHqJcDVC54PL12PdNLvAO+sJa5YKkrAy3VHaMbC1hRjdjb+uvNb84+4bQksA
 Pq2RualLm2bMK1XMYhGHa8OK7BQ2zZtOKX98dkEBrBUZtqFZdOUeYUXXAh+PVYlZCdrHXAZha0
 pMW9sxW55Cl+4SLSC3vT5s1dI/lUEAkeQNhLsk90ILGqbiD/N4feHryuIEh2SbSW9p5gOd0aFL
 kO8=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="150425926"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:36:51 +0800
IronPort-SDR: B7isdTvyVvIhjBpPP3GgmOMHlki7fKbe7Shzy4hhMQW8UfvG+6Bdk63ZkDC/Ms/U5z7i1LcXzi
 D8WVaxXEgr/g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 16:22:41 -0700
IronPort-SDR: fwhu3crPEmJiFgkatX3VhO+KPHADJn2m/DVtP6OhvHAmq9Ub+VQzViz55IJgBH5Xi/53GDNHVK
 oOLaU1w5DP3Q==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2020 16:36:51 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-core: put ctrl ref when module ref get fail
Date: Tue,  6 Oct 2020 16:36:47 -0700
Message-Id: <20201006233647.57760-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_193651_482232_D0FFE8E8 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When try_module_get() fails in the nvme_dev_open() it returns without
releasing the ctrl reference which was taken earlier.

Put the ctrl reference which is taken before calling the
try_module_get() in the error return code path.

Fixes: 52a3974feb1a "nvme-core: get/put ctrl and transport module in nvme_dev_open/release()"
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c20ce8eabe82..56e2a22e8a02 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3158,8 +3158,10 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	}
 
 	nvme_get_ctrl(ctrl);
-	if (!try_module_get(ctrl->ops->module))
+	if (!try_module_get(ctrl->ops->module)) {
+		nvme_put_ctrl(ctrl);
 		return -EINVAL;
+	}
 
 	file->private_data = ctrl;
 	return 0;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
