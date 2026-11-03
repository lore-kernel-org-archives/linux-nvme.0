Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86A606A326
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nGQHLBS/;
	dkim=pass (2048-bit key, unprotected) header.d=sufficit.com.br header.i=@sufficit.com.br header.a=rsa-sha256 header.s=google header.b=p+hoNOvl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=2peDZpv0Nt2X4R2zWrEwCZ58rKp6e+sLK5ncD1B3k4E=; b=nGQHLBS/tsejMmiDthsglPSGMq
	JbPYQeuAxx4RWEZ6G9QhW73LIBZpe43GVXXNODjoh12fr602ckdHbIyKSvzVYM6rC+luwc0l50fLW
	RfZUMmIEyMkOc3RM2mJyi4nIpEivUGomfYTo9hXK3MLdJGlC14swXT1JLA0IBC4n/+041gDn097bv
	/LV66jDg3sZ5WhG2VkWYlKxbYsg01+EovypgzHksEPyuM3Q8j9TKieLmtwVccw/SPinVG3W1jUXNk
	EydMkb7ehAzB/lLQt+d5NFwoLU+/PZwMLlgnxZQYkkvKe9Jf/vk7AtnLKaToWBb+iMcXNebLqXO1T
	VjOIoUBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOIzT-00000003Mxk-2wdj;
	Tue, 03 Nov 2026 18:12:11 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOIzQ-00000003MxK-47LM
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 18:12:10 +0000
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-3ab4354db11so33396691fa.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 10:12:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793729525; cv=none;
        d=google.com; s=arc-20260327;
        b=NDHYsj21p1Im2v8wG2e70Kg3xio/zTe+zGLhDHoYuj/yowmmJBO0diZw5ZczxycMcP
         L8MpnS4Uxsz9STIjCFS//rcTJwlvHjM1n1RBMHtK2waftV//vmAAPJqPFy88i5p6TulC
         a6jqhxMFZ+DVMmGYMaEJt4A0sIUrLoh3PdHnB+aRnyYKyzbjWFLhwI+PtqPGNpQWsJpu
         px3l5HEp5NtMBk+SynDg1eDe1wI34gTnLGS0xLCMjxFnJtPkLVK1VqJY8VEagadCHyrh
         BsA37QGD0H129SfGqDruUdqqCtSqwubuRIDR1nmkuJSijh5SlJEkuWjfFUAk5vtMfCd4
         9F2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2peDZpv0Nt2X4R2zWrEwCZ58rKp6e+sLK5ncD1B3k4E=;
        fh=gJgyqMUHH86Yx/8p1Cx0UfG5AB0fJ9c8Uzf1mJ3qIUc=;
        b=pnhjDlXiJSVjnhS36mkQC1w6a8QhyFTa7xMXxyDfuf8A4lM2B4y6vMpNzBks6n+pW0
         k5s7aJantF/a7nrXs+vfgw8E4RRAAbQysUcTEgSeJL+Jai3fd2lWhg19FkwaLJh3RDJb
         Br25wVkm+5PrUNySK5QMOJ+kUC0rixpLyV+vmqlcEsA9QbV5lHmHNrmJ9oq4C1rjClmv
         9uUMY3IdiV63p4H+EiX+rZexLSUZNz3rl8L0gOQZWtTxUOi/Xlq0QsSgz+jz1G0/h87J
         je0D4aB10eXLnU6ARUR6niBPYAL4lTSozwkSaS5eU8cBX/f0TnJb1bKHYwOXBCgNf334
         u0Rw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sufficit.com.br; s=google; t=1793729525; x=1794334325; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2peDZpv0Nt2X4R2zWrEwCZ58rKp6e+sLK5ncD1B3k4E=;
        b=p+hoNOvlLDoOItEtB8oxIy5qVDA89otQPD25R2qe0+eutbaqu1PSEqreyOoXgHiD44
         bWcCCQEByaT0Y3hrtEGXlqJFKsGM6TEbS7+T0H/O5eDb++1uqcFQF/t9seFSs2MBXC2g
         F/rY/XqbrmCBAmj/5vH4H0LSY3vato8Mv7wL+ph/BPA0g3iA4N3aKMez+UrDTn6wMNiU
         Y6EqE44H5X3DoeiEQ/iZj9bhvc6soppo8VzTr8pXeqFIJUjAx1I4v4QpNY9O5cRn/MtH
         QrX6a0kDt/06xC0lmDhj1Cn6fIz8ZgEHES6SbWyRzGLH8J3l5TqVxWUwy9Gvl9Q5qZo5
         HlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729525; x=1794334325;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2peDZpv0Nt2X4R2zWrEwCZ58rKp6e+sLK5ncD1B3k4E=;
        b=Q8Eu1s9VQpmp7qXapQjtfoR/OCeS4yHi4qtr+7xlNrHw/E4JQhncmmBd8S2nB5QzlV
         rIKYbBHUragNUmqy6cmTf9BcyV7x5AveL2IAHvVrewqt2b5CSW2dQE7YBWODJXMBGWnv
         Z5m4Z5LnQmjWJjrUKII47dxaH56B8o8dJAeL2yrIl8tQ4sDOpZmwyAEs2w0DJ2MgUf2k
         83Niu07IEfNWieslR/z87ik6pXLeKssTnjM9ZzUnYeGnDbOhujiLhVC9cgWwnF9ZgQsL
         iGGjEM9c43SEBBGhoJ0jy9+SInI/YV4ANwpBJA0svVjU4DodnNWkNkecE3Ff7JsZ9r/n
         c5Jg==
