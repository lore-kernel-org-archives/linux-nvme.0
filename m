Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82FEECE564
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 05:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eEtfoMqDRx+yDDIa9tn7IxDCt4FsjnmGHJMKKhjALz4=; b=J/2bv9mvpI37uf0sruaXEoVa6Q
	pxLBPR0w7OOEcpmvnVqVSlKGsEu+dXia+dyY4hmHb0XJFZyVHbpWdnlk1jJXKzVS/KQTM02iMS4Ar
	4c5Kmcp4R6BcscehZHFl2sBXiz9Hllr2ldldxHRZNK4V7edBophm5lvCsOmA7lJi4+fv9WN0JrcFJ
	gm3yQg/AOwcGR8h4+yczgBZndIqkmEvRLVexYcMp2Q9O0UO8gBOCc/fz+Rhxgz4Si6L96NnEXeCmM
	cxMbjR8a88l8FR6BatlTIaWyhWzW7nyHpiYNawk4QrDfKxlF79ZIr24e5+Qqymr2F2v5cYDDBZDt8
	ny7cUeuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sntPp-00000004KQL-3D7T;
	Tue, 10 Sep 2024 05:27:49 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sntPl-00000004KPW-1uGB
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 05:27:47 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so1465161b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 09 Sep 2024 22:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725946064; x=1726550864; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEtfoMqDRx+yDDIa9tn7IxDCt4FsjnmGHJMKKhjALz4=;
        b=Yj3fducT/lpc6SakTtHhFBswaF0R9cH7h2AZjr9HwjLNQ6aU3y6QbxNfdYf5AzGCCN
         fjzXptssjbyPiDfHOPSzpJIz2E7HMSgK1NYxaXlTPkb7WF/ok9Zg6sR2Pj47liunb4Lg
         yABaWVORbg7vuBcpXNW/ksgykzB2w3O17qqZbYgg7jOVNrSvysLz6CVaPi9CWirh9Q0K
         1lnykcoEYyGWUUgeL+xZySTZOenvAcjgla5oBwP/NS4kBm3oWYPWcKaBKjTkdwd4F0LV
         XJL4PNsq+Ur0cSEjUCcr4FqQkEFxQ/aTpyn8awvQfUPxhNkXdUS7MQsyC/oWOJh5s9o6
         6wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725946064; x=1726550864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEtfoMqDRx+yDDIa9tn7IxDCt4FsjnmGHJMKKhjALz4=;
        b=jWitQ0CvOvYoW75/Hu/GEE2Q23UwtkkUgy0/JtsgX8lNrQKyQlg1bzqADH5fAulEqm
         4SsjrDqM36q87KSbGaxQrb+nXbZWcFsLqnxmdp1uTw1ZFWwO2RGurqH11budfzxlkRtA
         8zSxXA4zhbbxNiqX5/ZjgUS835TNRGrBr1DbDei+N54UeUyds0pWYuHMrZHFscMTs7te
         G9fmthjxgQLXeoLDw5E0WrAZRQE96Q1QvPlXP01hn8LUjkkE9Az2Ch7rAIRAm+0YqrOC
         /zI1ZuAj60nLllE81BM4FD7ExF4nlZFyhwd19ZOWamOOTBZCK3dCB2Dimi/zNVAxop7b
         CAMg==
X-Forwarded-Encrypted: i=1; AJvYcCUcLxLNAp+PRSJNTZFhWzBPtVuON5oGunGOLu2G41WvOJawf+V0xWYfPnOcejBrdS3AfEu/mSVPQAz+@lists.infradead.org
X-Gm-Message-State: AOJu0Yxv9cyl6ABKDlTFhl47H8OWD83F79qEuBaaoATxByYFcpIiws28
	iPImGZ5PGg7CnsU/zDJNKSgV3FC8aQhhBtcowCkpfVenZQnxW6V+9rc/bd20vaM=
X-Google-Smtp-Source: AGHT+IHnOgN8l4AA2DGC3JHppwEd1vudzhyzl9cORSWuEhDk9LrdIjuJa7Dgan1uo3vrshJ1GaJafA==
X-Received: by 2002:a05:6a21:385:b0:1cf:38cf:dfb6 with SMTP id adf61e73a8af0-1cf500c188bmr2675343637.20.1725946064047;
        Mon, 09 Sep 2024 22:27:44 -0700 (PDT)
Received: from Kuchus.. ([27.7.2.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe244esm590594b3a.55.2024.09.09.22.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:27:43 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk
Cc: hch@lst.de,
	sagi@grimberg.me,
	corbet@lwn.net,
	linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cvam <cvam0000@gmail.com>
Subject: [PATCH v2] Remove duplicate "and" in 'Linux NVMe docs.
Date: Tue, 10 Sep 2024 10:57:37 +0530
Message-Id: <20240910052737.30579-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8734m8h9ce.fsf@trenco.lwn.net>
References: <8734m8h9ce.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_222745_518845_DDF39303 
X-CRM114-Status: GOOD (  11.13  )
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

From: cvam <cvam0000@gmail.com>

Remove duplicate occurrence of 'and' in
'Linux NVMe Feature and Quirk Policy' title heading.

tested: Not breaking anything.

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 Documentation/nvme/feature-and-quirk-policy.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/nvme/feature-and-quirk-policy.rst b/Documentation/nvme/feature-and-quirk-policy.rst
index c01d836d8e41..e21966bf20a8 100644
--- a/Documentation/nvme/feature-and-quirk-policy.rst
+++ b/Documentation/nvme/feature-and-quirk-policy.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=======================================
-Linux NVMe feature and and quirk policy
-=======================================
+===================================
+Linux NVMe feature and quirk policy
+===================================
 
 This file explains the policy used to decide what is supported by the
 Linux NVMe driver and what is not.
-- 
2.34.1


