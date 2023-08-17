Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDAAC2FC22
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 19:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O2zKFiMGHQtGnAkzwpdxllrWVf+BzfsOAvdanmJ38CY=; b=XLzRWzLwD/pGu5BVFgtrA1ea2h
	PgpiQxLsVcH4uj6A4xiVPUCHayVei4hObt8iT3730H9HaW15nyD8g7gHqpKjvut2ua1DXCMpIll5n
	XvXlHKR2OW/ARm7OlNhE85SE8nHxptSPegEG7xSf8q8glug+3PFO2BomF3JzjQFiCnNTKEsrbVhC/
	oO8AMuEqhP118e161vpQpUpT/e6FbGgMRHAOCZYPJ4il+CHVlOzSVaDmYLCr1AMF150Qct6q16vjB
	/MDMp/3rZMMEAeGJIGJmkogGA015E0uydDmnDGf0iU+ALHW0Ew9r/tAy3btB46/oWL/rFPN0Rpq1n
	GvbwR4OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWits-0073ia-0L;
	Thu, 17 Aug 2023 19:43:20 +0000
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWitq-0073iA-0E
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 19:43:19 +0000
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bcaa6d5e2cso203313a34.3
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692301392; x=1692906192;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O2zKFiMGHQtGnAkzwpdxllrWVf+BzfsOAvdanmJ38CY=;
        b=IHW1YFmng/yOpsQjHckR625eyENLPqyyVK0MG4vFg82m1RGV5szlXFC5RUpe3iBzXc
         KbBuFaCX2udNGaNCvFz1GAhBvD2AL81KyFf1/tG0Me5f24EWL53eU/W3yriydLV9pojo
         EbK7DHcfPmxSEICQPyvVDUB485svoSH1GIumlAidfRtrjPlsnCeCnBXORGDxKt8FnCf0
         ezcc5tdgXf3+14djWH80nkmRppwMyqwXLDbwLNWFPnWLlqmr23cEBBZMe5DwtC6zAHsc
         Fw/pTdRAC2gA1UfAAbFKuV+ffNamKY7M28WHg5jFzbC31oS349Z20e1lLwNllmgO3oZN
         HZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692301392; x=1692906192;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2zKFiMGHQtGnAkzwpdxllrWVf+BzfsOAvdanmJ38CY=;
        b=VAzLeD/vFl8j8y2EEbbSs6HvOpygrQyuTH3tuXQ9iXh8oSwcnwQRjnRlpAMihRb/ej
         6hoIXLvS1wFTyz2NlCXltcn/stfuhs1tyht1shvKRvzUbK+A8hhMRkV95VEz3LPUhNzE
         NXf5h3TNMgseFsddY4A6yf8DDq9PupmIrVl1w1o0VW7ngYpOSlXChauPA0ps0RBipfus
         pJFI+L92nU3WcmaTfZAlhCtycTZP9/pX0AWV7S7HaiPV+P355ab2QfciWugDi3LmM2lq
         L8hBNztMZbOpbjGMXtxkChm2FkmsNNcP/WV1WhAdnhWl9nlX49alKMWbbG3gjzQHXfaB
         py1g==
X-Gm-Message-State: AOJu0YwFuLZaEDP7jc6XWtoi6Ob+PHfjYyJGyGjhvdxg4lOcS0Pxqm+f
	BX5J+aBZ5tqbDPGEADhs1ca6IWYhzC1xyc9eU7v9CrwX+K8=
X-Google-Smtp-Source: AGHT+IHnkozaZDRsJ8AU+P39dHW9wM3KjNTFnrDnGOvvxZNy8bIZbzLvMJ/ZXcMhEiEvPeOHrV+2zzioImYwu7N2dUg=
X-Received: by 2002:a05:6830:605:b0:6b9:8357:6150 with SMTP id
 w5-20020a056830060500b006b983576150mr234395oti.35.1692301391923; Thu, 17 Aug
 2023 12:43:11 -0700 (PDT)
MIME-Version: 1.0
From: Nigel Kirkland <nkirkland2304@gmail.com>
Date: Thu, 17 Aug 2023 12:43:01 -0700
Message-ID: <CACnqm78ssvRVay=Q5mPhsZaWvu5-LxASKs2Dv86NiVgGXytWoA@mail.gmail.com>
Subject: [PATCH] nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()
To: linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_124318_112387_139EAF04 
X-CRM114-Status: GOOD (  10.98  )
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

The nvme_fc_fcp_op structure describing an AEN operation is initialized with a
null request structure pointer. An FC LLDD may make a call to
nvme_fc_io_getuuid passing a pointer to an nvmefc_fcp_req for an AEN operation.

Add validation of the request structure pointer before dereference.

Signed-off-by: Nigel Kirkland <nkirkland2304@gmail.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1cd2bf8..a15b377 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1924,7 +1924,7 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
     struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
     struct request *rq = op->rq;

-    if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
+    if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq || !rq->bio)
         return NULL;
     return blkcg_get_fc_appid(rq->bio);
 }

