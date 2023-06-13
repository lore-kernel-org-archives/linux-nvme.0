Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD9BEB64D0
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x/LIWU8Andt1zuMi+LeYhK6DxUg6+XxKywQDPaJDelM=; b=T7FIYjOaMDb7dCqroZUkQbeR9g
	RPCwbeAsJLNsJkuNVG1+iOPldlA9gD7+7NlfhsKRjtt/XPXncAtaGCaNrGyp0C1jykEJ2YGuiT7IA
	ZN3WNf/HFaXJEnFE8SdjSzpgtUY7USvywky+DsCy6SA5PbfhFMVBB7VmGmiGSDphz2XcIyymIeSNK
	OfKpe8PZmPV9/STV0EK6Dl9hAR0aTsoTxQj7XWZCPROyCrldd/wrvEs90sp1JOnNRFgfH5dAbeGu8
	OB4Cvte3mIbbW7G7P1Yu6lkfovhzBYpj+cULbPAF0Gsqkim3xbYEUXSs3McOIz9QI97tXJ2jBl2MD
	ZXRIZlCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q97l0-008iqk-0z;
	Tue, 13 Jun 2023 17:24:38 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q97kw-008ipU-2I
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 17:24:37 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6532671ccc7so6148992b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jun 2023 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686677073; x=1689269073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/LIWU8Andt1zuMi+LeYhK6DxUg6+XxKywQDPaJDelM=;
        b=rwqqhB+Ev6cMEvDNKGrk20Vo9Xh55zNE4My/ypyyPzEeMqPpWlbV1li28nqXfstEqW
         2VYqBkV8gIPVTHp9B4chL9zjxxrKkQppVTKa26nWoNnlxud0T2LDDvhlh8qbShM7gDxK
         MLr/svDd46seLb82i5kIUNS8M4qAhpOnuhE1gyElvqJRKt6FUi6OQqqQngSZN4uI3wLD
         OoNd03lK4zI5CaJOT5tr/VTRiY8afa4diK1jYvyGT19iYf2YehWsycUVgvjfziInDDPw
         lZBrJ5FyphRahWpFAz+YtxClY9XHKrgnTgagSyN4h5maq/EAPFS2yoXHC9dEhfpkriYA
         r/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686677073; x=1689269073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/LIWU8Andt1zuMi+LeYhK6DxUg6+XxKywQDPaJDelM=;
        b=JmqrWE4tkTFR/mEmTJfjc7xM//XdLWsVv9g6Ve27byqRgOURmMXByFREa4z1WS+IT0
         oVk7ix8Ig6+OXUtYeMWG77lmcUmvZV3SJa5mKdytLk6SECDxp5KrMeG8K45LkH4G3K8G
         tjPHWZKvc1FzeM3DAqdWzeOEegVnV8a4v+rEplShcfEUk3VZN1XSTUUQ4KLHER80zcS0
         5GqFiWWLpv/5LuM2FoJ3p21rm8I7cikGnHYh5abc1hoLPUxYkaXUjaHtDr6oHI/XTZFB
         zxn4xM2Ds3OpnDvXqemv+TAtmoLtuWbzcWaj+ef+vys4UwXMlG26LmhqcD5hvEKJ1fO7
         wo4w==
X-Gm-Message-State: AC+VfDzMUOrE1vtQ5/8VDoy3wUFDUlnT1HNopi5WVHvwDb876sIXteJH
	qlBtVlK8PeqUCXkz/+JLYAn3soDmLUOZ2g==
X-Google-Smtp-Source: ACHHUZ6BnobtayShAoB/Ye6sO3MvIx1dR9c7TcGSOcqNRaGqpezyU40u7WuG92uD6DjGJBmR82HGfA==
X-Received: by 2002:a05:6a00:15d6:b0:659:3031:5037 with SMTP id o22-20020a056a0015d600b0065930315037mr16523659pfu.3.1686677072571;
        Tue, 13 Jun 2023 10:24:32 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:9f79:ee88:c7fd:4212])
        by smtp.gmail.com with ESMTPSA id l6-20020a632506000000b00513973a7014sm9528179pgl.12.2023.06.13.10.24.31
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 10:24:32 -0700 (PDT)
From: Atul Raut <rauji.raut@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: Fix debugfs_create_dir error checking
Date: Tue, 13 Jun 2023 10:24:21 -0700
Message-Id: <20230613172421.6988-1-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_102434_769706_8C80F23A 
X-CRM114-Status: GOOD (  13.80  )
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

The debugfs_create_dir function returns ERR_PTR
in case of error and the correct way to check an
error is 'IS_ERR' inline function.
This patch will replace the null-comparison with IS_ERR

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/nvme/host/fault_inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index 83d2e6860d38..1ba10a5c656d 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -27,7 +27,7 @@ void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 
 	/* create debugfs directory and attribute */
 	parent = debugfs_create_dir(dev_name, NULL);
-	if (!parent) {
+	if (IS_ERR(parent)) {
 		pr_warn("%s: failed to create debugfs directory\n", dev_name);
 		return;
 	}
-- 
2.34.1


