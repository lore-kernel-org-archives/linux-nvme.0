Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10846C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zDhUBb7n4i/zjscinLcxbX9vyxcNyXV4VmsLqe1lsoo=; b=z7XnTcPOSdc//i
	D8CbpoAfXehReP0fFDCK6qtKgCDJba0LvzSXfMYbJu+Hsi+Vm5XwSe6QloJeNuM+Db1dCC+Nf1oBP
	qB6TR52h2IPcObbtqtB6oWB32548ZYduqA/mD6kGDUKd7HFpjNwYkFG1/bGs9RZQb3Q21RkNR4Jcd
	qMBt3MTFaZrGqRBpKSfvNxhxefqcf8ErjocbM6gpTvTee+JE0PEV6tE/12kud+y4Igs9X0ai54zdk
	Vctw4ut5q19O0jl73RNpPQrsqxzaFn7DaNlBuc7k3/lbmW4eGJWcdwXw7q1Qp6DrKi3hv8Yqt9nyT
	coBiuusix2hALVXqJoQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1pKV-00000001BTG-0wB1;
	Mon, 07 Apr 2025 16:28:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ndM-00000000lsg-1xHu
	for linux-nvme@bombadil.infradead.org;
	Mon, 07 Apr 2025 14:39:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zDhUBb7n4i/zjscinLcxbX9vyxcNyXV4VmsLqe1lsoo=; b=IbYI6FSzq4ezPeEcu4XIhjgWIj
	Xj3l7HkkSjPjyH0JH5cePc0KqVeg0AwEewxX5tcx7OfQMZQ/z3MUwwn0C6sfxIOlLDmpc9/upb1ns
	aCfomrMd4VhmTlWTb/AT77hIuuntkDz0tWc5u44JQq1XiSSkQsAM3TDxb2dOz1nfctvCXFha6CA9C
	nkgeI9vmkiI38I+3ob42WqCIopkTUXzE3IwDJeUhVko6ZrD6PkMKDFt0EPrVOdb8bXzuoxZyamS4D
	DmYyhxhyFTmJ1duy5SjBtPa+6VG0v9ymDIFX6dU3c76L2VelmIDiaaLVaTE9km8cm/9hrCuOier1O
	AjICTrXQ==;
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ndJ-00000007zWc-032G
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 14:39:31 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-43edb40f357so20873605e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Apr 2025 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744036766; x=1744641566; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zDhUBb7n4i/zjscinLcxbX9vyxcNyXV4VmsLqe1lsoo=;
        b=GwxrLoSQbC2o3AGd3qRcvUHiWi1HNN9FF0FEapMVKxsjVTDMsSCsMKmKDHdN8PN0Et
         wEEWuPlTcZUEiBCu8BDScxesVo0Yg+SCCszRcjxRxBPE7OlmbcCTjCcI+8a6sLtnS2PY
         tKfcMphnNIq40GbB8a7/YRlEQy4+0x2lN6Bsycdj5ZG4JeWtr4kgAI7RrMclUrZcYEsx
         /luqejs09CuafBuP923m8AngAZO2jl9zoMcsZpY9TWtZH70nF64FFRGUNFkglHZfxj2k
         ZOQzERaJw4Srh7gkLXF8pyZy/jAGKFL4YaKcmoYV9BWw1bbEaD3PCJKHlYDs/z2hff4K
         9GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036766; x=1744641566;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDhUBb7n4i/zjscinLcxbX9vyxcNyXV4VmsLqe1lsoo=;
        b=srbAMfHtt6AsZHHhiCDpzd0UjLFY+ZxuOdmnSEfuW2d/ha2vk2HOhkjoKlk5gSIkLq
         CzpV/8P4ISfU0AlqjFD/2mzoKVSGy/4I2t1ILnHD0N+rmIcAFYairq3ym82oevCE21Ci
         j5FNXJszoAEWbXoYzvwoElMuwrGwgA5BnmO1oRTnv6JTcrp2jfG+iageHAfkva4ecl9X
         RMFPOjqGtV9wv7lb9RJe/JE5UUX3dy4aRyPFZsOI4oLiIf0znetUZHRnVi0/8/bjMvFN
         PB62EOUZPpy7LERJkRsKscAtUHx3pcS8qeDMw0WoL3Goh7IJWmRgbeFxdio+AYDkAcei
         +03Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqgjzBuJ0wJf/zYLLZxXrY+dj6//SrpQ0YVdubTc2FeY7x0AkD8zsMmeIHlXiUTXuPUVxp8zsIOFTo@lists.infradead.org
X-Gm-Message-State: AOJu0YwbNYQ1vMMLGnHrt+Y9PZaOV7uek0lnLVcBOexyrPVQ/RHG7JDO
	Da41Db3MooHjIC5IY3LfTwYDKpXuGG0339j6kT2vn2qkmFUbPTyfyLPvN7Y6RTA=
X-Gm-Gg: ASbGncslF95PwTVsaFoLGMe3eWHOfJSUcu5AbSVCUnXt0Anl9PZf7gXslKPo3Hfp/HC
	tV5S9ZTMse/orEn/Hw8YHmIOL/oLCS4ns3A1At4qhmX/1+mYMmqiTl15rXkBeR+HcrvpWQ3kWXr
	4qldsvNgA+dlerFamXtlhMrp0CEq7j/U7t8Y7pKhI7eHexvR4YsdCn2CDKTNUpmkhvVyyYr66Dx
	7WAg77czCNbnHIT97X9R/IfhW0lK3DBKE/0XF0Ifg2XJaO5NbkPezc0w/MT8cWy22K0Ws+mo/+Q
	36XtO2cfODDr11mk84zJNl3pzmK7pocFobtcdjRSsQYb5WB6E0gHi5d0lw8=
