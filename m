Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEB606A328
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gUesZ4bD;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=q8EpVcW6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ch/Iv17IljnFoS6nGgOFeWmHSXKFbPsRqAv5hqjfg6o=; b=gUesZ4bDtmcRQI
	BsMOI+tdFw80gUiIk4xIgnkpfSL+bGuYxKn4GYClksuWZIYZ4HA6Ps3CP3T5FwFc8YKbEPMCUfNb9
	du6TaM7rM3st2EA3lG/niBbIh4jdXuSW45uMLQ6olCB57ijhIcRuy/fi9mnq+Pn7RKo8PgSwwOwSY
	o++RK5HlSg43teNnEcXve1YrWntuMd75tWhuInt2aZHPI3MFD889dXHQVRlbTVcgxkq2nW+7A5Pa9
	DWwFKFuUZ8X3RAe72bB8nHzeNDyl7Ycf5YX7RSiw3mkCoP51JkbEMBMSgzXCOQaiL+9eDyIpBMK8Q
	17PpC4y09YLT12QaSa/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gI-0000000B44U-2wfG;
	Fri, 06 Nov 2026 02:27:54 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gE-0000000B3w1-2gXe
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:27:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793932068; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ch/Iv17IljnFoS6nGgOFeWmHSXKFbPsRqAv5hqjfg6o=;
	b=q8EpVcW60Lraa8sKGftm2NGwV1mmIPlmxwxPtuI4OX55Gt5jRa5uKtApHYuWqpm4g9db2v/3HjVCR5Riuba+Wq8XNpULr/Su3Z1MI+AcFF9DgBVUGm6tXVMK5GR0D5LV5XO3oRnzETuA7bFYnKwzKBnx2FOI5rYBUaFgx0hxQI0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA2.it_1793932067;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA2.it_1793932067 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:27:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 7/9] nvmet: remove unreachable "pcie" entry from the address family map
Date: Fri,  6 Nov 2026 10:27:34 +0800
Message-ID: <20261106022736.3582824-8-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106022736.3582824-1-kanie@linux.alibaba.com>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_182751_380008_4D189A85 
X-CRM114-Status: GOOD (  14.38  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first entry of nvmet_addr_family[] is never matched: both the
adrfam show and store handlers skip index 0, and the
NVMF_ADDR_FAMILY_PCI type is matched by the "pci" entry further down
the array. Drop the entry and start the iteration at index 0 so the
map no longer needs an explanation for the skipped element.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/configfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b3a5242d06f9..874476277ffa 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -42,7 +42,6 @@ static struct nvmet_type_name_map nvmet_transport[] = {
 };
 
 static const struct nvmet_type_name_map nvmet_addr_family[] = {
-	{ NVMF_ADDR_FAMILY_PCI,		"pcie" },
 	{ NVMF_ADDR_FAMILY_IP4,		"ipv4" },
 	{ NVMF_ADDR_FAMILY_IP6,		"ipv6" },
 	{ NVMF_ADDR_FAMILY_IB,		"ib" },
@@ -68,7 +67,7 @@ static ssize_t nvmet_addr_adrfam_show(struct config_item *item, char *page)
 	u8 adrfam = to_nvmet_port(item)->disc_addr.adrfam;
 	int i;
 
-	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
+	for (i = 0; i < ARRAY_SIZE(nvmet_addr_family); i++) {
 		if (nvmet_addr_family[i].type == adrfam)
 			return snprintf(page, PAGE_SIZE, "%s\n",
 					nvmet_addr_family[i].name);
@@ -86,7 +85,7 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
 
-	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
+	for (i = 0; i < ARRAY_SIZE(nvmet_addr_family); i++) {
 		if (sysfs_streq(page, nvmet_addr_family[i].name))
 			goto found;
 	}
-- 
2.43.7


