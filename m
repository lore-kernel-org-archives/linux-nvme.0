Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24372C61D9C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 22:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NnRIlJI6Jdmd79h9TxFEwIOw5Gi77BWCazL0INdTA4s=; b=FmjIRlf5Ap7bL40OUe20pH73xP
	2vib2/gQkhQcV2FcTLBSfSjkMWKENNMwf2QMgKAIXKP6PcUdsoQHKFKnZwC9eBhd2x+935hVi1cSf
	/xy+KnqOwmU+7AAVsL5vZHvDN4puYYrY/PSRzFaO877BpuSs1wxrdBNcbrGgAC74X3lZ9rpD+XisX
	ipznkzSYR2/F+DwwxG7KHu0OXvquEWOcqZ9G6fn9ljBGUkvz0RRUG0Hs5R3dApD9b2bB5k4L3p2nD
	C/3xAtU4d6vK6YxX/9Ost5CiOj/D99wm0xpaBaRc9s4UKfK2GUC0zFSNVxa45TF1CpWfWvEksPVLm
	D95H4Lfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5w0K-003EmA-3B;
	Wed, 22 Nov 2023 22:47:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5w0I-003Eku-0E
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 22:47:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 38FC861FA0;
	Wed, 22 Nov 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1FDC433C7;
	Wed, 22 Nov 2023 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700693248;
	bh=zAaMHwAz6fQIMNy0cpFdvF6MYVuva8LCFObd/51W7U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9ASBCAxjepYSLCKpUhXqOTcz8HeeVQG9sJv//XEYxWgYrMZO5tnjra4JeXJZ6+xu
	 a/gXdFIsEm9KLJvYS4P2s9yLX4eBX0GTq18NjC/79OAuUSjXqihSeEsuz/jXu/7l+O
	 0tFo1EYPYxovDTaRaXJ5hNqWdN9ds0cEd0FFzGRuRPtuAormWPk2aUDiRE2EGCl/Zv
	 KEd0NI+TOy59khYiULMv+fT2nLAqhqlNI+YMNS1J3lavvcMwH2/GuitmY6F/VIXS1/
	 J3HBYsTuW+ZXE/jrw1uyIqBcwjGyv+xEpr8IQ6kAa2z7+F2dvfpcMIezbJtI5h8GWb
	 /h1X7fs6VAVUw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-nvme@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] nvme: target: fix nvme_keyring_id() references
Date: Wed, 22 Nov 2023 23:47:17 +0100
Message-Id: <20231122224719.4042108-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122224719.4042108-1-arnd@kernel.org>
References: <20231122224719.4042108-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_144730_149547_651EFADB 
X-CRM114-Status: GOOD (  15.51  )
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

From: Arnd Bergmann <arnd@arndb.de>

In configurations without CONFIG_NVME_TARGET_TCP_TLS, the keyring
code might not be available, or using it will result in a runtime
failure:

x86_64-linux-ld: vmlinux.o: in function `nvmet_ports_make':
configfs.c:(.text+0x100a211): undefined reference to `nvme_keyring_id'

Add a check to ensure we only check the keyring if there is a chance
of it being used, which avoids both the runtime and link-time
problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/target/configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9eed6e6765ea..e307a044b1a1 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1893,7 +1893,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (nvme_keyring_id()) {
+	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS) && nvme_keyring_id()) {
 		port->keyring = key_lookup(nvme_keyring_id());
 		if (IS_ERR(port->keyring)) {
 			pr_warn("NVMe keyring not available, disabling TLS\n");
-- 
2.39.2


