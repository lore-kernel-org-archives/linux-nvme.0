Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4252DC04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 07:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7Xvw3cr1RyoF79KTdx9ez6z4+coEhpvNMvaOv4mOPeY=; b=y+b3M2CdtdibXlbdeGxscMlaoU
	xiUGFNrGIo/fVC7O3OZumf1Y0lidyDUC8ndSiNJ9SnC5g+J3P6t75Ivr+0xXtYZsCd5XsyUYcQa2k
	GpVJwDhOzb/GSqIADg2kaRmfOWevFkglAxZ6LkbIN8zBBD4ENDqBEui3BLfcNR3NoiwcsFB+nW086
	FThuxy9s+dwFTg2ciZGXvptcFBzAwL8au6NYDsvgifYMsDh6JUgrG3wQbgu+qJjCWinUKM2Eu+hcn
	FpIYbw4ECmxvLOEveaKeTWoH6CgGKzyaozTcXxWnmx8ffyUyihzK+4/rVUmW1Da8Qv8JoyWoKdNNt
	NoJGtCsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4bxK-0000000ERdF-3MyV;
	Wed, 08 May 2024 07:43:14 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4bxH-0000000ERbM-2DbW
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 07:43:14 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a59b49162aeso862673766b.3
        for <linux-nvme@lists.infradead.org>; Wed, 08 May 2024 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715154189; x=1715758989; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Xvw3cr1RyoF79KTdx9ez6z4+coEhpvNMvaOv4mOPeY=;
        b=EHbpWSwi5PUYkuTHHrjt6x/qTmJH3D4FWXBGPwe2oBEq8MpGDxpwsm4yysX0q/dmuR
         Y9RyVxTzvW76ve7pjL1g6LQUf2mPGJ93dTpOcPbnn1gav7iHqw8ceLYU+vzJBtFg8kQQ
         ymxplDqqw1Mkm/HfRFKE67KnPY8CK4hKekmdTeLEGjjV63WGiFlr3tvkavWoZUcUsKgi
         JWvRN1sc54ZlMfe4iCJhSUVHI/5staDKvABz1qMUFGcR0QiC5J+GJRUH7E42L3nZeJyZ
         DGSh4SSOGYrKtAQAsD80UgQpaV+I8P0n5aqe9JmU4Q33KaQSFtoQQkbotWWgr5Fq+PBF
         o8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154189; x=1715758989;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xvw3cr1RyoF79KTdx9ez6z4+coEhpvNMvaOv4mOPeY=;
        b=pNU4eqWINS7dAdyXS5FvmCy/YCkPA+WX5VZDEF6CpYWmL5rx5jeX1cPAZGtwkINJOu
         Y9UH7SRgOjC++sepGxrCBh2IewEVLEzuRiKuPA7+h5DVRsVnX/iT15HZg5MO54bTUjWl
         S2NmHiv0K6qjyF7SjhdSOC7iU5wg2Lrv13Zbqo1VEFBsifdHHrPu8Mlpia4ew5vBcbBR
         4+BP1WzLZ7ileDSsIWX9/gjXNVqQxiF++2doFlSZZyBZFw7n4/eh/upumbmxVTLSLTcR
         VaU+T6QhVCL3afw1ogRxyYusUwQqK2oDVDLeqLajPW9s38qaPxCF40nc8FdKSN5y3uE9
         T1TA==
X-Forwarded-Encrypted: i=1; AJvYcCWLhd+ludReHUMfXcgqjtGzei3/oSuCpJdRQEb9lK7rfNbNWeSlHpEiN6zBQthr+XQ7ivMWz7tptEcEwC04YALeNM37OLTfOQ/LhnTi1w4=
X-Gm-Message-State: AOJu0Yz51Rss0DcaHsemTyPli/iTcwhVDeFyv6dbPfkjBHqd+tSajE3Y
	fMsceSSzpOkLNK9027ra6JA+hdKN9hYHRMT7Hm5AIx+99PV5gqzpWg8K/HjI+7o=
X-Google-Smtp-Source: AGHT+IGNGbq3AaoeyQZEUAek7mACIMKHY6D74+bWoezKoLVMrHCzDFCvjv/4+axxxyGGJUbfgQms/w==
X-Received: by 2002:a50:8e4f:0:b0:572:78df:c606 with SMTP id 4fb4d7f45d1cf-5731da6b1e5mr1274488a12.26.1715154188725;
        Wed, 08 May 2024 00:43:08 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q9-20020aa7cc09000000b005725d859e4esm7328022edt.73.2024.05.08.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:08 -0700 (PDT)
Date: Wed, 8 May 2024 10:43:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvmet: prevent sprintf() overflow in
 nvmet_subsys_nsid_exists()
Message-ID: <25e9c58d-d192-4a91-ad40-4c2ea01fbdf5@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_004311_868329_E0411306 
X-CRM114-Status: GOOD (  14.43  )
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

The nsid value is a u32 that comes from nvmet_req_find_ns().  It's
endian data and we're on an error path and both of those raise red
flags.  So let's make this safer.

1) Make the buffer large enough for any u32.
2) Remove the unnecessary initialization.
3) Use snprintf() instead of sprintf() for even more safety.
4) The sprintf() function returns the number of bytes printed, not
   counting the NUL terminator. It is impossible for the return value to
   be <= 0 so delete that.

Fixes: 505363957fad ("nvmet: fix nvme status code when namespace is disabled")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nvme/target/configfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 89a001101a7f..37cd75ff150e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -757,10 +757,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
 {
 	struct config_item *ns_item;
-	char name[4] = {};
+	char name[12];
 
-	if (sprintf(name, "%u", nsid) <= 0)
-		return false;
+	snprintf(name, sizeof(name), "%u", nsid);
 	mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
 	ns_item = config_group_find_item(&subsys->namespaces_group, name);
 	mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
-- 
2.43.0


