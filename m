Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F771C0502C
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AQz/+7Hv45LcCkG5G7Kz01M/h/RS99nK9qnOzhi1bx8=; b=qGEcluzlTu6YplLCcusXAdXHzF
	/hbxvfjYeA2F0R1ZeOpm4ixNyVSwKTvxBeeXT9b3STfIQAbf8Um1kzCgermGpLrPf21OFtQgbtC52
	gBeOsX/L05DV1OJGEai7rZyGHpZ/9Fr/LVt5/9Bw+OiK6fN1BsAqAN421fKTNiKN1WUZv8nkcsxde
	Le99wuDdhthGPmXgli1m/g6thuc5UGxzvzcVllSiuDqUbl41TuRSf/pl/Pe0Wbjlx9gnXf9tbtMZ3
	HJAVn+5lOZ34DP9ovWaFBbD/FoDW9jak/57pKV/4JTZj0P8enycL9D04heTmYXUcf3vx7adGg4Kym
	8Ed7PFbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaKJ-006JIP-Cq; Mon, 29 Aug 2022 08:40:59 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaIN-006HmD-Ve
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 08:39:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 700711F90A;
	Mon, 29 Aug 2022 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661762338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQz/+7Hv45LcCkG5G7Kz01M/h/RS99nK9qnOzhi1bx8=;
	b=q+0RKweo6Z12tytPO9orcUnN/JvFZuQqeo2ZCIyDSmYRCPuSMbYzbRJRF6gWQly4fKCCeL
	5itz8267y0ji/bbEs5n8aSY9JDr8lDor9F4BchQTO8KwpL2Lx25O7fJ57p4RNPp0rsBjhN
	MVT2Za5pA9iE6AJPGW3znMUF6A+heUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661762338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQz/+7Hv45LcCkG5G7Kz01M/h/RS99nK9qnOzhi1bx8=;
	b=8bpKrxx5n37a1IDzswF6WhmUwPgpr25nfhujlVck2LngCSxemzshEywlIp9N8ZHFwvDFxz
	kzlb+gwxpQNB36AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D29A1352A;
	Mon, 29 Aug 2022 08:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id t0jlFiJ7DGOKEwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 29 Aug 2022 08:38:58 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chao Leng <lengchao@huawei.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 1/3] nvmet: Expose max queues to sysfs
Date: Mon, 29 Aug 2022 10:38:54 +0200
Message-Id: <20220829083856.1850-2-dwagner@suse.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829083856.1850-1-dwagner@suse.de>
References: <20220829083856.1850-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_013900_272493_484DD002 
X-CRM114-Status: GOOD (  11.73  )
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
---
 drivers/nvme/target/configfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2bcd60758919..a415c2987393 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1281,6 +1281,33 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
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
@@ -1291,6 +1318,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
+	&nvmet_subsys_attr_attr_qid_max,
 	NULL,
 };
 
-- 
2.37.2


