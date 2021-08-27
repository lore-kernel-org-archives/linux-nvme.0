Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A89AC432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 12:10:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAE960FDA
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 12:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEAE960FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kjxjBxao553zTNqMc79pavmY7m4DFB7kZgcV70wxik8=; b=jC3vfIdsRPYmYw
	THQAOl6JtFNAuwt0X3GWSjfM8sZwfuxDzBSBkOK4NxT6n64wCABVXx7xmX397eLITuQUlRC75hyyj
	F1la1nYW3aFyj+JSzGZyCwmcRyO9fMlVZcFigTZjMz7XrvHKG5KgA11nV0pCH4LgNSCYsBjA/eyRe
	0Ad6WkmjqYDNgbGMe/3LT9CpePOzWfCmqSl8CS9LaSoj6Y1WJkrhrIkil+QTErf8pyDNEPlCXHuEy
	ZzHf8QrHCjyrFyTPO+dmoloh5BJ0eXyHaMfxi3glNrR8HBKKsMe1Vx59IkFfgdAOs3dgTbeezRlJV
	OfktIv4/OjKZ6mYKxiEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJagO-00COMw-Me; Fri, 27 Aug 2021 12:10:04 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJafv-00COI1-IE
 for linux-nvme@lists.infradead.org; Fri, 27 Aug 2021 12:09:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 811E7223CB;
 Fri, 27 Aug 2021 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630066173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=te0+2hzKacYXNu1YC6KsKvsgAeCw7zjn1ytbuqEmj7I=;
 b=ameX83Muyn4x7U7QcjpMURAfg1Nw6rpxSz8Zo9e8c1gNQBjv5HQfZwV1LNL3XXhdoHXY1P
 88dKppbjxnnEEvFyRH0IGW76gW8k3Y/Puu85NB7ZhdB1KSVepJXl9/xaxN7rdfaO66fvp5
 5z+yTS2zptlW08JWMu/hNoF7DrcRjxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630066173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=te0+2hzKacYXNu1YC6KsKvsgAeCw7zjn1ytbuqEmj7I=;
 b=iFmfYEcswoL1MIwi0wYj+2aconENt/iq7gB5Jo9Aeq4PXLCo8K7Q+eJi5Xq+aUDdh61osm
 duES0oH1VAbFsMCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 54A84A3BAC;
 Fri, 27 Aug 2021 12:09:32 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 7D59B518DB46; Fri, 27 Aug 2021 14:09:32 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/6] nvmet: set 'CNTRLTYPE' in the identify controller data
Date: Fri, 27 Aug 2021 14:09:23 +0200
Message-Id: <20210827120926.104398-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210827120926.104398-1-hare@suse.de>
References: <20210827120926.104398-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210827_050935_918214_AF8E1E4B 
X-CRM114-Status: GOOD (  11.56  )
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
index c8c72aab0464..e208520502d1 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -382,6 +382,9 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->rab = 6;
 
+	id->cntrltype = ctrl->subsys->type == NVME_NQN_DISC ?
+		NVME_CTRL_DISC : NVME_CTRL_IO;
+
 	/* The OUI is derived from the namespace EUI64 (if set) */
 	memcpy(id->ieee, ctrl->subsys->oui, 3);
 
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
index 7d0f3523fdab..28271ce51b58 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -203,7 +203,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	pr_info("creating controller %d for subsystem %s for NQN %s%s.\n",
+	pr_info("creating %s controller %d for subsystem %s for NQN %s%s.\n",
+		ctrl->subsys->type == NVME_NQN_DISC ? "discovery" : "nvm",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
 		ctrl->pi_support ? " T10-PI is enabled" : "");
 	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
