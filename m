Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D29EB64DA
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Jun 2023 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gWYD2E6jKhhuC6HiPSBxjFWYwVDYZ1MmirTurIgGQqo=; b=DXDkiprXxQ58gpBLAq8szJCanK
	02Y0anqMLms2cykGm+OoyD75A33iTtr/rnIrGyhHhuh2hZAD6CCNbPnQTlwnG71+5Gy+7Xt03V4ie
	b1UM4Hj4DfmYnRzZxkatVIVXXQFIzoN9a//bVzdNeskbBHD1MK15DUkrzXNIzw3Z0jBoWxQ+Wf3Qt
	vbik9IrY6EamjcBZMq+KGi5Z+bvLYeVIs/4ec1560qRdhrFX/fc5nPJmwvI3am3lJKhAAifM22vys
	m79X29lxRw3OXWE/NqhhUsHaftzZqg6u+LiYTnsYl6hDJPOkEsnAdUMYYNXP82FtCu5BmwV0Cmkgv
	0wXGm37g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qD0bu-005iOY-0l;
	Sat, 24 Jun 2023 10:35:18 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qD0bn-005iOB-1J
	for linux-nvme@lists.infradead.org;
	Sat, 24 Jun 2023 10:35:12 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-313e09a5b19so357094f8f.0
        for <linux-nvme@lists.infradead.org>; Sat, 24 Jun 2023 03:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687602908; x=1690194908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWYD2E6jKhhuC6HiPSBxjFWYwVDYZ1MmirTurIgGQqo=;
        b=NQ1JbVIgYoPsdMsV6l0UJGjuJ9lOyhVgO4aOVbAWEK9gTX8pxtCOxec5E/Hwn19seb
         EeMNlhZkxsd9ti5gytpWmmAAAZpq/hzbwMauOfiiXm+OyuVjnLF4X3r3P9DlrCPnGaJN
         0tTywloZFC4AqCkTn/VIYmYX7Gb0TNSI/uRxXhTqDBIPPohnQ39pdZ2RVwCJQ7M0Ze4g
         ykhNAAtjnlcr6QwqctllAzRzrit6E5lfkKSs/y0iLU0BN+orTKZ3cayBKwiPwNcOEsq0
         lO+p5ybMRDADD3YFQincIEY1r29sNnzsf61P2mzXIqznbvVTTE8+/IjDBhh/RKbsnngK
         qx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687602908; x=1690194908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWYD2E6jKhhuC6HiPSBxjFWYwVDYZ1MmirTurIgGQqo=;
        b=aH9s+Cf35Q43Yv2EERanBpHsV1RWu0/siim3zKLV3HDO8CqD0ZTs1MXoyc8T/ICcx9
         yRqROFAMSoNstFAocLJasLRHroSz0tHDlIJ9omhaKSc+YmRi9tbFIyUh+rBUWfTkGw5c
         2qqKhA1gVXVnsElZjTmFUYHJKCqorRzTRJ3ma+2Wa5hD8976oPaok9TkEXs09hYHDFjg
         b3OyS+9IKasaG/xthFSNqE1oY0jofMBs4jutk7OJoNFAmdi62K+hoVAddNMok1eIe2qU
         mHJBl5IEm1VbbhvmNvGS+wuFO338bIp6H93h178J7R/EuBWVEU0XPE0tVR1s6SIfJ3Xt
         ZHbg==
X-Gm-Message-State: AC+VfDwM7Uia/lzeFrwjNFmPrnKDYyTGYYbkItjCwxCW0XLCw6QcIImd
	4L1I4TfpvSJuWXbOfTqBtUo=
X-Google-Smtp-Source: ACHHUZ4wk2052fyJqNZCngj8jp8toPyQWE9Sc+BtPcp234cbKoFZYSz9+hXB+bauU0C/DyQwH3ElUw==
X-Received: by 2002:a5d:6e03:0:b0:30f:bb2f:705 with SMTP id h3-20020a5d6e03000000b0030fbb2f0705mr26146167wrz.22.1687602908252;
        Sat, 24 Jun 2023 03:35:08 -0700 (PDT)
Received: from archlinux.lan ([2001:861:3a05:dbe0:7a98:ed30:37d1:5b08])
        by smtp.gmail.com with ESMTPSA id z13-20020a05600c220d00b003f9b12b1598sm4767878wml.22.2023.06.24.03.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 03:35:07 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme-core: check id->mc before setting NVME_NS_METADATA_SUPPORTED
Date: Sat, 24 Jun 2023 12:35:02 +0200
Message-Id: <20230624103502.8772-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230624_033511_449558_5F2E03E4 
X-CRM114-Status: GOOD (  11.35  )
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

The NVM Command set Identify Namespace Data Structure defines
the metadata capabilities field (mc) that determines support for
metadata. Check for the value of this field before enabling the
NVME_NS_METADATA_SUPPORTED in the nvme_ns data structure.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ec38e2b9173..465206b5cf6f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1841,7 +1841,8 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * Note, this check will need to be modified if any drivers
 		 * gain the ability to use other metadata formats.
 		 */
-		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
+		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns)
+				&& (id->mc & NVME_MC_EXTENDED_LBA))
 			ns->features |= NVME_NS_METADATA_SUPPORTED;
 	} else {
 		/*
@@ -1852,7 +1853,7 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 */
 		if (id->flbas & NVME_NS_FLBAS_META_EXT)
 			ns->features |= NVME_NS_EXT_LBAS;
-		else
+		else if (id->mc & NVME_MC_METADATA_PTR)
 			ns->features |= NVME_NS_METADATA_SUPPORTED;
 	}
 }
-- 
2.40.1


