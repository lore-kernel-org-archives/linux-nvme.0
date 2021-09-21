Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647EDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 15:17:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2C5608FB
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 15:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A2C5608FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BE8IqBCY7au4hGDYO+tdoCEOc5JnLbVb6xZeMGpomfg=; b=QOYc2aDIn/VpgH
	X/9xi0Srs6DSy7tj+uYS4dqz+evCFRULEQaGalu/Nz/Tx0+oBV0AyEJ1HXmnU2tPhr0V3eLcuXkQT
	+1coAXM0mc5pf9DlHs1auZhx3rnHetOXkBI1aAfxx8eb1kr524SmM+HRjxFC3psjp3hzy0/wSBzsM
	M0+7cynDybTrKxDIs1sbbrVycLJMetTty2LgP0/pSl/xy/i+Oo9kgoepB0KP4DtF0hHxjw5CCchrz
	cu0mLpa9ssTUJ+FhwwV7zHIdSBbOwJ9qLMwmv1pcD0TJEl2D/rmP915hvOI/SheILf2eCEqsRhKO5
	sycNXVCr/xOvABM4SZnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mShVh-004rJU-KT; Tue, 21 Sep 2021 15:16:41 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mShUn-004r6R-AF
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 15:15:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 79B2B1FEF1;
 Tue, 21 Sep 2021 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632237341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jj+v5yeVoTU5YVl9YjTMWXzOiVjJ+OKtq58Shr5eZF4=;
 b=nD8MM1xnWXCR0N2I9orYAW6SV8MixCot/ktYdIq9VJr0x2HBSNoxl/UPMALeAqI9aWZxG7
 DTliNuKcy3CbzGY5z5UcJ1PiseEe7K4RisfCPh/4tarBkUK1KbymuRC4J13ajn4rZWmGdm
 z0HiY7NLDKFUQJI/z/FY2bayoQGxvsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632237341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jj+v5yeVoTU5YVl9YjTMWXzOiVjJ+OKtq58Shr5eZF4=;
 b=/dYKr+7kK5CKwwQdfPp6ygrljDwNb/47Oc846GJyoxwUDj9RatNvIREAEC28rk5sK5e5u1
 y76mWQbbCluar0Aw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 4CE0FA3BA6;
 Tue, 21 Sep 2021 15:15:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 77AB2518EA8F; Tue, 21 Sep 2021 17:15:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/6] nvmet: set 'CNTRLTYPE' in the identify controller data
Date: Tue, 21 Sep 2021 17:15:26 +0200
Message-Id: <20210921151529.29419-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210921151529.29419-1-hare@suse.de>
References: <20210921151529.29419-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_081545_544356_FCF4DF18 
X-CRM114-Status: GOOD (  13.02  )
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
index aa6d84d8848e..8546bae5244d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -374,6 +374,9 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->rab = 6;
 
+	id->cntrltype = ctrl->subsys->type == NVME_NQN_DISC ?
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
index 7d0454cee920..822601103f29 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -221,7 +221,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
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
