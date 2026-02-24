Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A407DF357D9
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5MnxCfiSl8pO88LgItQirBF6Sk69OYbyQL24d2UZK0=; b=ULA14w09T0JMt7yduHVYxz4lBl
	lrgK2SPhHI2g0MGoRjXQaQTVaRb7jNxeYYWrwIM+5beyMb00X7C3xggt89Onn5V5WJr0cjwTRYLhM
	2wTTQgIs1yQHyOe+28A0V94zfzOC1+TeQGHg6OyFXdfVRv+vGM0pPWeo4nXeqSHsq3UDgll8rAB5j
	5KPzspGeMJVOgdiUHyg+tJ+a+r7PZbFgE84w46aYdpE+4jK2MBUCRtmeyFVBK3q7T6VyFPRF1kQ85
	xvHDEhx90r/eMxFD3rcB7t8FRdD2uErGFm2u0wgYfVttmPDQUHGaB8gt98A00Tky3SdZmAALpSLpZ
	QNnpzMdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuw04-00000002SIr-3Rc1;
	Tue, 24 Feb 2026 17:15:08 +0000
Received: from mail-yw1-x1163.google.com ([2607:f8b0:4864:20::1163])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvzz-00000002SEJ-1zaX
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 17:15:05 +0000
Received: by mail-yw1-x1163.google.com with SMTP id 00721157ae682-7985ee1a10aso423777b3.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771953302; x=1772558102; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5MnxCfiSl8pO88LgItQirBF6Sk69OYbyQL24d2UZK0=;
        b=SLHSkGEkzedJXmOryaZn5hUFJeyHJTmvNlIgapEHE2NRGkarlNfck/yFgFJoYZgUJL
         rTfxr0mJdmfdL6K/XKLyDp4xmlPwG1pt4y3HpfttAqQ/hlnWOBx0+T38J6ALejcrlRo+
         ZKIjZRyWUYP/SjAlImRzKYdXQhP5KtaOxxUJhPe9IvwJciXlrJO6GwaFSrz+YFUftjaT
         Cm701L0i66V2Nd2mkozXCpsLIUyKamfU9Xsivdv+CW2qhbDXcY8b3UNtj/XJrVj+nMYo
         76hwkCNXDAqorCXkeqqqytO7dDdF9WNnotSTeo/k0nI4OQQrGuPhZ1uA/HMB7QKoTosI
         cJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953302; x=1772558102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d5MnxCfiSl8pO88LgItQirBF6Sk69OYbyQL24d2UZK0=;
        b=fPNhZ9SqCOboAQ4OyQBLYsu+O8wYaPejg05KMIgQztRQaRVACp0Jj5qXw9AOxNmBhK
         cAMDEObPxcWS4L83KRzQB9uT6J4zp00PzV3JbHrm3v+FTnZQavrz5yofOTw+JXxoIAzx
         jvRSnxReyDZwgIeOoJayryAxglU/DhNCilznDPsFf1+Z4zMxMb5cXP0BljL2MnxS532Q
         crBsx1aBKe6AOR80jq50qC/z0cfVmxMIN1TPBMmhl4cHoYbrcLw2L6xDpOI5v6sgjpFn
         ymv4eFlm94B6wBLCU8D+L1zyHDv/aKJTCHsjpoV96SdACD8sHtOFHgH7Aw1wK3pYXXZf
         BU8g==
X-Gm-Message-State: AOJu0YytSNRSvxLAdxPMMqTRVlb7VpGeVs8MURGRA/tSq6twsCYXAH4l
	4bcYnzN9PaQpGI8ShXsb39NZdDocOSZwOf2wLMMf1otgHH0Ia5wN9qiGNwigVgc68RF81bmu5XU
	vQZV8d3hkcYFSBqM/+lXlMHa2j4wB96CN2cmo
X-Gm-Gg: ATEYQzyu0ux+DoEMaJLnr4muulxZzPNccsRnmbBJM8wFK+E5ce+fW3hbhK3mGNM7RMx
	jWl4SnxxhcNiCM74sMsBMgQUoUadcqdXF+zTOslz24XTRaHSv4S6azGaudPVXOZvGHocAlpkKCk
	NUc5Rs4+tbIxBFcczFhBwXM5Htg3LmarIF67//1piQ/MakNQX5ETtQ8nGgOdDDdgBq/FvVprTi5
	GmKx6e5TYiXRsMYvKrCBnBKYIVe9OS5KXSKccYn//ScKSSyEgkrfIQWqW52wrJztiCU0y609c6L
	tCyCvaHrA2OwXecxUrV7qmBuC5EvldpLhXs5nVVXDz3eEruDmOFHwYo/mEkodndCoP4nSaEjjp6
	jOoQeCow1CjODtObTFh1yPNyeOBad7MzsAWo7WgBC5bERcL1f6jYIZQ==
X-Received: by 2002:a05:690c:82:b0:794:2019:29b with SMTP id 00721157ae682-79828f7233fmr100481647b3.3.1771953302220;
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7982de1ca32sm13166237b3.29.2026.02.24.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 791C934211E;
	Tue, 24 Feb 2026 10:15:01 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 73E66E41254; Tue, 24 Feb 2026 10:15:01 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 4/8] nvme: always issue I/O Command Set specific Identify Namespace
Date: Tue, 24 Feb 2026 10:14:33 -0700
Message-ID: <20260224171437.3175993-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260224171437.3175993-1-csander@purestorage.com>
References: <20260224171437.3175993-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_091503_511385_F50B7847 
X-CRM114-Status: GOOD (  17.09  )
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


