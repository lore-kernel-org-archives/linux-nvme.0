Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DEBECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M5ghPQ7T0Gtwo0acr/6ZmF3fmYtYmg6gvjNDzECvUHE=; b=vjysiS/g1CbPPH0j7tUalfsV1Q
	Uw3/vSQYTX6X+BbdDeMx71GZ3WxCejvtwZx98wIqCrhXXslOSCHUEiOpXTIow+lqB+SMjxUZwy8G5
	RuDVSLgdkhH+fLReVW8FJi8zLtrrbUb0wg52DYjy0LppEShcd4eq2NZdJdAJkVMzmzoWffJX6XIRF
	Ii+sygRnxPOeISIXxaFvh5+rY2T/MeqeTYi7TZf/SSWLckeEV1G0H5nGsseh68/c8LRIG3YTCGAqu
	OKcsU7BlBp7P3+yyqEfyLFpc/wmYjGp5M23VTbf2YJ9ADvum15zUImPPDoCAhzhacO3q2sL2/rro0
	x+u6Py6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSb4f-006jSq-Qv; Mon, 29 Aug 2022 09:28:53 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSb4X-006jNI-Lk
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:28:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 388BC1F390;
	Mon, 29 Aug 2022 09:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661765324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5ghPQ7T0Gtwo0acr/6ZmF3fmYtYmg6gvjNDzECvUHE=;
	b=0Q+dqq1O2kE0VUtcpNL8ZVqbpaDnkNgowkS9KujfYB7y/nLYNEaX3f3zQBbLRXSlr46643
	IZNM2onmcAimuPIZGQrFqIOwzlwdiuGzAsaVMeRqynBQEQCrglMX0KMwDl4Z/JDRDKUsSw
	HDQAa3SgCZekxG+ceVqJThuScrtMsic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661765324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5ghPQ7T0Gtwo0acr/6ZmF3fmYtYmg6gvjNDzECvUHE=;
	b=xuBHZuYmE8dNve6gHyRVrOCm66iSF1Js0k14J7Ro/8AneXNIdRRAj+qsHME6V29y5uLlwl
	V2FA75bDLUALdyAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2916D1352A;
	Mon, 29 Aug 2022 09:28:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MH/gCcyGDGPzKQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 29 Aug 2022 09:28:44 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chao Leng <lengchao@huawei.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 1/3] nvmet: Expose max queues to configfs
Date: Mon, 29 Aug 2022 11:28:39 +0200
Message-Id: <20220829092841.14244-2-dwagner@suse.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829092841.14244-1-dwagner@suse.de>
References: <20220829092841.14244-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_022845_893329_A8062D85 
X-CRM114-Status: GOOD (  11.26  )
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

Allow to set the max queues the target supports. This is useful for
testing the reconnect attempt of the host with changing numbers of
supported queues.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2bcd60758919..e34a2896fedb 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1281,6 +1281,34 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
 CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
 #endif
 
+static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
+					      char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->max_qid);
+}
+
+static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
+					       const char *page, size_t cnt)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	u16 qid_max;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+
+	if (sscanf(page, "%hu\n", &qid_max) != 1)
+		return -EINVAL;
+
+	if (qid_max < 1 || qid_max > NVMET_NR_QUEUES)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	to_subsys(item)->max_qid = qid_max;
+	up_write(&nvmet_config_sem);
+	return cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_qid_max);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
@@ -1288,6 +1316,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_model,
+	&nvmet_subsys_attr_attr_qid_max,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
-- 
2.37.2


