Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB07C19F2D
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6An2Bm+HRPw2jUsWUGxg/yl4JgWAUg6zKT2TE/IRa6U=; b=EQfdzkWabEruV6/MEVLkLbyy+E
	k/lCxnkHUzC2CFYacOAR+eFy5kC1wNNK7SbxAmDakeBmTgKUZfoPj7J43j01nPd7ahEIvxwuPFJ2V
	+P5u5ggo90R1LH/8kQNejeINmPcIdEQS0lJpoA79XpfRVZnZRf9FnCIjT9/hpWCjCcG2QZFZBStOW
	GUpmFIucvAaAwgjna6XzPeFN/TAo723sQQfUfgeteh49LsxhoEUBXDC47wSBVBIKQN7x7nNOOe5Gn
	56sRzgmK8zDZ4nbBLCbVlO1BOdUJFL2jS/EetohyvImsCf5rzwcBRFVNaPNfEls7faXnOfqToFy+N
	IJyuf9wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM2oe-009ktG-8H; Thu, 11 Aug 2022 07:41:16 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM2ob-009kpn-Ii
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 07:41:14 +0000
Received: by mail-pj1-x1030.google.com with SMTP id gp7so2587666pjb.4
        for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6An2Bm+HRPw2jUsWUGxg/yl4JgWAUg6zKT2TE/IRa6U=;
        b=Mgt2J/+MHwKThQVs4oQVlJ8IJylX4tgDxpCXs30fmcHRr9HtTapNkMYFGxVkdgvhVo
         8rzvRirxvqXUlreSEsyVs9eOBBBF6F2c7aaqG7KPcTnfDa/YhrOCBBpUa/cr8fW8VMNZ
         MWcxXWtf3+HoplgGjV6d8U4blhDqYMAK+Zrf9zS0OR4HDccctwXbvBd86SW2Af6ZyVFN
         Gu4lo+Bj8/zCuIsdtu+5a7BZN+WkXNtoPQDnGyEjwObfKVMdLJabr032AFkBOEWd+tVa
         CzQh2WChZsbW9CC5sDm93Fls26AXVlfi2gn5xYmAPZRyDJ9DNapUnt+1eCsiRi0xV1wl
         NHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6An2Bm+HRPw2jUsWUGxg/yl4JgWAUg6zKT2TE/IRa6U=;
        b=G8ATZYW93T57siEIiuqi7cwkpT7FQ3Xvc/ExtKqvbty/xRoE+W0CQFLlb3+At7jHvS
         lrTaGUSY8OT0q9bQPnObhDkhlm+29uQ0AGrrQuCG6ugZWnpkZpLEzY+eg0l95OMttJ5W
         brhC6oZ1w3ciod6Qk/ywBWAo76NrgSPBGlKofPxXPwFBP8Epqt6wERT0YTi842Zx+aGp
         bJut3Zwy4oO3YEEUvzAxs6sBGZrAorjf9ZvuYmiyIGcYx3RrsuL/UQ6+cJpmhRfndqn2
         sjA0bLBwAf/YjhgLWsme0LQiMrGoQUkRU4tjrBnGwf1aJlyE4XEc/NXP7xBb21Xe9DkH
         4coA==
X-Gm-Message-State: ACgBeo2gjpYxlsNLCuhH4ypj8NZgXPwZTPIsDPrQwVHzBlCZjsKFC1U8
	gKlF0e+9ALAVf3rdwLCEgSlAmCdhaPGKQli1gwI=
X-Google-Smtp-Source: AA6agR7VSlLFYJgVPQvtmdBK/65Cg1unbT4ey6bZY1xdRJuabobdK218dzhUg+yfhId/cXLGQwhY9Q==
X-Received: by 2002:a17:902:cece:b0:16e:ea30:6287 with SMTP id d14-20020a170902cece00b0016eea306287mr31152370plg.104.1660203671995;
        Thu, 11 Aug 2022 00:41:11 -0700 (PDT)
Received: from localhost.localdomain ([101.82.148.241])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b0016d12adc282sm14207411pln.147.2022.08.11.00.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 00:41:11 -0700 (PDT)
From: Linjun Bao <meljbao@gmail.com>
To: 
Cc: Linjun Bao <meljbao@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: add comment for unaligned "fake" nqn
Date: Thu, 11 Aug 2022 15:40:24 +0800
Message-Id: <20220811074024.4382-1-meljbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810140812.GA24773@lst.de>
References: <20220810140812.GA24773@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_004113_638499_A79E53A0 
X-CRM114-Status: GOOD (  12.28  )
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

Current "fake" nqn field is "nqn.2014.08.org.nvmexpress:", it is
not aligned with the canonical version for history reasons.

Signed-off-by: Linjun Bao <meljbao@gmail.com>
---
 drivers/nvme/host/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..e72021212971 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2704,7 +2704,11 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 			dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
 	}
 
-	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
+	/*
+	 * Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001,
+	 * the NSS field is different from the canonical version 
+	 * "nqn.2014-08.org.nvmexpress:" for historic reasons. 
+	 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
 			"nqn.2014.08.org.nvmexpress:%04x%04x",
 			le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
-- 
2.25.1


