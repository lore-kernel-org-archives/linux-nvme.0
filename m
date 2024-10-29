Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D02D5B870
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 03:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kVPL53CSZevap4e6fUOKrwJ2Ntp60WL/AwHXOe1coPE=; b=XTTy1S2ogF3hfLkpcW3u+YRmfJ
	7Ne4q8c3ih2UM51Bu8NUa07N5jRHPyVPSNyLLRB3ZkXQzJW6y50axwnzOdc1xLb+LsYoqdEzImY5H
	PXEHSCZJzvJaeupPqUsf6A7LQC8GnhuVcQAG2UIds4eOPTXv6+JSSj84nUAmcEsbOqSfwrXPhdC4W
	2njILoFQohgGnKKz5F/Wgf1iDw7fkHN5GuMjHCgbAHVJiqM9NzrbIamXyhm004jOrvt3dYVqSY0sC
	b9oM534kHGarMGiOvSe9HeZRdfmHh+X+QqM/ivIbm93jXM6dCwcKcXlxt3X8D/8dS2ctlJENeWU9Y
	yfswSR7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5d8d-0000000D7Ed-48QT;
	Tue, 29 Oct 2024 03:43:23 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5d8a-0000000D7Cz-3PWp
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 03:43:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730173397; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kVPL53CSZevap4e6fUOKrwJ2Ntp60WL/AwHXOe1coPE=;
	b=b9s98ir+UC2DP71evOMjDVOuLk5M5kPSy6MqGetsn0HDYN8WY9Yz42GY8udITh1mVkK1a39CIKi78ES3FW5WBu6ZNZsfgiPztK2OYroer+46uGnw/CXM27GikhthPU9f/8O9ddKMJnMiCkumeRZWbow1sxIp4MpZLAiXOnjva2A=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WI8nBdq_1730173392 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 11:43:17 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmetcli: fix double ana groupid when save config
Date: Tue, 29 Oct 2024 11:43:12 +0800
Message-ID: <20241029034312.15083-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_204321_050953_4E88BE4B 
X-CRM114-Status: UNSURE (   8.12  )
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

There are two ana grpid in json file after save the config,
including ana group: "ana":{"grpid"}, and "ana_grpid", remove one,
still one can use both of them to set ana_grpid.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 nvmet/nvme.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 59efdb5..41b4845 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -626,7 +626,6 @@ class Namespace(CFSNode):
     def dump(self):
         d = super(Namespace, self).dump()
         d['nsid'] = self.nsid
-        d['ana_grpid'] = self.grpid
         return d
 
 
-- 
2.43.0


