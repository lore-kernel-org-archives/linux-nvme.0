Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BC6C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Mar 2022 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LcEdEAQRGx9fZVtxgemsHxgkCj9rqid+/gKmfPZM6Ho=; b=k3nJvU8OlVgQmH9qyA59Rv3PI2
	jZxDv0TplegtafZe4M+FaPuaTSSzn7WC57YHghW6GkbYu0zcbn+a5YZrzKWMLzLt2SkTTgXSwFs3/
	xdQzYrqXVFO1IdpcU1ARKh/FIfREV1CfDE7SLZxNDubsPKPabT+YCiNAqCmso8dqDmbsI91kY7fnU
	4ulPIwt4E3xrrm+5PUVBEBnZy4SWwmHQqz+xWNHfnGYHsX8wQZN7Xv36P4W6RmVD3N8BrvxadBJl7
	fuprHieH3PO7zJ3j/stUmBGxIRzr6CttBW8DsKQqL1Ap1vhZ1nuBcHdxUXu6tAcBdoCcCx6zClTf/
	6mDe4moQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUr5Y-00GQ4v-8e; Thu, 17 Mar 2022 14:26:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUr5O-00GQ2Q-9z
 for linux-nvme@lists.infradead.org; Thu, 17 Mar 2022 14:26:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BC4BC1F441;
 Thu, 17 Mar 2022 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647527200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcEdEAQRGx9fZVtxgemsHxgkCj9rqid+/gKmfPZM6Ho=;
 b=02Yq9p9I91HjinNLo6k7qiaOi0uHKsn8H11Y4VRbZFflul2geFrWl7SfmOEbsWiGHKAKU7
 jM4PCvOP2lsXtmY0LF0fsEBFZ1VlErWkb4OabjbKSGZdq1WPh+k36eV3shUHnchTJJwQVe
 crUOIlGhRc3NIco/SGK4N9h/4b//XUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647527200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcEdEAQRGx9fZVtxgemsHxgkCj9rqid+/gKmfPZM6Ho=;
 b=s8c/tESxuG38sfqijIG7NT4BrJYq3SNnVZwOoHH3pT2EVpNJn700hPoNSfivqPxYvIGO8y
 r92+nCI7S1YrpCDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 65B26A3B8A;
 Thu, 17 Mar 2022 14:26:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 567755193766; Thu, 17 Mar 2022 15:26:40 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvmet: check for subsystem type in nvmet_find_get_subsys()
Date: Thu, 17 Mar 2022 15:26:32 +0100
Message-Id: <20220317142634.49324-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220317142634.49324-1-hare@suse.de>
References: <20220317142634.49324-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220317_072642_507390_44DB376B 
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


