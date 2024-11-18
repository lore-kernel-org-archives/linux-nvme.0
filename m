Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF1AD43FED
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SCbk4TlfvzPjOdLFFqTGjXfKYNxdwV9cR55qDByjVYA=; b=pe1aIJuDNXCM7zy3lW3NHqcRHF
	/cWiR+D+vEjDb6Y+pMbpBws2mfL83qQfyZY5A0pdbK2dGlVm7PfesKkKwR5V2zKqjdVs3Y+PcRDJf
	jnZ+K3D5qkVtkBmyBZNtANh9dWpJg/xmnHsov0/uplhoNgXyLf74hgdyIjLdjmGGoaInywiTAl/wY
	B4T/7tSkBlpUnfkqiD94pJspJDpMD5VriwfYa1mkvo7jQWzglalUKj2TLwtq3LSBPLwIYAB56Ok7l
	3Q4YvaQXZXrDXx9gPbA4O9fDojKilCDj10W9CuICEqQ225VmJ7aEzpI8P/rZGp9iptr0zieYgF8nI
	FjP1MoQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tCx39-00000008lC6-3K0Z;
	Mon, 18 Nov 2024 08:23:59 +0000
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tCx37-00000008lB9-0FCL
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 08:23:58 +0000
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-71a9a02b499so253567a34.1
        for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 00:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731918235; x=1732523035; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCbk4TlfvzPjOdLFFqTGjXfKYNxdwV9cR55qDByjVYA=;
        b=gJ8IXRJX2idu7YwuFbAKjN8xXjyu+7E52IbdMTJokfBmnoOtILlv+CoMcRQe+R5OAP
         CKKMeAxi5GgVH0BcNASZ1KBcns/TGoJVbKVkLDnOZa9LOAXeQ1nKq6l46ykrj/ihjQkB
         zbk2JIvUx0pBqBwab8oa/90VaPjjabi9QMc/b6j2+4ZhsqUCeTIFVzYVYHiNEi8aPhJf
         k1KnsF9dVVLPg40EskicgMxYP9NDWOnsdl4TPOlBOX39qXW5+gve8KhtaYSBR0iU8Mqt
         WA1m3d6Y71abbucZAkChvbNopyBRY0rmIPg7lJvvET3AFTHYgNyE45w5ZXGGT+5E2mfN
         Qj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731918235; x=1732523035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCbk4TlfvzPjOdLFFqTGjXfKYNxdwV9cR55qDByjVYA=;
        b=ITs6i7P/lKgfUCP3tadXEGyeY1H9b4H9u6Q9r9pQbRinsNxdrzn5i3CePGmxl6PPh7
         I3cHwe+M+43cqb8Msjc/uDedHriCP6QimZHHQrb6y8V+/MAb5l7SSXf13wfS9K9o8u0g
         +p6VxMFFRrZDv4S4SJX30EJRkLbjxnpN/8i6DyVAOfLTjmeG8QPie5LDBhKSTft63Pcg
         aRQbafcrD5qehL6Vqr30RFN2OSwUoMNZ+A0Wxqy/yEAOi2TU57QmE3F/rzTuZ0BHsi3E
         1677nTtUj6cN/qVp5Tom6wCD2GaFza3EXYvkrISFVD9RIy9FcUhOyhBJ5gDSEBpTaAmF
         sj7w==
X-Gm-Message-State: AOJu0YywsorBhDKWxKWg5pZkxW4J/8JDpkZslHJawBbnqN9/5KKhKHXA
	B7EnDnsdKwslna3LSPsV2X9yFJieq+HKS4DDgDCsDE8AYwjz7eyZL0UBNzzuIqLSph7gKEHJTrc
	=
X-Google-Smtp-Source: AGHT+IHPwdoIIv20ZBrWH7DKZTnWpFwfY9K/rbsdLP8Ornpdb2oaHhsxCXEpXC4AlEb+sqMy9L4wzg==
X-Received: by 2002:a05:6830:4708:b0:717:d5c6:d593 with SMTP id 46e09a7af769-71a779ce2e0mr9736978a34.21.1731918235394;
        Mon, 18 Nov 2024 00:23:55 -0800 (PST)
Received: from localhost.localdomain ([117.193.212.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dac1f1sm5350101a12.68.2024.11.18.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:23:54 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
Date: Mon, 18 Nov 2024 13:53:44 +0530
Message-Id: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_002357_098065_2516E7A3 
X-CRM114-Status: GOOD (  15.63  )
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

PCI core allows users to configure the D3Cold state for each PCI device
through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
to allow/disallow the PCI devices to enter D3Cold during system suspend.

So make use of this flag in the NVMe driver to shutdown the NVMe device
during system suspend if the user has allowed D3Cold for the device.
Existing checks in the NVMe driver decide whether to shut down the device
(based on platform/device limitations), so use this flag as the last resort
to keep the existing behavior.

The default behavior of the 'pci_dev:d3cold_allowed' flag is to allow
D3Cold and the users can disallow it through sysfs if they want.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a..a4d4687854bf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3287,7 +3287,8 @@ static int nvme_suspend(struct device *dev)
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
-	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
+	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND) ||
+	    pdev->d3cold_allowed)
 		return nvme_disable_prepare_reset(ndev, true);
 
 	nvme_start_freeze(ctrl);
-- 
2.25.1


