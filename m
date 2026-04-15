Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65D5F433CC
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JsMMBm1WM41W4hIFWtgmHCtwETMF7jT3du1Isr8t+hk=; b=WVu0oEPBxKx19/wWfpI+gqTMd9
	Xx4rx0aJ5tL1Hvbc1M2MLYWatXV3CN6CdaEewyChR0yhH8mU6eAygleiXUS1YpireafJrnHRQIpJX
	I9wn0dSzWXGOFZLaLg9BCpjMq+MekOp+UV7WhzLxsXm+JqDNYf6GYp5/jSuUlvofnwL0RbBSjrgqp
	xCP7vDC73FZNo2Wa0bfGdAo+mGPME0xa319b/PRgWpDAHNBpKyBxj/nx2NP/SYw3ebz26yMSptIXo
	AEVI997wuBFFUgVIp4fCuweq3LZ7VtDFDAGhOI57B6u9JOYEEcEap2iV9xueKZ7oiDiVszabo+3Pi
	UqLGs1eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD9M8-00000001j3s-20Ke;
	Wed, 15 Apr 2026 23:09:12 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD9LZ-00000001j0X-2YRy
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 23:09:11 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82f2766905fso2074614b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776294517; x=1776899317; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsMMBm1WM41W4hIFWtgmHCtwETMF7jT3du1Isr8t+hk=;
        b=ikLV+P/u+t1reMo/4+1J2O6jew8LQzoPBilWaVd8T+peUVe8cbmz3aOTNUbnKrSiVc
         9VfTSmGzY3obDktucZiTMMs/OvC0d41Xcq1Q8uVtZamcMyU0MR+LCi1RQlj67IUm5ut7
         t33LKo8jiU4iliefTmmX5uHPuEfa75JQlDnOZ4SHPF4eZFR6ofl6qqKsZl0MoVEAG53C
         mdbzt3pGkQH76UbXTzGSpTtCMLDxxkNTuE20YRqGAsOTbQW8A7VPT0jt35eRl4b0qGCF
         5anhMo9R5+S0DIXrONie2UNk3WAuG8hBXjgJjPjzW0A/w1RBmZVTT23XoAO724boY6CC
         d+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776294517; x=1776899317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsMMBm1WM41W4hIFWtgmHCtwETMF7jT3du1Isr8t+hk=;
        b=IhX5uiPsy6ogy8r9ScjT6xLDbpXiGxZ4ceflxkiUGayLzzKWF89fM+ZaC3Y+fQc6De
         kAumsaIKdnvpk5aquBeFLpHZFnlPTkP9EDfZWa8hPHbLl/Ps1GO4U9Xv7/9tk1qgC6Q0
         JZU8DqkBg6fgzMpDrhoBJ+R9egYDSW1UWCmNsyfqmf2+0RD/X6bElrNjvYTwmzXQZQy8
         XYFAEWzXj1ENGDzGSR3DLRTHnZFeYpCVin+hzJAYQ3HGoCJd9e2hFQlqIs/nRLNP2cGn
         J9jZWHqd1wEUtE0C/UOWcfqpyk6+8/udiXKg7pJzYspKC+8Himbs4OCnMvEegXQ34xyG
         xIXg==
X-Forwarded-Encrypted: i=1; AFNElJ/btvcC8MkON5YEKGKN32Sh5y22/rSp/pYNI3qvWXeDOUt4dGqA0eKszTUkhrhmfk4DyilD+4c8VOD8@lists.infradead.org
X-Gm-Message-State: AOJu0YyhAm6HW0dTk/HPgzgSHkJy14JjoNKk/PeURwgm5Tevvl8zcXn/
	VEsHpNjDTcz1Rd13Z7AzfVzvdY1IAfyojrEwrKkM9DebUEf+vgHMQzcf
X-Gm-Gg: AeBDieu1SM6HBRdBlLB0FvbyhH0p39Y4PT9aiNiHEiN79YHkYZhugPo7LbX3BYEN7wb
	uc6ldqtTFHLxak5/tlB9fT/b3gANFnZ9LoARLPXNf15yQxckanLRI+ExbE+78cVz3/kjm6QCTsm
	J2HSH9UFHuYkqldNEo8U4EF++8SKRXaSkuUxK65j6Gp9QVNR5DTMdpZwLMazcRqVG98XMw0jG/E
	06XA8PtFsLlT23pIDD0UArfbAHOj8uuztTAd6qzNxDLEMoh6jjgWAJF1SNqQUPV8yC7BKdt7BtP
	w5gQj6/KGv3kMDDSPI7pLP2pduw87wJFWcTTR3+MyPYvAv71JR4T922cRNSzzglEW/pKugO1gqf
	pbqv72bcIlrXaZqcSQfBOsa7sbuWE3MZNluy6l/Uw7SIqHg/VAvuw3I+cwnX3IGogXYayhYfUbQ
	TSHnuu6XIMiU3ZWc3yZjyXbwbaNVisX+0D695kCRqiTg==
X-Received: by 2002:a05:6a00:a87:b0:82f:559d:ece3 with SMTP id d2e1a72fcca58-82f559df420mr8363404b3a.15.1776294516557;
        Wed, 15 Apr 2026 16:08:36 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67078605sm3376019b3a.15.2026.04.15.16.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:08:35 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2] nvme-auth: Include SC_C in RVAL controller hash
Date: Thu, 16 Apr 2026 09:08:24 +1000
Message-ID: <20260415230824.2790058-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_160856_669219_7278066E 
X-CRM114-Status: GOOD (  10.80  )
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

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
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


