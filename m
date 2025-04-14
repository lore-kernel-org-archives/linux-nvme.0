Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C7DC369A2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qiKJZWlUOfWA0QW+ryIG5j23wYWkgysYlTR8YimHn6U=; b=HyDGR1/VGl+Y6uVC7GMdhlywy9
	Znua+u20CzFNPvnlrxG5xLZfLbG0H1TNXW/Sb3ZjVxdAEtQW93H1X3dduN62mRiygoVt5eVyuMCMB
	fkZEvEoSbICyEy+NnLkawT1r9L3z5CkRXdX1rQ2A1LP2UdnKB5awZtzYzIeTouCADwljHZi7vosp4
	x3bNr6aGuB8tUEgK/DPdEGNrgB9EjH+menfwdTopVojEucDtI11nZ+bvHhh2Trwlap+yAxgwjJCNA
	FudI4XYuKugOjkn0sr429883L7ZAzgxs5rc7WMl++lDHNaGi1xh3b3U7nniJNWJXgjAYSdAfQVhdd
	CvJdK5jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtK-000000028t3-1uNz;
	Mon, 14 Apr 2025 13:30:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtC-000000028iO-4Amg
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:30:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ACB2C451C9;
	Mon, 14 Apr 2025 13:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A4BC4CEE2;
	Mon, 14 Apr 2025 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637418;
	bh=WR1nmioPnYCDw/Q/8Q6v2DL7uBItXhvHeiWqF0rSOzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQ2KmPoOKeAVzLKhm7fQR3u2A8TDQK+qCsecIuYdPeBOtBVq4EUIQvPMlW+6YVkYZ
	 IxF7fPUUuMXwp4hORWtSySMigUmONuzxoI8bu8UIFme200U4fBKrfWdhMS+iEMR0CK
	 yQnsmYbtSBohEc2pdc1Xy1pd/EXs2vLexxfZfGdSa76bwNewZWkEeQm2lX4bYTtdLq
	 zgqn9h1FjAbK7c40fk8MGPS/ACLEEqymj6bc+o5vpqprR+2t7gW7MiU1XMQXClLpTP
	 cBurPKZmTcHdBEFTzeXMp0IiLcAVTTDDGc8NTjDxIqIJ42LZETX5Brd0ezy7LFhxYt
	 dKEe8UaxnrQYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 10/24] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:29:43 -0400
Message-Id: <20250414132957.680250-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_063019_065099_09962AA1 
X-CRM114-Status: GOOD (  12.14  )
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 62baf70c327444338c34703c71aa8cc8e4189bd6 ]

When scanning for new namespaces we might have missed an ANA AEN.

The NVMe base spec (NVMe Base Specification v2.1, Figure 151 'Asynchonous
Event Information - Notice': Asymmetric Namespace Access Change) states:

  A controller shall not send this even if an Attached Namespace
  Attribute Changed asynchronous event [...] is sent for the same event.

so we need to re-read the ANA log page after we rescanned the namespace
list to update the ANA states of the new namespaces.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e36c6fcab1eed..8827614ab8c63 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3976,6 +3976,11 @@ static void nvme_scan_work(struct work_struct *work)
 	/* Requeue if we have missed AENs */
 	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
+#ifdef CONFIG_NVME_MULTIPATH
+	else
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
+#endif
 }
 
 /*
-- 
2.39.5


