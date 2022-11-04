Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BE6C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Nov 2022 22:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=woNaRBySiJN/NiwDPL1Smtcv+zCo7/RNBCDC4YUZTto=; b=BKHdKcBeYRB4CzKtRoDXhX5JnZ
	e4sKetNYW5t+5jfuG3f3yznm7vZDHoxoT8FCw8RcUJHWaN1D+DmIPfMQx7OT3kb6hNIDi9UsPtowo
	QMdXCtbzh0pz/M8GSbC6jMWpbk1z4B58bA37xt7gEww92Yz+DA3Xy4elJocV6ehr4SnI4k4b9xwEy
	Mc5XNnZz1CJ5MQwWy+0Wr5qWxKQ3xRPiyol9kzsds+eWnPF0jiwd0bYFqnD2lXA3qgrjvY/RWLQp2
	ScnFAHdrX05sHrJTIxRk5dOIRHxwCjs9XBCrr1vNPixnmLSoXWrAuT7lEYxi3XUmrwBJgcs4zFpIx
	JvuQAWww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1or5JB-005NAg-T4; Fri, 04 Nov 2022 22:37:05 +0000
Received: from mail-oi1-x262.google.com ([2607:f8b0:4864:20::262])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1or5J5-005N9y-Qm
	for linux-nvme@lists.infradead.org; Fri, 04 Nov 2022 22:37:01 +0000
Received: by mail-oi1-x262.google.com with SMTP id r76so6576539oie.13
        for <linux-nvme@lists.infradead.org>; Fri, 04 Nov 2022 15:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=woNaRBySiJN/NiwDPL1Smtcv+zCo7/RNBCDC4YUZTto=;
        b=Vk3ehRcT02cZmce+rq/5LLQhN+t8ePJgJwQAK6GQk53Ns8WVORl1aUqKZ2qzuNx5Dc
         m39ufBJad+FfyH+jY8nUI8NOwwnk9Xw2b6Clr5wdXgls/6QsxuqZ6qea9RBluS0mFmsa
         h3F9HwkVWbfPBn9xaKwcIQAsQO729WQusLHIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=woNaRBySiJN/NiwDPL1Smtcv+zCo7/RNBCDC4YUZTto=;
        b=vwqogqbSA6J7pYMw5N5IA35RsqMXk+faeHyJV3fD865WlqkGQwLSnLzEuStP9htZdb
         tVPHyndH3xv6Nz6v0BAoO3+gcnH2yG4CbnpGTejPEu1Z0dip6zVfdTWkmBS3JQc5NEfk
         rDMlQHend3Ey+4ctdglcbEYuM0COsZZR3tls//mZdsGl6qEm1+L/VbdJdqJdjPCnYeOZ
         m+s+20essm4PdeyHQaO9WzbwaGB3kE8AXdWGDGBAbSw0eG1yNvTqcF0VtFAq95Ry8ghu
         yyL217VJbdLvP4wYzGODuKU6a6854/wb9db2Lvpr+OnnNMQ9CIbWBHkKb/+BMIWWxE4b
         FbxQ==
X-Gm-Message-State: ACrzQf1e49rWaX0bl6bxf9h4sktpS+Vz4vl3QH5Ld4docG9+YKvTICgl
	0Q6sXSDVaUbNzf88E3+oTEfuw29x0U7KLpXxQE57L/kL2SvVQw==
X-Google-Smtp-Source: AMsMyM4kYoPkgiH/dTwiyhwkQuc3FhE09ljxUAJJeGpEyLyFqLNUaXmJSKI1AuaBpXNifDjzYdRPSPUWz/Nr
X-Received: by 2002:a05:6808:1a14:b0:355:15ed:47e5 with SMTP id bk20-20020a0568081a1400b0035515ed47e5mr19910327oib.76.1667601416293;
        Fri, 04 Nov 2022 15:36:56 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id x17-20020a056870e39100b0013c332f6f68sm27171oad.26.2022.11.04.15.36.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Nov 2022 15:36:56 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 476A921B0D;
	Fri,  4 Nov 2022 16:36:55 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4236EE408EF; Fri,  4 Nov 2022 16:36:55 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH] nvme: scan sequentially only when list scan unsupported
Date: Fri,  4 Nov 2022 16:36:22 -0600
Message-Id: <20221104223621.1435666-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_153659_976253_995408FB 
X-CRM114-Status: GOOD (  12.68  )
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
controller non-support of Identify NS List.
---
This would break devices that claim to support version NVME_VS(1, 1, 0)
or above, but don't support Identify NS List. But it looks like we
already have NVME_QUIRK_IDENTIFY_CNS to deal with that.

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0090dc0b3ae6..5bd19819d33b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4535,7 +4535,7 @@ static void nvme_scan_work(struct work_struct *work)
 	}
 
 	mutex_lock(&ctrl->scan_lock);
-	if (nvme_scan_ns_list(ctrl) != 0)
+	if (nvme_scan_ns_list(ctrl) == -EOPNOTSUPP)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
 }

base-commit: d30a909f9bb5283e701a5fdfffac763ef57a3e7c
-- 
2.25.1


