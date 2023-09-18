Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBDFCD37B0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Sep 2023 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IItNc+Zt5nnQ/8UdDotMfLHi/NEp9s9tuV8PI8RzTEg=; b=4zCC52Dbuh9Z4oxaWadAPilIXX
	oMnqOiS5Uku5bPcRL2F3pi73YQ/zPXrMpFUMzC9ER2ohzuRPVLhIG5VRc4VCh7BL7/dAkINfaT0cj
	LewsdpilXlmRSSPX8vqzvpmlL+NwD0bDI1DwyKpJa1u8i11GIxAvYU8kijxd4DfkrbJj1oa31afpE
	PleVy0k6YP1OLKjCOwCxtjZjnBL8oz5xq1dkz2tFW3UsX12K0Ms+pXrNVUIadN2qksgvVVwP+QgeB
	Gv6dAjVRLEVd4/V1F1SiUa2+tODvgEXhbRA+sGqqaw9aX4FzYzwCbuJBhC7VyXnJuDvJeGH04uXHw
	8cp1o4Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiHkt-00Fx3Z-2q;
	Mon, 18 Sep 2023 17:09:51 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiHkq-00Fx10-0q
	for linux-nvme@lists.infradead.org;
	Mon, 18 Sep 2023 17:09:50 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf6ea270b2so35266155ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 Sep 2023 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20230601.gappssmtp.com; s=20230601; t=1695056981; x=1695661781; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IItNc+Zt5nnQ/8UdDotMfLHi/NEp9s9tuV8PI8RzTEg=;
        b=gMoe9qHcgiVtqFNog7krqtz/fQ3aW5fenwdt5QKAWw3B3b2q3Q+d/WG+ZkHLYEHvKE
         80OE87TnRwZkOlucBhG/sh/7VwcSZSwV8KdpfTFw++wytKKPpfUgepIiKCbdRWCa1i50
         yoLbx6wm9r4/pJvy6IaJ6SKaWDY6NVfun4fsp3XnEciadaZy1DWHy8+gwXNtrdbrJTta
         V/aRPjSr4g2H1uKWDxxdhu7Ct8jUVcLEFacvXaGJQUM3HQUPQHAapEUk/B5vyMMrDTiA
         Yy8sdG44dcpoiNLggxfH/Q0+ODqpVP2cVQMfleIAeL3/joA16CpfLvi0pIH0H3hcEP7G
         W3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056981; x=1695661781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IItNc+Zt5nnQ/8UdDotMfLHi/NEp9s9tuV8PI8RzTEg=;
        b=vtbVOJinEhYQ7Qx35RM/WLJx9x1UBWq5lLAAezEiNIR9Ezfn6pSx8D1HhyQUfZb5RJ
         GXQQHc8rW3Ms9RiV+0QPMpLnOr7NAd/WhjsFmNv2pcCkcjP2TCJp9tQdC9J+JeyCeYja
         dzANA8quh2ebaO1mQ1d42Qs5uk9pJJYsPxAeBqKBdxunOlA+MPwy1HFHq/KLAk0eJv1g
         gwjfrN2jZNBuRBG5tipHRlt7sDb3m0a9hAVkmau3PXzeL2ZGeAbSwSlWXR06rxoCB+zg
         mZ9khz0i1bMWemP0la53qC2xfgjxTpvw0A90Bu3xMt4jzMlWpb33lFDH8DFzFWQ1QoCX
         SBpw==
X-Gm-Message-State: AOJu0YxYrRnszsyI+xayFBW3lxvnMbHe61rZCXwwkHgNSADS2gkdfE3F
	MF/b03z99cuy9UA4JEC7Az+JPg==
X-Google-Smtp-Source: AGHT+IGICE7p0GqE8Tg9jhcYRkzC3fqApnNRjDURAFmQTFb9i/QX9MA1iUEb6QiwhikQ+AKuqo0Hjg==
X-Received: by 2002:a17:902:e9d5:b0:1bd:e64c:5c71 with SMTP id 21-20020a170902e9d500b001bde64c5c71mr6845120plk.21.1695056981249;
        Mon, 18 Sep 2023 10:09:41 -0700 (PDT)
Received: from localhost ([172.103.222.8])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902eb0d00b001c57aac6e5esm1604567plb.23.2023.09.18.10.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:09:40 -0700 (PDT)
From: Jade Lovelace <lists@jade.fyi>
To: Gene <lists@sapience.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Keith Busch <kbusch@kernel.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev,
	Alyssa Ross <hi@alyssa.is>,
	Michal Suchanek <msuchanek@suse.de>,
	"axboe @ kernel . dk " <axboe@kernel.dk>,
	"sagi @ grimberg . me " <sagi@grimberg.me>,
	"linux-nvme @ lists . infradead . org " <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gene <geneslists@sapience.com>
Subject: [PATCH] Revert "misc: rtsx: judge ASPM Mode to set PETXCFG Reg"
Date: Mon, 18 Sep 2023 10:07:39 -0700
Message-ID: <20230918170831.1677690-3-lists@jade.fyi>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <66bc5229-8131-4111-96fe-bd5ee90314b0@leemhuis.info>
References: <66bc5229-8131-4111-96fe-bd5ee90314b0@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_100948_301339_F8B183E6 
X-CRM114-Status: GOOD (  19.29  )
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

