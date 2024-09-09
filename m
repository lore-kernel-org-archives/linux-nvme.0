Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1ECECE587
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 20:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XIpVNTIU7AkD5qFomoi/slMfyi8wrL5+kfsNJ7Mu8EY=; b=zY3aukKRrOS3Wu7BabWrz003Hm
	CXA8eRDsNeTKeLzcv/Jm/koAWtqRflhQzEJYzCvxFI3WKVtQ2CBlFNYxdT2A+n5PAkNEGAIBslEPx
	7Djip957/e2ApPLgHMy9a7pilRqT07RazX/MEqwR+gtqybHxiWomRNbiuyyvlNiNNMc6UH9dxtFO5
	yn9QQslddctKhURC6uzLU6LnJDE0hqWfVhGe9p+SsFAqFumAiCgBfEbfZ5yHfIa4rXKSlNTxhjIUa
	TjMlx5bp5cGdyQH2jLpNq2JcXUul/v/bjPdHLH2QCqVcCmTHfRFqEfpzR4VJSi48AVKyOA12K3oy8
	IBEOgkqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snkbM-00000003ANz-44lB;
	Mon, 09 Sep 2024 20:03:08 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snkbJ-00000003AMb-3gF9
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 20:03:07 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so3198048a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 09 Sep 2024 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725912184; x=1726516984; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XIpVNTIU7AkD5qFomoi/slMfyi8wrL5+kfsNJ7Mu8EY=;
        b=T+PNMFd6+7k4TFJSZZg4bziImBnLTav5mHqLYJ0/YITtUer/4esXA+MYJ4oEFRPCwp
         XrCqfChRfRefvdW2eSvmLIDrZ+7B/PgIf9+dTtYiNl5k3KUj6WSwhYGhBxzGMlHMjr3F
         n/LKKAp1/kWmy/cKdeXPanjuGynlxuR10EuPfBsM9+EXj/ah1ABl6TWwuSuRtltodhnq
         bi43B/FMhnDEmQzsWUBiPX6mrNkEYy7NiSmH/+dwH+kh48DBaOX6iyiCDCJN5WBwb1y1
         EC1fEZjcLgZAUDNoweXw5LhxNk5mww0ph39XZsf5AT44ds8GXqx0zKGgDvNvOZ/39xzO
         Y17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725912184; x=1726516984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIpVNTIU7AkD5qFomoi/slMfyi8wrL5+kfsNJ7Mu8EY=;
        b=Oj71xgUFRxTzVztmtiavv4NdX9U/ew3XBibBpbfQfXCkayJWiV/lPpspP8hP5goDk6
         Jtb+bZX8db0/sjGaavey0mQo/oHqpP/eWSgx6L4X/5VVjY+YdKufdQdUYls/5QGs88ML
         QxzakLCx9iP0ty3hfwnxOx3BbH0q53GaThLv1/myX1pnIlgpDpNoPwA12QC1XSa5yMFk
         PmGg/h8y7WveHIp3b/cm7+eI20GhkU+tErhsQEAcysfwho7TlA+fqRKtYJ5AO7qlA3DN
         19uSvyM1IB+wscvmo3OzEpJl2IfXboL7pu6oGBY7fkOVX9yFSkirC+PZeba7mf+kFwhT
         RzKA==
X-Forwarded-Encrypted: i=1; AJvYcCWygveGj25F5ca14/riJnwYgsXiVzifURMTcCm31FTqIRniovZuRds5GYGonO1cv9KSg3iSk22TisIc@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+s5YG0hEAJHKYGPbxh7/yAbjnRGhLI6nrplXgGg4+nBILMWQp
	6awaPEulfZrb/7UKMkgvVmnE0MdEp5kSpWH8hyuVI1ZYOqGYaGqU
X-Google-Smtp-Source: AGHT+IHPYLUqDL9wxAHrYhKP1C7rVJvZOr82JaMztbBhc457FG8zFTv3sXRmmYAsW5VdVnxAsMdvRA==
X-Received: by 2002:a05:6300:4c:b0:1cf:32b6:bcd with SMTP id adf61e73a8af0-1cf32b60ca3mr9822622637.33.1725912183946;
        Mon, 09 Sep 2024 13:03:03 -0700 (PDT)
Received: from Kuchus.. ([27.7.2.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190909222bsm110594b3a.115.2024.09.09.13.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 13:03:03 -0700 (PDT)
From: cvam <cvam0000@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk
Cc: hch@lst.de,
	sagi@grimberg.me,
	corbet@lwn.net,
	linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cvam <cvam0000@gmail.com>
Subject: [PATCH] Typo in the file 'feature-and-quirk-policy.rst'.
Date: Tue, 10 Sep 2024 01:32:53 +0530
Message-Id: <20240909200253.19818-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_130305_937276_CB22024F 
X-CRM114-Status: GOOD (  11.41  )
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

location: 'Documentation/nvme/feature-and-quirk-policy.rst'
tested: Not breaking anything.
Signed-off-by: cvam <cvam0000@gmail.com>
---
 Documentation/nvme/feature-and-quirk-policy.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/nvme/feature-and-quirk-policy.rst b/Documentation/nvme/feature-and-quirk-policy.rst
index c01d836d8e41..b5461aa303a4 100644
--- a/Documentation/nvme/feature-and-quirk-policy.rst
+++ b/Documentation/nvme/feature-and-quirk-policy.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 =======================================
-Linux NVMe feature and and quirk policy
+Linux NVMe feature and quirk policy
 =======================================
 
 This file explains the policy used to decide what is supported by the
-- 
2.34.1


