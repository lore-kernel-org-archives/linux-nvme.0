Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959E5D5B861
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 02:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EU0m18qlbYPwqYfA+DIm9Rsw5kNqo31NH8il36rID1c=; b=qauRCzHJ+TfXP4Mrl+Dsr+IQif
	uiBUQCtRVKv5wbsF4p9/g2U48E1CcglRfbbqLI6tphMXZQrUsPjPjNWgWW8+WDlqM/sLgCQlnLVmK
	J/RGrsymLJWU4PAaBO+PuFimcXScDTzOPi0RtzcWwRukcwBijSdQ3t5xE7xdXZBVu0k5AZklFxKnI
	LgSl20HtwUWjVGpfu7hy7V5GABLeZNUv50qdQi/iUP+Tf4EHfQE/6Yx8sgp40cyJ051oWdiHviLSH
	ShUsr0e33bqtsQA+YeD8QPR3a1sjKDbfu01wyxaX/WwZUNK3XqWyy5b7CTggM0+5QXI3R9ABB5LUY
	9L9qevew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5cDv-0000000D0cc-31Gk;
	Tue, 29 Oct 2024 02:44:47 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5cBz-0000000D0Ft-0GYm
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 02:42:48 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-20cd76c513cso45244685ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2024 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730169765; x=1730774565; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU0m18qlbYPwqYfA+DIm9Rsw5kNqo31NH8il36rID1c=;
        b=SlXAYkVokYR3ye/zozvBXudN0NsPmuwyHgjvYWvr7bU1Z6OkQ6okjEUXC1gxLJ9dIa
         lb1VW0Dq69GxNpeVwlNFuG87BzjzF/mICz6BA/ZJgr74ZbKrKtTRknNwY6CP5q7S3Zjb
         gS3paoww3+VZPWr9iJ6EdspB9tSFnrB0R+ZSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730169765; x=1730774565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EU0m18qlbYPwqYfA+DIm9Rsw5kNqo31NH8il36rID1c=;
        b=KB4vvhyr+8ryvvFD+pZRK1bYFzDE+qRfqZAMo+AHcQDQ5FVIuJOqKKZ8CbxbklZ47w
         ZFZ/B4oBsi6dc+xCr9ktKrJg6OhYqZgh0J452bttpwKBPjHyO7kNwaQ5iAy1YtEQ5mBW
         fVK+seoQ2Ocbk4BWTVAKyIOrw3B2g+OoEkg56L+btcM0TdFVQcIKosOnbysH+t3zUq6X
         14rcFPoK9oQpbIL7tHwwvw64ZTbMY6o55K7zxKJDX5lvI73m3oRNUU4AhtVOM7xdHSHy
         HtU8woNSQGv/bPyB2ZnsB4IZLaideAzbzGNAYrGe3wiWLW7gwrDRv3IoSoec9V1Fseru
         y1VA==
X-Forwarded-Encrypted: i=1; AJvYcCVL93zmfMWnqXjVxuGUQSFEvQjWkqZmuNhsMLhU/yxDeQfS+vltFTS4GmCb5dpPm1xD4TvYpqqJqAq1@lists.infradead.org
X-Gm-Message-State: AOJu0Yyb2KT51lITEf21FPwztKTkUlICM3rPXju1+BUIpm4z4DJIzjV0
	8G7bqYXsv5Mmfj+oWe2tV/tS604xZn6E3ewEYpPWE6+YJVwpT23EfLcvkYv/1Q==
X-Google-Smtp-Source: AGHT+IHT+dld7klfyYLy6A9hBhkDuS07vpgyWFV5LZFb7JFYIdXzbJyScSCZU4fj8F1tmYMj/GtyeA==
X-Received: by 2002:a17:902:d48e:b0:20e:5777:1b83 with SMTP id d9443c01a7336-210c6c011b6mr139172565ad.24.1730169765434;
        Mon, 28 Oct 2024 19:42:45 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:6e49:6193:843d:22c2])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-210bc0489e4sm56506135ad.236.2024.10.28.19.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 19:42:44 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: bob.beckett@collabora.com
Cc: hch@lst.de,
	kbusch@kernel.org,
	kbusch@meta.com,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	Gwendal Grignou <gwendal@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Date: Mon, 28 Oct 2024 19:42:36 -0700
Message-ID: <20241029024236.2702721-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_194247_152161_2428E98E 
X-CRM114-Status: GOOD (  12.58  )
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

PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
is a NMVe to eMMC bridge, that can be used with different eMMC
memory devices.
The NVMe device name contains the eMMC device name, for instance:
`BAYHUB SanDisk-DA4128-91904055-128GB`

The bridge is known to work with many eMMC devices, we need to limit
the queue depth once we know which eMMC device is behind the bridge.

Fixes: commit 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")

Cc: stable@vger.kernel.org
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/nvme/host/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a3..1c908e129fddf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3448,8 +3448,6 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
-		.driver_data = NVME_QUIRK_QDEPTH_ONE },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.47.0.163.g1226f6d8fa-goog


