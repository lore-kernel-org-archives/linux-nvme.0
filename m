Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3A8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Mar 2022 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LcEdEAQRGx9fZVtxgemsHxgkCj9rqid+/gKmfPZM6Ho=; b=X0QoLe9k6inyfc3JdJiHxWqng9
	3scqNbVSr9XlTq+u2B0gDS+UVGDngbUqO/5HJ+xJDwgiRPhR46+hYIBoByk0g0yQJVteN+bo0erxC
	KBFRzBbSUwVdEsrmYISQ+9vfcwI0ZJS+4gJurmWNRQvqD7MVYFKdadQY93acWUdeHtefPsUXwyHAQ
	TfRI6C61WV2eYhvuWY2znvc0p0XDwYmv3F6rswHZ+bBRMLdpnKxfRDdslWyjXYdhxDBsX1MZD3e9W
	DI5lSmc8VB/QF71lFy2uVuskdbHxt50308OkklrCtMPJTX2mkuMU28oN6MXZ33djmzzttNkAu/z7J
	wrtwAAEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUq1f-00GDbc-9Z; Thu, 17 Mar 2022 13:18:47 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUq1c-00GDZv-4o
 for linux-nvme@lists.infradead.org; Thu, 17 Mar 2022 13:18:46 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0728F1F390;
 Thu, 17 Mar 2022 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647523121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcEdEAQRGx9fZVtxgemsHxgkCj9rqid+/gKmfPZM6Ho=;
 b=IDh7kl5RU+fM8jiR1JhtalXcMs24Q3v22b9LCoDSdMFfYyRN5JSvB47GFQaPgmB1ybY/MN
 /fU+zgpw+0etLmiJ40pXI1OQuh++ESKVaIuSwY4HI29MpHrOP4vQho+iw2kX9bJTlP5VEk
 BBw0f2TSxlqVsYWzbqm0oPDuhxjzrJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647523121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcEdEAQRGx9fZVtxgemsHxgkCj9rqid+/gKmfPZM6Ho=;
 b=MB/YVW3/l6NG9gHvaFtcjttw3OzhOgVEuFLdffNKI6/p6T7F7HyP70CrbqG39bcbvlGgZ9
 mOf7FFHcJ6X85OCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id A3090A3B95;
 Thu, 17 Mar 2022 13:18:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 8F9A9519375D; Thu, 17 Mar 2022 14:18:40 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvmet: check for subsystem type in nvmet_find_get_subsys()
Date: Thu, 17 Mar 2022 14:18:31 +0100
Message-Id: <20220317131833.37068-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220317131833.37068-1-hare@suse.de>
References: <20220317131833.37068-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220317_061844_386800_2FB87802 
X-CRM114-Status: GOOD (  12.75  )
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

When looking for a subsystem we have two ways of finding the
subsystem: either looking for the subsystem NQN itself, or check
the type of the subsystem when looking for a discovery controller.
This patch implements this check, and also moves the check for
the static discovery controller to the end such that we can
return unique discovery controllers.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b0dc6230d1b9..83eba511d098 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1508,12 +1508,6 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	if (!port)
 		return NULL;
 
-	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
-		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
-			return NULL;
-		return nvmet_disc_subsys;
-	}
-
 	down_read(&nvmet_config_sem);
 	list_for_each_entry(p, &port->subsystems, entry) {
 		if (!strncmp(p->subsys->subsysnqn, subsysnqn,
@@ -1523,8 +1517,22 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 			up_read(&nvmet_config_sem);
 			return p->subsys;
 		}
+		if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn) &&
+		    nvmet_is_disc_subsys(p->subsys)) {
+			if (!kref_get_unless_zero(&p->subsys->ref))
+				break;
+			up_read(&nvmet_config_sem);
+			return p->subsys;
+		}
 	}
 	up_read(&nvmet_config_sem);
+
+	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
+		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
+			return NULL;
+		return nvmet_disc_subsys;
+	}
+
 	return NULL;
 }
 
-- 
2.29.2


