Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBF9C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o0m2cct6gQ1hTU8zWjrJlY1/CzYGMV6aIaj43pzMyHQ=; b=xN36NsKTJS2fmLg3ccrg8A0N6L
	O7TxHRI/IkeiN/2M1ih7xfaleNJAnO6teyo0ij7G5n8KUQylbR6zSLFfSvVnoepc6eZsLYFPkXVoj
	FWlhURfEiC64hQtVHm1Wl70mvBNv3gRW3M6oFjGtJ/vUXXGlSk3N+gIgFfxTUfetX25zWVeMd1eSm
	EYPJmATSCS5X1yyPsYgXXbE8d2kVkmera7fsRj9THBfJ4N6TQYmiyHXWOtvF3+Qf9Oh+T040pXvdn
	2ODBoMW5RWP9Me0ai4MSZf6n9FqEGRqx21/SpBVSdjCehsQdFY1RJX7cnSIolzNMNcDA8KqvgNKKk
	8UQ+RvWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrJac-002GH6-5O; Wed, 18 May 2022 13:19:46 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrJaZ-002GFd-PD
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 13:19:45 +0000
Received: by mail-pj1-x1029.google.com with SMTP id gg20so2016498pjb.1
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o0m2cct6gQ1hTU8zWjrJlY1/CzYGMV6aIaj43pzMyHQ=;
 b=umKomzNTnxFS6bZsoFa6ppQZeJt+zfPQytLmumJLs/djqxC49M3mmhYlkyQQngnwyn
 f1UHtTKAviySFJOH931vQd8f+sqmaiLm8zbbFf1ZLLmttwg3ObFbmIqJ7HIMqJjFGz4f
 3rOvpAe0Ronm9jj6M3flcWOBpwZEADpP0FEqTM+Y0t6KPDDOOBOdv+j+ws6PZ90SqxIm
 DhxCFoOvjQgLF0ogB25DjAAQFJqKKnMGUpP8YOfNT5CTYvpH1Rf0StUfMOv68SLfNdEa
 i+1skS1vRbokch1jy3ZPMODZR39KIkDj2C8+cwijleR7EaNKoNQehKCijXPLBkgmKI1h
 vENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o0m2cct6gQ1hTU8zWjrJlY1/CzYGMV6aIaj43pzMyHQ=;
 b=AmoZ0wicxcXem3WTuuDuezL4l7Xn6a9cQEBkutzS75RAq7/HJ5ZZEtQNA4UG46snLp
 +nB0O4zOekv5zB2iwesM5WOJCTDIkwwn6Kr7wJVOG9rRSWSp5F5CI+go08+I50T5n/Ah
 xSBHhfoQus5bmx3v8K2OKvLuJJevVUKV6U60yTra20cuI3gp00JY+7nPPcjKWuAAygUN
 ybwojulCli863AAzom8CQT7i31X9yyIj8BmDKZSQvcjxpUaInb0b2Gdl1CFKDarYfFov
 iHClPA5A1jZqXaSYfDtNfozm3/sLT3ubZUKYywpM9Xl4wlftGi07UJucTiGolNilBk7v
 vzGA==
X-Gm-Message-State: AOAM530ltP8QL7AXbxXMNRoGIBGcJEJj40HBxk+TJ/OGU4U6RDww336q
 t6fua4nYDn6MGabn7j3t80OD
X-Google-Smtp-Source: ABdhPJyHDXnFThSQ2XZkBGm0ehgt4AjaSs5P8n90+AxqDFvzx/b9+gdrukWw65K8iRuiJeeg7pXjng==
X-Received: by 2002:a17:902:cec9:b0:161:a107:d30a with SMTP id
 d9-20020a170902cec900b00161a107d30amr9115101plg.105.1652879981149; 
 Wed, 18 May 2022 06:19:41 -0700 (PDT)
Received: from localhost.localdomain ([117.217.181.192])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170903228500b0015e8d4eb27esm1663908plh.200.2022.05.18.06.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 06:19:40 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
 quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
 quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
 linux-pm@vger.kernel.org, rafael@kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] PCI: Add a flag to notify PCI drivers about powerdown
 during suspend
Date: Wed, 18 May 2022 18:49:11 +0530
Message-Id: <20220518131913.26974-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_061943_875303_B08FA0D4 
X-CRM114-Status: GOOD (  15.42  )
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

On some systems like Chromebooks based on Qcom SC7280, the PCIe RC
driver or a hardware entity like RPMh may powerdown all PCIe devices
during system suspend for aggressive powersaving. In that case, the
PCI host controller drivers need to notify the PCI device drivers that
the power will be taken off during system suspend so that the drivers
can prepare the devices accordingly.

One prime example is the PCI NVMe driver. This flag can be used by the
driver to shutdown the NVMe device during suspend and recover it during
resume.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Changed the comment for the flag to mention the usecase.
* Reworded the commit message to convey how the poweroff happens

 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60adf42460ab..3e3a1c4f4559 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -578,6 +578,8 @@ struct pci_host_bridge {
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
 	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
+	unsigned int	suspend_poweroff:1;	/* Some platforms like Qcom SC7280 may poweroff
+						   devices during system suspend for power saving */
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
-- 
2.25.1


