Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02166F8E497
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OnWo2Tuaq7Z+geKHmJANpC2Zz9+7IbUKXu6vHtPg40w=; b=M1SdURMmyrUblnJFnpiGh2JDSk
	YOhu3jvViFZRolc6T/Pa0jo3+OZ5oGBj7DN7PuuQ27aQVLc8EUl1uh+LWAV8lmUuroMYh8Pzu1TDz
	hxGXe9jaNOjemODuG0wwF5/uoLCs5s6dxU25o++zPgAjn1T9k65Qc65H1RF29jwYdlkOCzxCAcXQl
	/kkJCle+GQPdC8oq+6D8Og9Hpdi3TGTz2vy1KqU85bNT7H842FrhpyjTUJ2P8FyWi4VukkA5Pxe0S
	ODf7bknXunHn5KHIQjWjNlajKUd0p611TPUuOjgG1FPt88HIIct6aQ+QPeflFICqjDFBpZJGwzHJD
	dgGWIIiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXQJ-00000003FXF-1Bue;
	Fri, 17 Apr 2026 00:51:07 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXQH-00000003FWn-0JRI
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 00:51:06 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so76895b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 17:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776387064; x=1776991864; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OnWo2Tuaq7Z+geKHmJANpC2Zz9+7IbUKXu6vHtPg40w=;
        b=RO3j3mVzbASxBpSmnKKv/zIb3NU2LAYUHt3iTMqRB4aFVkbYCG8uN+A8a22ZMWCNHj
         lqpF6TGrbmIqy9M/HU1dMp6FBJUx16V177SSkgiygOpyI5KpGx3VVQGAx5c0HidF+b/U
         QkHtoB3ujWnPBJ8SVQ6DKc/DUW28eqDVdjvL4xLebJu7AZnw6MkzhPHku29y9u3aYhCK
         CoGao/FMJLNtPPROOAeYxgbFfF80tEWItiLwnZEO6tsXQyqZUDppMaCltYboPFVdPSDI
         y9Gr49AvE+TujElyto0/upP5wns8NxWMKrcipJrWd8mrsVKxqcGeKVVj6bUnT3BFSGCt
         p4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776387064; x=1776991864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnWo2Tuaq7Z+geKHmJANpC2Zz9+7IbUKXu6vHtPg40w=;
        b=TojErt8Tz4PGhrWQUxtJmBqg+31gUrSEWlDJkYYlhzwhwGww9IqnpUYdD+chAgo2hM
         treFx6y12/0DaF87ue9UrSUwytkNol2cV8E5awhE6btzBBg4KESiiCs0nZmoKyKLYyP+
         oNXFtWr/ecEUuEpyuCj8qqZKTFj5KX9xkoEuyLbckxWB2QqUAu0JTXAKhoAGzODEK4OP
         AwbBpdbvBGZBKf6rfnbiIz1uuMeWxuXMAytiFZSkovp0TT++nHTvXE5S0WjMqwHO6/xm
         ZYbHlpvFzbHOZKXRyvR0Tbu32bPbbBMAs7x12aTM0AQOZSkBbgjT7L6SCEWTMzKE5M6+
         pjsg==
X-Forwarded-Encrypted: i=1; AFNElJ+2lrOA4nWQuhCqj2I11I2hjen2wCQind9fA0RJ8OmdzIq64g+5U/Q6x9UBLYA0CrPt+Zmx9FWKznRI@lists.infradead.org
X-Gm-Message-State: AOJu0YyvYrA5B3PTad/y3UvM+Va1PrKBgCYWMfjtxH9poL/fLdV2b4jK
	WlIXW0NsVieknEkPQmDtxusF0aUbrR4XrBb6FioAZuc0OkCNLyWuWwgx