This reverts commit 101bd907b4244a726980ee67f95ed9cafab6ff7a.

This commit causes the NVMe controller to not work on the Dell XPS 15
9560, and similar laptop models. It appears to happen with any SSD
model.

This commit is broken on 6.1, 6.4, 6.5, and 6.6-rc1.

OpenSUSE has already reverted, and I have submitted a revert to NixOS.
As far as I can tell, this regression has fallen through the cracks.

Symptom:

kernel: nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
kernel: nvme nvme0: Does your device have a faulty power saving mode enabled?
kernel: nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
kernel: nvme 0000:04:00.0: Unable to change power state from D3cold to D0, device inaccessible
kernel: nvme nvme0: Disabling device after reset failure: -19
systemd-cryptsetup[169]: Device /dev/disk/by-uuid/b80aedf8-ddd4-46fa-8d09-5215d5f286b9 READ lock released.
systemd-cryptsetup[169]: IO error while decrypting keyslot.
systemd-cryptsetup[169]: Keyslot 0 (luks2) open failed with -5.
systemd-cryptsetup[169]: Keyslot open failed.
systemd-cryptsetup[169]: Failed to activate with specified passphrase: Input/output error

There are several downstream bugs, these are the ones I know of:
- https://bugzilla.suse.com/show_bug.cgi?id=1214428
- https://github.com/NixOS/nixpkgs/issues/253418
- https://bugs.archlinux.org/task/79439#comment221866

Upstream revert links:
- https://github.com/openSUSE/kernel-source/commit/1b02b1528a26f4e9b577e215c114d8c5e773ee10
- https://github.com/NixOS/nixpkgs/pull/255824

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217802
Reported-and-bisected-by: Gene <geneslists@sapience.com>
Link: https://lore.kernel.org/lkml/30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com/
Signed-off-by: Jade Lovelace <lists@jade.fyi>
---
 drivers/misc/cardreader/rts5227.c  |  2 +-
 drivers/misc/cardreader/rts5228.c  | 18 ++++++++++++++++++
 drivers/misc/cardreader/rts5249.c  |  3 ++-
 drivers/misc/cardreader/rts5260.c  | 18 ++++++++++++++++++
 drivers/misc/cardreader/rts5261.c  | 18 ++++++++++++++++++
 drivers/misc/cardreader/rtsx_pcr.c |  5 +----
 6 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 3dae5e3a1697..d676cf63a966 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -195,7 +195,7 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 		}
 	}
 
-	if (option->force_clkreq_0 && pcr->aspm_mode == ASPM_MODE_CFG)
+	if (option->force_clkreq_0)
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
 				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index f4ab09439da7..cfebad51d1d8 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -435,10 +435,17 @@ static void rts5228_init_from_cfg(struct rtsx_pcr *pcr)
 			option->ltr_enabled = false;
 		}
 	}
+
+	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
+		option->force_clkreq_0 = false;
+	else
+		option->force_clkreq_0 = true;
 }
 
 static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 {
+	struct rtsx_cr_option *option = &pcr->option;
 
 	rtsx_pci_write_register(pcr, RTS5228_AUTOLOAD_CFG1,
 			CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
@@ -469,6 +476,17 @@ static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 	else
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
 	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 
 	if (pcr->rtd3_en) {
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 47ab72a43256..91d240dd68fa 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -327,11 +327,12 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
 		}
 	}
 
+
 	/*
 	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
 	 * to drive low, and we forcibly request clock.
 	 */
-	if (option->force_clkreq_0 && pcr->aspm_mode == ASPM_MODE_CFG)
+	if (option->force_clkreq_0)
 		rtsx_pci_write_register(pcr, PETXCFG,
 			FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 79b18f6f73a8..9b42b20a3e5a 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -517,10 +517,17 @@ static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 			option->ltr_enabled = false;
 		}
 	}
+
+	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
+		option->force_clkreq_0 = false;
+	else
+		option->force_clkreq_0 = true;
 }
 
 static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 {
+	struct rtsx_cr_option *option = &pcr->option;
 
 	/* Set mcu_cnt to 7 to ensure data can be sampled properly */
 	rtsx_pci_write_register(pcr, 0xFC03, 0x7F, 0x07);
@@ -539,6 +546,17 @@ static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 
 	rts5260_init_hw(pcr);
 
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 
 	return 0;
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 94af6bf8a25a..b1e76030cafd 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -498,10 +498,17 @@ static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 			option->ltr_enabled = false;
 		}
 	}
+
+	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
+		option->force_clkreq_0 = false;
+	else
+		option->force_clkreq_0 = true;
 }
 
 static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 {
+	struct rtsx_cr_option *option = &pcr->option;
 	u32 val;
 
 	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG1,
@@ -547,6 +554,17 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 	else
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
 	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 
 	if (pcr->rtd3_en) {
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index a3f4b52bb159..32b7783e9d4f 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1326,11 +1326,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 			return err;
 	}
 
-	if (pcr->aspm_mode == ASPM_MODE_REG) {
+	if (pcr->aspm_mode == ASPM_MODE_REG)
 		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
-		rtsx_pci_write_register(pcr, PETXCFG,
-				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
-	}
 
 	/* No CD interrupt if probing driver with card inserted.
 	 * So we need to initialize pcr->card_exist here.
-- 
2.42.0


