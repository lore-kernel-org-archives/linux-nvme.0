Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA28CC369D1
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 08:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C8tGWCdB1F+2LTmhAkX22ynJIxbqoFIVMbky72nwvho=; b=xxjx54+5x5SK4E
	Tt+CuBfIXftNBuOhQHhmWZ0FlhKIIfT2cbdQll5T06DhbO5zEsNn2YiBXa9iyh/LFelOuEo/0nInY
	9nbvsFqVL/FwF+GzrmrU1rcLavo2yelxEppqyiujKFrLq/b7+OiwUmH0Jam2IiIBe0LQL7aI8FjMC
	F+JKSn7EOqVBZmQbGGUrNhCLF4tSZRnZES6WkLGLrSXl3EY7yuMZOwTRV9L6HiT/5g3GdGD5sIvyW
	KHratbZykxhFAAL9BQmd+v2nXoUaoVJQGiDvk4FhXAoq/bxO033U7yobT1oLnLG/xWuQTxHemAMSM
	Wv0NjAyy5YgtZSVfT8qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7s55-0000000DLSS-1uTM;
	Thu, 24 Apr 2025 08:37:15 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7s2L-0000000DKuR-25Ib
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 08:34:28 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-39129fc51f8so556049f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 01:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745483663; x=1746088463; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8tGWCdB1F+2LTmhAkX22ynJIxbqoFIVMbky72nwvho=;
        b=EdCbhRa1rrTiLlqpVTK57+qZvn/Pqvkofuw9f4eQ3hoowY/bEGXjhV8qGelhUCrFIj
         npmk/gL3uSnx/IG2/IsnA7B7yAi4BLnJzcYi36BUEwIvMnRciStQpECJPiLzC6JjanVx
         5SF1AnY+K6ZBAa+oTvgxbW18fQAweEXVxJueAaO079ipjxSaUwC7JYw4tGEbazA2QrCv
         GAwD2BH1FC+5QaWWavBBWu4qxxqgRGfw0PlwRuXZDSSJfB+3p+WhU9iI4Uq2Xl2OjMBo
         4HmsX8nRH65X2s+hkA/LLhvAAQkAIQQioMq+Qq3T16l7fqaYr554diAaeby02me8aVci
         zfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483663; x=1746088463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8tGWCdB1F+2LTmhAkX22ynJIxbqoFIVMbky72nwvho=;
        b=nzjqOcu7tlFFMke2gjHgd7MCb53SN+EUIipvDRUEgMQTHWqAIHq1gCtiOMdNXS5JOV
         ofOvLvZnYAdH9sdQxYSps13wCjHwdyg5Ey65AlMWC8KPkyn1QeNID1jZR19RB1hSI356
         Ml8GS74gJDKYoYnjedVMGfe5gHXGU1Oy71fM43H3LksL4I+zGxnGtIYFFj/IziaI1Cs1
         YIpciYGh61JEE0sDmXIDboDsqRi7kIJg8Dqs1rrOUzJzhrnvwvGwTbT/lD2iO91h6zB/
         uJ0/8bAiD8WgxQVIHhdn+2FWlvcT2yXE29mQw0MtJz9POiEFvUp8v1Pmayj8ji0UgfIC
         D93g==
X-Forwarded-Encrypted: i=1; AJvYcCWIoKGPJf5FSV0MzJu2BEYvMXqjt3qvv86GgfcwSjB5CXi5dn/ronfF1+QZdlOIU76LMlQp37Sz1c37@lists.infradead.org
X-Gm-Message-State: AOJu0YyEP7asbbNAAnhpvLqw56EQlhMoCgJ7b0f0u1MTznY73ZSzU+Um
	nLVUEukcD7Hn0gVy0otuyTHG3k8450/hzi7QvVzfzFzYQEABdUcKd3LgYvQh6dE=
X-Gm-Gg: ASbGncvpltbXMLV34saJBKnlOTonKkDhzg9pouybWPEk1PuXW7YirqkIKOD84dLxodO
	ZRbj6JzL+m3m1donbYEEyyi5TH1Eqt7f2QLtZGsLAQnCx1oELPDZ2J3aCoX7IJSi9kCy1N4UVT2
	XN2JLKAzb8FmOVOpDfvNF/eZw3SZ6l0y1bI0ubqk3vr8nx+9f+YS9syBdP41RW/WrnUux0NneGE
	1eVu/90C4B8CsNpKvjEdzAj2FOcVIFk1BZeQAOCQdksus+G0dOUCc+PE8EAdywQkkDRZDBPkKDx
	CDcHY2BIa8kSkdFTAJdC6uIWGbQrzX0M3HIZfXAO71OEPfO9OLVp6A==
