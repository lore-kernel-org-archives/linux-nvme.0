Return-Path: <SRS0=6Jtf=X4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA9CC10F14
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 11:57:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128D4218DE
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 11:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qYsI/rpv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZqhZ/Rdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128D4218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=E775U4A+SZgeRDo110qlMDWpdPjMiSM/NpW1w3YhMcY=; b=qYsI/rpvIpedzi
	dHdahY1yo3A1fCmUrrb1Qg34RKNRQGWuOOG+QEEF8m30rhEGj9hZfyatolsZZxOZUXccyzP4YyyRc
	1jMggrnz2ide0IswqN9qTcG4BacwDZBPEnIfazUocrzrqgL3IjDqoTjdOkgrbKEr+0F8JcZ4qCz+E
	1T6yLTVvx/zNRclE7PRV2x8NqtROPKEtf7kDjGr7uY4PMMFdKPZKrYnLepV+3KLpIxvfL5OhpDkmd
	4c8mJNpnZJacPfoJPLfiulIGrmtCqigMnnP9Vkj0xcSiMaCIDnI9+Rt1jp/oZurTtuGaE4pQ8t8Xa
	gSf9zy8q/g7gxw5qVX4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFzjo-000270-Ct; Thu, 03 Oct 2019 11:57:40 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFzjk-00025k-TU
 for linux-nvme@lists.infradead.org; Thu, 03 Oct 2019 11:57:38 +0000
Received: by mail-wr1-x442.google.com with SMTP id n14so2589688wrw.9
 for <linux-nvme@lists.infradead.org>; Thu, 03 Oct 2019 04:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6h2JbzxyQKFhqauZlBHEe12iBQntYE0S9rhBoyOjPKA=;
 b=ZqhZ/RddigVdKsKr4axU5LUFeux+2xDNe3KiX0pjQiqeCdUxLQs94E5b4jBSoj3DCw
 9qDH3p2myltaBTNE9DXlnJq0CeiQa5BBtKuj3e6J5ZkumGmBHViTdCRtO6QcUNMnDewU
 ng67JH7ItyFg1579dnhYLsWw75gnwVqAdf0I1ixc+Pt1AoQyr/EI/Lvjq/kWHjPe9zKw
 67lIfiksz6/jbwTzU0YTQlKGVBiWMsIZs0HXT0K0xzZ4vwsy1oMvBZeXHx47iX6IBu+g
 wsiuzKQpyxrOrUdrRz6YiwmmpZ0NZNsCDE6JovqVGOErWVk/Bj9yadHRsASWEWzOAJ6P
 c+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6h2JbzxyQKFhqauZlBHEe12iBQntYE0S9rhBoyOjPKA=;
 b=rvXLgZoR0p00tOEVb+gfmVbnrw7hEy5AiXAoCxf/Z7eNP+2yhRTBkRA/klzAlgv60j
 fpK8YN9YZKK/MPQQRs8d5CWoETWpPoY+gEX7T+82mIfi9RRv+WJ1j7IRwpjSFRloOuiE
 pUNRvxMSjcUVDMJ4ZrjSapR5D/WP/swxUwvJXksQs7g8o+SsMYfSOaV7B5baV8Q85OUl
 u7Sa0RLC7VrxPdM2CHbGjNaLTJcXIvFGDC/QwUnILUJhRmcJIby77LK88XzMcEhuH2MB
 Jd7L82vejuhE2khR4ae1PhZHKwrR7mP2/EMHU7C+DPDABkydAcSk7WJqQluMekCh4iJV
 H7ww==
X-Gm-Message-State: APjAAAWnrvZ2bUCsDLEQTJ+4dFxDzHuZAnZLzIncgmpx5K4id/ghmsd4
 5U7Iz48DgfTX/LVjv/0l4Pmq9HkyebjN3dg9
X-Google-Smtp-Source: APXvYqxRDpo1RGPhQ3TQxVOk9FhKlxuMHZU/RPv/sonjHMve6sxGPBcRwGPaFiu0r/Wji5+3c4QNWw==
X-Received: by 2002:adf:f18e:: with SMTP id h14mr7040186wro.143.1570103853325; 
 Thu, 03 Oct 2019 04:57:33 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:9527:da56:7d2e:43f3])
 by smtp.gmail.com with ESMTPSA id w7sm3254160wmd.22.2019.10.03.04.57.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Oct 2019 04:57:32 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme: retain split access workaround for capability reads
Date: Thu,  3 Oct 2019 13:57:29 +0200
Message-Id: <20191003115729.8988-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191003_045736_955569_0E90F7A8 
X-CRM114-Status: GOOD (  14.97  )
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
Cc: sagi@grimberg.me, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 ilias.apalodimas@linaro.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Commit 7fd8930f26be4

  "nvme: add a common helper to read Identify Controller data"

has re-introduced an issue that we have attempted to work around in the
past, in commit a310acd7a7ea ("NVMe: use split lo_hi_{read,write}q").

The problem is that some PCIe NVMe controllers do not implement 64-bit
outbound accesses correctly, which is why the commit above switched
to using lo_hi_[read|write]q for all 64-bit BAR accesses occuring in
the code.

In the mean time, the NVMe subsystem has been refactored, and now calls
into the PCIe support layer for NVMe via a .reg_read64() method, which
fails to use lo_hi_readq(), and thus reintroduces the problem that the
workaround above aimed to address.

Given that, at the moment, .reg_read64() is only used to read the
capability register [which is known to tolerate split reads], let's
switch .reg_read64() to lo_hi_readq() as well.

This fixes a boot issue on some ARM boxes with NVMe behind a Synopsys
DesignWare PCIe host controller.

Fixes: 7fd8930f26be4 ("nvme: add a common helper to read Identify Controller data")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2: drop WARN_ON(), add reference to commit that [re-]introduced the issue

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c0808f9eb8ab..ee7ce7696a88 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2672,7 +2672,7 @@ static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 
 static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
-	*val = readq(to_nvme_dev(ctrl)->bar + off);
+	*val = lo_hi_readq(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
