Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9925EB64D9
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jul 2023 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SyPy6unUqhqYvr9G7zrtCVnKUSfpzIjGwEVu2KRMmEs=; b=TtFhYE+U4R4hjhdM2DNR7kcSjQ
	uCXrfZaftNozRcWp3Xw8+mZ8I/nhZ0wIc4n7xSTJ5JWG8eBiVr2/tKDBkoVchhpWE9pxzvf4cY1qD
	Yyqj0vfwZtvb4ziU1biClvBp0Ypm7SiwGdAnSLbdepfqK8yHYInai4qtoOrNGEB2KltdTWsTq790T
	/WYe7O4czusoUV+j30msDJURBHrE1ZscDRE8T6kIe3BPDNm5cunkWcIL9UjBX1R13bBuTzpSC3s57
	nu2AirahXYbceGWQyHXLA1x0MpEcWmLMRR854Ytk1GT+Jckrlcb8LqRbL61+A68lhpw0vK59+uJbN
	HoyNhqhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHsu9-005igT-0G;
	Fri, 07 Jul 2023 21:22:17 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHsu6-005ieo-0O
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jul 2023 21:22:15 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666e6541c98so1924513b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 07 Jul 2023 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1688764927; x=1691356927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SyPy6unUqhqYvr9G7zrtCVnKUSfpzIjGwEVu2KRMmEs=;
        b=Vmm5/ZSFn95kkggd3ArWEN8YD4Vx+zXwMTMJGjvtaWcgfxmkvdGOIk5EWp7c9lfnpK
         q2qMZjuJvkYAhRR1DRgNvPx9zIZLBh35a8mzNPI2iSgXpPi3ZqpXWtQXTqHgw0rL5v/2
         Xan+h+GdpbwEXQTqsFznfO6hfaPBULDCYalzqov0FXL4EpZ5KeqhytfE2cO0BYsySTLh
         RD42onGtY96DDFHG+kQWDwOeD735GT5/UDhcqDjokHz+kWHC23Gpd6jIgPhmJb2u8l3F
         nNtoeg3TDakUIWkgpCFT7fKkcj1fVxXXUKihFiPep46V+RAtDH60X0ZaRMMBjGlIIVO4
         T8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764927; x=1691356927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyPy6unUqhqYvr9G7zrtCVnKUSfpzIjGwEVu2KRMmEs=;
        b=QlnvzJp/E06EI2oCs+owmIS8dbwLBZ0cutDtyycMZqV0nvPod/+j1/ro1tIuK4yrlu
         PXZNksY9IEoxiOMHvL66SK1DdoBUsF7Rv84BkmPMKCgGxLKMAHV9NI4gV/RJG/HRRXt1
         8Lh5qqmTVqm8DDoMEngFqmSoOX7TLiUekcHaSP15wG5jIOwy1jlrA7122M4wTJLAmzdP
         5koPV4SMERQqB+u08L7b92eNZRTrWzyNCt1TRdBuWSIsnmzdz4RUnxkOstgsbm6iOEXR
         viawJNPrzyv8Gam6853hYJUqzrjwupCuz3PxV700ApUWaWhpLOGJRZMT/qMLzgtgPAja
         9QRQ==
X-Gm-Message-State: ABy/qLb6prkGcNgEI9b115uQOL46tCrmFjyxEej4DppRQ5hNeTuBmGun
	Lv17KLmu4UPVXGe8lMnqSgj4xDbvDc9UQ3L4pNRSRXYZX0pATAq92fFFupIDZSATq6L7SoXvVxJ
	ReBAtkFiiNbXIMOntPo6IQEbgkSJsrg4KtalPKCStrUsCyCI1Ab4/w9xiDozg/7wD33mxr+pKd9
	XxUYEeCCXqV0bE
X-Google-Smtp-Source: APBJJlEo6OInoDyI3skG9LQuayf1PxlBKGkminzfU/WfTyEZYE5WNcdQlGdMFYKTZ8/QCTBE+AfVTQ==
X-Received: by 2002:a05:6a00:15d3:b0:67f:1d30:9e51 with SMTP id o19-20020a056a0015d300b0067f1d309e51mr7570879pfu.33.1688764927479;
        Fri, 07 Jul 2023 14:22:07 -0700 (PDT)
Received: from dev-mliang.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id fm15-20020a056a002f8f00b006828ee9fdaesm3274967pfb.127.2023.07.07.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:22:06 -0700 (PDT)
From: Michael Liang <mliang@purestorage.com>
To: linux-nvme@lists.infradead.org,
	jsmart2021@gmail.com
Cc: randyj@purestorage.com,
	csander@purestorage.com,
	ushankar@purestorage.com,
	psajeepa@purestorage.com,
	Michael Liang <mliang@purestorage.com>
Subject: [PATCH 0/2] nvme-fc: enhance transport error handling when create associations
Date: Fri,  7 Jul 2023 15:21:55 -0600
Message-Id: <20230707212157.1158725-1-mliang@purestorage.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_142214_160346_EA2B3E28 
X-CRM114-Status: UNSURE (   8.73  )
X-CRM114-Notice: Please train this message.
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

Currently when there is some transport error happens during creating
nvme-fc association, nvme_fc_create_association() could return 0 status code
which implies the association creation was done successfully while it's
actually not. The consequence is the nvme controller could be stuck in
connecting state infinitely. Also there is a potential race condition
between transport io error recovery and the last ASSOC_FAILED check in
nvme_fc_create_association(). We may end up ignoring a transport error during
connecting creation.

Fix these two issues by:
1. Return non-zero status code(-EIO) when needed, so re-connecting
or deleting controller will be triggered properly;
2. Protect accessing to nvme-fc controller ASSOC_FAILED flag and nvme controller
state transition under nvme-fc controller's spin lock;

Michael Liang (2):
  nvme-fc: return non-zero status code when fails to create association
  nvme-fc: fix race between error recovery and creating association

 drivers/nvme/host/fc.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

-- 
2.34.1


