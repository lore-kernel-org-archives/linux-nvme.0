Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97610C77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=52xl1+Xc+PyJxrkH2dti/MbJeGl5SGLlljunavtsP7c=; b=QySrzkIsl0qRgV3hJgy3iI6tgj
	XyEmAUxAFL/NHOKlTmFcrl5RVwfa/wt+Mx6v5JpBIsJu9oDleWQjTEz2qCwcyBatPyzxFAHOUCfSF
	OJHe4QVEVBZMEsmLvewFlc3jkZnLjhJFTy/kweTmV4dv1zzEzUtoeqcMUtyHIrU3AmahVq9xdV8oE
	ncyjsPDhVVZjPkGy4X3i7clJNZsc9Q7/NxMfzTBw37EnGZLGoaENDahJRVeJYSZnOTNsd6nUWPLqQ
	G4dMEkRKolJdBhIgiBrehBdoaaKmhOKvGTmWuJP2WlmxzR7QhTmO3MqXe9WeRxbuhvj8SvHsYifaz
	eiw9osMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzlq6-00EJhm-1a;
	Thu, 18 May 2023 22:11:14 +0000
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzlq4-00EJeR-1I
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 22:11:13 +0000
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6ad13a1fbceso1978681a34.2
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684447868; x=1687039868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52xl1+Xc+PyJxrkH2dti/MbJeGl5SGLlljunavtsP7c=;
        b=kfv8sAo2XoDhxhrWe228iI8il44uEplAif6/wILB+fu7ti/3CselSuJqDHPwy87HnC
         31I+PqWd1wFGbxGEOaXvD0A0VvwA0hjDTKEYPVeZsSOlxNLaIIXE09UKamVwMJYwgSXq
         UV4Qty5US++MpAP+TEaxaNef8OwbRsCyhtmnB3yUd5Yvs7LbNuL3v3OVmdSwXCr+zcim
         CY/52Z+yq7B94jmwWOhWlxWpLLzGo352Wi2eoiXiTHDwNPHKU//Vp1qvs7hZRKdRCPF2
         Fc609Y24sYYuPy2Vt0b+N1PjtN5BuDvwoDpocehqITijEml06NcF38WtEScJi5D0+jPr
         Z97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684447868; x=1687039868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52xl1+Xc+PyJxrkH2dti/MbJeGl5SGLlljunavtsP7c=;
        b=SBLjKinfxd1/GnEvIIGQOmdZxzmk62GkM5dwKgiimSYuTjCHjZfH5brZ6hw0pExJJU
         A7p5Zz2JGkmEhDoBJhNwSCpSsm5OLmSW8+mDuXialZFcPu7o1u8fLOJoUl6aIERWXNgr
         DI+2rE16Yac2ywqkubVQAmwFFHwQZ3otWqiwFzYON53t6rMeyeEFaFUjbdR2b7CP4H4e
         HkDtPcNQNsoBeJz4MlI3SOklI+SRhcG/LYjq0dphmKBmgKZ0h/clVlSvt4wCREa9/U9a
         9pJC6EeoxR8Mrhz2a73pYsjqISvno4QZn5tYFJjEVcKRqq1nLUvMsvCQ2lpLrLQgQDUh
         YCgQ==
X-Gm-Message-State: AC+VfDyznt8c2lQ8hvCzhx/ZryTQaf2S8ossrRnuvGt/X0C742Lm/W10
	kQ/f61vNnf1+EBVpsgmafRo=
X-Google-Smtp-Source: ACHHUZ4S7EF0AftgIbok4QUd0jsSMoOSAKw2XgIvZUQuFNlvazGiN0UfTFuFnUSuZlDe74iVULqRCg==
X-Received: by 2002:a05:6830:1086:b0:6ab:1890:7ff1 with SMTP id y6-20020a056830108600b006ab18907ff1mr28536oto.18.1684447868614;
        Thu, 18 May 2023 15:11:08 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.195.153.187])
        by smtp.gmail.com with ESMTPSA id p23-20020a0568301d5700b006a42e87aee4sm1092262oth.32.2023.05.18.15.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:11:08 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 2/2] nvme-core: use nvme_ns_head_multipath instead of ns->head->disk
Date: Thu, 18 May 2023 19:10:54 -0300
Message-Id: <20230518221054.56378-3-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518221054.56378-1-irvincoteg@gmail.com>
References: <20230518221054.56378-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_151112_437631_B238E974 
X-CRM114-Status: GOOD (  12.46  )
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

Change the way we check for a multipath nshead so as
to consistently use the same check to assert the same condition.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ccb6eb1282f8..c6889cf4439d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4310,7 +4310,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	 * instance as shared namespaces will show up as multiple block
 	 * devices.
 	 */
-	if (ns->head->disk) {
+	if (nvme_ns_head_multipath(ns->head)) {
 		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
 			ctrl->instance, ns->head->instance);
 		disk->flags |= GENHD_FL_HIDDEN;
-- 
2.39.2


