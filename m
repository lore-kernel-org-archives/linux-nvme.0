Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA79C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CGEUp3ob+JGpdilZp+gx8NdgXFPIJ9r8QmvAiWLd4sQ=; b=Zogq13rZenAzCP0DtEB8dZYD9G
	bt4fBGzfl/ZAp33pTkn/zT5Pqpmk1XmbrFOZSDEjo9/HUiRpcsOQQdz3oaQFBxHrOenkvOIz8C0jx
	SMperA5xOGPNnMEmvYUmMMxBszROZWbY3OtJPCmN7ZJBb5e64bTwWiNvlG3ojnvHC8RHyUktxGiGj
	3t/FGk3NIITaphFZLzle+107V4TtLr9pzAyL78jtY1ZCblPStKz+wM4/X7RUvmzR88KBXybd0ROmi
	2j7eRI4vEuT8y3MyPht4glB3iWShdY83YnYjt0JR/xrzvxsaf+xxmwSzdLRghrLP8akQhySyjeBBf
	BIWE3FpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9tN1-0000000Ay3K-05TE;
	Tue, 29 Apr 2025 22:24:07 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9tMy-0000000Ay2s-0PSv
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 22:24:05 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b041afe0ee1so6295455a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745965443; x=1746570243; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CGEUp3ob+JGpdilZp+gx8NdgXFPIJ9r8QmvAiWLd4sQ=;
        b=dVrf6FL3BLx55NlOQ3WLdRBHqjKl24GxetlzjylOBzHMkW1399itWhTQeSvUNiqFHI
         MOe7snHZspApCBI3RvFw19PNdDA2DTogRsXv5kSTUIqKRwAUtiEJ3ZTZyPVQU3L0PG2C
         uypEmtht41VG0N4jbV0/60IdKDdbyRE2xen9rVfMBB0enaHBwENAPxGh9LbD54+H8RQz
         F3HyHlbgWps6BlGqJF5posHVDH2STwI6GaM9qJAOmVx2poA119BSHKEwmeyO1EVq1Uch
         k82C1UJTQ8UyobXtBza6DgyVMvM/L1jGjEMGeacbQAp3/DwWJXcjOHlDeLaep6+3XWFu
         XDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745965443; x=1746570243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGEUp3ob+JGpdilZp+gx8NdgXFPIJ9r8QmvAiWLd4sQ=;
        b=llCi2l7Wjsk8LS/dat7T1lVIHe2kKgmw3tqcYhxXhm0rsxhXg+ngXx7WruDiN2Pjcg
         htNHnRYACtiIyiaQQurvU948DzK72ptjlkSNVz/47OiK3u0kGei2wpKa8ZbWrwxBHUYe
         Rsy4cOvSRdF6pBIgSm8egnZBucAd21ZYowLmQAsIOzoJZg1uOe0QP91FSbiNss00ooHR
         7FCggO+jy+Dj04nBRQXC46HOL/o8SG5T4L0oWyJwvkcpmYBrx71X3L0SlycERPTN7Vfa
         m+Db7BEtkZoKSe2Q8pzFVWUCuisCXSFh2CTpJOrHg/8QtpAeH6UpB64Vcbgx29lMDxgr
         kQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCVoRJJ3rDRsKfD9nsFE3JD82ag8BQXYl5UQrKXmTjujM+4KEvkBczrgNhFQ+kh77ZLd6jij97+t1qH7@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1+CZqnfNhjSiqL1PNa3zhNRXKyMbuKxgs4ynx0dwyrl9UCFVr
	snomchy9eqhsdR2GEw3gAyDPBtse4L02T0jFqOTwzI2tPJXS9O4O
X-Gm-Gg: ASbGnct3EU6uBtPKCpQYgkUVcGNBIJMITr6Fqp/6DUlD+SuuhCIfhc9kPCsNsP1k4ON
	8mI8EqR32swc9PWI9EF7A3FlhtdvhoCjEANU7RIlyDIj/SUjkTXEay4yziT4ACEL+KB0rIn85br
	JLoFBFSLIKgL7KKgnuDWkmbU8arcngU4aCdhmqMUJWmRA2mJiQzVjIvEFglXH+fleWhg6ImQ0Nu
	svC1a8ZNBP9INtbGgCwZwCLcV9A+yZQKhQS10Wcunl5BW9w6PwOJKrgrAptH9TI2gxVT1s/h6ZH
	QMkOoLVrC1eAzVck/nlWLj26NLDucM14tSQlYxgzUAGuaIdxqwNXBlG0R5Yp4xHnEl2c7vI7DJE
	G6v6kOh8WLKEAhhmGqTX+yCcOQeQnLA7ByseJRLxOuXNSdg==
X-Google-Smtp-Source: AGHT+IHF69aRwz3TZ1NaDoib+tAud/ycJsSGFVCOO3bK++WRTy36kJlMFxYTEpVOplk/jCEwcufrxQ==
X-Received: by 2002:a17:90b:55d0:b0:301:98fc:9b5a with SMTP id 98e67ed59e1d1-30a332d5c99mr1058275a91.6.1745965443080;
        Tue, 29 Apr 2025 15:24:03 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a349e3c37sm68489a91.5.2025.04.29.15.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:24:02 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2] nvme-tcp: select tls config when tcp tls is enabled
Date: Wed, 30 Apr 2025 08:23:47 +1000
Message-ID: <20250429222347.2215363-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_152404_136373_0B81D630 
X-CRM114-Status: GOOD (  10.22  )
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

Ensure that TLS support is enabled in the kernel when
NVME_TARGET_TCP_TLS is enabled. This allows TLS secure channels to be
used out of the box.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index fb7446d6d682..4c253b433bf7 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -98,6 +98,7 @@ config NVME_TARGET_TCP_TLS
 	bool "NVMe over Fabrics TCP target TLS encryption support"
 	depends on NVME_TARGET_TCP
 	select NET_HANDSHAKE
+	select TLS
 	help
 	  Enables TLS encryption for the NVMe TCP target using the netlink handshake API.
 
-- 
2.49.0


