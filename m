Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF85EE77188
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QGA07LvV3zN9Q99s9liqrOQiuEiANo/ydFwebQiH/o8=; b=lglxKOKE1pvCbSHJgddwcBr2Q8
	4SwccHeXZ/zBFva3nesjcBfD+rya6Wl9nnlJMFFNh3a4tFHZUoDBmORy4EyvoDH/Sz6j/6/JKkwis
	s4ExiutYgznBLVvsuSpJ4I83/xGAntpm4qbg4auzdjk93XlVhIql4yS4wOc2R0gHCLh2eBDBkegxO
	bnCF55WPyCoLnzc+um5+IiljK8nDy+LCzsBFeNjhTzLNcUvv8Rqh65x3sWhZLYvSvB9meGDQ7CHvr
	AfZ23Jfnl7iy/9l3Om9pJ0Yg6JcposFSd1B6SvkwO8h1rUlRkw2wdRRvjZOX3w35j6L1HQOAxazVR
	iLBH5Mag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNwYp-0000000H8Hm-2iNa;
	Wed, 18 Dec 2024 16:06:07 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNwYn-0000000H8HO-16hf
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 16:06:06 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2164b662090so54567155ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Dec 2024 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734537964; x=1735142764; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QGA07LvV3zN9Q99s9liqrOQiuEiANo/ydFwebQiH/o8=;
        b=OhQ4kRY6Ox67MiF8ED6mVzuPLOaWzxtsMRlgnQzMBwzRk2XsVc5j/7xDymqioD4ydc
         cVGIB5M0caBT7QrhdvPmWLb759MC3lTb047/6ex4+k8McX/3FSVX/heFLqp0yV4Diuhk
         9pnMEokY9nQm+D5yfTJ+Z+oWbGzPm8f8K8hT+lQhebVH9gcLyxYRmsDnZb8DELY1fhND
         OO4MgNS1wIUAUw/hmY9NSTwNaoRmt46i8As+aEHq3EwBqkA7oeXLmjrAQtUQZTi7EhEz
         Yub1eRd0DNgQFAg5+cWPqRQR6OTcujEGbWcr8v9fFoZ5ntGysg9DzhlwQUL7SIdAzZwl
         PYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734537964; x=1735142764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGA07LvV3zN9Q99s9liqrOQiuEiANo/ydFwebQiH/o8=;
        b=tqLHSljfoOnXcRPZ/0j6EpjV0v3hg3grIXgh0icNl42e0gVbzbtX3YLxKAc+ELK73T
         dksTJ1iNPS3jBRomPEkm7SRv7wg0wc6g/nn1TX4AliGPcaBu2xc0PXW4pZ1wFzIxKjhb
         KTmQi1rFEQ3mGnfW4p5XGnB8anQJoUtrA5FnUHHdW8Y4Q1IompLrtX3m2o+26LEfaL2k
         eyTOuzcsS6ANi05BATym5s0q+ukg0W1BPy6VjWZOxaHDcCHNpFE45iAfFFucuXnAAXYA
         QLmld7oj6QVtZvafO/4YTTBlzLI8BfwQlnwe4IEv6HAAotwZ4Py2wZp7YKlsqH3L5Yc2
         bDjQ==
X-Gm-Message-State: AOJu0YzrPWz3itj6cRk2JDTINrTHXPm8WaHC7JroQdmR3mtJQv1VyuZA
	Ncla2BRQUyhmI3xe2OcNG9M1bMhSj5PJ8p3Wz2eVzfBrzjyQ9IBS
X-Gm-Gg: ASbGnctqdrOfkGDxdsCk9XVp+v1qK/cv1NSMaQccFNn05J80B7kdzkHbGfUynOiiU9H
	9I7nflkA0GC5hIdigR3kwQmRzep3vfrTpWCybXwJ//G2lTaJh0le1QV1YiMVQluh6gXHrPaSeEg
	gyXbTTia03RynHNSEwfjNfzCNurVL3Dj12yLfcilpwP+hYS231JojszewUFoeRhDz45JsObvwK9
	KPSecwZvCxcIK+UVY1kTC199j9zRrQuPnyzW0De7V573a7wurMdGHMW/nlyLUO+fPGyf80q
X-Google-Smtp-Source: AGHT+IEucAWZibMABF49mbBrsMR26MY5jaeAS5hwwJZaLIeQ+Zl/CV6LRHdsRUZ65CLY1ysuLdeJpQ==
X-Received: by 2002:a17:902:e5c1:b0:216:3876:2cff with SMTP id d9443c01a7336-218d726fa81mr47570875ad.54.1734537963752;
        Wed, 18 Dec 2024 08:06:03 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:ce92:bb28:b3c4:b6e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e502c2sm75869075ad.128.2024.12.18.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 08:06:03 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Leo Stone <leocstone@gmail.com>,
	syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com
Subject: [PATCH v2] nvmet: Don't overflow subsysnqn
Date: Wed, 18 Dec 2024 08:04:59 -0800
Message-ID: <20241218160458.9587-2-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_080605_308900_A83F6BB5 
X-CRM114-Status: GOOD (  12.82  )
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

Create a new string with kstrdup instead of using the old buffer.

Reported-by: syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff4aab278fa7e27e0f9e
Fixes: 95409e277d83 ("nvmet: implement unique discovery NQN")
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
v2: Allocate memory outside the lock and handle errors.
v1: https://lore.kernel.org/all/20241218005909.89092-2-leocstone@gmail.com/  
---
 drivers/nvme/target/configfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index eeee9e9b854c..3c9c98250cce 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2254,12 +2254,17 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct list_head *entry;
+	char *new_nqn;
 	size_t len;
 
 	len = strcspn(page, "\n");
 	if (!len || len > NVMF_NQN_FIELD_LEN - 1)
 		return -EINVAL;
 
+	new_nqn = kstrdup(page, GFP_KERNEL);
+	if (!new_nqn)
+		return -ENOMEM;
+
 	down_write(&nvmet_config_sem);
 	list_for_each(entry, &nvmet_subsystems_group.cg_children) {
 		struct config_item *item =
@@ -2268,11 +2273,12 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		if (!strncmp(config_item_name(item), page, len)) {
 			pr_err("duplicate NQN %s\n", config_item_name(item));
 			up_write(&nvmet_config_sem);
+			kfree(new_nqn);
 			return -EINVAL;
 		}
 	}
-	memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
-	memcpy(nvmet_disc_subsys->subsysnqn, page, len);
+	kfree(nvmet_disc_subsys->subsysnqn);
+	nvmet_disc_subsys->subsysnqn = new_nqn;
 	up_write(&nvmet_config_sem);
 
 	return len;
-- 
2.43.0


