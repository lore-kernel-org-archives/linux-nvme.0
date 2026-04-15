Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2C3F433D0
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 23:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3/nZZ11g+qJgs+aEgAlORhode/4t5Z8MGx2W94OjR8M=; b=FeK81lgc+Md187rJTrTV2AzM3i
	H0za69v6es51CoqGIRVxNs+8B6BRFUTug6ndpK7SoQ/1Yw33icGBgPTl6BXzHN6I4ssprH6viH9ys
	IcHZkXULcDZFwl40PBoVHbZYixRu3FeCg5rC6ILab1LqtrqNaJaVSn6fin34AySqzmrr0T0s21uYi
	P442+2/G0uiU7Y8ZG5hXcyZvUH5D9hvQ1PfWbZdsSGXLDAp2cbAKQOo4LXDJrKG90C4dfXENXk0nx
	u2sZh28IjYgUpmsrgSSperyHpUoYwiaFK0ADpZNInqHlrOL7ogpJ3GlLCTNOo/jEqjVjnKsxB1kCg
	owT8m1/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD9GM-00000001id8-3FOt;
	Wed, 15 Apr 2026 23:03:14 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD9GJ-00000001icm-19Wr
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 23:03:13 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82f69adeecbso519337b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776294190; x=1776898990; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/nZZ11g+qJgs+aEgAlORhode/4t5Z8MGx2W94OjR8M=;
        b=gy64OHNgSboQ40GcgXvUwhKDWRpP/k8UTn+IpXDS069J6GDsoReYKDx6xjmwSTLgf6
         U2ebHYgHQkBTBpjCW2BoynONeVL/ig3O4gOOprYK/t1ys0Xw0586azny0CrRbObcY0VR
         xoawPDjRplJvhSeU9bFfxCQcENUD4qDrde8H082bbEg0VXRyFPXxLkhXIyFYcn46xNWR
         SU2sa4M7XFu3tHscKTRavuZlc2cI3ytFYppDJJab2M9szqDtD9b2K74DyWpTtaYnK2PM
         sXAw/ScmTvLYC+V0Q4wDvnw6Yr3y5tkrvxvlqFp5Yx2tQ6fEMZGSwzATMjcpTkcnwL4a
         b9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776294190; x=1776898990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/nZZ11g+qJgs+aEgAlORhode/4t5Z8MGx2W94OjR8M=;
        b=mF5tTVXk7WbszY5bfwmUSp7JdFKry5yX5gBUcoDIeguvfQeKS3v/Wq1ZNggefu0YIx
         DKMJRvkb7icLJ2B0wrOS2JgkxAEgKhaB60nn4/9/QJpQPwwtWFzx58z4zwZtDKWM80l0
         C06Ockrig4hFlNsmGe4SRno4dDNoBb4DJjvU2lRFcz6qg4W/ElOB9ApMKe72PrPse5wH
         cXWPLv0SAIRiEaL8D7chExy9R7bIwcMq9ODe2VDQ0OZoAWB+8W4ycWyZDheD0RosZukZ
         J5q0y/bCtIw+Pj1gTfUAtApxVFgQBy1pN3rPVdGiwQGqNT3QlV6LbK58sq8iDVq9Uncr
         sM7A==
X-Forwarded-Encrypted: i=1; AFNElJ8JXdsZr0COokugpsa2pDqajKNbSkZap3mbmfz064oz3KWTCgOt9uwBKGVRbBLh7QTGmkCmJOwG+kZD@lists.infradead.org
X-Gm-Message-State: AOJu0YyXHINexCwQQmA7ZPLqPaqzhYVD7/uSaN58i/VKn+01MNM1ZbjU
	NP9GaqWRmpq7dKZjna0HN748vxILb7ZTh5ogZHfnIK+itH96VA6hAvTf
X-Gm-Gg: AeBDievvcHBKpu0lrQbVhNDrFzWvN0+JFoi8R/IBKevt+m2bOlLrBru5jq6huPQWn7L
	tp+okvYGNPYB0zJ6gMEZorN4yp5scS6DGMxnTYhf0VNMpBWHU8yMnX43LupwOerNPnxIRDZRttv
	1sjja0WbAEvRo5qjxiXG4Jcag8YKrMWAv+W9gKKTExgz6Y+E4EnuHUOYI9tXDbHKr2k42/bIhw/
	hiHTxEQmi/4qnZu+f77bUkOTjvo0KwoGqekRBYuN41pfjdPuApqydeYpaidkS0mqoEMS98s5K7F
	/8mD3IzQl+jjmfs8kwH5RiidVSivv122biaW3i3DIRNpF+29AqpdGP+O2VuooFsT2MyWT4g95I5
	SabFoBrJAlrmy8diztFJUZOgASKxY4Gx0ONYNgFBI+TERosC8p9sQSgwVz6aVDo59Nh6iDqM7Rf
	OWQSL5XMhoiTQErL3fAGdPDcLiQPvkBOuXNNU9d96TYA==
X-Received: by 2002:a05:6a00:94fa:b0:82f:592f:2eda with SMTP id d2e1a72fcca58-82f592f35c4mr7956907b3a.43.1776294189477;
        Wed, 15 Apr 2026 16:03:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f694a422esm3482261b3a.43.2026.04.15.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:03:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@redhat.com,
	mlombard@arkamax.eu,
	linux-block@vger.kernel.org
Cc: alistair23@gmail.com,
	shinichiro.kawasaki@wdc.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] nvmet-tcp: Ensure old keys are freed before replacing new ones
Date: Thu, 16 Apr 2026 09:02:50 +1000
Message-ID: <20260415230250.2783414-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_160311_338234_6DF0A613 
X-CRM114-Status: GOOD (  12.00  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Previously after the host sends a REPLACETLSPSK we freed the TLS keys as
part of calling nvmet_auth_sq_free() on success. A recent change ensured
we don't free the keys, allowing REPLACETLSPSK to work.

But that fix results in a kernel memory leak when running

```
nvme_trtype=loop ./check nvme/041 nvme/042 nvme/043 nvme/044 nvme/045 nvme/051 nvme/052
echo scan > /sys/kernel/debug/kmemleak
cat /sys/kernel/debug/kmemleak
```

We can't free the keys on a successful DHCHAP operation, otherwise the
next REPLACETLSPSK will fail, so instead let's free them before we
replace them as part of nvmet_auth_challenge().

This ensures that REPLACETLSPSK works, while also avoiding any memory
leaks.

Fixes: 2e6eb6b277f59 ("nvmet-tcp: Don't free SQ on authentication success")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index b9ab80c7a6941..58185184478a4 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -412,6 +412,13 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
 	int data_size = sizeof(*d) + hash_len;
 
+	/*
+	 * If replacing the keys then we have previous successful keys
+	 * that might be leaked, so we need to free them here.
+	 */
+	if (req->sq->dhchap_c1)
+		nvmet_auth_sq_free(req->sq);
+
 	if (ctrl->dh_tfm)
 		data_size += ctrl->dh_keysize;
 	if (al < data_size) {
-- 
2.53.0


