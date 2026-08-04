Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8E9C55822
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 21:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yRZ9KtvM4Uvs1PJvqeEv2QOFNUN6xaam9dkuxhQtkew=; b=ucZuWruSYbXZ9/32kei6MAgNJE
	wvhhvrG1p0iM96Fl8iZvlTqXBRkq4Ur1A/jeppFbp9lPlXiLoCkZCRk5s9mwPuZrjL7KWIm6B0JNy
	uQjPAJYQIsrBMSRWgRyBmX/Hr/LYdBp/z/epPoHL+9zXb9XlOXXSYOgBe0nqvrpdSGAvW4QhbiFIF
	P/KsSMToQh/g2hSuLacmBKNJD9rQbcjjGwV1bf6wndsp5IKA5AeS2X76zuz8CFymzyZdZYEfsk28Z
	/gv9as6loC0EaTyvzaGsFbMFpIgxRcWDBkHGtIGLbAn+zsL1w9nwUCtgvAe6F6/2+EMwnbQNMsiYh
	FPUSD6WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrMoY-00000002pI5-3bT2;
	Tue, 04 Aug 2026 21:36:46 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrMoV-00000002pHT-1GVQ
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 21:36:45 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2cc891373e0so3984415ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 04 Aug 2026 14:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879402; x=1786484202; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yRZ9KtvM4Uvs1PJvqeEv2QOFNUN6xaam9dkuxhQtkew=;
        b=WAJxvUaEgSFppg26yqhl/5HufSVjysGBYYmp21tr5gHQxX1/wTDCLSlFNHfhD4DhNq
         Y9mDSvjX4Vbk1EqoH4sOxmyKeYAt2wfNmb0oPtI8hVYRAoaMC/p2RPR+TV5UMkL/rSZK
         T2d8PqW8uc8kxisMU0wdLAp6Swa5mhckuFO93ZIWcfWDogHnfqxhI9f6MQK/RxPFyI01
         wil2RptCrYjcEnvg4pZ1mA4EPxhRn70ZL1+8M9rG5hwWy5B5SWNMcHxKYnRmEmeFlYSp
         fZAzu4/OVSlP20rbVlasYX/MJ4QfJ9OxcBh0cmbQiOHRqenReSLcTKZJJAPVYWbWnBmK
         nCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879402; x=1786484202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yRZ9KtvM4Uvs1PJvqeEv2QOFNUN6xaam9dkuxhQtkew=;
        b=sSkDUR96k7kQ14v345F/F21ErYM7DIy15//ZRr+MsuyXUbSqx3Hz0tmVJ4y3wu/9dB
         +o6H4jj++s2yQc6VeHEQPbEiP7fGq/yvEmICglVWZWhW/Dpc3VsqYvnUhBCaYklnfMxD
         T5FVZBZ4KJYv9pMJnjZxLQu2Wa8FhrCEQjDnpP4FdR60mc8CGAs9zWap3Prvp1fp4PWh
         UTCA6MbC+AEhrprjFkAG1xL1TcmT74xmZs1m1Xw3WjiO/cLGuH1P2wGYw+ILmoUwW8f2
         YIIFzzfeFtG8OrF5Lr3RbqHojqQOAZ6+KmeOBG1vGxvsvQWmUs5+6AELqblsGnLuGdbp
         C4qw==
X-Forwarded-Encrypted: i=1; AHgh+RqHA0HYy3D4sox9QHO+oUn1XiF/zww36/ODcUFsJr5lyvkwkHNUoKUFtuKDrfnDvpyWZz8fMiUik8Ji@lists.infradead.org
X-Gm-Message-State: AOJu0YwPfpT+z7Pw13vJaEZzARF10/ZHO2ODDDlYI8Pzn8JazlIZ1nqx
	Z9sB2pNJYpj0jicfi+BgdhK4QgNVa/xEJLONDwpNhWUbSJQ2TYE2I7vL
X-Gm-Gg: AR+sD13bPoVE6YqOMa2cI40AN5Zn9KgRO9zntLFq05l3urq1pPvFv2WaKuh/C8e5lNZ
	A/Iv3/Bme7X82W6qf1U1hPN8Ar+DEDNHrsMtvHLHA8cQQLMVFRXDIm40BmIw9cjuSge5yJjfEu+
	6H5xgXNHfc6wBpy1ePbKPMCLL/nvQya+xjVR9dju6qDQMuUFTvXfgXzwu06WWL0NpjJIV84mdkb
	mjyKIFdgC4or4Cz/7KT6J79gUUGJ6aBcz1LklvyEZhrSg21kHpiKjUetcYJ3H4T5yJJuhXLjG1W
	AjC4pIAOmXNnD9iz64b/j3AA9DiSwvp5SncWCxXfnnGTlbmDTjw1uW+a5PHB3U0iNHhejXbnYgi
	jTGh/6MvlN1AgXboIvyDBJ6BVGg9+WSrnfbroUSkXVjmSrZShMaD1n2f5LkEcJ9mQu9zPce7Sg6
	7XRvErUNs5HibIgausC2PgooJsdMbnaHdW9hGsy2Iuoljr9ZqVLIoXw5kujyI9ZSFLiucsNFLHW
	WgneBn8jSyd7iSvpvzmrft3hpvwz3G0/pA6/IZu5+xV6eoCHSG/dw==
X-Received: by 2002:a05:6a21:7a9c:b0:3b1:a9ce:507e with SMTP id adf61e73a8af0-3cb8607a666mr1715295637.32.1785879401687;
        Tue, 04 Aug 2026 14:36:41 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586777bcfsm12780536eec.21.2026.08.04.14.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:36:41 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet: pci-epf: put CQ ref on create_cq mapping failure
Date: Tue,  4 Aug 2026 21:36:25 +0000
Message-ID: <20260804213626.3410403-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_143643_345367_0857D8B3 
X-CRM114-Status: GOOD (  11.41  )
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

nvmet_pci_epf_create_cq() calls nvmet_cq_create(), which takes a
reference on the controller and installs the completion queue. If the
subsequent PCI address-space mapping fails or returns a too-small partial
mapping, the function jumps to err_internal / err_unmap_queue without
calling nvmet_cq_put(). The matching put in nvmet_pci_epf_delete_cq() is
gated on NVMET_PCI_EPF_Q_LIVE, which is only set after the mapping
succeeds, so teardown never releases these references. A remote PCI host
that drives Create IO CQ commands with a failing PRP1/pci_addr therefore
leaks the CQ and a controller reference on each attempt.

Drop the CQ reference on the mapping-failure paths. The err_internal and
err_unmap_queue labels are only reachable after nvmet_cq_create() has
succeeded, so this pairs the create/put correctly.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 drivers/nvme/target/pci-epf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..794e88d1d9a5 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1339,6 +1339,7 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
 err_internal:
 	status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
+	nvmet_cq_put(&cq->nvme_cq);
 err:
 	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
 		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
-- 
2.43.0


