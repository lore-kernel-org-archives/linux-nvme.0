Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC89CCFA00
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 02:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BG3ptHS1Z7SD++VVRWKoJeySA1Kn+FHtV0LMlMYBAa4=; b=CaZPXeIIbadbUhaGAZbbhG564f
	xIJZ8zDW2HcmdaXgFs2NHxIGJaF+HYAa0qeqJueQc5p2O8/4ntuRi21k8vhVGntQIw5wiq4MCgixf
	X589Xzz5cHLs4DVSB2iUUx0gEGUTwEiw+G+RE4WydyNJTFCoXE0Nkceuv1oJtPjg6d8uRN4aRcguk
	IPC6MH4WoaGSbyN1zo0jyHk9MU8WwZGqRoYV1pV1rrZ7ks7SBO+mJIp+ZdUf3r/ZVE0ZpAkNUPKJg
	aczNXzIEJ6S7unJvfVXPZKoUHP9n7jeym8UDcRpHUQ3S9jjHVgvlAfCDh8Dg/8rdYI0NghOH1ztfS
	zO4lPOow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFkWn-000000094iI-2h86;
	Mon, 03 Nov 2025 02:42:41 +0000
Received: from ssh248.corpemail.net ([210.51.61.248])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFkWf-000000094hj-2RTv
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 02:42:40 +0000
Received: from Jtjnmail201617.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202511031042226078;
        Mon, 03 Nov 2025 10:42:22 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Nov 2025 10:42:22 +0800
Received: from inspur.com (10.100.2.107) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 10:42:22 +0800
Received: from localhost.localdomain.com (unknown [10.94.13.117])
	by app3 (Coremail) with SMTP id awJkCsDw3fiNFghpCKsJAA--.11932S4;
	Mon, 03 Nov 2025 10:42:22 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] nvme: Fix typo error in nvme target
Date: Mon, 3 Nov 2025 10:41:31 +0800
Message-ID: <20251103024131.1855-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: awJkCsDw3fiNFghpCKsJAA--.11932S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1DJw4xCF18tF17ZF13Arb_yoW8Gw47pF
	4DGF12yrWUGFZ5Aa1fAF47ZFy5Ja1DWFyjkws2k34rZr45JFWFqFWDK3Wavrn8WF48KFyY
	vanFvr1UZFs5XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?qVcpO5RRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KYDuIAxMgs1TN2muRnDhaYYJ30b0MeiTb5cNH1w8ExGKMtp5zAOcuXG3uCwUwo/eFZjV
	cfLCFrhKBmpiFco4imI=
Content-Type: text/plain
tUid: 20251103104222bc4ba2f2dffef220a6d94143087124bc
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_184233_879935_98B0A12C 
X-CRM114-Status: GOOD (  10.71  )
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

Fix two spelling mistakes.

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/core.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3e378153a781..3da31bb1183e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -708,7 +708,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	/*
 	 * We don't really have a practical limit on the number of abort
-	 * comands.  But we don't do anything useful for abort either, so
+	 * commands.  But we don't do anything useful for abort either, so
 	 * no point in allowing more abort commands than the spec requires.
 	 */
 	id->acl = 3;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5d7d483bfbe3..029a9f2420d3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -40,7 +40,7 @@ EXPORT_SYMBOL_GPL(nvmet_wq);
  *  - the nvmet_transports array
  *
  * When updating any of those lists/structures write lock should be obtained,
- * while when reading (popolating discovery log page or checking host-subsystem
+ * while when reading (populating discovery log page or checking host-subsystem
  * link) read lock is obtained to allow concurrent reads.
  */
 DECLARE_RWSEM(nvmet_config_sem);
-- 
2.43.7


