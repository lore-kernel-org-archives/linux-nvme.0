Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F7DC32774
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Aug 2022 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ncoyUvgrY7Lm/4WGfz/miEjgyBXtrZ7WIQNiQ1XGMKY=; b=AJGECq+3N+r3iXivmwEYW84x+w
	k9o9izaxmMkYpai79rnqDfgu8v0XGdBHKMFT66VLzRTGbVelYEMF3nucLV3HlcHi50tucqbEmEF0Y
	GMeQ7UZXGn1Apn5zCRkDwUQmTYFRlhthj8n5P1oErm2rhdOVA1YE0F7mZpPkdlHMzf+8qLSDD6n6i
	apG83nnZCxpDrgAQPYOQwzyRyzC9UnYcTO156ubjy43FlaUE0SLVcz8EwE/ara0DxPqs94Gcx7V0d
	q7MXAxzWHrrVLDmP1rYtXhWHsbmA8zlPG/j5ukmYI72RrqzBCUyuGvJkJHKYMrUI58vchSMXGifWe
	ED/NqFXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQOb1-003Zbx-2F; Tue, 23 Aug 2022 07:45:11 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQOar-003ZSV-6v
	for linux-nvme@lists.infradead.org; Tue, 23 Aug 2022 07:45:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 476DD33FFA;
	Tue, 23 Aug 2022 07:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661240696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncoyUvgrY7Lm/4WGfz/miEjgyBXtrZ7WIQNiQ1XGMKY=;
	b=gCokpOL0ZxDrWQ5xHa7yNWgKUZXStFg+WmZSz0IjuwE3S5XGk7fGsERWzWwhLm2UPC/pAU
	r6O6QjcmrH0hCb7yMV7U5dXwKZfgxUSscA1cqc3Sfg+8Fjet4AHea+5D534uYeiElXDyhl
	BGCm+ZssztdmofLeULzxpw71RQtc+OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661240696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncoyUvgrY7Lm/4WGfz/miEjgyBXtrZ7WIQNiQ1XGMKY=;
	b=lL4XqcUjz7wCnGKuLp5MHLgFx3qinCiu8tvXaezVsBBH2RngJFh0OuHKx4pCcYumoyH1iW
	gtoZTmhMWZJVoMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36E5513AB7;
	Tue, 23 Aug 2022 07:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bukUDXiFBGMzQwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 23 Aug 2022 07:44:56 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 1/3] nvmet: Expose max queues to sysfs
Date: Tue, 23 Aug 2022 09:44:49 +0200
Message-Id: <20220823074451.12170-2-dwagner@suse.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823074451.12170-1-dwagner@suse.de>
References: <20220823074451.12170-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_004501_514093_8565FE03 
X-CRM114-Status: GOOD (  11.98  )
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
testing the reconnect attempt of the host with chaning numbers of
supported queues.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/configfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2bcd60758919..ba9f3209f848 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1281,6 +1281,30 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
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
+	if (sscanf(page, "%hu\n", &qid_max) != 1)
+		return -EINVAL;
+
+	if (qid_max == 0)
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
@@ -1291,6 +1315,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
+	&nvmet_subsys_attr_attr_qid_max,
 	NULL,
 };
 
-- 
2.37.1


