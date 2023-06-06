Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6043C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 08:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bwBS2gz/E8EDElAiYNjLDtHJCY3SmZ3WuJ+7vsonn0A=; b=K0ZPZIteOiG74qRQwYeDVNuUsh
	2C3Fsv9kTNYpNccGlAMWK4OlEYFb+L7DcXh3ucp+AlrKq5fblahs2UZ5FAYBKsjOrjIsuoTAjOW+T
	hLvv+eZQ2OfbfihMU5Lakb0tChblfh0PSzHUdb1WLXpeeutlNWnZBUGmK/+gC1ZGQmobJUM4HBkwr
	WAKRza4GSggSWS3vpOOAQ31HSRM/9YjgH0Pi0gH7l1ddkmVFEPD6t7OcKch3hQWIXjfqMeerrTO6p
	s9o7BGhadKpkRjtf9FQ4HPCoDsM51L1q772R3g07DYcEdVTuL71VVeW4eFmk3H09ApCfwNwyM2OFs
	puHVj0vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Rwl-000mG1-1g;
	Tue, 06 Jun 2023 08:21:43 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Rwi-000mEO-35
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 08:21:42 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso58659385e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jun 2023 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686039699; x=1688631699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bwBS2gz/E8EDElAiYNjLDtHJCY3SmZ3WuJ+7vsonn0A=;
        b=QbfeuD8MPVc48fUXuxkdPZRaGcxpL0Fx+sCdRSrCsN5M3Uyvo11eUFtoQ4yCmDdQN0
         SHccJH6UjR6y80KT6Wv7tdFs+XbzH8ZyjGC9hwJ0uiX1zSm+TsuzfQZD9eix5wygk1An
         QFFpkarl/jOMBiEHnQNGvDsmqDMmjWBy4pT5jJf+xqChsbbr4G3gdmdjwHcqXpudHbUO
         eO+N19/SUuxYwEvtSk1BvLUNG0oEUwlsGxSp19+QxE5a78238+f/5M36oFXrlX+jwyDc
         aLor+otBKP3e8pITub2MLZZm/ofaWtZPj2rhJoUSupTOSwfryFDcErfRs2zemtrmbc9o
         yRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686039699; x=1688631699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwBS2gz/E8EDElAiYNjLDtHJCY3SmZ3WuJ+7vsonn0A=;
        b=Z61x543uFKslLU+DP1VlwyYhO2PM1nr636sf0zMyLVCy+crU63uQ4E7C7oaC379lML
         rPcMLWw46TfXn5C7zfnXXCWxEmAmR6jg6vERUgmNbsQrlwegcsurMgUOTqCY9l+vY3Jz
         6xCPTB3o0DXGn3NEH49BMFdaVORGvXa3VTK2e/lIkAWN96Xh9lT9KwwAdn9CJoB8krZS
         gzsIJ0mtu2cVUaa8vp/8YLmc+XynQUF/qCwFnfgm6SGZOS6r6DR7w5yP1yVzWirW27xo
         gecXmDaHsF8kcHdsR6cv88QtsUq+DRkaBdsnvEL3g0jnQghYZ5wFBu4qhDuztuvRU7xX
         vr7Q==
X-Gm-Message-State: AC+VfDyb0Eszfbr3GPdMSljuNg1e2f8iFhRsOO9C175c0VmQp8RhXYbp
	Wl7QOYj2Jo27gvivmjUSki4=
X-Google-Smtp-Source: ACHHUZ7YFIoEgEagb/zVI2mwYmtNuqoiz6R3JuU77ZAdFMdJgvOeY9FQ3QoG5Y8BZ+WjQnH84GY/HA==
X-Received: by 2002:a05:600c:218b:b0:3f7:39ed:c9a4 with SMTP id e11-20020a05600c218b00b003f739edc9a4mr1698891wme.30.1686039698739;
        Tue, 06 Jun 2023 01:21:38 -0700 (PDT)
Received: from localhost.localdomain ([37.167.208.212])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d6185000000b0030af05fce4dsm11944142wru.77.2023.06.06.01.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:21:38 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme-core: warn and abort if shared ns with empty list
Date: Tue,  6 Jun 2023 10:21:34 +0200
Message-Id: <20230606082134.20623-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_012140_990637_E13B2581 
X-CRM114-Status: GOOD (  13.16  )
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

In nvme_find_ns_head if we find a shared ns but it has an empty
list or its refcount is 0 we gloss over it and go to the next.
Ignoring when such a case happens means that when nvme_find_ns_head
returns NULL, we could create a new nshead with the same nsid. Hence
we could find ourselves with two shared nsheads having the same nsid.
Instead warn the user through dev_err and exit.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c8a471482421..175f1516083f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3341,6 +3341,11 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 			continue;
 		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
 			return h;
+		else {
+			dev_err(ctrl->device,
+				"Found shared namespace with empty list or 0 refcount\n");
+			return ERR_PTR(-ENOENT);
+		}
 	}
 
 	return NULL;
@@ -3535,6 +3540,12 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 	mutex_lock(&ctrl->subsys->lock);
 	head = nvme_find_ns_head(ctrl, info->nsid);
+
+	if (IS_ERR(head)) {
+		ret = PTR_ERR(head);
+		goto out_unlock;
+	}
+
 	if (!head) {
 		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
 		if (ret) {
-- 
2.40.1


