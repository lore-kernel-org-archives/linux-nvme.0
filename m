Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D39C5DF97
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mdmN3wMWTcsanPcaJmNKQ1gOjeyw7tg6jisvRkDUOfI=; b=RykGeVurkSWhoaZADNAntmCd9C
	vZDJpS4FNSOd8BZwuHqjBmL1DoER0vysHcRoqGouexltPRqcFZBeun8UVIGsayvz1UsbUNIim7GK/
	G5gb+o+6/DOQcvEC9haecXXlWpHahJ4FAlmF55nI9Jj+27XyeKchjPHhnFJazYMqhs2xcZ0La4vcu
	XroVoMy0nhPnG5LdmY+gBOX7vtPI/8HH3btL/aZMtwqN0DoE1mn+voOwvdwAfzT5dzegNrTE2gx6R
	yy16aeJoNHhqug38RfNT7aBWtwSsmxFsl8e1LfWdm9zGgjdOUCpyKe3bhVWwClWgYcVBglHfEP807
	SCmyxE0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tI-0000000FBZr-0jfg;
	Sun, 23 Aug 2026 08:49:20 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tE-0000000FBW9-0Nml
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 08:49:17 +0000
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a422090b2fso3716530a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 01:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787474954; x=1788079754;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdmN3wMWTcsanPcaJmNKQ1gOjeyw7tg6jisvRkDUOfI=;
        b=irp60YS8BgXdmL6E6l3G9NgHa+In57sOLpPQjoOuhK8hHcLLMYUL8jidFKH/Xy+fFU
         /QrtYSRLzLTaBY/bhqDgOjC+SicMJR9Ai7msx2GsrxqtKrLtZbavcumpPLXMZnaEYnlN
         iV3QRzxy1CWCpacoRJ+LAXUpsxs5XmFnmUYdJQphUF7Kdpti6ZhDpvM8bKEqrsaVEq4P
         hkW78Y3as3grMaOaFoaijF58sTZ6WUdhKnBj/OR1xbve//h8IQlDovs7jKx/QOnHTJtI
         aMg0GCXcsKAt3CM/n6YpMYYtmW1MFL5i8jXfRgawZRikxzKduZmTYqcX12RmsMMycJKu
         ca8Q==
X-Gm-Message-State: AFuF++kEQFy4m+PU6iG8lhlfx7SonNWxoJmG4cs+f4rzf/8uDBoP0i6w
	86DR8wLWvPpsx7njN/SIXJZQ6s+IVewT/+TXccfyLnuZddCPyyck5+whStdGMA==
X-Gm-Gg: AR+sD1018V64BJVkS2whJn7q4vLqoBqiPHh079Eu8yGHSdg2bH285Fbfvy7oICmMhQc
	PkzMecEJl7rWizQmvrV1VxXP8QwDSVVr/sSt9aKEb7GG6E5SURJqm/hdpncH1nooD40K9PJBVii
	Hzp9SRubPzJ8G9nJfY4q6KzM+dOyYvtnLnklCedNupwNePe13URFlzN+wNt5lCcqxFid9zf+vvK
	ucnm2enUOMQ4mkHbomKX3iJFEguxpB/d+pwsP2MtrSsMjJERj9Z1Nexfsk3oyaYFmwknMAZ9Mde
	FMscK9Nb6+VrAeAXLWzpBtBvZsMrbDl2DRvj/NjoGL53/AfXlUR8b+eHb3NAOXD1aSM43tYAf/Q
	HCY73eYgEhnQNtm1XFjoMgBDw2syz7PR+XlcNYO9pvO2KYMojTU0T7CKTLkipmEjoIza4gkHXx+
	P10POJQz8Fetx1ZCNE2XqYYffB4VOkHxqIZ4yCo5cHubNUPjaXJZZWVPuUW3pcwxImJ04vVF6tR
	wpkbG6FTuI8hk76tIGW8sLnYpa6UAaD+PM+tETp529zx7N5V/nBT6/6aewvng==
