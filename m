Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAD7D6E2CD
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 07:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g+YXwzMITFKTDUjT0gkIIx4bZbNRgLkJbKpZ2oYqcR0=; b=iVi18ONlUy54iGn3+ArGL4q1hh
	c31Exn7ZgHgVnfy7icnIu24DfmcF2rS0Rbke/4lBQGGqnv+WdxMwdpyCFzSb3/O50P5S7gAuw2dCt
	VwlnAW1I8mgK2LFMRx7rtRnBrlf1KULbR9GNLtsYtvpXUlA11kYZiOwgDS8h6UFx1wEpCRFDEtLdK
	HhOIW+t3+Jpzr+kgv0ximdo1rpX0SCouxVhUbepf3kNzlzMND9oWyhTVIpLroXSBWv44ULEjn7XVN
	MMIJ6uXij4ELlG8ZbSZaDqCC49cmS/9swnGahv2zyKS1KeAoojGFzWGZcebe9B6IagfTNxj/4fMUu
	1TA3/QVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDer1-0000000EaJt-1OOg;
	Wed, 20 Nov 2024 07:10:23 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDeqy-0000000EaJ0-18cQ
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 07:10:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732086618; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=g+YXwzMITFKTDUjT0gkIIx4bZbNRgLkJbKpZ2oYqcR0=;
	b=UnWarQ9bpHubekvALqU2LBFdQ23YSJuUd6IPyue1XcXkvfcPz/pknpEdO5Ul9J7q4joBB70Nd5hINy2EhYEhb25mQY1J94Z9L/cKjPFGPagOm0LymMKMSd4f+H1CipJtjFHnL88JpYKAy5HmZNurNLxg2oZeX0jo6277FXJXqk4=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJrAD1U_1732086613 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 15:10:17 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/2] nvme: introduce change ptpl and iekey definition
Date: Wed, 20 Nov 2024 15:10:07 +0800
Message-ID: <20241120071008.106933-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120071008.106933-1-kanie@linux.alibaba.com>
References: <20241120071008.106933-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_231020_447913_79BA2542 
X-CRM114-Status: UNSURE (   9.57  )
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

This is for the next tuning pr code more readble patch, make
linux/nvme.h's changes separately.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 include/linux/nvme.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0a6e22038ce3..90c09a9d211e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -2166,4 +2166,13 @@ enum nvme_pr_release_action {
 	NVME_PR_RELEASE_ACT_CLEAR		= 1,
 };
 
+enum nvme_pr_change_ptpl {
+	NVME_PR_CPTPL_NO_CHANGE			= 0,
+	NVME_PR_CPTPL_RESV			= 1 << 30,
+	NVME_PR_CPTPL_CLEARED			= 2 << 30,
+	NVME_PR_CPTPL_PERSIST			= 3 << 30,
+};
+
+#define NVME_PR_IGNORE_KEY (1 << 3)
+
 #endif /* _LINUX_NVME_H */
-- 
2.43.0


