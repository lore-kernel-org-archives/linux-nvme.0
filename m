Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34932C47DA9
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 11:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ExlPcIdY1e1as+zOekpylatFWbuWGe7C4QnOoNYrAG8=; b=zKVosxdtaxUL6lm2bROPl1E1dh
	ERtqnisAfrJZwEwrKJa0TvzD2YMYAEDEYkI6kcwHYcEKB7IYh5BtHDdnX5MZOmhTokm3n+26W887M
	AAeUigVn221Tog1ttwE+ss1jVZsMrEYxL0Orun/rfrmNp0PTYf/16TFsbCk/ce6ybZwtNnAfpQugL
	R9hO/eHhnyBv9uUi9KnHLUthPneqexLJvWGNUsvZchUUEJR/w5pR4W4J4uqfycmCtpbwPDljj/D+K
	3p5NewS5AsruEUSvrPQXcDx3wl90ujU4RlifxD/RaJVrorHIe+xbWuhgbyPBYx8gZsIX4uIDTuwt2
	vYIGIiAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPTv-0000000CLOj-33Go;
	Mon, 29 Jan 2024 11:07:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPTt-0000000CLMU-05mU
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 11:07:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706526432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExlPcIdY1e1as+zOekpylatFWbuWGe7C4QnOoNYrAG8=;
	b=SIhHRwMK1stvdbsOE5RpMfQof4ZRx+t1DNQkaU5q2QUCh2yOW8nbb6C86G/vy8BdMEsJ95
	P5IRSU5sf1ttLCOqzfxvb3yIFHrFdHLEMDfNGbisGvPUTVyB5mTw/6dLCfIDuS1ZPDH0os
	rPd2F3fMog2l9T94AYLeHdkphrSWdsA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-SkkpvD5APpixStbjJfkyiA-1; Mon, 29 Jan 2024 06:07:08 -0500
X-MC-Unique: SkkpvD5APpixStbjJfkyiA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2955245641dso1349218a91.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 03:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526427; x=1707131227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExlPcIdY1e1as+zOekpylatFWbuWGe7C4QnOoNYrAG8=;
        b=UAdmCQtzXyUcRHz1GdnVqiX1lrIg3ZFFuKxIISIrKMALdPl5UgVXkWMthPeuHExYBx
         Y9fIMSTfAKhF/aPzbgkGo9Q1Wi9GIWzQJ8CLXUjpkVPgzgZv12jnKUKIkghe1ku3h1ja
         DV36J+C/bTg9X8KqpVqL/lL4QXzGr2dUs7tdIE9TBks10KARMl6aQxt2lgUiPdnFTxYG
         aSSKSX10MbHqqZs4x3hIn+sT6+bLn7OSAqMODP3+XEQwuC7qgOvBrG6AGl/iP/maMhVS
         L4pTb+Ug44SBZla27+swudpkMwIRN6Xth30G22YEkvK5xg1o5vnKnXNzxX+q4Flxo3Lu
         nV8w==
X-Gm-Message-State: AOJu0YyEK2TgiA78oiNhRVxsTRxLRfgnNay8Yf1XhcIbW2yqe5exKYfv
	H9XodhRtrQDiG4EHOe+JzPx/luDfYCEew1FznvcJwdDMw6qK+HOVOdycSfDx1Pm2foM+WciiaWL
	FaLfpvPMXzweGwPr0ouXvCY7t7KTisPlvqtGlIr14WGK4RJ63eg3Gbzro2TKgAKhK
X-Received: by 2002:a17:90a:d342:b0:294:b42e:2582 with SMTP id i2-20020a17090ad34200b00294b42e2582mr2902104pjx.18.1706526427501;
        Mon, 29 Jan 2024 03:07:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzuMa1hpzTUGArAcpRo9ywW50fp6anLmzhc+LOVkCSyO/JqPT/FFB2KYvWjJcPgdzEOaCfWg==
X-Received: by 2002:a17:90a:d342:b0:294:b42e:2582 with SMTP id i2-20020a17090ad34200b00294b42e2582mr2902095pjx.18.1706526427147;
        Mon, 29 Jan 2024 03:07:07 -0800 (PST)
Received: from nyewale.pnq.redhat.com ([171.48.38.219])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090a520100b0029552a03219sm2791124pjh.29.2024.01.29.03.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:07:06 -0800 (PST)
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
Subject: [PATCHv2 3/3] nvme-fc: show hostnqn when connecting to fc target
Date: Mon, 29 Jan 2024 16:36:39 +0530
Message-Id: <20240129110639.45542-3-nyewale@redhat.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129110639.45542-1-nyewale@redhat.com>
References: <20240129110639.45542-1-nyewale@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_030713_183332_24865198 
X-CRM114-Status: GOOD (  10.34  )
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
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 16847a316421..7ac565b0f13b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3575,8 +3575,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	flush_delayed_work(&ctrl->connect_work);
 
 	dev_info(ctrl->ctrl.device,
-		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
-		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl));
+		"NVME-FC{%d}: new ctrl: NQN \"%s\", hostnqn: %s\n",
+		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl), opts->host->nqn);
 
 	return &ctrl->ctrl;
 
-- 
2.39.3