X-Google-Smtp-Source: AGHT+IGo0Uhr29cvTsRS3LxyOzKKN2ODb8nALSSx+D+EwmUMgG7tIeki4Sbg0p2SXiRhZCiImjf7MA==
X-Received: by 2002:a05:600c:524f:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43ee06ab14amr77347205e9.19.1744036766119;
        Mon, 07 Apr 2025 07:39:26 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:1122:cb29:d776:d906])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec16602bbsm135003705e9.9.2025.04.07.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:39:25 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 0/3] PCI: endpoint: space allocation fixups
Date: Mon, 07 Apr 2025 16:39:06 +0200
Message-Id: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIrj82cC/4XNQQqDMBCF4atI1p0So6Gxq96jdJHEUQc0SiKhV
 rx7o5tCoXT5P5hvVhbQEwZ2zVbmMVKg0aUoThmznXYtAtWpmeBC8kIomCwBThDohaB7at2Aboa
 qVtIIZRSXnKXbyWNDz8O9P1J3FObRL8ebmO/rPzHmwAFRmosyudSVvhm99GQ8nu04sB2N4gOVv
 PwFiQTZQvPalLax8vIFbdv2BrNE4pkGAQAA
X-Change-ID: 20250328-pci-ep-size-alignment-9d85b28b8050
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=ogQNcCu8YxT+9o47hJnNjydZZvfGLWbCXP72er2tm7Y=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8+OZHbkA5zUijOC1Lyem6hVLcbAobdwSqz5Ry
 4vtiY/xbzCJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/PjmQAKCRDm/A8cN/La
 hYLrD/90dg5PKRwz8YLHDCaM7Vq3WVq4SIxJCfhO1ZtER7+uHYYRkbooqqZ+UrW017Or3od1xQa
 yCkeURyi1REiYqr6TxlMlG1lfST2grvdD3Xvy25bCN7ooV7ljuZTb9PpWlFDdSh/zTcapGA3HyH
 nrhBlsnoRlTzVbgsaUXnOCPJkBma1OXjxPKPvccqxKcUYUPrQEExKlTlG6RU4otW3/xiS+kwXyI
 EpsA2FckSNHcLvDREnS3NayTyn5lGsbC4KyCRnekHn1HK30MZnarf7+sQX1foxD7K0LqA1ASRhs
 xy2vzOae7BRGOvnFScpZtpDiYEcCVcSQBuhDIXimPFLxvN18UBq1w7tfw4WNd3lzkrcsukUta42
 fHma6it0bX1PnIX32+TcPMZIK8WuHATrIjqFBfsQJxSTZBxxWTEIQROzgMhbJCe0PYfaBzWSpCJ
 DxsWvvx97spixLpnSFgbO24aFXZKcd0AzQ8ZpYPLK2kicpC/8sDO6MzwAmSu9TLENZI50DQROtH
 IA4ZS94r/7tr6hOoikclE+ISSP2JK5029ZltBiMh9FdJlcGtEobu/7VZG4wYaKTASXFSXKE8qj6
 T/Z7baToAeb5lWbVXYyyjf2tCLLabejWhGSGmsIh8jtWmG6wt7QkR2H/4F79ewvO122I/MbBuBx
 /pBoV7hfw/sCr3Q==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_153929_458450_A2A3EB3E 
X-CRM114-Status: GOOD (  13.36  )
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

This patchset fixes problems while trying to allocate space for PCI
endpoint function.

The problems, and related fixups, have been found while trying to link two
renesas rcar-gen4 r8a779f0-spider devices with the vNTB endpoint
function. This platform has 2 configurable BAR0 and BAR2, with an alignment
of 1MB, and fairly small fixed BAR4 of 256B.

This was tested with
 * BAR0 (1MB):  CTRL+SPAD
 * BAR2 (1MB):  MW0
 * BAR4 (256B): Doorbell

This setup is currently not supported by the vNTB EP driver and requires a
small hack. I'm working on that too.

Changes in v3:
- Rebased on v6.15-rc1
- Fix build issue with newly introduced nvme endpoint function
- Link to v2: https://lore.kernel.org/r/20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com

Changes in v2:
- Allocate space that match the iATU alignment requirement, as previously
  done.
- Chose not to add a new member in struct pci_epf_bar, as initially
  discussed. After reworking the code, that did not seem necessary.
- Make sure SPAD registers are 4 bytes aligned in the vNTB endpoint function
- Link to v1: https://lore.kernel.org/r/20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (3):
      PCI: endpoint: add epc_feature argument for pci_epf_free_space()
      PCI: endpoint: improve fixed_size bar handling when allocating space
      PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space allocation

 drivers/nvme/target/pci-epf.c                 |  3 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  3 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 ++
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 42 ++++++++++-----------------
 drivers/pci/endpoint/pci-epf-core.c           | 27 ++++++++++++-----
 include/linux/pci-epf.h                       |  1 +
 6 files changed, 42 insertions(+), 36 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250328-pci-ep-size-alignment-9d85b28b8050

Best regards,
-- 
Jerome


