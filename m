Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BF1F45A11
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 22:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RLxY3RUXio63RMFVV2S/82uTKGXRqhW5FspTC735xUQ=; b=VwVwZYhNskIrOkpfVlRKU83rPb
	8VAFRYTbmdGTsdtKQKuM4imJpdZXtamJ7BkIDvZJE+D4sQploCjxX8Po+HnirJCuMblKA2Qkc+L0H
	AT/viXYw63lZCLADMWEMlvNxI6juRypOZM15/ASoeiSW1stqynK6uzLd0xHWTJA5uVq27lBEbT3sX
	HVVbokfQgSpCgfgGFffVR5qi1bwwuuFY0rmqd1Drd3fsXCSFIe/8rJnuC4cuAzBo+LZCiTDwfelP3
	6eA/EbtAMTuX3XOmORCJ6C5fqfLHnwU6BTpwkVtmv1C2iE90w3CbFAcp+LaCCTg42uqmw8+8dOEkq
	DVQ7LlPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBKM7-0000000CsnU-0vQy;
	Fri, 10 Apr 2026 22:29:39 +0000
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBKM4-0000000Csn1-3B1V
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 22:29:38 +0000
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-6501d242e3fso2471955d50.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 Apr 2026 15:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775860175; cv=none;
        d=google.com; s=arc-20240605;
        b=TtsYG+Ggm4ebmHpeMlGFKPJ+qLT27WQzQ3ON3ubj19CAkK3z4HNIJC9yiNz2Aw/giX
         LvRp17n7zrTt83F8tvYeiIhMe76iXnyhauDAedlLR+LhVTJ+kpGIMHPjAhr7BVKG1s0h
         VEJnfDoBF5fUyatRyE0r68fuiD7rT7tMSdl6DohXfu51bj0ZD98g9kIl3rbzRXUbggpi
         gF5ExXyyOnxPwFjBtHf+XZuBZsP0iIPlwlrbz3eE9VwrKdzanpaK/Fed9urMO0W35ysV
         DyZeq40kO8XQmEQPPG56wHxyJ4e1WuTmSCjIO3o8siJGGZgxq11OAEQiV7IabNxXBPIo
         44SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RLxY3RUXio63RMFVV2S/82uTKGXRqhW5FspTC735xUQ=;
        fh=8pgtm7/YrQoilv7dmsi4rBrFdcN+aD3TWfnBF5ccpec=;
        b=ZMFb8Nd9vRfWAzx2/kb92I79iwppPOz/g7pWtyrwzDEk7yt2sK4VOKZ6RwSA/aj0JG
         N+TCIw7cdRYpLaAnf2SQjNuHLGeCmw9dljzNlQi8OeBVMG0Vh3IBYjgTS9ZhPZDBbkXK
         VjXChAC6AhUyHtJPagbn2Ljy4eUwXyICVnh57SVtDsRJo5DttPVE5s0NWG8jy4zLLGqg
         muvw6pV31xe1d+MixGMjtgGtyO4BBjj1RuK4gCKmd0pnvyMdnYuRspms5vuEO+GSmZCO
         bZHZAEA+Y5yI71rjnpnopTMZiHfcvXYZLBx5mUiyJwtjrKvJEDMRVZHU80XQcvd3CYEb
         j6GQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1775860175; x=1776464975; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLxY3RUXio63RMFVV2S/82uTKGXRqhW5FspTC735xUQ=;
        b=IfdSq9cN5d9OzI0kMkunif5bk5vfrHxQ1IJIoYsvv5ZDjA+XPCDfAmxP518Mk+rR0W
         qKkVU04RlIw8Ja4z15+VMIhZPnWnQm8UcK7yebXllc/i3ILdP6a3gRqmFF/hgnx7PFwW
         Y8KDBubre5VvUpvM8m1up/pUjAeUHWWNyZ5K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860175; x=1776464975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLxY3RUXio63RMFVV2S/82uTKGXRqhW5FspTC735xUQ=;
        b=MqIQjeNwahmQBmVZ1+WoEOkAlbSt+uLvAW/rUo7Hl1nRSvH/8YcwBCiSPh6V+XZVV1
         GRxhFJU7TEN+mSit8LDLbjoQ/JnWH+kpQ1GQQVYP84jJpspJ/qt+GPZKNy/UPeOQpfxP
         flXUIVR7Q1B8eOdNEJ7zmkZdBdD7J4NzRcnmQK5EQ4yUtJlqUVayvTyXkql+oUvWLWlw
         TIlF9TDfynDwJEVnG4lGk0pcps37rS3nD3G9p837tEpon0M8C4YqTI66T24qXuzArgXn
         fCQ+7DWUd1AuXgv+6gSNSuWzektImyEtLUqatwn997oazAGV5PWrgpHZAdREMJlh4Juk
         sBgg==
