Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4955C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 19:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/HMLr1VEFYiSbef1vxcPOJKrKcd9Vx91gHY5Q9Sq/dM=; b=L9B6i23N0Y9eVyDjsRv3C76pyR
	Cy88KrOAgaTAT0xeXPWlXbucOQW5bX7VpsTUESpjny8vMCJfFPS6UuzubASE/2P4ojYMGaxbAr0U5
	pPuA0DKbhh1IwRSgOGiKh5Morq3vnus7Rg6H6pqbmMTtd9GvBmOXjEc4NyHEuBYov9/MDHLrDsb9E
	oUk/CY5bQcYKjvwsRnxgMLveFGRkGg3252WSkezUI1S9sPHlUHyGC9hr/U2QaLJcBYH5BRZXB4vV0
	CfPMgOoanoePqqvKvqln5PO+SggPy1nhgXwX/DYcEikhnC1xpd9N8dNE52kDWc3T/ToiRANvaZZ+2
	BTDxxi+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os8HZ-000E4R-PR; Mon, 07 Nov 2022 19:59:45 +0000
Received: from mail-vk1-xa61.google.com ([2607:f8b0:4864:20::a61])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os8HR-000E41-I1
	for linux-nvme@lists.infradead.org; Mon, 07 Nov 2022 19:59:39 +0000
Received: by mail-vk1-xa61.google.com with SMTP id e16so7461302vkm.9
        for <linux-nvme@lists.infradead.org>; Mon, 07 Nov 2022 11:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HMLr1VEFYiSbef1vxcPOJKrKcd9Vx91gHY5Q9Sq/dM=;
        b=VHTIXsK3xUdRgZb2pDbAx2ltVex0PiyP4Q078yLLoszVlSFpEdOxinCMvhDsCSLoi1
         WGS8pJBX1dSBNsMYCkrMipyqADpHkyOmMEn/pHHQJhElzVPOdzxtdIRpsOxMj2SW1960
         30KRf0HC4iRNgchHxeuVckgZx/ah0kxsuo2JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HMLr1VEFYiSbef1vxcPOJKrKcd9Vx91gHY5Q9Sq/dM=;
        b=Z4tDkBqNY7gvHaZJZ/Jg4XU+0/kdHsdZXycYg+YWSHtGprfN9wpSBqzzrCPZPmnhQM
         HPMsNiOZxL0fIIg55R9P7Cy5LwfcZhTBvcvdgQki35iWXGG/lF0osOmLvG+ylsjFic+B
         pG986iCLLcvPX0nR2Ucs6eN0pX91qtND+vuAQwkajqt6a95gpzNFfS09tKDwEeR8F9UY
         izWE7ASD+WuvAoCbbKh8qA6EJ8lq70qsWlAxblRx8yeWPEuHLjOLT6QfW19MbMWewZ4j
         YLpRvAPv/COdHAiMhPU9J1MzOJNFNW1cczZ1F95n34ddNf2/3Bjrv933K0Y9dRH0pShB
         Ny+A==
X-Gm-Message-State: ACrzQf3TpDbhsXo0i6fp/LKCWp4tWPzufO9kDFBW90UHWaQ6FAt917Sr
	j6mGtIWOynmdAZ3zl2v0CMmlWzgNB7T2JRR8tN+2hQ9HDSQyG3YF3aAGvFqjkiiCkA==
X-Google-Smtp-Source: AMsMyM4LRm00xX0gKaM+33w8H+cJzUws1QHlm7M0uHZRhVP2yzfGnl/9Z/uFi/Zc3RP5hV5beCqWWNYsN4uL
X-Received: by 2002:a1f:e1c2:0:b0:3b8:ae7a:7588 with SMTP id y185-20020a1fe1c2000000b003b8ae7a7588mr7884023vkg.16.1667851175197;
        Mon, 07 Nov 2022 11:59:35 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id z2-20020a1fc902000000b003b881a035fasm500497vkf.10.2022.11.07.11.59.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:59:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev5.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 2C3C021B14;
	Mon,  7 Nov 2022 12:59:34 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 27303E40496; Mon,  7 Nov 2022 12:59:34 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v2] nvme: scan sequentially only when list scan unsupported
Date: Mon,  7 Nov 2022 12:54:44 -0700
Message-Id: <20221107195443.2176099-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_115937_768322_BDD95DAE 
X-CRM114-Status: GOOD (  14.41  )
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

Currently, if nvme_scan_ns_list fails, nvme_scan_work will fall back to
a sequential scan. nvme_scan_ns_list can fail for a variety of reasons,
e.g. transient transport issue. And the resulting sequential scan can be
extremely expensive on controllers reporting an NN value close to the
maximum allowed (>4 billion). Avoid sequential scans wherever possible
by only falling back to them if nvme_scan_ns_list fails due to
controller non-support of Identify NS List. This breaks (noncompliant)
devices that claim to support version NVME_VS(1, 1, 0) or later, but
don't support Identify NS List. Such devices can be made to work again
using the existing NVME_QUIRK_IDENTIFY_CNS.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes from v1:
- Move limited_cns check from nvme_scan_ns_list to nvme_scan_work
- Move note about devices that may break with this change into commit
  message

 drivers/nvme/host/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0090dc0b3ae6..5abd8d4c6d9b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4425,9 +4425,6 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 	u32 prev = 0;
 	int ret = 0, i;
 
-	if (nvme_ctrl_limited_cns(ctrl))
-		return -EOPNOTSUPP;
-
 	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
@@ -4535,8 +4532,10 @@ static void nvme_scan_work(struct work_struct *work)
 	}
 
 	mutex_lock(&ctrl->scan_lock);
-	if (nvme_scan_ns_list(ctrl) != 0)
+	if (nvme_ctrl_limited_cns(ctrl))
 		nvme_scan_ns_sequential(ctrl);
+	else
+		nvme_scan_ns_list(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
 }
 

base-commit: d30a909f9bb5283e701a5fdfffac763ef57a3e7c
-- 
2.25.1


