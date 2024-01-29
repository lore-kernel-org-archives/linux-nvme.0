Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39D6C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QJPLjTVDJrkQ+IDokQSa6pjiidetStvVX93QhwelKIk=; b=XPQGapEqSEGcZRRNRR5fdxm52O
	s8Ies8CPdHpy5Ry3fMlvTQH6JTrtfXTrhqcapP/g3t83aLQOwuvITCVaSGB9pgNYTp8i6wEHcitQm
	0xIvSlFIvMCoMSTU9xAUOY9xdgcgUPjpNzz4vc4giSQzH99ySJuBQDu+UmEgvNkavh+q9b4KoAexn
	FE8Fp5ZsZEsmZp+7Erjn3qdKQYeHA5c9gD826MxlAlzNi6xlS7Vu3DOm2GVIcQsyXiflUeUdsEFWl
	EeqoTu4ALFikLGKDTyusBDJboLfNV3PQJ8S3sNG/eGxx1SzxkNhEXXhWnW+QusUMR/WuGfpExal3J
	b6eNd5qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPTt-0000000CLLo-3BZR;
	Mon, 29 Jan 2024 11:07:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPTm-0000000CLKT-3qKA
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 11:07:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706526425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJPLjTVDJrkQ+IDokQSa6pjiidetStvVX93QhwelKIk=;
	b=IcN1nvd9LRxodgjX+q2oQxBKXhXbYZp5I/TwMjrP6WA8l6tbfWth6hqXPsV/DAivF0ugMX
	KxUcB3FuxwhMflno3zrsx+4sI1NpRISMe88B4vHrlWGXHwe/xlfwgSefs+c4JNppCYwVpP
	Mqt3BLRru+ane/wHoqJ9HYZTKiJCRoQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-mksMmQJeOI-EXmw6edzJEA-1; Mon, 29 Jan 2024 06:07:04 -0500
X-MC-Unique: mksMmQJeOI-EXmw6edzJEA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-290c6d7776eso1250513a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 03:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526423; x=1707131223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJPLjTVDJrkQ+IDokQSa6pjiidetStvVX93QhwelKIk=;
        b=ES66EXYQcoZ7VKjFoMFm90nR+xc2Jb4Gfb5aghq86Y7KcksCHmXExA634DXd6NyUxB
         lzPVHQZZAvBdXw5J6iXIFywUnIxsrw2HisUpGWw6xOPJ1MldfXZH0Bg1UQu6qgWMQb5C
         kCVrcapE1hGDHuO0nfnX6skkF1qIWQMY7GWSQ8RpHy0yDbtZqUN1MtWtxJptrp1c1UkD
         Ft4RuL+kop5qrIAZbJ1vc0AJuG1YikT8Q1amC/90tGY/jKpk1k/pST5b86iSYSH1x8Ze
         kPOqdL+s2VvKZfqD6EKCIbApQVOsQgdEHjhxTmTx6MEk3ITQfw+WcLUAlLHJ0vXCg4k4
         77oQ==
X-Gm-Message-State: AOJu0YzE9qJlKdkXHC8r9sfGs6qIkL71sI+1PYE45Kam2secp5bEdfUO
	zrowE90D0UFDZrbbCdKprp/fBB4yCVKbYvwU6Ph0zBM0ITKkXh9N4CEqVXSp+SMGntKvT8bc2gL
	Oopu6dqUMdllT6b5zb7o7Qca3G0a+zM9n8IHd4gAiysrbSLZEZ3Y2hetHlFcPFkNOmGdWImOwD3
	s=
X-Received: by 2002:a17:90a:1b87:b0:295:4251:8368 with SMTP id w7-20020a17090a1b8700b0029542518368mr1154334pjc.46.1706526423082;
        Mon, 29 Jan 2024 03:07:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVeYU8eDy9h+2M9TdwdombFaiP+taBrZ6TnucuguT39OC7zR0vAuGu7pNGFezxtqjroQhcQw==
X-Received: by 2002:a17:90a:1b87:b0:295:4251:8368 with SMTP id w7-20020a17090a1b8700b0029542518368mr1154317pjc.46.1706526422773;
        Mon, 29 Jan 2024 03:07:02 -0800 (PST)
Received: from nyewale.pnq.redhat.com ([171.48.38.219])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090a520100b0029552a03219sm2791124pjh.29.2024.01.29.03.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:07:02 -0800 (PST)
From: "Nitin U. Yewale" <nyewale@redhat.com>
To: chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	jmeneghi@redhat.com,
	loberman@redhat.com,
	nyewale@redhat.com
Subject: [PATCHv2 2/3] nvme-rdma: show hostnqn when connecting to rdma target
Date: Mon, 29 Jan 2024 16:36:38 +0530
Message-Id: <20240129110639.45542-2-nyewale@redhat.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129110639.45542-1-nyewale@redhat.com>
References: <20240129110639.45542-1-nyewale@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_030707_079991_772ED19C 
X-CRM114-Status: GOOD (  10.75  )
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

Log hostnqn when connecting to nvme target.
As hostnqn could be changed, logging this information
in syslog at appropriate time may help in troubleshooting.

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


