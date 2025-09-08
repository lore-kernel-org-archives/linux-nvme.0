Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27061CAC581
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GYHDtL1FKEy8pSg7jl8CvgwHSXlrx6WrsK62wkhC/3o=; b=Ua0kDl15ZY0hxQy0K6rK5GfSjC
	kLTdP115M2p1SB7iu2wMMPCJes/mB7oChZlpx1x15+jrnh0D+YY/G4/u/22WS4rvS65aU+JrODiH/
	zpATv4t+TqLHcDj2suLqeYXegDnCT810xwTlc8vAgfLmgIh+d7g+61jGruRVwPXEej65kdVkoHOJh
	4OkBG3yE3Cr5850BYs7Qf1PWN9wSfO4Cmq6MJPqspjWU6O/xPKNZKtWhwJXg0wf7fiGJ5gVcsl5tr
	Vq2s8cuAzwsiFheDp1b+GVLmVmvY9CUm0EbPqEmqAlEllCh77IhlqCNfJLVsyEiXt0fGDE86qdL04
	AJD286EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvfLK-000000010HJ-2Mtg;
	Mon, 08 Sep 2025 17:07:50 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uva1v-0000000GfNS-2gbi
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 11:27:28 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7723bf02181so3337605b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 Sep 2025 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757330846; x=1757935646; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYHDtL1FKEy8pSg7jl8CvgwHSXlrx6WrsK62wkhC/3o=;
        b=H95cDCAbFSmJ1vBInva5bvLMdg+3viq4WoLWY/KXNKFT8xuZDz2YcgvdVS2ZebU71T
         KM4+QViV+dOMq4loHLno3vNruNjkG4cwxtvInkb/X9oMG/CQxcB/TsqkHG0y+SQkIkWs
         1DIfKKJNxW5r37me0A7jLqMT5swv7iJw/KU1CSnN83gfNGfQOBuNbnA017MxPUoTGpA9
         qXlZO7lMij81aZJDEBwFNGar0r2pbKyJ+9ft+OxO9VWWzPgdjP0Ls8Jysa+84hfWQS6h
         2sd7ZYPieJfxmO+/jVkgiwHhtN47goYbAZ9AKEsnk/ZaDw0ib6H/LW8sbL5i3JIBo6si
         N6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757330846; x=1757935646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYHDtL1FKEy8pSg7jl8CvgwHSXlrx6WrsK62wkhC/3o=;
        b=O2M57WF7gsCxbp/8Vp1V/3HIgw0NBPIkEbzIKIytf1GgR3U3TPyAjOHzmbTskIMIkl
         QtbQ0TwKRkrE6/l8+F9qE7eSNjnnruy238JlZTi5PL4fPqwrQn/BqNpfTS2i3maWltaT
         IkqxGbk0llsB/D4YQYE6U/+Pv6h6vPzpoCI5vTORm6fPJ0fixmFiQV19+GMKsO7Kn8aO
         1vLDX4/+qQfRBY6qZh2qR7BT2K4MTbdZGjB6Yz0fAP23nFhlzWXBcIGnjnGyc5jLb5TO
         0lwS96AINQeTTKyQaVTi5CISR/kZrjXijC0WgFbXtUUSIRWxImhAi0wJcEZ4696v4ukg
         XtqA==
X-Gm-Message-State: AOJu0YyCNg+yIn8ug7eX+V9+G4qQcIii4E57bBGV/T7f+f8/Zq9lS1P3
	GBMkReURbit2kBP3GPjpv0FicFbaWRhFpzeZLE1hR5p6jlIOoiQXsg1jlY1bRg==
X-Gm-Gg: ASbGncuPO915NwrMwsM01a/bcZDGW8neccGDBzgQWkxSL0FOjsO9Ktxn9vba9lAgM3R
	w361zRDG4Y8RTbfclavuEXPiRraI2tUDMKzR2Kaj6tR4zn2JtUV/iTXxGg+lCtIhTx7IDfiKOvZ
	TJ/f8X7s1TDbDMd+k1wYoqv4ZZicCnlxyBguw65g0cphNp6ureuHX/4h3lZzVTjZ8wjDem6+Gwo
	Ezefk9Pz1S86gAA7SN5tPHxwjRLKs2HXP9CPL0oWt8P0Qmu6Gg0TYRDuYa2sPMlBrLSRR3D7lHO
	DrFgaKsHu4uAMx6CZCYpJ+XIoOoJqIfWghToynIaSGzYXg/6cDAmGNK1vtxJqwNQq05sfUnJn1L
	uloYAUwHOQSDxUoNn4VqBhmwco0ypWEarOBXzaFqsvcu6GpE=
X-Google-Smtp-Source: AGHT+IFdaeGuRoydmPp53A+0YLLsoULa08R9OdHW/iAHLTCnsMKqgvEWUNKk8E8CL7LF5WEl3q4h0g==
X-Received: by 2002:a05:6a00:9a4:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-7742dede382mr10477690b3a.32.1757330845894;
        Mon, 08 Sep 2025 04:27:25 -0700 (PDT)
Received: from gooner.hq.netapp.com ([223.185.128.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bf561sm29573619b3a.59.2025.09.08.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:27:25 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@kernel.org,
	Martin George <marting@netapp.com>,
	Prashanth Adurthi <prashana@netapp.com>
Subject: [PATCH] nvme-auth: update sc_c in host response
Date: Mon,  8 Sep 2025 16:56:42 +0530
Message-ID: <20250908112642.3447-1-marting@netapp.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_042727_676901_5F0EA98A 
X-CRM114-Status: GOOD (  13.47  )
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

The sc_c field is currently not updated in the host response to the
controller challenge leading to failures while attempting secure
channel concatenation. Fix this by adding a new sc_c variable to the
dhchap queue context structure which is appropriately set during
negotiate and then used in the host response.

Fixes: e88a7595b57f ("nvme-tcp: request secure channel concatenation")
Signed-off-by: Martin George <marting@netapp.com>
Signed-off-by: Prashanth Adurthi <prashana@netapp.com>
---
 drivers/nvme/host/auth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 201fc8809a62..a7344faab2b2 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -36,6 +36,7 @@ struct nvme_dhchap_queue_context {
 	u8 status;
 	u8 dhgroup_id;
 	u8 hash_id;
+	u8 sc_c;
 	size_t hash_len;
 	u8 c1[64];
 	u8 c2[64];
@@ -154,6 +155,8 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 	data->auth_protocol[0].dhchap.idlist[34] = NVME_AUTH_DHGROUP_6144;
 	data->auth_protocol[0].dhchap.idlist[35] = NVME_AUTH_DHGROUP_8192;
 
+	chap->sc_c = data->sc_c;
+
 	return size;
 }
 
@@ -488,7 +491,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
-	memset(buf, 0, sizeof(buf));
+	memset(buf, chap->sc_c, sizeof(buf));
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
@@ -499,6 +502,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 				  strlen(ctrl->opts->host->nqn));
 	if (ret)
 		goto out;
+	memset(buf, 0, sizeof(buf));
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
-- 
2.43.0


