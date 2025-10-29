Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B716CCF9EE
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 21:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQd5WnTIHuwOTKOc3/5nF1ZAvZxVbQqd8kUZmHhqZSI=; b=IfAle/9tTkRJzaKDojP3/36ND3
	mnTN+L6GR87/5qS6uCNgdNt6pMimwM301lQ7FUAh9fjcYmpUgKnGoT0Y6suwtc+d56J4Y5mHBY6Ma
	jwylh1bUnZQNmCe/rzBcGHF3dpqvFvRR8xjb4fhRCb31Lzj8Ze+afIsGTBTplNe8oL6BZO/rPO/tC
	69XDLS5viuehYkDPZ/Ph3IGflM3W8k9aOR1H6m6io/4N7Px4R73eTIAJalBW4MaEB8w8eg6Nbszt0
	+IT03BxgM1x0eKbkKHS64wUlGYRPaR2YUS3L44Eqzg+9LQZjQWxhF7LDxncvQh6XIm4OtarQIt5pl
	+OxTNiNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEDQA-00000002uUE-1vao;
	Wed, 29 Oct 2025 21:09:30 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEDQ8-00000002uTM-45DU
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 21:09:30 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-633b4861b79so52895a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761772167; x=1762376967; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQd5WnTIHuwOTKOc3/5nF1ZAvZxVbQqd8kUZmHhqZSI=;
        b=XnfLr3OzDfNzqt27UbLTu0N6eXmEUQVYE556wjFzkny6rU7s5qEBpH89wV1EZeh7G2
         l/sqTxKo5vXFo5kGZ0f48P1xAqO6WXhdv6yHaBkUQEXVhvWec96DkuUwzbEIBiz2VTyF
         aBssMToAyXs508c1NqY41otm0chfp/kzsDHPfg+mIJcIUaf6YRyn5LoHPKdTjw1KezJS
         frVBtudiXfGWC7EVMnKUgIMnuGg7sz7awOTiBd0UjRhsXUZ7cohqRYZmvfWYwEMoRx/I
         buObilIabLumelz31dEqzfg0OVfMrBGTVwONl0qkastQBGN6LyPxGpMyleDNHJhMLWFM
         z2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761772167; x=1762376967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQd5WnTIHuwOTKOc3/5nF1ZAvZxVbQqd8kUZmHhqZSI=;
        b=ahN6KyHcZkPQuDxGVBnMAplLmrd+Y1nJtdigFJykujdtOVJviZ2bzfuuC5dDk3yejk
         WLYNkpgaw7OqBj9PviXdK/M1q34HePQit1/JeOh93N3ICAaoyJ69D+cMLij9QPwm/HI/
         DIkn3FOkd3AhwRB4YTVHpqCjSnBImaKMj5ig+U33KkK4zsCwRz2KPTCSf6RKvq1QKDdu
         YxCmlzW7q+lNLqFLt7w9rv1Cg2H4lqkOwzFtAW+FYicqbafBSWuevpZgcfyTnHoEK//P
         /sEQayn+fwZfOq7hUYqxoXSDgAsM3bzBB5j0LI848bDX2OuCdxWjttTBnEgDGaMHpdvS
         bjfQ==
X-Gm-Message-State: AOJu0YyxdbRCAFItYNyHb0ofURu+UPVp39ral1e87hUTL2sYX+vtBEB0
	9Fyubr0QdxCXEdBuo+smwoAihFA7uMJU+HPtA5tZlk5DNMO5IipiyxEsOLBMHTSh8mUGOk7OaMg
	Ldl139e2ECj8dvLOHzUUu62OXWtE0VPWn4rf2ucZZx8eZVEdquY30rvBbD3H1TYjSIj27oWprJq
	xp/6ggwXR+be1JJ3mr9ygiuGJlWtzoEiQiLeiB7CHfcWA0jPa0cWcT9Q==
X-Gm-Gg: ASbGncvP+GCdoHPZcJWYYMkfYZkLoeOESgk3GDTrjPBGuqGD8MJdDrGqlZrutbv6Ho4
	L/ruHgnnR/Khgpg2MGNRvikpSZdf/QpY96zvFz/khRE8tKmqGi9d764kY40hplHW3f9AYumxZ0H
	icSagt/6jA/GOicNc3T3n46ZDlw4j1STOZnbz2qG2zVgsYsEqtZ9auBDZGhCD7CksooUl3eJ7Qs
	quXvgN06obaK4Oz0wT9zHNobFQ3+A1tQRBXUz4R4jbFIjy2m7W+sgBFx9Qe57OwgMabgKrSIS1I
	yHuM6hgjjG3rd3FAzp3fWJd5xto1Nn1Hx9taCH42P8WjkIkzPeBmf+sjzqhc2+zraKmvKYZiw+/
	2ZhBkRdE5fYrn2nMewd+DNMw7ZXdKWRftlqFKshajC09cxt5Qr+WJNrjrKeDq5oMSjd1Ani4x3G
	ZepshXOfLk7v2ij7HG8Q==
X-Google-Smtp-Source: AGHT+IEqPZ1jbtVsBO4M/wJE1BB4Qc7COpExc4FmA/ky44z0r1TMOAvss0Flq1oWWxe/RE/PkWKKOw==
X-Received: by 2002:a05:6402:3590:b0:637:e361:f449 with SMTP id 4fb4d7f45d1cf-640441b9c80mr1972963a12.1.1761772166823;
        Wed, 29 Oct 2025 14:09:26 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([2620:125:9007:640:ffff::9190])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82907sm12966917a12.12.2025.10.29.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:09:25 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: yzhong@purestorage.com,
	sconnor@purestorage.com,
	axboe@kernel.dk,
	mkhalfella@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale pointer
Date: Wed, 29 Oct 2025 15:08:53 -0600
Message-ID: <20251029210853.20768-2-cachen@purestorage.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251029210853.20768-1-cachen@purestorage.com>
References: <20251029210853.20768-1-cachen@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_140929_028981_23FE3BAA 
X-CRM114-Status: GOOD (  13.59  )
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

From: Yuanyuan Zhong <yzhong@purestorage.com>

When a controller is deleted (e.g., via sysfs delete_controller), the
admin queue is freed while userspace may still have open fd to the
namespace block device. Userspace can issue IOCTLs on the open fd
that access the freed admin queue through the stale ns->ctrl->admin_q
pointer, causing a use-after-free.

Fix this by taking an additional reference on the admin queue during
namespace allocation and releasing it during namespace cleanup.

Signed-off-by: Casey Chen <cachen@purestorage.com>
Signed-off-by: Seamus Connor <sconnor@purestorage.com>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8d8af58e79d1..184a6096a2be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -687,6 +687,7 @@ static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	blk_put_queue(ns->ctrl->admin_q);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -3903,9 +3904,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	struct gendisk *disk;
 	int node = ctrl->numa_node;
 
+	if (!blk_get_queue(ctrl->admin_q)) {
+		dev_err(ctrl->device, "failed to get admin_q %p\n", ctrl->admin_q);
+		return;
+	}
+
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
-		return;
+		goto out_put_admin_q;
 
 	if (ctrl->opts && ctrl->opts->data_digest)
 		lim.features |= BLK_FEAT_STABLE_WRITES;
@@ -4002,6 +4008,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	put_disk(disk);
  out_free_ns:
 	kfree(ns);
+ out_put_admin_q:
+	blk_put_queue(ctrl->admin_q);
 }
 
 static void nvme_ns_remove(struct nvme_ns *ns)
-- 
2.49.0


