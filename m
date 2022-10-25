Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E08C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k23ZRigiDfdD+zYIQfERIotoSKjF06R5NEGqHQY3uCU=; b=vbFwUtG83DLNAfq5UlzGt2aOog
	Mgb7U395EW15wZG31NiXHBIg9192Skf3vDf1XHIjU6yLTlzkKAJFi8ADkOi3E7rwCTx8F3h9PHP3E
	b8iIkoVvH7w5VWVTEgcLLldKOFfTxGJ9O4l9ICwt8ayr+zmQqIl9gfdXvvsnQr765obe8oIpu089i
	MKsLUsFXraEtvakjlvv9BTOANwYXHfy1+JvFwGhCqshSMbr7zltLjadrlT14ERjClb2PLaGKr6DIA
	wh72RQBNf8IbadRSUiJPW+imYwbPLQFfkAyH+llze1X9Gg3ylmxlpj5aPvJk4Lis4is2jlqXYz2D8
	5Vwy4PjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDy-005WoN-IM; Tue, 25 Oct 2022 13:44:10 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDa-005Wfj-Tb
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 13:43:48 +0000
Received: by mail-wr1-f51.google.com with SMTP id a14so18299140wru.5
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 06:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k23ZRigiDfdD+zYIQfERIotoSKjF06R5NEGqHQY3uCU=;
        b=EXayzUR8DPiZd4Cn8jr6V5NezhDBLE3pB3+JkxCsPhC9E7YSeY6md23bUWKuq0c6vP
         1pUYCY2pJuPSZ57IqpuG/JM2xr+l8zXuGSK7DxtVOCsONmrneZARSR1vJmVdl5A9jMdQ
         nn8JBGuCUn4+qsZeAOJTvLKDnpv6epu/b5HupuFxyb9HXpUzOlmmy3otHsgojhN0Wjxe
         gTeVwKuuF1ohH8apxqSk/Mj1L8wMsp666bh549xYpUKH9v+rypcFBDxELg1qtMZ+Z0p+
         lbe1t7E5REKIwNH/ji/40MXz5CKlFh/QWg4wZMLAdGyuX75nKo3yj8wwxN7zjimrE+Cg
         fjLQ==
X-Gm-Message-State: ACrzQf2z2yNVbVMPzZQhaxGhRbiPHf34XKDZXXOX1MEdT9tiKs/tdpQs
	2CnWDhdbJzaucARuRcU7+Tuo45HwJes=
X-Google-Smtp-Source: AMsMyM6mJ7SHSzNYMdOntsw472ArJ0HFoiLhLEFeaBGZHXqDnarNnmvrDXb1IvXjTTPOJVac+YSKKw==
X-Received: by 2002:a5d:5c11:0:b0:236:547e:a38b with SMTP id cc17-20020a5d5c11000000b00236547ea38bmr14801239wrb.221.1666705424056;
        Tue, 25 Oct 2022 06:43:44 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6c1686b10sm11442239wmq.7.2022.10.25.06.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 06:43:43 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/6] nvme-auth: don't override ctrl keys before validation
Date: Tue, 25 Oct 2022 16:43:30 +0300
Message-Id: <20221025134330.1028352-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025134330.1028352-1-sagi@grimberg.me>
References: <20221025134330.1028352-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_064346_968075_EFCE340D 
X-CRM114-Status: GOOD (  12.38  )
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

Replace ctrl ctrl_key/host_key only after nvme_auth_generate_key is successful.
Also, this fixes a bug where the keys are leaked.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b0b11191ed9..ae1bc79cd712 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3756,13 +3756,17 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
+		struct nvme_dhchap_key *key, *host_key;
 		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->host_key);
+		ret = nvme_auth_generate_key(dhchap_secret, &key);
 		if (ret)
 			return ret;
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
+		host_key = ctrl->host_key;
+		ctrl->host_key = key;
+		nvme_auth_free_key(host_key);
 		/* Key has changed; re-authentication with new key */
 		nvme_auth_reset(ctrl);
 	}
@@ -3806,13 +3810,17 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
+		struct nvme_dhchap_key *key, *ctrl_key;
 		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->ctrl_key);
+		ret = nvme_auth_generate_key(dhchap_secret, &key);
 		if (ret)
 			return ret;
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
+		ctrl_key = ctrl->ctrl_key;
+		ctrl->ctrl_key = key;
+		nvme_auth_free_key(ctrl_key);
 		/* Key has changed; re-authentication with new key */
 		nvme_auth_reset(ctrl);
 	}
-- 
2.34.1


