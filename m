Return-Path: <SRS0=8MmT=XS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16E2C4CECF
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2019 18:23:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84695206C2
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2019 18:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WM8BIhxh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHnglSaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84695206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=M5Gx+YWLcVSKqfID7+fV43hXSNeCrfUYNS1PWIwop1E=; b=WM8BIhxho7Ufai
	9ZKggEGKNSOqI6A+Oo0RNQQDB/fu8pc7a4zXPVTbqf1mOOy16PvIuyveXnven24uYsWdLVv3+ATEO
	Fo/BiWbXE99n/M70c1Yw43w7c2gE/jtMjYRKESQlxRNTf/iCK/1XRYTia/+k3GDKQT8YI9RKVtq1g
	xgZ8m0RFj2m0NbWEa8mrkncbjQHOBzyMPSkqoAssYe9N+o9pKjMjW4vo/lmWuwMFFvzGFNqzxCx6k
	g0H2cY9/b6tagSuBtUe8XUhtkQ30SQ6RR3v4qtqnjlB2kxnogy4QEf58sGup/Mtj0WDsCsFaKCe4J
	jHExLNg9uLo7qIyL4U1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCSzg-0000Lx-4h; Mon, 23 Sep 2019 18:23:28 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCSzd-0000L0-Dq
 for linux-nvme@lists.infradead.org; Mon, 23 Sep 2019 18:23:26 +0000
Received: by mail-wm1-x344.google.com with SMTP id y135so15624791wmc.1
 for <linux-nvme@lists.infradead.org>; Mon, 23 Sep 2019 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ayq0p6X/ErZzs4hinfPpnJipMcpKRV6Xdv93NSXWlhw=;
 b=UHnglSaR5xTYUh6u8PEkTLlPY47tCqYiYn4IHYLGLfS8EY8PsHRrH1CDJnrBYJNtur
 +IZRL1mZKrYDs711H3Y/Vtua56wYSwd2EjDpCC//WFL+n7uIAANJ6Ub5LpdiCRzOFNig
 lG+VERRbz2/3QhvhyR27nT476KTplwKHDDdVWnjg3u+OBhTCidjyP6TAcYMpaATWuNA5
 4FjPOyghNJE2MjBSH9VJqvViszHpQaGXDDgVKQm2tncsdLXNTXHeGh4SAQd1N6emzwKN
 BtCWuRgyw13oz6tafpa0c5B38Kjvc2UCMXKSQB/0bMMdPSCXViiF78bJ8X+C92ZAlMRf
 3Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ayq0p6X/ErZzs4hinfPpnJipMcpKRV6Xdv93NSXWlhw=;
 b=j9D2dibQPV18U55A9Sy69dItU2iyXQrGMG+pUo90D9AEsIkVlCp3442WN22MRjcech
 kkS2MvyNGYdBNzN/Rw7RKZRCtd3cFh8pXAECGG62A0mg0RaMc3DjwEv0uKJzsb8dHuu+
 1HCFg/k2K71azAAVGRkBaydFRnubaWwnaR6G6tVz/wM6Vsa8tl6Z3xjnqtNpyt9/swBq
 69y19bqffiFiP47YVERhD9L/tRwfozthmAszc/hgZiQY8eIRC22bVPrD4h3kxwos7qZY
 RZb9Wy5LgMN/FSOErsJHI03CandgUz3885q36lGVyzaW8nSm2FRLT+lukm9uGfZGl6Bu
 P2LA==
X-Gm-Message-State: APjAAAUxF9GRlLiTfX+Q4ba/zKQ03EHYYT5NkabP/W+FqAa1o2iKaeWS
 ChwPS3FAA0ILHRjx7KhWcN29X+ualg==
X-Google-Smtp-Source: APXvYqySSJxjMUbOQGW9MPHwsn7DPJhlEiwLZfauDT+NUFbYPOv7XvnZQ1fV3xvzKy9bXOXmp09Ycw==
X-Received: by 2002:a1c:a90b:: with SMTP id s11mr778134wme.92.1569263003383;
 Mon, 23 Sep 2019 11:23:23 -0700 (PDT)
Received: from nitro5.fritz.box (business-24-134-37-65.pool2.vodafone-ip.de.
 [24.134.37.65])
 by smtp.gmail.com with ESMTPSA id t123sm15679861wma.40.2019.09.23.11.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 11:23:22 -0700 (PDT)
From: Gabriel Craciunescu <nix.or.die@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v3] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
Date: Mon, 23 Sep 2019 20:22:56 +0200
Message-Id: <20190923182256.11062-1-nix.or.die@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190923_112325_469011_C9F4D025 
X-CRM114-Status: GOOD (  10.72  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, crazy@frugalware.org, linux-kernel@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Booting with default_ps_max_latency_us >6000 makes the device fail.
Also SUBNQN is NULL and gives a warning on each boot/resume.
 $ nvme id-ctrl /dev/nvme0 | grep ^subnqn
   subnqn    : (null)

I use this device with an Acer Nitro 5 (AN515-43-R8BF) Laptop.
To be sure is not a Laptop issue only, I tested the device on
my server board  with the same results.
( with 2x,4x link on the board and 4x link on a PCI-E card ).

Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6b4d7b064b38..f5767741838b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3088,6 +3088,9 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.23.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
