Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEC6C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 23:47:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662CE61287
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 23:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662CE61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H629c1CYQ9fTGCcv68BUMZLMAlRzkWH8RqkActb7EDc=; b=a+Fi+hSB8OBzSWY7x0Gn/FrWO8
	Y0kbPA+zeA0t+zcWAG5XtC4djfzu1jg/5A3LQuo/t611TygpN/UQxlBaDlhZntGveSl9PirEuaMoc
	xJ9hFa17jdXsIAJFteTF5TTXDaVaGvinUk5TgZoTykCcmWKIewVB6ydgl9fb9GxxLydjq3B679P63
	Gk7qwaBK8/KhVDcH//13AwMdIPWh0STNpOm/ViDbluulciP1fOhhEIp4Ul5JmmuEUuUBxqIf+3CZN
	5Whr+GAMiwhjZWAeVcfHO+EVBcUcG1INQZLiDVEbo6J7/ZxlOcoRsdAa+52lVaq66d3HrPZZzjxyZ
	J0dd0fAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lW6GL-007uS8-FF; Mon, 12 Apr 2021 23:46:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lW6G6-007uQY-He
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 23:46:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=sD5zWbzHocJWExoRtuQpTL3B9ica4gx00qs+VGRFMiI=; b=wkvxGu4XiVeiXeX/3CDfYhGS4U
 8hJyBik6lU06VGjH/GfTTLkbHAXBgs7yCfJmPyYGbIW/1yimvudqZsm4T0XvcZw6XgMjo4OTSBdiF
 3o3/CzOPyCaPUNsTL42Dg0ve2MmYD+XRyA3jUUXwB5K35hdkw6saRdg/PPAmYFxLjen2C0euZzvac
 4QerV4gO8vA/qDnLoltnVlCwsMG/9iY5AknscYj5WAwNPR/ELo96agWbJx4FG5Q2b/wblRoV/WbUv
 BgQM01o+4y6Rr4yq/ff7rErAWCTYdHnEo2TBIMusl/xMGdIKYLvOCLNM4c5sSVRYNc1yxm/lLNpiv
 IEsaxrsw==;
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lW6G3-006dJ2-QO
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 23:46:21 +0000
Received: by mail-pj1-x102d.google.com with SMTP id u11so3851563pjr.0
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 16:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sD5zWbzHocJWExoRtuQpTL3B9ica4gx00qs+VGRFMiI=;
 b=VMHvUPwvk7oK7nGKmYN+OHtxd1KlvBFZyzbeO2VgE7cxXWvAvZ+T0UcIHQgfBQqoPV
 x8tJxsqW6YdM89jSyAMRhbOEtFYiqVi8ynRbc8B8eIyHkQMxKcWP/Vs2ah7FcZYiZE//
 E95t51jYq6CXAFaBb9DeFAEmnaPowZRi1jo8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sD5zWbzHocJWExoRtuQpTL3B9ica4gx00qs+VGRFMiI=;
 b=FiECoaezQkCGMkQexoyAUrgsCCspjTVWjxbYYhUjicfin4yFmj3Z8xvGzxR8wKP604
 zp/F1QO53cdpg+vg4aXpkFqvg8x5ga8wRabA1Lsh9EUYSO7BCcs6vL4z7f5rZrtbQHmZ
 qvEKaO0zHjWTYhEL7POEYGf8gALtPSZCszzAwE0Q9ZtFT53CRCqaGipLFgFrTx14f2HW
 gZNmUFyAzfnM3ZJgovFW61vL2T7pWeQ82jKnFL9PDESaYYhFPhSioFW4rysTPEJnMzEw
 LIS5/xFyT3rYc+5HLjdpyNzqLgThywxpaMOMecJHSoEIkwX7DpGRA43qqsTCW5+ra59d
 p+Mw==
X-Gm-Message-State: AOAM531Q4+NH5Bn1KgR4VoslVQ4Zp4nIpFxyqjGH11zO4uDALGBNZ7JX
 vIjjB6wGLj1j9Rsq8CsNuXFnKw==
X-Google-Smtp-Source: ABdhPJxbsUNfW2zYkJ5U1gt9S92ThS4KRCfaG7hJxf1beXq2LhQ8Pbr1pnwOgOLyhcVNtuBT/v7nFQ==
X-Received: by 2002:a17:90a:13c3:: with SMTP id
 s3mr1785359pjf.59.1618271178329; 
 Mon, 12 Apr 2021 16:46:18 -0700 (PDT)
Received: from dev-yzhong.dev.purestorage.com ([192.30.188.252])
 by smtp.googlemail.com with ESMTPSA id m14sm10237182pfh.89.2021.04.12.16.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 16:46:17 -0700 (PDT)
From: Yuanyuan Zhong <yzhong@purestorage.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, cachen@purestorage.com,
 Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH] nvme-core: initialize status to NVME_SC_HOST_PATH_ERROR
Date: Mon, 12 Apr 2021 17:45:43 -0600
Message-Id: <20210412234543.19913-1-yzhong@purestorage.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_164619_959982_AFD9CEFC 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Block layer blk_end_sync_rq() silently drops blk_status_t error.
When ->queue_rq returns error, nvme driver should set nvme status
explicitly. Otherwise the passthrough command may take the stale
status as result. A typical value zero will be interpreted as
NVME_SC_SUCCESS, despite the dispatching error from ->queue_rq.

Instead of trying to fix it for every error return, this change
initialize the status to NVME_SC_HOST_PATH_ERROR during
nvme_alloc_request().

Fixes: 27fa9bc54541 ("nvme: split nvme status from block req->errors")
Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Casey Chen <cachen@purestorage.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0896e21642be..f22323d02755 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -580,6 +580,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 		nvme_req(req)->flags = 0;
 		req->rq_flags |= RQF_DONTPREP;
 	}
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
 }
 
 static inline unsigned int nvme_req_op(struct nvme_command *cmd)
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
