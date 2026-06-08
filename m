Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA040CD8C9D
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 05:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6ZqvEFIx8o+tuUq0/oKqceOPSer9LPJeoZ78Qqb2WNQ=; b=xn4kFYT902cBuEOG+gwxja5K4z
	WYdmxdhRqNvTnsrFqYnSs2elPFwbcnFOoppQSpqIQQOmGDEapfj3na06dV0gkOFqf8oEvyH1fKC9T
	fvmK36z9+WXZgdmhgrMuPub45P/c3q4ty5GDubJk5ykbHU9wTKk1RJV6k4eapdRVcpczAz85omKin
	fMlY/RCitUu499kd3YJIdSGefYH2KAf7idDDwxdrnI7qvXk2AI78P1teflLpcnHpekGJeYUJGWiVc
	9kIQETbF0xUtNqkJ+/6fg+SP/wwnb1zDhJ0MtgSHUSn7em50bTD2QgiU1djzaVR40nv7u4ynhVAlw
	yt6iEE4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWSI4-00000002pPj-2CSs;
	Mon, 08 Jun 2026 05:12:48 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWSHy-00000002pPL-1HJE
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jun 2026 05:12:43 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-7e8b45dfb3dso46892627b3.3
        for <linux-nvme@lists.infradead.org>; Sun, 07 Jun 2026 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780895561; x=1781500361; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZqvEFIx8o+tuUq0/oKqceOPSer9LPJeoZ78Qqb2WNQ=;
        b=NeocDwu/y4lUxVqw+ICYAd+SXn2nGqonSHzjPre4kgnojXkD+3Duvt+iifqkFEcjQm
         kePeBedqLAXheqbQHT9v20URV+n2WoIvbNKALAkm6vR8Wg1w/1/3u3E4ZhcJR2IiVvle
         jRpaGhRWQYX+9y0h50vsMBs5syBqzdUibZnQ9sa7VNrL3dmBwjXK/3jOaLaP1UMiPF3m
         RL+juqwJUrLe+cKjDCoN7ppV1w2Np++jzNLvD/qu0au8MRjQZEffdSUvKMjJMMK1t9DT
         MjCiiikxY3QtB7kYmv8ET8dv9vrjmMzJyp7fqAygkdBPlD6pmQWIUyLeLHx3uB3wE6wT
         kx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895561; x=1781500361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZqvEFIx8o+tuUq0/oKqceOPSer9LPJeoZ78Qqb2WNQ=;
        b=IjeoZGN/AYBRBKe+Gu0KQS+e9DcOCLHBC61+TegZ6DfCw1N0M8bv7p1DDY8KsQJQ0B
         sOBjNyPNdlTdsItuqCQekPrFjCbYDgbyu0iiAUIIMDFpOGgMaRctq9VQd9Js3ArGdqO6
         hDY3dlPZWYQ0I8yJJrcaRXGEN+yVs99U0V1WkD52aOvjggtaWPMIocYcD2Q+GWOCbRtp
         bS13laaRKQpPq6dkN6e51H5npyf7GqxsNXomnhQaQuoLc4josCwzbdI14iLrQI/2qRQq
         SeVHwDx4vw0yCl9ZnSvqS8UDb76Dr2EWZRhZUZNdB+zeQdmxcN681TljXAo2uqHNDB74
         Faaw==
X-Gm-Message-State: AOJu0Yx+0+DKbmMermEf08X+bJ9pozWxBDoKu8muKgF6ko0frm6yux3B
	PdjT2/j4UxmQd4ZQDAeF+pORjdq4STrMieZslM6+0BwX0bYME9tqY+hPhV84lCLS
X-Gm-Gg: Acq92OFGcewfFRkAY8GkGfgl8ZrtkcRK3MEvlEfcwk4wUs7UMQnpq+q56AwIZ0UVaVt
	9VQY8l2pOJpXnRx7sE+S7wywZAlVgGZsqXfnS5jaYAu5RcifAZhK3IJviLm1S7r5sJcpNhHaCYi
	DPubgyxD5uJtrtgGzyZOlyGCXWzT9DKRwLn+4oop4J/s2R6HvFIghBA45xY+cGOR3G7Thuc7A7e
	pQkBnXb4QMZjtOEACYALeiZ6FMzbMgaX4zj5RPWfoLm6RTKrRJ9Flj/468VqqN8Qbf0WqZWcOCR
	4FsumujDDkOX2grLMqcW9B+h6jUEWuCoN8t/15cnCpXTiMSRP36EyzFU7+mu+in9JJr5+AccOdt
	KAKWaByZBXT4JuPOKJZAgct3XkIQpBvQo3584U/xg0v3m3WMw0B5mirK16hpGFI0kqz/xoF1hpz
	wZZBhJqtKxqekXV+mEf141IhYF8QYvfCs7o1qFDSyPjf/v+xOgXGKn9NF94+VSyarg3WDhxNZbo
	1NUr7TLYy9EvdA1QHFUqcb3P30SH2fwEGrDl0ohcXksDQ==
X-Received: by 2002:a05:690c:3349:b0:7dc:e580:7f8 with SMTP id 00721157ae682-7ed0d1da1d2mr124891767b3.26.1780895561209;
        Sun, 07 Jun 2026 22:12:41 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2167b40bsm78518697b3.17.2026.06.07.22.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:12:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] nvme: target: allocate ana_state with port
Date: Sun,  7 Jun 2026 22:12:23 -0700
Message-ID: <20260608051223.6884-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260607_221242_373869_18A04626 
X-CRM114-Status: GOOD (  12.02  )
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

Use a flexible array member to remove one allocation. Simplifies code
slightly.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/nvme/target/configfs.c | 9 +--------
 drivers/nvme/target/nvmet.h    | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b88f897f06e2..2b69ffcfc8df 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2007,7 +2007,6 @@ static void nvmet_port_release(struct config_item *item)
 	list_del(&port->global_entry);
 
 	key_put(port->keyring);
-	kfree(port->ana_state);
 	kfree(port);
 }
 
@@ -2047,16 +2046,10 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	if (kstrtou16(name, 0, &portid))
 		return ERR_PTR(-EINVAL);
 
-	port = kzalloc_obj(*port);
+	port = kzalloc_flex(*port, ana_state, NVMET_MAX_ANAGRPS + 1);
 	if (!port)
 		return ERR_PTR(-ENOMEM);
 
-	port->ana_state = kzalloc_objs(*port->ana_state, NVMET_MAX_ANAGRPS + 1);
-	if (!port->ana_state) {
-		kfree(port);
-		return ERR_PTR(-ENOMEM);
-	}
-
 	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS) && nvme_keyring_id()) {
 		port->keyring = key_lookup(nvme_keyring_id());
 		if (IS_ERR(port->keyring)) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3305a88684ec..aaba745e3c21 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -208,7 +208,6 @@ struct nvmet_port {
 	struct list_head		global_entry;
 	struct config_group		ana_groups_group;
 	struct nvmet_ana_group		ana_default_group;
-	enum nvme_ana_state		*ana_state;
 	struct key			*keyring;
 	void				*priv;
 	bool				enabled;
@@ -217,6 +216,7 @@ struct nvmet_port {
 	int				mdts;
 	const struct nvmet_fabrics_ops	*tr_ops;
 	bool				pi_enable;
+	enum nvme_ana_state		ana_state[];
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
-- 
2.54.0