X-Gm-Message-State: APuU4Z9FPsKG1hr6SosdFkdWXWV3v4e06u6z55q9ViYL23FixaTuyqb9
	wU9ANGQKTS5g7jysy51bEhwQgYe0rb3Q+AJFvt/1vcOPfLW24QOMOTyocr+6hZIvFL4U+bJWTyN
	o722z0CPj3w604xd57kQT3obgt9G9P5NRHavz4ttEEfgLKV6KForEJ7HDfw==
X-Gm-Gg: AYBFou0wjZAGvwxnbTQ5Q4MS36MfyAY+PrDKQi0Bprv+msZFV5TnPOzS92RdxrbX9iK
	kQQgtDJ2HeBCFOiumkFkKII3Nz5yZ4JvHPAfE6f8iDZ2jldaCwcR7jTjbaPbjUpm+BfREMY9iqn
	KkpEi4ZytUxahAU8frUOdW0yxCzFndMxUiyvmg6v/WXWXtdwGB2bPHYwmCvk4Zjp44SD/+fwYLs
	HWVn9/99yRzFzzJkm391dekvJIJcK2PWoHv5HkexVvp1iLOVvWS1rpr0oY3vZtcOKCtn8zQeoXM
	edCxNmJ3Sm9pn2SXhcm8IUTatmakyQTho2KREjDuXxrSg7J+SXiz/oVPZXVUzjmPgEyELQiDYkp
	yAN3jltOgozm4AMZRSMXSq/gPoKCCYuuMzmHCws2LYBbC2sIS+RKqBJ/k4TUNelVGFj5RIw==
X-Received: by 2002:a2e:8a88:0:b0:3a5:e792:2dc8 with SMTP id
 38308e7fff4ca-3acb7ad2a7emr28560531fa.16.1793729524867; Tue, 03 Nov 2026
 10:12:04 -0800 (PST)
Received: from 609194959516 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 10:12:04 -0800
Received: from 609194959516 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 10:12:04 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Hugo Deco <hugodeco@sufficit.com.br>
Date: Tue, 3 Nov 2026 10:12:04 -0800
X-Gm-Features: AclHuK8R1HPQ0O30EAMzwY1a7LQNMhKTizAdurdfNGW4JjvjIspy-iDgFKoQWEE
Message-ID: <CAGFVba_n+Fhrp42X4Yn5hjBd=YWP-_2FVpCsxO_mogWGrfHd3w@mail.gmail.com>
Subject: [PATCH v2] nvme-pci: add NO_FUA quirk for ADATA XPG GAMMIX S70 BLADE
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	andres@anarazel.de
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_101209_086365_12B129AD 
X-CRM114-Status: GOOD (  13.14  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the ADATA XPG GAMMIX S70 BLADE (PCI 1cc1:5370, firmware 03020P5E)
every Write with the FUA bit set takes 200, 400 or 600 ms to complete,
always a multiple of ~200 ms, while a plain Write completes in
0.0-0.4 ms and a Flush in ~1.3 ms. Tracing nvme_setup_cmd and
nvme_complete_rq shows the whole delay is between submission and
completion, i.e. inside the device (e.g. FUA write, control 0x4000:
598.3 ms).

Because ext4/jbd2 issue FUA for every journal commit, fsync() on this
drive stalls for 250-890 ms and desktop applications freeze.

Add NVME_QUIRK_NO_FUA, which stops advertising BLK_FEAT_FUA while
keeping the volatile write cache enabled, so the block layer emulates
FUA with a Write followed by a Flush. Durability semantics are
unchanged. Apply it to the S70 BLADE through nvme_id_table.

With the quirk applied, 4 KiB O_DIRECT|O_DSYNC writes and
create+write+fsync drop from 250-890 ms to a 0.82-0.85 ms median
(30 samples, two partitions on the same drive).

Signed-off-by: Hugo Deco <hugodeco@sufficit.com.br>
---
v2:
 - Match the device by PCI ID in nvme_id_table instead of the model
   string in core_quirks (Keith Busch).

 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/nvme.h | 8 ++++++++
 drivers/nvme/host/pci.c  | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09..a9f54ef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2482,6 +2482,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		lim.features |= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
 	else
 		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
+	if (ns->ctrl->quirks & NVME_QUIRK_NO_FUA)
+		lim.features &= ~BLK_FEAT_FUA;

 	if (info->is_rotational)
 		lim.features |= BLK_FEAT_ROTATIONAL;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2d8f681..8833a46 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -183,6 +183,12 @@ enum nvme_quirks {
 	 * Admin queue DMA buffers must be page aligned
 	 */
 	NVME_QUIRK_ADMIN_PAGE_ALIGN		= (1 << 23),
+
+	/*
+	 * The device is extremely slow on FUA writes but fast on Flush;
+	 * do not advertise FUA so the block layer emulates it.
+	 */
+	NVME_QUIRK_NO_FUA			= (1 << 24),
 };

 static inline char *nvme_quirk_name(enum nvme_quirks q)
@@ -236,6 +242,8 @@ static inline char *nvme_quirk_name(enum nvme_quirks q)
 		return "dmapool_align_512";
 	case NVME_QUIRK_ADMIN_PAGE_ALIGN:
 		return "admin_page_align";
+	case NVME_QUIRK_NO_FUA:
+		return "no_fua";
 	}

 	return "unknown";
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 019a1e3..e262f38 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4483,6 +4483,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1cc1, 0x5370),   /* ADATA XPG GAMMIX S70 BLADE */
+		.driver_data = NVME_QUIRK_NO_FUA, },
 	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
-- 
2.53.0

