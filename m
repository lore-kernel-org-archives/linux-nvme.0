Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393D4C7EE31
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 22:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gLTvYWHsUoFQOclHF7noQSBVeXqR6YLngZYWA0NAmiM=; b=rohKf6dUmYoLsG3C30gxw2FDD0
	PxAFytBPcbbrhy2NeAse6q0Hm/3zN/1f2v1ts08v+ENe7OsCQT8GUUY8nEv7CJyonpc4LmC+Ewz/n
	gRYjILVqJDnDn1zN25yl1n/5UmV7ebT+OSliwOTLS80EGh9nsxbHJaoXr0LYVOBKlMu+zk84DXNYn
	vgVwaqkJ+kk8T4PkZVtdlXKxZepcD/eukHcg4WFA3XUbZYCmuZYt6OH74TYy8344uHKC9LqVrplnz
	1mpUIXKfmFlthsVx3qo+q5c/M6e0XQr1cacoTVJEiJwrhhhIRo/HgggsP0sC9ThmVGLGfBzB/Tqp5
	3W6e9g4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q47oO-00FJkw-0x;
	Tue, 30 May 2023 22:27:28 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q47oM-00FJjI-0a
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 22:27:27 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39a4f37ed11so5875b6e.0
        for <linux-nvme@lists.infradead.org>; Tue, 30 May 2023 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685485644; x=1688077644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLTvYWHsUoFQOclHF7noQSBVeXqR6YLngZYWA0NAmiM=;
        b=KQQjV0sfiKHASYnmI8GaBCEPgTb1RNqkFxfWATMBygUnEVuLNm6adG4J5pRkQ1T+dW
         eXeK5TnooLj0+ipRZn40OBLV89i9gFZ5etMU/8LFNPsYPy8DkwRDTDxdUrAC4BKFNuv/
         STU85IF1dp+qXeRbl6as+Nvx3bPAXRCd09czKRnUJmoRaJqQHl9Waw6vCJan/R0PeqEQ
         eAWqWPV27wuq7tmz31dXlkf2jhbiJh9w/AwoIJ374RX/RIYjYk2tnoCEIVXY+7FA1GtA
         mvkGUB2cLvCfAAh3ZLyWuOiJWm7ACY8NKrU1EUOvzb8gguXrvNRgc+HPK5f+gIEGg8G8
         Pksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685485644; x=1688077644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLTvYWHsUoFQOclHF7noQSBVeXqR6YLngZYWA0NAmiM=;
        b=k+YwFD3A+iyCXPL+leInTm8qioQf5CfMJQqX6UY3E5QVg7kTZey7qAQ+4SV2HabSNB
         dqZvCNUl7CY1L0H1krJqozCImqWtooAxVKEFIflc3O6LsqEvf1m9sP+4bv5Tj6o+idZq
         u8YmLy/GQJ/CugMlVAPJl0VcpQvdawVSqWIbwizDXQtb+rBouBp/1GNkyOmiv0vHSERw
         aQ+53+u8o7P4h9I41vbbrsejZyhyLeyOPDYMVsp4h/A/eBkRq/avQYCRUIXWq0GFFI1y
         4dV1TIqvSTE0qEJSyAoR6uMGmKQ3VhtsQwvafZcePt3CfjHZBcs0L5EoJWVykKhuE1J3
         pyzA==
X-Gm-Message-State: AC+VfDwPrf/5oOkkLXRguBgke2elvbXawGNaSg8J0FpZZTHpSDf+33AP
	5cuugz7TDvJSmFRSIWiJ/N0=
X-Google-Smtp-Source: ACHHUZ5EyuAbyeGOJ1LVeegzT/f2U3irysr8R/RIT+eJ6F3L21x/qpg6jFBlDevRLaXeLBs9EKy3Cg==
X-Received: by 2002:a05:6808:4ce:b0:38d:e632:8302 with SMTP id a14-20020a05680804ce00b0038de6328302mr1785959oie.14.1685485643983;
        Tue, 30 May 2023 15:27:23 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.193.134.103])
        by smtp.gmail.com with ESMTPSA id o10-20020acaf00a000000b0038c35f512a2sm6359041oih.56.2023.05.30.15.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:27:23 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 3/3] nvme-core: changing comment on disk names in nvme_alloc_ns
Date: Tue, 30 May 2023 19:27:09 -0300
Message-Id: <20230530222709.28682-4-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530222709.28682-1-irvincoteg@gmail.com>
References: <20230530222709.28682-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_152726_220657_16CC0FC2 
X-CRM114-Status: GOOD (  11.20  )
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

The comment was mentioning the name of shared namespaces when
multipathing wasn't enabled, but we don't support shared namespaces
without multipathing anymore.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6aa160529887..197a30a59c99 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3661,9 +3661,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	 * namespaces could lead to naming collisions between shared and private
 	 * namespaces if they don't use a common numbering scheme.
 	 *
-	 * If multipathing is not enabled, disk names must use the controller
-	 * instance as shared namespaces will show up as multiple block
-	 * devices.
+	 * If multipathing is not enabled, we only have private namespaces and
+	 * disk names use the controller instance.
 	 */
 	if (ns->head->disk) {
 		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
-- 
2.40.1