X-Gm-Gg: AeBDieuL5vi+6UU0ejfZgcV0hXKHcd5Y1R91WPrmZ/qPGzHKH0VbdH/3Xnp2JN0mw4k
	OYtJRmXrPwiC7lykfh53gblXwlLvcU2cTrqOC6LljX6HXLs2es0GAyCKIK68PtZWtuPZYx3OXSL
	TKbJtkSd9WCf4l28NEk48JpITfd4vpvUxUcpesGBG4zor9mgb2o8Hq9VQqKIPiaCSOUorz5nk/R
	/y9F4kFGjcE9c+mEbKR14zemNV/Nqy+nvFWyWHgog1JDBMhHdHHisKlxUiAs87kGonBrsh8hX/b
	JMrVWkAT4qTy3zw8q4MT5efCOAcB0x7kWXJAAPa00UTBNnCDp8rrzwSjJpjSC5iU0W8W4yiWJtF
	ZnBPA2X0y416GgFL4GqGJGiy69eUSN+sPO8TL/0/DRLhejiQ3ZHbV6iMbSuvfQJ/KuDkSGv5731
	Hea1fziMc8zFdXCA/JuvBO9y6g3so4o+d8YdrrspJVa6iDo9Dpdi4=
X-Received: by 2002:a05:6a00:2d98:b0:82f:5c3f:94c6 with SMTP id d2e1a72fcca58-82f8c91b7d4mr502361b3a.28.1776387064055;
        Thu, 16 Apr 2026 17:51:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8cbc05fcsm233782b3a.55.2026.04.16.17.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 17:51:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Chris Leech <cleech@redhat.com>
Subject: [PATCH v3] nvme-auth: Include SC_C in RVAL controller hash
Date: Fri, 17 Apr 2026 10:50:48 +1000
Message-ID: <20260417005048.2898121-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_175105_319697_60888E62 
X-CRM114-Status: GOOD (  10.27  )
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

Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
included in the Response Value (RVAL) hash and SC_C should be included.
Currently we are hardcoding 0 instead of using the correct SC_C value.

Update the host and target code to use the SC_C when calculating the
RVAL instead of using 0.

Fixes: e88a7595b57f2 ("nvme-tcp: request secure channel concatenation")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chris Leech <cleech@redhat.com>
---
v3:
 - Update Fixes tag
v2:
 - Rebase using new nvme_auth_hmac_update() functions

 drivers/nvme/host/auth.c   | 3 ++-
 drivers/nvme/target/auth.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index bbedbe181c8a6..63f543e809985 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -535,11 +535,12 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 	put_unaligned_le16(chap->transaction, buf);
 	nvme_auth_hmac_update(&hmac, buf, 2);
 
-	memset(buf, 0, 4);
+	*buf = chap->sc_c;
 	nvme_auth_hmac_update(&hmac, buf, 1);
 	nvme_auth_hmac_update(&hmac, "Controller", 10);
 	nvme_auth_hmac_update(&hmac, ctrl->opts->subsysnqn,
 			      strlen(ctrl->opts->subsysnqn));
+	memset(buf, 0, 4);
 	nvme_auth_hmac_update(&hmac, buf, 1);
 	nvme_auth_hmac_update(&hmac, ctrl->opts->host->nqn,
 			      strlen(ctrl->opts->host->nqn));
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index b34610e2f19d4..f032855b21477 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -402,11 +402,12 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	put_unaligned_le16(req->sq->dhchap_tid, buf);
 	nvme_auth_hmac_update(&hmac, buf, 2);
 
-	memset(buf, 0, 4);
+	*buf = req->sq->sc_c;
 	nvme_auth_hmac_update(&hmac, buf, 1);
 	nvme_auth_hmac_update(&hmac, "Controller", 10);
 	nvme_auth_hmac_update(&hmac, ctrl->subsys->subsysnqn,
 			      strlen(ctrl->subsys->subsysnqn));
+	memset(buf, 0, 4);
 	nvme_auth_hmac_update(&hmac, buf, 1);
 	nvme_auth_hmac_update(&hmac, ctrl->hostnqn, strlen(ctrl->hostnqn));
 	nvme_auth_hmac_final(&hmac, response);
-- 
2.53.0


