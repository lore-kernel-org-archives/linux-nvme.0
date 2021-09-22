Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94DDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:35:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B692E61107
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B692E61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FXo6BRqA1C2UuyrYzQKRPKr3kqZja4V0n0wJ3z8PMZA=; b=AIdmWZu7ImL8pP
	VeUrDnRoQ6CTiTf11HYzEHCYtkZpdl/8NPwE87OtCiLbTLjlQ+LH1ftMGx74/GXNqN5EQMPzF4bbe
	n1LYkdv5Ks8ZkG4Qh4KJHtgx8IscU3BsXPLFcvI+PmVMRNPfmAHvpeSELrfjcmP7e8DrX6VuA6L1p
	yHCfhde6gWKybi1EAFU79Z1Fs0q2nWVBM0O9KPsh/qY4Zh0Nr9MjBzTUkdl7PiALxVBsnQrnOCoBe
	4sZ8drUM7gk89XxX4RYe2W9FShffHdk0Ndhwoq6CBUZu/Phnd6pUvTK2nEU5MphvbClS7Gtemmw5n
	VfjJXNkVWJZaKHjgkxNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSvqv-0075eo-Ts; Wed, 22 Sep 2021 06:35:34 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSvqq-0075az-On
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 06:35:30 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 522C0200AF;
 Wed, 22 Sep 2021 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632292527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4J6838AfZENJCOU80EqytKqR+9yoPCDG7BvyTcAKi9k=;
 b=0yRytUsiV4lM957BalE9bCVKRvEHODsg1MV6szEZgSTdwHMfRjPd7kMOnYl42k1gjBscBf
 0VgkgFWIQaSHkdCs2qaxEfwLI22Id5A1J/AuzkuR6N1KU0IbfKCbeiYDOIag1ieUnMu4wH
 Ef3kgmM1DCE6fiyw7dIMy63qcMhiA94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632292527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4J6838AfZENJCOU80EqytKqR+9yoPCDG7BvyTcAKi9k=;
 b=OFaSLrg3Amyv4ccUvTm2LXQQIpaEExXD0abcZo5UkEB6dCQwwRmFyLbgDNleDZJY2xL5O/
 zXh0IOrJjm1IvIAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0EAD9A3B9F;
 Wed, 22 Sep 2021 06:35:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id F2144518EAF4; Wed, 22 Sep 2021 08:35:26 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/7] nvmet: set 'CNTRLTYPE' in the identify controller data
Date: Wed, 22 Sep 2021 08:35:22 +0200
Message-Id: <20210922063525.143045-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922063525.143045-1-hare@suse.de>
References: <20210922063525.143045-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_233529_111625_6D5C80B6 
X-CRM114-Status: GOOD (  13.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Set the correct 'CNTRLTYPE' field in the identify controller data.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/admin-cmd.c   | 3 +++
 drivers/nvme/target/discovery.c   | 2 ++
 drivers/nvme/target/fabrics-cmd.c | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b653ea4244fe..0428bf203fa5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -374,6 +374,9 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->rab = 6;
 
+	id->cntrltype = nvmet_is_disc_subsys(ctrl->subsys) ?
+		NVME_CTRL_DISC : NVME_CTRL_IO;
+
 	/*
 	 * XXX: figure out how we can assign a IEEE OUI, but until then
 	 * the safest is to leave it as zeroes.
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 7aa62bc6ae84..7b360f8d07e9 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -268,6 +268,8 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
+	id->cntrltype = NVME_CTRL_DISC;
+
 	/* no limit on data transfer sizes for now */
 	id->mdts = 0;
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 7d0454cee920..70fb587e9413 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -221,7 +221,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	pr_info("creating controller %d for subsystem %s for NQN %s%s.\n",
+	pr_info("creating %s controller %d for subsystem %s for NQN %s%s.\n",
+		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
 		ctrl->pi_support ? " T10-PI is enabled" : "");
 	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