X-Gm-Message-State: AOJu0Yzm7cJqthyQqPcLfbG4v/luOhrdtCp8sZ0Qya6P0umJzvwhgzzU
	k9Ik7fkUnh39PxtbsmT3BMQN95HyaLLHfn7kneym9IW6i3c4cXhN8Qtxz1vfcMp9RYj18JT0dTf
	O3aC+bDJMIaXPp8kzQBCCo6Py92CBNgFvw8snPSrDXNyWxkyocWThUg3XT0/9
X-Gm-Gg: AeBDieuEmy1TuWshKTfEUA1+gQqD9gSDUct9L+MpcNvXgHub9PZMKIwSWvOl0Tg/2rF
	i5MK6dPCIf+xzfQIgK6ZgeKVCNEfJxPGFdOe3A5c5Dc99OtSyYfe7gvyz//Z3yTV/zk5j1mOCx6
	1I9Nd39+/nlLQYQjsOTZ5uwZAgXzcqqYmZMgfGKZ2RBR0GEHwg5sSNhOliaQFeyXy9CZkqo7nM2
	dDYYrjjlzhdCPnGLRN3Z8BHcKKjjFa2lJnM1Kc4KMeWEPlNUrb6vyGNe4OthHcZZb552F0FL2zq
	stKj2tUL
X-Received: by 2002:a05:690c:6d84:b0:79a:4fe4:ff4b with SMTP id
 00721157ae682-7af71b567a3mr57702457b3.37.1775860174404; Fri, 10 Apr 2026
 15:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+w=M=SEUeGvXaK6OqdDVjYrbagnzDgAMgCRHbRqoYvS+OgW=w@mail.gmail.com>
 <c773c37c-b4ce-4f3f-927f-0be8a9b2d7a5@arm.com> <CA+w=M=SmUFUCfS6kGvRh3A4Vq++gSwhuPK7gn-ebWnM6BkpiZQ@mail.gmail.com>
In-Reply-To: <CA+w=M=SmUFUCfS6kGvRh3A4Vq++gSwhuPK7gn-ebWnM6BkpiZQ@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 10 Apr 2026 15:29:18 -0700
X-Gm-Features: AQROBzDIB9oFAIunzApXxKG1DD_NAHg0n4-3ye3q9P7oRIP4fQdJ0M1mHx2g3pg
Message-ID: <CA+w=M=THPjp9JwDPe_XpLcEpLTLakCf8OiybSbLwOPxjmAHy0w@mail.gmail.com>
Subject: [PATCH] nvme-pci: fix swapped arguments in SGL DMA unmap path
To: linux-nvme@lists.infradead.org
Cc: linux-iommu@vger.kernel.org, iommu@lists.linux.dev, jroedel@suse.de, 
	Robin Murphy <robin.murphy@arm.com>, will@kernel.org, Nagi Parimi <nparimi@uber.com>, 
	Kshitij Doshi <kshitijd@uber.com>, Jeff Bean <bean@uber.com>, Vikrant Soman <vsoman@uber.com>, kbusch@kernel.org, 
	xboe@kernel.dk, hch@lst.de, sagi@grimberg.me, leon@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_152936_826836_949FD607 
X-CRM114-Status: GOOD (  13.30  )
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

The arguments to nvme_free_sgls() in nvme_unmap_data() are swapped for
the multi-entry SGL case. The first argument (sge) should be the
segment descriptor from the NVMe command's data pointer (type
NVME_SGL_FMT_LAST_SEG_DESC), and the second argument (sg_list) should
be the pool-allocated array of data descriptors.

With the arguments swapped, sge points to the first data descriptor
(type NVME_SGL_FMT_DATA_DESC). nvme_free_sgls() sees a data descriptor,
unmaps only that single entry, and returns -- leaking the DMA mappings
for all subsequent segments.

This manifests as unbounded iommu_iova slab growth on ARM64 systems
with 64K pages and IOMMU DMA translation, where IOVA coalescing is
disabled due to the NVMe 4K page / IOMMU 64K page granularity
mismatch. On x86 and ARM64 with 4K pages, IOVA coalescing handles
the unmap via dma_iova_destroy() and the buggy path is never reached.

Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 28f638413e122..728999e4247d8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -761,8 +761,8 @@ static void nvme_unmap_data(struct request *req)

        if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
                if (nvme_pci_cmd_use_sgl(&iod->cmd))
-                       nvme_free_sgls(req, iod->descriptors[0],
-                                      &iod->cmd.common.dptr.sgl);
+                       nvme_free_sgls(req, &iod->cmd.common.dptr.sgl,
+                                      iod->descriptors[0]);
                else
                        nvme_free_prps(req);
        }
-- 
2.39.5

