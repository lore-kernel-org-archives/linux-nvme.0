Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DC0C5DF7C
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 03:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5MnxCfiSl8pO88LgItQirBF6Sk69OYbyQL24d2UZK0=; b=cDZuujtYzQBOLApGoiKZPPBjrP
	ASj/4RatVT8NjI6rEPCIcMNWxUayNWGNwaOap3t2vAF0ghntpLe9dQQ1PJ0sbtRqq65NACSX5+ujo
	Zw/o5/zybeOaq9Xjm1FZYXG/tz18bnOxKQE3aJ56WmGcWJmKohVKfCSDjJ+UKknUJCLPSByLqYcWn
	5bx4RPLw3hEF1qU0yMQBdECDX5/Q6ULPpiK0gPfi4qDCjE5tZUS4AtXOEmCLQBXyrQPVYyrGveq8K
	M1swkxaZx4bfVjgMjMAtyDcCddTI6nh7JuFd99zem8fMZbxo2JCLaALMmqHpmxzExpiXLTtPvYbsS
	PqKgrOpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjy-0000000FnZX-3DVz;
	Sat, 21 Feb 2026 03:33:10 +0000
Received: from mail-pl1-x661.google.com ([2607:f8b0:4864:20::661])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjw-0000000FnWy-0oX1
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 03:33:09 +0000
Received: by mail-pl1-x661.google.com with SMTP id d9443c01a7336-2ab1c8fdc40so4139565ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 19:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771644787; x=1772249587; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5MnxCfiSl8pO88LgItQirBF6Sk69OYbyQL24d2UZK0=;
        b=S00ZBTsCTIW4FLanuW4XwzS9HL3h4pswLNfzOCU4BjXqe/cPVk3IArCSaHndxmlHXe
         bw3GiUnUerdn8WNsJYjlbce4T/HyuNUFhjF3uz3k9cGTS03IntsFHK2X0R3rFXgYavVE
         5ovhOa/Dr9vjazA+otLvnBf0nNVgRf7UHtFxTsyLa0nVbYf/FaT72TV9O1p868WAzpCr
         azErbJha4GWL+hxhLW053nO+RFmODyXfd1XgpFhzdScXf1NBB5idx3E88nPQpg1hNFqn
         dQ1td51AkB5hvMYKvQfZ13cK3AN/p1Orpn7VLQ/jRZ69Q7lrJmCejja7r0PxZCak47yi
         ZX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771644787; x=1772249587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d5MnxCfiSl8pO88LgItQirBF6Sk69OYbyQL24d2UZK0=;
        b=jQCuNhxMi0EpBaJYCRWS2Dsatxxebvy54O/xUu7p2iGTf0BE34ZgVpHakBvWr7TeVZ
         bsJc5UxZzva9PbNqxfxK1ZTb2+XD6P2NUlZt46+KlYKfCUuHvKTjtB/+myGGqqY107hW
         5r+5Qi4f0cKoWWDw71QbZ5YVlLmja5ckqyDUIMFXXxMNVuEybboAWZzI4qDGr7w26h3U
         +W3z22cTc7s1yZfw4miPiXvMSMHXFU6PXZN1b+FreXwTg0WLo4qiZu9jRBt+HgcBebM3
         TlYjGYhrCqLVqxVK14XdzWQx7FuLwD1oee6voERWleSWk/U5FAP38Zb2ACrcd72QWyl1
         ybrQ==
X-Gm-Message-State: AOJu0YwizCmjXTOIvCX4EC5ksSL4AG9+ZPVGurwcFw//zi6CwQoSPYXu
	/puTVQ/Fk8/xu4TpPhdaWe38bckp8MLny7ukv7JJKqJ5dZbgYoDH2yJpOn5mUIlnY6kOhDt58jm
	Lzi5tpYktlklib0WGStxGxBP6LpDKPdurV4HAXdKy9OinWQoKo7Rh
X-Gm-Gg: AZuq6aLILcmieNEKLV+8aUYJuYyT+38WylDEm7wLFIop7c5I/9RECjZ+4Mw3dM2DfA8
	dvYQu6OjRmv4l0BU9FH3ohOAQJBhn1MBNv+RJ/LtDU6m+YJb5MVesuceawYi4bISmrtl/eZEu9u
	7VuimAzAiTrp8HHmo1Ce1yOnoFbCgxjuho/41Yeovf3eDz3i254VGLMFPVMtbHTbE4wEs22/hJk
	nNVevdD+dqBc4PvxjBSvDadiCUVrLRYSQ3+hqiShhuK5vEG4KfXICdu5+yqyaRc+q/z38IGwpjZ
	nHtimGtCVTtT/yC+5Mz2TeqiqHx5T/GHbAagbCi+5WVBvTZ+P02TIb0nIK/pZbJCao615GxZeln
	/O2LgbjAx+M52GRGsCnNFT7SdzM/mrg19ZWLYyjc=
X-Received: by 2002:a17:902:f607:b0:2a3:bf5f:9267 with SMTP id d9443c01a7336-2ad744d1bddmr11993925ad.4.1771644787570;
        Fri, 20 Feb 2026 19:33:07 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ad74e03b5asm1599765ad.2.2026.02.20.19.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:33:07 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C91E8340705;
	Fri, 20 Feb 2026 20:33:06 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BF616E427C8; Fri, 20 Feb 2026 20:33:05 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 4/7] nvme: always issue I/O Command Set specific Identify Namespace
Date: Fri, 20 Feb 2026 20:32:59 -0700
Message-ID: <20260221033302.1451669-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260221033302.1451669-1-csander@purestorage.com>
References: <20260221033302.1451669-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_193308_231037_DBF55282 
X-CRM114-Status: GOOD (  16.87  )
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
nvme_update_ns_info_block() if the controller supports NVMe version 2.0
or later.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bff6f26d7bcf..2b433478f328 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2352,11 +2352,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		ret = -ENXIO;
 		goto out;
 	}
 	lbaf = nvme_lbaf_index(id->flbas);
 
-	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
+	if (ns->ctrl->vs >= NVME_VS(2, 0, 0)) {
 		ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
 		if (ret < 0)
 			goto out;
 	}
 
-- 
2.45.2


