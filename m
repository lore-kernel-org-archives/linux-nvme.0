Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24105C79F99
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 03:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmghxinbbytPxy8g2EQGlZOpOuepMqEU3DRJsEVrLXI=; b=Yv2JL/EMLSkdbLIEoOND7mpN9s
	ay+u1wootgb2TXLvmvP0PA1dSzyzYJxZiAKQNUBYkH8V1Fo4WFDYiIFGpHBpodtLvZz/gZP1bvq46
	v6/CP1rTeiotWXkW2BSx56C6lkWmDTOSFGTxI3DEAdK2fF+Op+lAAO72HVJ5TaaadyMiSiwitD0hz
	u2zyKLfp8vMqQDDwn+XR58cYGKZ1Cqj3FhsMbsepTpMGzgfho/N89itPK7T7Dk4NR/9PwpcOVe833
	wQiUBz1rPcLprvkZGQjDPPO8+XnXNSzwu1m3t+F5Erpnv9h5gcAfkHsGN+H9/cfuIh5kqy/9cbiA5
	Yt79H4zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3mcU-00000007z4g-2mOK;
	Tue, 08 Sep 2026 03:35:38 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3mcJ-00000007z2y-2YmM
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 03:35:28 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso34701545ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 07 Sep 2026 20:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788838527; x=1789443327; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmghxinbbytPxy8g2EQGlZOpOuepMqEU3DRJsEVrLXI=;
        b=ibfhElFctIrFWRYDmFJWiDDJnXUZooCu8xKJ6FYxENdn0BjqFOOlNMhfNzZvui517U
         fk874anUZgfwrPBwViPbLHjEgr21LzsOrSSAjOBI5caSIPcizpNBSiuwLBZNwO2H9hcZ
         8aPW2cIMYxPtwwylEzCSLZp/Gc+qN2Y7tuqD/Gd+2A5Bz/FhjsPa8ESY3B6W5vsDaRQE
         Taih4SYCj+C4VkKtY+L1ATyxY9a4o3aIVbj15Ir77U/aWZLQR987evdvVVrS1nCzJ6Tm
         JA3VhaGxmP/BZAPiWdIuj8UBu12CIbl0Sgte13UhEv3lxtijgk4v19+XiA21Gxeef1h3
         KUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788838527; x=1789443327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmghxinbbytPxy8g2EQGlZOpOuepMqEU3DRJsEVrLXI=;
        b=aYta1w9wzoOiqa6mKMg5Bl3yRPgP7nc+NtRMH+4+BGdJts75yQ0IN/6OvpYjZASRvT
         Bp6LQGGoh40bu9pi4kEm3OXCya64Ao9pqbkiRIumkWPxJaaE6N/oEHm7Ud+Sa4AcKkvR
         xeMKxU4M+CXuibM3Qhl419JFvFhvkTeIKySkp6Clxz9Wi5ro5X5NGLuqqiEbJDwGipbi
         jI3mx+k5dMj907pd/+iX7QZbi3kS/WTe9T40IKRjT7A4qbgmrtNs1qRuVqLQFuIqa9aa
         5xIpHfjNtNYfdUS6t6GekGJYjh+sEbPgidsq3lKMZvw5pUyOLANbcZudZD8KKguCqxfg
         GJLA==
X-Gm-Message-State: AFuF++mQjSm7gzZ5S4+4Y6XCmJdplMj5NyWCI4eC5rAYyVFCCpunWoNF
	E4u5SMIB3mrxINICcDdPMyNs5adqX6MlLaK8rhzKCSAt6Fp49odaZ3gqChL2+7E5Z3XdE9N+h1s
	uSp5iuzQ=
X-Gm-Gg: AYBFou2AX6Bf75r6u9nhZlg6886/+PjAnw/+1cBdnDpVGfcEm1z4G8qX88rN9IEaCu+
	Yo8M98VHa8adcaid6QNpqit1lRA6242ThZZ1GuQ5OY1HtjdgGUTB8TVleer3cLXdYvtDRHQQGXM
	PCo8+PScRceWXvM/a2qe3cZb9jbW0xbR7anows1qp2MxzM0eyUE/13zjCW4mjssjtXSgRg0+DBM
	C+dyZK0RPlyO03+N3HsqtDDwPtP6Nnv07+SiXl84Cr6WXK+8T++t60q2FVrwCCz68Iqs8Hnj90P
	wHm8fu+R2KQa52LhwRINwrSmV2HmC2v8uAnkDbQ1s4lbtljPuQckNkV3gMFlN3RFa/KVLEdcQO6
	ea6hSlu7YAHFfn95UzwMP1p6lt0/AnRSleEGjIs7LwZLMwIY8E8LhJ+UqWIymiAzzouqLe2hGdi
	w70LWem2T2QAS04roaOfR3wcSeeVnfwsZIoi5sZ/0rLAjhChETFUleyXj5tiaUBI4=
X-Received: by 2002:a17:903:11c8:b0:2d8:d4de:fa80 with SMTP id d9443c01a7336-2db1235721dmr370371315ad.4.1788838526507;
        Mon, 07 Sep 2026 20:35:26 -0700 (PDT)
Received: from localhost ([106.38.226.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495b574sm50816505ad.16.2026.09.07.20.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 20:35:26 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	armenx.baloyan@intel.com,
	james.p.freyensee@intel.com,
	ming.l@ssi.samsung.com
Subject: [PATCH 2/2] nvmet: reject enabling a namespace without a device path
Date: Tue,  8 Sep 2026 11:35:19 +0800
Message-Id: <20260908033519.2721210-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260908033519.2721210-1-sunjunchao@bytedance.com>
References: <20260908033519.2721210-1-sunjunchao@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_203527_655387_BF246D41 
X-CRM114-Status: GOOD (  10.71  )
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

With buffered I/O enabled, nvmet_bdev_ns_enable() returns -ENOTBLK
before validating the device path. Enabling a namespace without setting
device_path therefore passes NULL to filp_open() and crashes in
getname_kernel().

Reject enabling a namespace if no device path has been configured.

Fixes: 6f6d604b4ef8 ("nvmet: allow bdev in buffered_io mode")
Reported-by: syzbot+6c46a179b56c651c4c96@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c46a179b56c651c4c96
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 drivers/nvme/target/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d74c01c98f19..d73524947d63 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -591,6 +591,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
+	ret = -EINVAL;
+	if (!ns->device_path)
+		goto out_unlock;
+
 	ret = nvmet_bdev_ns_enable(ns);
 	if (ret == -ENOTBLK)
 		ret = nvmet_file_ns_enable(ns);
-- 
2.39.5