X-Received: by 2002:a05:6402:4498:b0:6a1:44c8:edc4 with SMTP id 4fb4d7f45d1cf-6a42f21ee3amr1358469a12.12.1787474954210;
        Sun, 23 Aug 2026 01:49:14 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00129fsm2566761a12.1.2026.08.23.01.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 01:49:13 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/6] nvmet: Add support for configurable crdt (command retry delay) attributes
Date: Sun, 23 Aug 2026 11:49:01 +0300
Message-ID: <20260823084903.193188-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823084903.193188-1-sagi@grimberg.me>
References: <20260823084903.193188-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_014916_147233_665BED16 
X-CRM114-Status: GOOD (  12.77  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Paired with host side error injection, allows us to exercise host retry delay
behavior.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c |  4 +++
 drivers/nvme/target/configfs.c  | 62 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 67 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 01b799e92ae6..c1a343e9a58a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -786,6 +786,10 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->nwpc = 1 << 0; /* write protect and no write protect */
 
+	id->crdt1 = cpu_to_le16(subsys->crdt[0]);
+	id->crdt2 = cpu_to_le16(subsys->crdt[1]);
+	id->crdt3 = cpu_to_le16(subsys->crdt[2]);
+
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 	kfree(id);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2b69ffcfc8df..7bd51f176da0 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1470,6 +1470,65 @@ static ssize_t nvmet_subsys_attr_subsys_vendor_id_store(struct config_item *item
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_subsys_vendor_id);
 
+static ssize_t nvmet_subsys_attr_crdt_show(struct config_item *item,
+		char *page, unsigned int idx)
+{
+	return sysfs_emit(page, "%u\n", to_subsys(item)->crdt[idx]);
+}
+
+static ssize_t nvmet_subsys_attr_crdt_store(struct config_item *item,
+		const char *page, size_t count, unsigned int idx)
+{
+	u16 crdt;
+
+	if (kstrtou16(page, 0, &crdt))
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	to_subsys(item)->crdt[idx] = crdt;
+	up_write(&nvmet_config_sem);
+	return count;
+}
+
+static ssize_t nvmet_subsys_attr_crdt1_show(struct config_item *item,
+		char *page)
+{
+	return nvmet_subsys_attr_crdt_show(item, page, 0);
+}
+
+static ssize_t nvmet_subsys_attr_crdt1_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	return nvmet_subsys_attr_crdt_store(item, page, count, 0);
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_crdt1);
+
+static ssize_t nvmet_subsys_attr_crdt2_show(struct config_item *item,
+		char *page)
+{
+	return nvmet_subsys_attr_crdt_show(item, page, 1);
+}
+
+static ssize_t nvmet_subsys_attr_crdt2_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	return nvmet_subsys_attr_crdt_store(item, page, count, 1);
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_crdt2);
+
+static ssize_t nvmet_subsys_attr_crdt3_show(struct config_item *item,
+		char *page)
+{
+	return nvmet_subsys_attr_crdt_show(item, page, 2);
+}
+
+static ssize_t nvmet_subsys_attr_crdt3_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	return nvmet_subsys_attr_crdt_store(item, page, count, 2);
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_crdt3);
+
 static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
 					    char *page)
 {
@@ -1700,6 +1759,9 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_vendor_id,
 	&nvmet_subsys_attr_attr_subsys_vendor_id,
+	&nvmet_subsys_attr_attr_crdt1,
+	&nvmet_subsys_attr_attr_crdt2,
+	&nvmet_subsys_attr_attr_crdt3,
 	&nvmet_subsys_attr_attr_model,
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index aaba745e3c21..2650c5e101f3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -347,6 +347,7 @@ struct nvmet_subsys {
 
 	u16			vendor_id;
 	u16			subsys_vendor_id;
+	u16			crdt[3];
 	char			*model_number;
 	u32			ieee_oui;
 	char			*firmware_rev;
-- 
2.43.0


