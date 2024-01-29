Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD61CC47DA9
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 10:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uubPDQv6uMnolTu/olL5ADIfKztYoY0F2gCMrnDZxMw=; b=4wz38rPWrdbT4W6LrhmEMGBPti
	jStv6+wtyup5Xck09EdbQIEYH115RKINXFKD2auIrdlLD/XJ250t5L3pDzfLdsA1rhcmSBOJ5uQZG
	EUsfAcGWmWduSFo9PXdXUajISvzTy3Pha+7+J2rCxlEntJFdwNqzFEXv9ZMRwARkeURP/+x4nQjAu
	C4enc4TQxtJIF4x9m8VEkQzxaRCAjAz8D3XkCrmuq+nOEGA4mzMnanN23B5iRGta0gHw8bI85jJA/
	QcDS+kFak8su2766I2CuvGWJIflZp6RU9gZpNkLhuUEyM1jtbgvFDxUzV19mnh0Iwgw6DIZiDimul
	xxoD7llQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUP2N-0000000CFH8-1wnS;
	Mon, 29 Jan 2024 10:38:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUP2K-0000000CFGJ-0S0N
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 10:38:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706524723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uubPDQv6uMnolTu/olL5ADIfKztYoY0F2gCMrnDZxMw=;
	b=GmavHGncQVkzaKmXlVxuPhi2FXOCOH0I9v/WvhdVmYz7EYU0t49TPyEg3LADL2lB91DQGs
	3NfdsiuuVlx+VwkGQeoSClAZfa/O8LogfnW6txsdM7KCLorz2YYjmi9/jEhArwTzopFyfZ
	5R6Vo9ZRL/OZdZWxspyJq6ArruQuk/A=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-M-UAUW45Mta8hVE1caYRsQ-1; Mon, 29 Jan 2024 05:38:42 -0500
X-MC-Unique: M-UAUW45Mta8hVE1caYRsQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6dde04e1b6aso1236585b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 02:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524720; x=1707129520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uubPDQv6uMnolTu/olL5ADIfKztYoY0F2gCMrnDZxMw=;
        b=aVO5X21U95sc5pRkrDcD6ITrIRd7OiLQ/24CJkmAV9lPZAFFhyghGlN21DdrnVgS2I
         Oh9aYP+gPs+mXDREGhshMsKh78QyJvWr4eUZqLZpg7699Ip/02E9VEbLfSiVurDOJfiL
         wIYjLuISlKfOugC1T4YTKhd8THgH+K6wR9kLja7Jv5IKy2+lU4fhwxpSEfmKXvhhw9nQ
         fBwROc1U35bIw7JdksqdOY48Y7nYDcC3TzMaDfmyIsNXI4twv8Mai74rX4TSGI/uRvUT
         wzL/5eGbeOORLQVfF0g5IQoI4PleGugoro2RFKs9rIYzQXRUwtwuN0t4vHqDfUnXqtsZ
         MOuA==
X-Gm-Message-State: AOJu0YyUxWtz9PQr4d70JfbhAug5XeVuHM63mOC7iwsoVeQZ6vVOLxgA
	eu+uCBDXnFAQgkUZgSAFV8nyc6w+K+tcmkLopKT45MKwrVgWHzbPhEoKSBsYqmcYp4cnsuIihj2
	K2TPyLxKCjGgPmmDeS69qal7pKQPDvTQyE24OqjKuSMPLGOl76ojcWjO6z8UwdM4A9mZJDSHhg2
	NyKpG6o3yq3YlVrOjNOqBnhm1mNMvp/ZsJW0imH3xL6jxR6sjP2Q==
X-Received: by 2002:a05:6a00:6a0d:b0:6dd:8935:61d6 with SMTP id hy13-20020a056a006a0d00b006dd893561d6mr1781951pfb.29.1706524719841;
        Mon, 29 Jan 2024 02:38:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjI4o526IbPKfoZhQS7q5PQAMDQoIZRujiTEZIlAlcyzE+X/v0lXVBbg+jmoJv3uRIAgcYtQ==
X-Received: by 2002:a05:6a00:6a0d:b0:6dd:8935:61d6 with SMTP id hy13-20020a056a006a0d00b006dd893561d6mr1781933pfb.29.1706524719396;
        Mon, 29 Jan 2024 02:38:39 -0800 (PST)
Received: from nyewale.pnq.redhat.com ([171.48.38.219])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7849a000000b006dddc3e298esm5521654pfn.150.2024.01.29.02.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:38:38 -0800 (PST)
From: "Nitin U. Yewale" <nyewale@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	jmeneghi@netapp.com,
	loberman@redhat.com,
	nyewale@redhat.com
Subject: [PATCH 2/3] nvme-rdma: show hostnqn when connecting to rdma target
Date: Mon, 29 Jan 2024 16:07:58 +0530
Message-Id: <20240129103759.42653-2-nyewale@redhat.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129103759.42653-1-nyewale@redhat.com>
References: <20240129103759.42653-1-nyewale@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_023844_267974_3F74CDB0 
X-CRM114-Status: GOOD (  11.04  )
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

Signed-off-by: Nitin U. Yewale <nyewale@redhat.com>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 11dde0d83044..60f42c959acb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2296,8 +2296,8 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_uninit_ctrl;
 
-	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
-		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr);
+	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs, hostnqn: %s\n",
+		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr, opts->host->nqn);
 
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
-- 
2.39.3