X-Google-Smtp-Source: AGHT+IFVQQq6l1DulQrKW6deJu7Kbn7RZmVVR447idMPpE+uOzGwM7yCKCZrv8fEuvw9xqkYlMZ8QA==
X-Received: by 2002:a5d:5f87:0:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-3a06cfa3157mr1117016f8f.42.1745483663218;
        Thu, 24 Apr 2025 01:34:23 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f74:6a9a:365b:4453])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a06d4c6c56sm1323881f8f.60.2025.04.24.01.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:34:22 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v5 0/2] PCI: endpoint: space allocation fixups
Date: Thu, 24 Apr 2025 10:34:03 +0200
Message-Id: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHv3CWgC/4XNTQrCMBCG4atI1kbSJNNOXXkPcZGkUx3QtiRS/
 KF3N7pRxOLy/WCeuYtEkSmJ9eIuIo2cuO9ywHIhwsF1e5Lc5BZaaVBGoxwCSxpk4htJd+R9d6L
 uLOsGwWv0qECJfDtEavnycre73AdO5z5eX2/G4rn+E8dCKkkEvkJfgKvdxrvrkX2kVehP4omO+
 g1ZZecgnaFgnGq8DW2A6gdkPqFqDjIZwhKwQioxBPwB2Q9I6znIZqj0DaC1piWqv6Bpmh57SL2
 9mAEAAA==
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
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Niklas Cassel <cassel@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=fyPcyt5tsx33zLc81Kw1P3Mee50TZQ013vRkVqNuYWA=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoCfeLltdBGrihKLgdra13UYvpXsgJ+UUry4H7F
 Hc94NUoWA+JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAn3iwAKCRDm/A8cN/La
 hfXLD/91NjpsftPFNZcFoUD/luoLQAcGz3A2OFoThdNs3G2BGT3FZhX/f2aXzeLQjeaxdBngIdi
 2GmeLpbiNqTW8mQtRAIxJdIZNzDS7igdAXLbIz+bJON8TIZ4FjZmBkrzfPzWONU/MNnRy1uMgZD
 Vs0X0Q7yXaXq/u6PY3+b3Xh3JW9FyPr2SNevGbok3WHdty4dY0HAneF6qfaXp+91puUgQgwHa9Z
 f//y8K5tghzW6O4EEEecu+Baf1odyBbPBOK9YlAsshznXqRwm+I1TTGoO5Fyfg9solmmtONAItW
 1D3jiJlEQFdv06qPSWKFR23skq89u9HM6Df4oCc39QNVOA67l47Lzu7nDcaUfRjafa/VjGa4RkP
 mmm5bSFBwRgMKdRyt7FZa4PuQ0jc7EOXEJrrAXPLCbUth21t2A9QRGPkcb1uCwPeI36zikqFEMX
 zL10wNPQPlE9wxhNMzQw8QOBUVejrkSH2OkH3yVIkuB9aDtdOZ3/Vfl4c/4X8wSrE6h7MBhD9Xt
 4RMptgpbYbZJ2s1r85CBzIjDWwKJHwAtkByOEN91LJWTmom+Jy/cYrDX0R8N1H8i0P7twDDxy4S
 4gjxf2M8EvX/SDppQ8oC99pU6gv8vgzELc+rmoxja7Ht3OKxjT80Cf0eKdCP1Q6fplqbIBqgzs8
 bovfcXTnwJwwypA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_013425_816268_EBDCAA00 
X-CRM114-Status: GOOD (  13.86  )
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

Changes in v5:
- Collect Reviewed-by trailer
- Fix nit full stop comment
- Link to v4: https://lore.kernel.org/r/20250422-pci-ep-size-alignment-v4-0-6bd58443fee9@baylibre.com

Changes in v4:
- Drop patch 1 of v3 and add new .aligned_size in struct pci_epf_bar
  instead re-computing the aligned size on the path freeing the memory
- Link to v3: https://lore.kernel.org/r/20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com

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
Jerome Brunet (2):
      PCI: endpoint: improve fixed_size bar handling when allocating space
      PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space allocation

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 26 +++-----------------------
 drivers/pci/endpoint/pci-epf-core.c           | 21 ++++++++++++++-------
 include/linux/pci-epf.h                       |  3 +++
 3 files changed, 20 insertions(+), 30 deletions(-)
---
base-commit: 92713f0ea620bbe923eb4e7bda408e5c79597cd4
change-id: 20250328-pci-ep-size-alignment-9d85b28b8050

Best regards,
-- 
Jerome


