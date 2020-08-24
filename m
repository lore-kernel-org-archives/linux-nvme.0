Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48534C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 22:57:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EB520706
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 22:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vQc0glHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EB520706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TUm7+jNmCgWLOZhxlrYgaj7goZ3QaC0G+nHQMJYYWlU=; b=vQc0glHIQ7NcCcnKoVOI4VIPi+
	rKqdsZduptS1Y7a+9phbbxGrxTuky4ZYVKVViAI2l39uFq/sP9mtHdYPip5gOrdtKjwB6rNWFGEfO
	mL9Z1QK6x8EF0Bz5kD8IKOqiAq0YMYrUHHzTST9ZLmRxLDP5AMwejeZkCmMwk2lXGQ1XLhwtKPAdP
	JWzcgWiYk7ryFOatSArthHRauILoKI5L860X3mohSJK/IDrENX+AoJ6kGfIPtkrY885Ub8TPdsiGu
	DgPL8FRuZV7HDF4GXt5iw5ICZJiSAL+/zpfbhNlPQ+RcXSLy9eCKYiNjtgRNcsa9mEqfjFlm9bRIR
	IT7QIi+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kALOf-0007jS-Cu; Mon, 24 Aug 2020 22:57:01 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kALOd-0007iq-8X
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 22:56:59 +0000
Received: by mail-pj1-f68.google.com with SMTP id j13so196373pjd.4
 for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2020 15:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XTcltDZPNQKizuMbWAOerxiat/3rZwzNsstPzneRXgI=;
 b=LsZmBnW/6VFQ7lpKKXWqSpvyiXrJPmwszU0d8ubcAzkl8CPPuPGC0TAaDkfhjDWpyG
 J/54KvgGGAg6EetiFMlQjfr4gPw0vZP3Ilm0w5uBkYrGGd3VIDXWxMsEzw+ucUQr59D2
 ta/fVlCSLzz0GxnD3EnhBwvrGzPKHRNza3nrdLsJh4vqqv5ujeEy/eR6QGmzd65hIAVp
 YRHajQQMo5hTPUC3UcYLPzrswx5LRrW+MlRlVHtj+fBUz6nKqf8QGcKKc3Vl01gYuCnZ
 wBsdz8PgA6rzZ2VAB3+QWABg2GByRMEjSTImEYtRT5CGiJhiicvh8e2wAF972MtR6jH6
 8ZZg==
X-Gm-Message-State: AOAM532OHO+Wh9+H/1biR6nQEquim8t3KbpJWgxEwSlg59KsOczlR+Uh
 w2kS0LsX2GKduKeIOD2ya+6BcL4kaM2VjQ==
X-Google-Smtp-Source: ABdhPJwmKzlL+BvH/5y6lYw2BE4eHilsdOd6SwO8BSkeF0FlLtSk0rM9h6E2MxHYPA2WGbRpcJheCg==
X-Received: by 2002:a17:90b:4ac9:: with SMTP id
 mh9mr1183751pjb.40.1598309817959; 
 Mon, 24 Aug 2020 15:56:57 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:cda6:bf68:c972:645d])
 by smtp.gmail.com with ESMTPSA id a13sm12252623pfo.49.2020.08.24.15.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 15:56:57 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: Fix NULL dereference for pci nvme controllers
Date: Mon, 24 Aug 2020 15:56:56 -0700
Message-Id: <20200824225656.227194-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_185659_337488_1D5C171E 
X-CRM114-Status: GOOD (  11.76  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PCIe controllers do not have fabric opts, verify they exist before
showing ctrl_loss_tmo or reconnect_delay attributes.

Fixes: 764075fdcb2f ("nvme: expose reconnect_delay and ctrl_loss_tmo via sysfs")
Reported-by: Tobias Markus <tobias@markus-regensburg.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 537dcd900cb5..e406c3cf55bc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3676,6 +3676,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_hostid.attr && !ctrl->opts)
 		return 0;
+	if (a == &dev_attr_ctrl_loss_tmo.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_reconnect_delay.attr && !ctrl->opts)
+		return 0;
 
 	return a->mode;
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
