Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2ADE77187
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7BCBYHG7bJS7UDA//DV+hf5xIHGLQBR//VRrTTK7Lik=; b=TqthQmwcGuniydzl4OgNfrFSZB
	z+8dPLK96D3NkEtAfYlwLGXPSfBf/fIArVs5PxT4iTQd0q0iL/2Ax1yqEWp8m6FjZP3aVACTCxo5b
	yXFz3weh2V1tS06iUbnCs+sbNVxcmlVBDc9ePhBymfFIIdynCVMxQY639/Pp0gNce8u8cpERVt8cN
	YrTitr1rwPuCnawNQMtFLwqAoSmwosXw4KQMq3TBNlDHbgfGZEPzOoJe/gMcVdIBffIUDC3WR0U32
	YfmVHibLqeEe7cTK+Rn14k8SOR+bJ/sP/zaY2MSVK+n9ADL/YPKmSvCC1lRJmg1GejPT8Gk1nPfdT
	xv4nJr2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNz8O-0000000HU7U-23Nr;
	Wed, 18 Dec 2024 18:51:00 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNz8L-0000000HU74-2pfc
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 18:50:58 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-725abf74334so10048b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 18 Dec 2024 10:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734547856; x=1735152656; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7BCBYHG7bJS7UDA//DV+hf5xIHGLQBR//VRrTTK7Lik=;
        b=dQmpbRNDYJA9vqZ5QIRBz1ZXIJpuEq9OGYz7cxiA1ttEaY3d4A/Jr0Zk6RYwFpTQij
         mRyDwwr9HmVEn5ejDf6qS0rD4Estj+W80hdMxyz0avKTkuiL3VpRjdJljG5UoOUVbwxC
         uM5EWzgsnDFHkDNuE1aB0obvM5WR5ffSMUZQ20oQ9dmRCaUyDbfMiWofYxz++tWUGuEA
         D5ZjEl9Yiaxfe5PVnHjR2q8Mp+PLAKQJz6R9F9JTRHlh8eQppWcovyRm7F28Aph5wNNh
         VpyFOX3587o7PrhFhw7OJcYcG4KMw2afMzAMaqEdodtxfqGOLR0PjD22YaqVAhXvFHjm
         2tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734547856; x=1735152656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BCBYHG7bJS7UDA//DV+hf5xIHGLQBR//VRrTTK7Lik=;
        b=XtQ+uURdbahUdOo1iPlrlxx+5JMXQi59komERLgO8KuoS/a9jE9D8uh3/IlVs/hKhE
         4N3hxSXPIzLb2DQfc0YDopasxFB3+Cl2FSQp4FZCFF/bwLpT2HnB6QjiPfihFOiTSase
         840NABu7iVcu3YygWEpi3pPfMM3PpCXL0zM6xXJSrMuwNrElYFnZQ3DjI4fRqy+FLlEP
         /JYIZl5/14qlbzwVUfGveTI6Y13bCfH+9UVPsg4NhXXB5n0l09r+D50Ese431xl4/RKi
         UcCmV0j9G8Dz07357+yRz7WMuDBe2ViC78Ahd+Oa5+XjoGuxfAcLtQDgX2VOqbTJXZ1M
         7OqQ==
X-Gm-Message-State: AOJu0YyaqTBBY+9ITvdmDkdhUb5J2a71vF59YUMBRyE6sozPwezAjcKN
	sjgtGP9EW3G0eU1y5MAfgYuyT28DJoA83EgpGBsnqrdGJ6268gvl
X-Gm-Gg: ASbGncs1WiNLYcCGkRzAEwe6corjTraY68Lx0BZFNQJ38R5h9/3zOf82Ag3sikBL1FO
	9M76caIyGfwXdPy2muRaCt7pUPyBiN5vw9rVjurRldmlVfFvsz0QGyYIZuZZLvI8qX0kTbh+D9M
	tHO1DGBJqHMoTe/wV5B6KMORSGM9vZ1ybeyPU2zlcxABpifetUJs1EEjIZfQ7Zp4UeUE+kgnmAx
	IwoJ8634cSoItuO6I0Vrbe1dHz9KAA70tMDDUmzcbBV/opSLnSkqeJAoRosI1BUbgkaHI1U
X-Google-Smtp-Source: AGHT+IGbGw3j4xDNWHy1Dxq9IfhyL4Qy3S6kWggqQhB05DXIUPS1i/Lwv0S9kT2cVQIUCsm5I5iigQ==
X-Received: by 2002:a05:6a20:7343:b0:1e0:e027:2eaf with SMTP id adf61e73a8af0-1e5b48229fbmr6768604637.19.1734547856485;
        Wed, 18 Dec 2024 10:50:56 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:ce92:bb28:b3c4:b6e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72925e6e8b1sm7382878b3a.139.2024.12.18.10.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:50:56 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	csander@purestorage.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Leo Stone <leocstone@gmail.com>,
	syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com
Subject: [PATCH v3] nvmet: Don't overflow subsysnqn
Date: Wed, 18 Dec 2024 10:49:57 -0800
Message-ID: <20241218185000.17920-2-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_105057_733221_7D7559FF 
X-CRM114-Status: GOOD (  11.81  )
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

nvmet_root_discovery_nqn_store treats the subsysnqn string like a fixed
size buffer, even though it is dynamically allocated to the size of the
string.

Create a new string with kstrndup instead of using the old buffer.

Reported-by: syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff4aab278fa7e27e0f9e
Fixes: 95409e277d83 ("nvmet: implement unique discovery NQN")
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
v3: Use kstrndup to avoid copying the newline, and free outside lock.
v2: https://lore.kernel.org/all/20241218160458.9587-2-leocstone@gmail.com/
v1: https://lore.kernel.org/all/20241218005909.89092-2-leocstone@gmail.com/
---
 drivers/nvme/target/configfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index eeee9e9b854c..9c109b93ffbf 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2254,12 +2254,17 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct list_head *entry;
+	char *old_nqn, *new_nqn;
 	size_t len;
 
 	len = strcspn(page, "\n");
 	if (!len || len > NVMF_NQN_FIELD_LEN - 1)
 		return -EINVAL;
 
+	new_nqn = kstrndup(page, len, GFP_KERNEL);
+	if (!new_nqn)
+		return -ENOMEM;
+
 	down_write(&nvmet_config_sem);
 	list_for_each(entry, &nvmet_subsystems_group.cg_children) {
 		struct config_item *item =
@@ -2268,13 +2273,15 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		if (!strncmp(config_item_name(item), page, len)) {
 			pr_err("duplicate NQN %s\n", config_item_name(item));
 			up_write(&nvmet_config_sem);
+			kfree(new_nqn);
 			return -EINVAL;
 		}
 	}
-	memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
-	memcpy(nvmet_disc_subsys->subsysnqn, page, len);
+	old_nqn = nvmet_disc_subsys->subsysnqn;
+	nvmet_disc_subsys->subsysnqn = new_nqn;
 	up_write(&nvmet_config_sem);
 
+	kfree(old_nqn);
 	return len;
 }
 
-- 
2.43.0


