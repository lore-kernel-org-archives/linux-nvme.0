Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B218C531FE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 03:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ROLPQj1JsknI7CLw0SSjV12TwHbOBrfd3E+ueRGmUuo=; b=pB1uyk6XK79NrXmjPFETv4CyhD
	TvTRq4joEl+/T46ECHDdIQri1McAW0S/8t2i9/44jX4GW2XOIPpbImf4go8w6amO8i5O7Pq64IoRz
	nVqPNsD27gto3YQ5Q5WmdCPSLJWBJ03uIfOecuGzMq2ASJ5EMpkEPJG1Exeq4RxPuCv9ak0Z4yBM2
	oiaUZP+yF3WmUiA2O+gpk7eoHNucXVw6jIwXX325k2k0cTgHFIkzGx/3RN2KZvWF08KjGED+Tjuku
	ngjfTwW3fK7yMkqpJOxqFWJs1ndiwiqyt+VJ8LE2JQYcoZP0RiRoK1rvpCXQWxCiQjDYsX4suUtQl
	4JjpUYzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBl-0000000DA9H-35Dl;
	Fri, 20 Feb 2026 03:28:21 +0000
Received: from mail-ot1-x361.google.com ([2607:f8b0:4864:20::361])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBh-0000000DA6m-3r7S
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 03:28:19 +0000
Received: by mail-ot1-x361.google.com with SMTP id 46e09a7af769-7d1a2680f96so263718a34.2
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 19:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771558096; x=1772162896; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROLPQj1JsknI7CLw0SSjV12TwHbOBrfd3E+ueRGmUuo=;
        b=SycpWMJQfnwJY1PopxJYChmKjdXiR9LEb5/Bb4U3Z9hqD/orV9B4wk8WqM+IAWlUkm
         kXgc/H7jMEQOXaaBVxiwj34fAz+Z0uCOJNYShmONNAIwiFrT2UiuKLpAgng2ceMFmJAd
         Z91bSHFFDu474yKTm0VIpVc7fWbvxQrKlo4f8naW0wCt1JFcqLNEnnxWajKX/m9M/xmR
         c+9pD+VVXFWvQCRYbFuI4jm8JAoOp+25f9aOwaUGDIqdIqIlfFdy+uyKRmjW3Z0z1xun
         UDMURLuE/LxhujO94qR9QMGDIIeVyqNP6dDmxHSZcfP8m9Glt0zdW+SCZLl/g0qXmZmJ
         71RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558096; x=1772162896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ROLPQj1JsknI7CLw0SSjV12TwHbOBrfd3E+ueRGmUuo=;
        b=vfmOo7ZeKHsZCrp9aQKGtZCHUB+Vr5ZPQoy8H9ZYy7W3+UgMStlADgIagkcGY9l9G6
         zPpObn9kXjDOyF7O7+J6jQMPE6dCW9dgugmzuJ0yL9fq0eo+pB0A6WEdwGAY5lPJlQxz
         W+RbZabT1MDOZ4KZCM+OmuCy0ANlU1bo4l4CnMC97Aihipyx1Vxngw54A1ArRF7BfK47
         9B5/oc/rZe1PO5WXVulFOnKKTRe0RsMtMZCioGKlnGkCNmrduF6CNC8r2E2ftF9lpprz
         VQNHqjhENWzYXbMJ0vcsFIMWMUsA1V/VbnomxfWAiuRdzsYVnYnQ2R6E7pbXyC9pGvLC
         fgNA==
X-Gm-Message-State: AOJu0YwOqCjrIKQX3mezp6q1mxirWCQGSM1kqq06S07Z8pPJBTSacbWl
	d/uZuw6fbNdjeIWxLeY3YrRFXgydeyk+AoQObwYrPYq0tSFccfIWHzuG7ttsWqwpN2lZRbpJKYz
	vdlleEmG1fQPMk11HlznNLgSJvvkaNryjkvCE
X-Gm-Gg: AZuq6aIJIaoM7tQa88ktNflOoLzr68OZONkRfKViGdXWKyJAawfijSUPpXv2R8AqfwB
	STHHq1CjW5vmm9nV3+PncMqPzr5X4JARxPt/tf5g7DHR25uL+Ghi6H5s6iGonkwQTB5TtoHNU4+
	MEwvLMTiGPm7rGzGBfe9+/8Zrumq/HdwdHdpSFWCo2HJNTQN6CtPQVTo5TQLIhHAUWlV8ztDmGU
	kHPF6Ib9G8WbHGetpk5wKh4Dj7GdHpk/l38+EJw0nRtWL1KxU0EGqr1jbZNhWbfNxEcyvFUlk3I
	EYldAtk/cGRZFSUMYPjriEyzwaAFUlYDibh+KG10/WPdtunA17gkt7sr5oOdzi6erbsPA5XUkEn
	URZHqOXNPqxy+mdj90fARbh1+m9xHOHO5xDBdm26wh7InF8x3U3W5nQ==
X-Received: by 2002:a4a:de01:0:b0:672:bc17:221 with SMTP id 006d021491bc7-679ae7dc8a7mr1836862eaf.1.1771558096335;
        Thu, 19 Feb 2026 19:28:16 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-67817ccdbe7sm1973163eaf.2.2026.02.19.19.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:28:16 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D13AC340705;
	Thu, 19 Feb 2026 20:28:15 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D034DE420F8; Thu, 19 Feb 2026 20:28:15 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/6] nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
Date: Thu, 19 Feb 2026 20:28:04 -0700
Message-ID: <20260220032809.758089-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260220032809.758089-1-csander@purestorage.com>
References: <20260220032809.758089-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_192818_074824_7F7E80AA 
X-CRM114-Status: GOOD (  11.91  )
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

A subsequent change will use the NPDGL and NPDAL fields of the NVM
Command Set Specific Identify Namespace structure, so add them (and the
handful of intervening fields) to struct nvme_id_ns_nvm.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/nvme.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..bc991d4ae89d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -511,11 +511,16 @@ struct nvme_id_ctrl_zns {
 struct nvme_id_ns_nvm {
 	__le64	lbstm;
 	__u8	pic;
 	__u8	rsvd9[3];
 	__le32	elbaf[64];
-	__u8	rsvd268[3828];
+	__le32	npdgl;
+	__le32	nprg;
+	__le32	npra;
+	__le32	nors;
+	__le32	npdal;
+	__u8	rsvd288[3808];
 };
 
 enum {
 	NVME_ID_NS_NVM_STS_MASK		= 0x7f,
 	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
-- 
2.45.2


