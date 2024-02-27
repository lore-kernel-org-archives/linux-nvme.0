Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408BCC54798
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ldVylhUW5nyQzFglVO1GqY4N5hFvd/bmHiRbuW8ZlVI=; b=gho3NaaTTd/UNfLoAzbvl+QhmK
	1P5KJcxlpiEjf3bN7CcuZ4vH9aDtKwvNGJVlSulwuyw/UZ3D1XgUIYlSO3Pe41q+4kP0BA0rEk+qW
	PndjQmglBvSiw/kdRypCW/sQ3m3UezKTzS2afH7bpquiSe/rVQHZTJ8EmwhVXsAVZ6afw6w0yhdhn
	YLczsjhqLUOcEb8xyh/CxLCrChP5+Z2WCLVJ/pePwed9JZWAg/MrJXM1RN+Wk1OyDHJeS3wEjGdsE
	SJ/ZeMe7irJevx9B+2Rl6K7Nh1mnPKhz5KzBBTHjEj4U0cfWaiJtdTqeJnmhzEoJieHZd4/WDq/Iz
	TrfpcL0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1retEK-00000004PDk-3GIw;
	Tue, 27 Feb 2024 08:54:28 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1retEG-00000004PAU-49u8
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 08:54:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709024061; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ldVylhUW5nyQzFglVO1GqY4N5hFvd/bmHiRbuW8ZlVI=;
	b=Yy4Zk8DHHz+0swkHmCmfXMk3zI/sPZxveQPZ/SSmBgE0v3BfPD1h5g2VYb/0o4E1/ipnT0KYjqtgNkQGMlB8z7WDtfYmiMm7KlXR6USf3gLS1jYFLSo626IyBSUbn7AFg8OAUOH+423SOQB0/axnvw+WBaj0r54peK+7eW0KgwE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1MEJB0_1709024055;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1MEJB0_1709024055)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 16:54:20 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvmet: parse dsm command's attr deallocate when tracing
Date: Tue, 27 Feb 2024 16:54:06 +0800
Message-ID: <20240227085408.130161-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227085408.130161-1-kanie@linux.alibaba.com>
References: <20240227085408.130161-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_005425_379460_E4056005 
X-CRM114-Status: UNSURE (   8.63  )
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

Add parse of dsm command's attr deallocate to make the trace log
more consistent and human-readable.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index 6ee1f3db81d0..657bd31841b2 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -83,10 +83,10 @@ static const char *nvmet_trace_read_write(struct trace_seq *p, u8 *cdw10)
 static const char *nvmet_trace_dsm(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
+	u8 nr = cdw10[0];
+	u8 ad = (cdw10[4] >> 2) & 0x1;
 
-	trace_seq_printf(p, "nr=%u, attributes=%u",
-			 get_unaligned_le32(cdw10),
-			 get_unaligned_le32(cdw10 + 4));
+	trace_seq_printf(p, "nr=%u, ad=%u", nr, ad);
 	trace_seq_putc(p, 0);
 
 	return ret;
-- 
2.43.0


