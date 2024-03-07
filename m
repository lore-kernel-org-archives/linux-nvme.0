Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8519AC54E41
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 01:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eye52Nq6DzbsyvcGLe6F9NZyI7E9KumQ8b0lW6PgSb0=; b=meJ/04Mf4uihqsf5THkVLwYNdF
	XFXjKgAllezAGQLDlpoFnOu4TjAfqFNUFOI4lVYRBGY/qBfuaDgEVDwQ2/VjU61whqtLGgieu2/Si
	hd0pH5gKfce+xvJq/4/tlq5aHrCMbblJ4bT6X4CTVZ9a+Fb5dbiEC6GVp2WUfXdv5ImOTAuJEN/qy
	NKDUlwVQYpF/kheQF141zWHXArfdkh5tbEs48wnl7wB/C3Dp2nK3g7c0paCy4E18/xgFPDxFDn3um
	+XVUAB21o8QwpQMcw2mj1oS5NGS0d+rD2T7EjOH7riNilLQqYBl1cgnW3+oPbYrKr7yKXUkYMOhSY
	1Fh0q8hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri2Cv-00000002TM1-0Gz4;
	Thu, 07 Mar 2024 01:06:01 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri2Cp-00000002TLS-3P1I
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 01:05:57 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-78845b93490so18012685a.0
        for <linux-nvme@lists.infradead.org>; Wed, 06 Mar 2024 17:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709773551; x=1710378351; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eye52Nq6DzbsyvcGLe6F9NZyI7E9KumQ8b0lW6PgSb0=;
        b=L1gNJs7h3R07YD0zukvLYFWHrQPNGqEGG5uN6DeZW8NGlhMdVEVsCXu5E4Yo7lSZ04
         DRIpUqSjme12yaeQwDP4i711RaDdUeUNUgX4Kb9dAdCpUoGd2E+1gQqyL75U7237ZTHV
         puZBPpJXXObBgSJdhQ0Ru1Bk9nr0Z9WiiuzFXVQnuQn/CCXiwuzOYeTvDBv94dCJLHDP
         nN7I9K3IJ9P3OrX++O0E8oCr1SbHFFtxYeI/BIIye7gxth90hF01FpAOvR1BwoRA0tuB
         LoV/BT7ypaka3b32z/pj2kNjK54XLe6W/X1BlnjGOEDGRdwNkOUk6D9u275pdgOt3Wfp
         Z5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709773551; x=1710378351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eye52Nq6DzbsyvcGLe6F9NZyI7E9KumQ8b0lW6PgSb0=;
        b=UQ86UIHBjOOZi6dl7adGQX9WmmdDyynBj5kPjjjQLgHjvvcCci/F89CfzBgEQOMEzW
         IpTBk7TrLV9Q6g8XifE2OviwTGNNP2koGf2oEdz9AigMR+OUB4wSsxxhA+h51b4CspQ6
         I8LvEe70cvB7u5cYQ+JMZo0lHOOVG4q1cIbxB6arxfFmcsKRVB7ANs39w2wPOMRC7U2j
         et2tM6eP1uaKTzDJxHNiBsjMmlfgL8BVConpKjLyprKd6090E4cNM+ptN/1WYwYB3KHE
         qFYqCzQ/EM/xNgCs1hTl7dJ46j0SwKnzRzfX98Cxa6qWgrhdU7CYA5bW4d3OO+MU6rv/
         IAsg==
X-Forwarded-Encrypted: i=1; AJvYcCWVpIrjYs4mjIjaKVgogEmKNGqr9qyxZ+SrNlKegPj0eTD/DNdeeeEqnrgeV7Dqvwk4v136v09WmCCjQfw5QRXEee4NQncw9HJtNLpZmiI=
X-Gm-Message-State: AOJu0Yya24LSgV/VFdBPbr9x5LQfrKOS0CDBnh9dMSq4va1L+fTPZJLj
	DKs3L5Emg1yK4uPaP1bibg/UEskeA8pZRsjLgF3Ex1Cl1G4cTIga
X-Google-Smtp-Source: AGHT+IGyve37Ve4gfumbpnNvgXbbOC150hHHz+8iZyxrlteaRw4CD9TaTx4Kw/5ypIPliQjHE2M9fA==
X-Received: by 2002:a05:620a:5627:b0:788:2715:8074 with SMTP id vv7-20020a05620a562700b0078827158074mr7093388qkn.27.1709773550898;
        Wed, 06 Mar 2024 17:05:50 -0800 (PST)
Received: from lenb-Intel-NUC8i7HVKVA.intel.com (2603-9000-9f01-67cf-d46e-8590-8b01-6ff9.inf6.spectrum.com. [2603:9000:9f01:67cf:d46e:8590:8b01:6ff9])
        by smtp.gmail.com with ESMTPSA id vq5-20020a05620a558500b00788242166dbsm4256558qkn.133.2024.03.06.17.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 17:05:50 -0800 (PST)
From: Len Brown <lenb@kernel.org>
To: kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Cc: maxg@mellanox.com,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown timeout
Date: Wed,  6 Mar 2024 20:05:41 -0500
Message-Id: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_170555_882906_ED22D416 
X-CRM114-Status: GOOD (  12.33  )
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

From: Len Brown <len.brown@intel.com>

Some words are alarming in routine kernel messages.
"timeout" is one of them...

Here NVME is routinely setting a timeout value,
rather than reporting that a timeout has occurred.

Assuming this message is actually useful to somebody somewhere,
let's make it DEBUG level...

Fixes: 1a3838d732ea ("nvme: modify the debug level for setting shutdown timeout")

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..e361af1953a4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3205,7 +3205,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 						 shutdown_timeout, 60);
 
 		if (ctrl->shutdown_timeout != shutdown_timeout)
-			dev_info(ctrl->device,
+			dev_dbg(ctrl->device,
 				 "Shutdown timeout set to %u seconds\n",
 				 ctrl->shutdown_timeout);
 	} else
-- 
2.40.1


