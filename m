Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F1C43460
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 17:10:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B2461168
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 17:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B2461168
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SiynQ1XsqCdejzOFMBBDJbc3JXTSfA+zDsjcGTcA90k=; b=czErKkYTNyR+nUygbtgMgY177
	SbFwbrY79klfEtBJeSZBjZNmTJ4KWMoMiA1qfcONLpHCZBfhVelEXGdnkc42hOJXAki4hh/vgV4xX
	ZyagSdfl+0f2LPkrFUFSQo0tnHbbnM9C8EnTe4vuneA6MkxSEOk+nmFOKC5AsOM4qnaTurksKS9Uw
	L6QJvKQziOX5AlweBo0LLg8wCSP3RrqpZW35xwCkSXu5eRqIhsFzjZt9fVJ4fv2UgVzUA8oW8ZIXR
	N5EROqAw/XhHIYTgJog4lDPwhSBmXtAUpfgeUxOtfmFIw0EC1LIxIj1CGEXVE+9/jSQcK46F+e2C1
	dTX58/rRQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWj1p-00DDsm-Ge; Wed, 14 Apr 2021 17:10:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWj1S-00DDpp-CX
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 17:09:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=IiDsgbUelY2suCad0re9CPy9BSIX+5NSmyWHcrZV5jc=; b=UZwiGdWumkLWbv/Gd0WitdwOpZ
 VZQVKPU0VFWqpbLwFqj58sUAJRLGL2hxk4etvpPzH88BYPxFz/YL2aSiVBy0ag6JEbL9/asefo38M
 Lwpy4hOOak+iyIsjv4aBhJ+rJt+resF8njxofTK95g4bWUZnkoYVzxxfdpDLQyJXzFEB1JYl5FoYW
 tZldwpyF8sOchXCJoix/WmOOeZyvCwilxQGCJSSKeEHtPSAgilei0MPzy9s5KRBw/78nahyhL4def
 jorDoAUAvt6RczjxXEfn3sHYB9FXt736Z6owR/TL77UoAZVMGl0SUOzNTOA7ddF3VTSFP9ISpTdhk
 JD9BD1xA==;
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWj1P-007xsF-Hx
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 17:09:49 +0000
Received: by mail-pl1-x634.google.com with SMTP id w8so8151704plg.9
 for <linux-nvme@lists.infradead.org>; Wed, 14 Apr 2021 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IiDsgbUelY2suCad0re9CPy9BSIX+5NSmyWHcrZV5jc=;
 b=K6GYVJBM2FcVCD5x6Wzz18ureogteakuIsWEAUEVHhqu6UClc1pY295cuj6ncdhjOw
 TvG2UdqQoZxkQ2t5aCk6K0iEKaRh4DzOb3IA5Ilrl2R9fEHu6LuzsLwWTMtAm89LdJ3g
 MUjGXBd0vZHFvy5HDiPbb89y4u7J6ZRK7b25U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IiDsgbUelY2suCad0re9CPy9BSIX+5NSmyWHcrZV5jc=;
 b=HJ9oKak6OzcjzddVFVWPq3Rlt01w+8OJMvB8F0dcc4JvpGadVu7dwESf745PjBINIy
 qFn5bxi730QdmufyHQKxtT7UauOM4NaIBu6ddGJHCcX495Rsddu/g0b/N7/CcNQxPUUv
 lhkN/QaSEAxO8xKYPmwrqUEYb0s41+B5tDiIm9kWWD2uozdTOVDgFb3xX9V8z6jxLRpR
 KTLhXF2cLClttRLTaH+CH4aiC1U/4mQXJt+jMkhdzFJoISUc83WeJd/lxtp3yW9JLKis
 W8hf2/oQFFRn7uSDFNeOijbCKQKqRsbJa5P9GN9k14V7qt41P/dT5O+Y5g6EVltv8Ntc
 nqeA==
X-Gm-Message-State: AOAM5333dXZbIgl9cnRU7u1KEVxaEAX+0YbDOseQ6ObQlPVqyne8Clco
 nVfhVCL07JJfX8cp59PeEZYOpw==
X-Google-Smtp-Source: ABdhPJxpc7ZjXiazGrTsyiuF71YCc1KHEkHLbcxD5UD9C+BxqlWJY087/ViQyxV/X+9yX3MA7HYIMA==
X-Received: by 2002:a17:90a:a505:: with SMTP id
 a5mr4577015pjq.58.1618420186347; 
 Wed, 14 Apr 2021 10:09:46 -0700 (PDT)
Received: from dev-yzhong.dev.purestorage.com ([192.30.188.252])
 by smtp.googlemail.com with ESMTPSA id d75sm40369pfd.100.2021.04.14.10.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 10:09:46 -0700 (PDT)
From: Yuanyuan Zhong <yzhong@purestorage.com>
To: Chaitanya.Kulkarni@wdc.com
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, cachen@purestorage.com,
 Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH v2] nvme-core: initialize status to NVME_SC_HOST_PATH_ERROR
Date: Wed, 14 Apr 2021 11:08:33 -0600
Message-Id: <20210414170833.24929-1-yzhong@purestorage.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <BYAPR04MB49656BC34E2C7AA4E3324DF2864F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BYAPR04MB49656BC34E2C7AA4E3324DF2864F9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_100947_703944_19A94D58 
X-CRM114-Status: GOOD (  13.17  )
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
nvme_clear_nvme_request().

Fixes: 27fa9bc54541 ("nvme: split nvme status from block req->errors")
Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Casey Chen <cachen@purestorage.com>
---
 drivers/nvme/host/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0896e21642be..df7d9a515297 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -580,6 +580,14 @@ static inline void nvme_clear_nvme_request(struct request *req)
 		nvme_req(req)->flags = 0;
 		req->rq_flags |= RQF_DONTPREP;
 	}
+
+	/*
+	 * We need to set nvme_req(req)->status whenever ->queue_rq()
+	 * fails the command submission. Ideally an appropriate status
+	 * should be set for each ->queue_rq() error case.
+	 * This is a blanket failsafe to avoid omission.
+	 */
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
 }
 
 static inline unsigned int nvme_req_op(struct nvme_command *cmd)
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
