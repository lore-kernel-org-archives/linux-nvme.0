Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA1BCA5FBB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 07:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oEoAhhUdhpqceZvWRKwJpGll0882jQumAWqkQ0kdrWo=; b=OUVAwPE49EHPeQqvNfuSoLEKMD
	3GDFuktr2oGycuDcZHQfjhJFjjSGH5689ADj8agykK/eb9+Y/JKkQryBuANhaFOcgd9YZ6++LNSeB
	UdqgB9sVZjID3Z8txl7iHzSEonvwaJ+wC7FKlV3723Y6S27G+StNSYSW2M3H3Mr9tfxbyL2UooVDd
	JM4W4NapmTcwsJRF/8xDz70yjgcx/gFEhPUysE2hfoKEBSnEcJKXwi4inWwDdUqjZoVCIEngoJCrW
	/saVFi8j4oVTQ7XHCO6E8jJda82FqMMJO6c1DmlokOMb801a3IsD6LgVx0NU44jELgn7OzpFC9diu
	OtGiT/yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBoqc-00000005Hc0-3DJI;
	Wed, 30 Sep 2026 07:35:26 +0000
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBoqa-00000005Haw-2sCg
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 07:35:25 +0000
Received: by mail-pj2-x0c.google.com with SMTP id 98e67ed59e1d1-3a0d31bda43so3046787a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 30 Sep 2026 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790753723; x=1791358523; darn=lists.infradead.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oEoAhhUdhpqceZvWRKwJpGll0882jQumAWqkQ0kdrWo=;
        b=aw631MAwy+drwdsEtX2yvD4w9favNiv1dxlrugAWDFbpLs6K8pigIT0HYO7Mmxld3J
         sTX+Szm7jZwxWFvxuBVCR850FfaPCPXdAp3Pc+EOHwJ/NxuyjqEMDrKZ7uZbM3hCZT79
         Y/BDRS3ipNlHHiWBSWhbp8XR1yzuUoJjfRkWig/Y1nMobGa3QGFGc2CkEX8TYywswkNl
         QcPw2EWZCtxqbE1p0hdrxpGKD9f5ifGtYC3fPCBOEIf7UumvBZsuN7JRGFs7XQacDTIS
         5s/fG+dd1/lbQ/0B37Twey+gK9kvysUd1vyAHhsdXw7O56UewgGkIEvo+HVDeGwk5B3n
         zPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790753723; x=1791358523;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oEoAhhUdhpqceZvWRKwJpGll0882jQumAWqkQ0kdrWo=;
        b=kEWK2i7/MQhXvC9K2zggc7bVOD0w9cYj7hRYE7KrUbXqq0QzZyMlaYdUsRfIeJOzMv
         TFaPrWZe0hKw/3JiW8lzcnHBoEJq9RXlxQR0FcfxU1NRIMTznxro2eBAHjG8WGEpYAI8
         reJC65kHu/aNSBuwWY/vG0foc1zVJCdM3icDO3Kw0/jrmV2xYAWDf9fREDXm4hK5iIdq
         ATXNDlufae6k0beIBNSoaqPh2OVqNg3RH2HZruKEoHzD2T53irJjqs31D5Hsq9b8wFO+
         +CfVwYlCSfM6dD5G4/4G19d9uTYn9RcoMKmaZKKLWhgNNT9ayE8dp9ZsiHUbS1IPlxdq
         LmEQ==
X-Gm-Message-State: AFq9FYJjewHYgGh1ixf7mGA9DUPxDhz5K46tDRjHyvT52HY/bwo05buE
	ECI/HQyWYxQP/Xw9Zm21+0ciGbFiuWLitvX/+Hbu4U6hnPoV5XXrfYSqdhQAHpNt
X-Gm-Gg: AYBFou1HALxHATAc39b4BHu2sBH/1uKkZR/w4Os3ZgCHO0Dynty5uRqFwLkCv7Gn0TD
	K38UtHzSuAsSo0vGE6pp2ARSJsRpVqXTwtQxBHiUCrjM6uzM95SV4gzDOxfX3TWlxVn5hFq/3n9
	p2PWg9kNKQyJwxU8+3FfPsl/Ms1ZTcLL7d/zuT9/BaDYbqVz2wDQ9atAKUZVDMrEFcDqbH2FXaN
	51GmmhiJpBqHRXale5iVvaVjtVosRVQHr013PFdNHHA7f+0uSGsKhanGgw+x4PE5xBfnuLJQero
	FLHLrEts0hx6bYYRenNTafy0HVQm1PGnSl93HL9qwzXAWRl4NcY7ma7gAsY5S1uN9atyy+WjSNi
	Q9Ta8FnBflEME8FCv6KZwamK/cbUmL7/Rnvi+bgpqo8EptXdLpVQ+j0NRS4a9tAfdk4AJ0E9Wvu
	6MW6yCwlSi9NRmCuTxCNfOe8PGlIpAWBsD02RiXLv5kTyVFWAatLv9wAFXlpud0S89bVM0kVY6f
	/SjD00SBjUpUyPI7llR046kXYwdoJLxKA==
X-Received: by 2002:a17:90a:c2d0:b0:39e:4c7f:7308 with SMTP id 98e67ed59e1d1-3a4d1aff806mr449203a91.31.1790753723118;
        Wed, 30 Sep 2026 00:35:23 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4c7662ed6sm808626a91.3.2026.09.30.00.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:35:22 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] nvmet: use the local P2P device on metadata allocation failure
Date: Wed, 30 Sep 2026 16:08:58 +0900
Message-ID: <179075213853.3.11747926147721077082.idr-bug-90@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_003524_726786_067B5454 
X-CRM114-Status: GOOD (  11.51  )
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

nvmet_req_alloc_p2pmem_sgls() assigns req->p2p_dev only after the data
and metadata SGL allocations succeed. If the data allocation succeeds
but the metadata allocation fails, out_free_sg passes req->p2p_dev to
pci_p2pmem_free_sgl() before that assignment has taken place.

Pass the local p2p_dev argument instead, so cleanup uses the same PCI
device as the successful data allocation.

Fixes: bcd9a0797d73 ("nvmet: fix freeing unallocated p2pmem")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Link: https://github.com/lcy8047/radix-tree-bug-temp/blob/main/bug_list/idr-ida-xarray/missing-idr-lock/IDR-BUG-90-nvmet-p2p-ns-map-lookup.md
Assisted-by: Sang-Hoon Choi <csh0052@gmail.com>
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Compile-tested on x86_64 with allmodconfig and W=1 against mainline
6f8319e3e9a44dd537d17f41565a8453c560a581. No P2P hardware or metadata
allocation failure test was performed.

 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43871a8f56ca..9ef29b2b49de 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1317,7 +1317,7 @@ static int nvmet_req_alloc_p2pmem_sgls(struct pci_dev *p2p_dev,
 
 	return 0;
 out_free_sg:
-	pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
+	pci_p2pmem_free_sgl(p2p_dev, req->sg);
 out_err:
 	return -ENOMEM;
 }
-- 
2.43.0

