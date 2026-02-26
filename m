Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E40FD8FFE
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 19:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qC1PH2EFy1+JEy/LIGlvD7SDeva8ogk5m5U5Vw+2yf4=; b=NwZosYRsINVIrMbfSFd/Ar4HAg
	HwDiLxyNoVP9JM9EJtPt2BqUeA9Z+DEjSkbwLx1BlMmneMWCC+qB+ubABTkPt5W/m+9hiq5Br760k
	7fm7QKVatiFne61O5IHAhIJKxA5FtYo8uRcCoRYKTtvN+InDz/yiiywtEfyjZinNIQRpWaDC1jhas
	CYKya2LAdkcKnbfEGCWJ7/lr2GuQ0J80v02UC1Yenl7eKPyQn5bvSZP3uJ6zsD//DjRbAwDVqrsWk
	AXeIh9pSXlrcQnJ7/MRsRwRmlgZJ7tLmeHG3TWi4TzVjC3MzH7RoCeg2NDwDdvNf1H9T9B3+bVjp6
	HZJaoITQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgey-000000070WL-14Cb;
	Thu, 26 Feb 2026 19:04:28 +0000
Received: from mail-oo1-xc63.google.com ([2607:f8b0:4864:20::c63])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvges-000000070RC-2Bb5
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 19:04:25 +0000
Received: by mail-oo1-xc63.google.com with SMTP id 006d021491bc7-6766dd30141so35120eaf.0
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 11:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772132661; x=1772737461; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qC1PH2EFy1+JEy/LIGlvD7SDeva8ogk5m5U5Vw+2yf4=;
        b=d09hq/iMgRVpWiYWwLBrmLjpkx2Ja7mkJLzHa/borLig7OBGIKz3Kt6BFXNM/kj/Na
         5bhnxZnb99KbzE0R6yi8dn/kYxbvkIc8TCj9pStG6BVFlNJPSdeF/GVJY6P1AmPgTXmc
         at5Eg/GdXsUB2K6MXEnIOJ6Ptl4q48sSod8N9rLFl2qWd+0m0PdlfR6sS4x74FBerzCu
         ONUor0NwqwvMUzli/LZfsE0Lg75ghWtdPCNVYz5ElMV1ZXV9V+V1OpFogt1uC8aNV26w
         nWSyBJL9FwE0DPT8bgsR09RBtg/qzq+0bG1FKTSRfM7uv6UV3sVbk8hiVcGWOIf+KYgD
         yIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132661; x=1772737461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qC1PH2EFy1+JEy/LIGlvD7SDeva8ogk5m5U5Vw+2yf4=;
        b=FixB9Ttf+SiF/PZSsN8OmyxMFw0JAVUhHuQBksi2YT5wTX5ROECxrZbUJH5LmO5Sun
         +UznIVcTN1WTQDzsRzVPuO80XghhTd6RJH3PHOHNp1hUNQ9hdZWhtMOZPlpppwKqxZwD
         qqK2f6LG4HfNg0nQnt+85Y/q+uJsQbBwHpXLc9p5CEIqrOcb773Y5RtnSuIJ7eHieyEo
         n2fGD7+BEnyVEtiAK6Yk1hdJKuurNdmcA3MS3E78T0IcBtG/3EpFmSBHRSkCNOlwyOVj
         AHbu+lojV1CXjfCeLWl8gGpubSnOaGP42L60nGRsu+vn8yTSuR49TIA1i+KeyX6dtpAK
         +g+g==
X-Gm-Message-State: AOJu0YyieKMBwSeMAY6ssK0X9iZPYe7DBQT9hcP6M+aLkz1TLXcDKZgH
	HRJPkDc6UziAs854CTJ1pf/jSaifiQe+ARLeEeDrC7cBF2FA/uapyCrtLnoDHXCSdfirOKFuQ1k
	E0B43eIMHMLjiwsLuPgsIJOThaSVfRT4ZfZeV
X-Gm-Gg: ATEYQzyKIN8E4fFST+LKouKRHottGAoRBCO5Z+9dOFJmYqxM3HxOMO8/xx4CTBFRON7
	8GZrXtXsi4EeWDB5wS3EUYslIzRVhus2edEZkxHY1Npzgo8i8cxTWweVajHai8WwOxuPuxPuCaN
	s86xRLEUgWvjo1ZbuUU1uxZ+cRu+SEddzyXR5/imQ+5tIXSTcEx7yi60UWlRPVpwBL5IGFTFgbg
	NiGELwpy5bpYix/4nARdfeniWz2fcCvEjndTYZ1sVIHWDdBmIQECw/lc5Er5qj6Q5jraShtzrH/
	xSvZmkoe87PmiWwdyPLu7cgwxc7JBVNx17yMc38azemkg+I67KY/W0m6f2uW654iYeEHN5yBEnJ
	/D1cfmVejHqVNgMNmCumhojyatl7QQrcrPAH40VRHYOMXMo2Jk5CYRw==
X-Received: by 2002:a05:6870:fba0:b0:3e0:de76:31da with SMTP id 586e51a60fabf-41627039f55mr138150fac.4.1772132661105;
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4160cfd4986sm369477fac.6.2026.02.26.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4D21F3420BE;
	Thu, 26 Feb 2026 12:04:20 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 48515E41254; Thu, 26 Feb 2026 12:04:20 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 4/8] nvme: always issue I/O Command Set specific Identify Namespace
Date: Thu, 26 Feb 2026 12:04:11 -0700
Message-ID: <20260226190416.297725-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260226190416.297725-1-csander@purestorage.com>
References: <20260226190416.297725-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_110422_585541_F8F9A821 
X-CRM114-Status: GOOD (  17.21  )
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

Currently, the I/O Command Set specific Identify Namespace structure is
only fetched for controllers that support extended LBA formats. This is
because struct nvme_id_ns_nvm is only used by nvme_configure_pi_elbas(),
which is only called when the ELBAS bit is set in the CTRATT field of
the Identify Controller structure.

However, the I/O Command Set specific Identify Namespace structure will
soon be used in nvme_update_disk_info(), so always try to obtain it in
nvme_update_ns_info_block(). This Identify structure is first defined in
NVMe spec version 2.0, but controllers reporting older versions could
still implement it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bff6f26d7bcf..14e52b260f5d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2352,15 +2352,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		ret = -ENXIO;
 		goto out;
 	}
 	lbaf = nvme_lbaf_index(id->flbas);
 
-	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
-		ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
-		if (ret < 0)
-			goto out;
-	}
+	ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
+	if (ret < 0)
+		goto out;
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_query_zone_info(ns, lbaf, &zi);
 		if (ret < 0)
-- 
2.45.2


