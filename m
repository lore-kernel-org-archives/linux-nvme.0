Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B93C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GdYYOGY5uiaHI7PkfK1bus7O/ox17phLvFfIukUr4uA=; b=lnaFcdAb/0tMId677VgpZxuERp
	qZuglTJpSc7jhxat+rKZVsD9Zngmt+RW2tQ2OR0/9HB/oWt+19a2UFULzok1booxLhichdMsm6hvG
	eZcuX1nLoOlKRAwUm3NmwJv1PNqUSDjVAS5x4jZgYhChfHzyvQK+v0EIw77cIA8BWl/YowPxumpzX
	e7eC1E8L2T3RAE4E40sU30NyknjFIRWQtglfU7oGNoDjdFMyP6IXjqMFKC5i3suCN4mOQuIAiKTZC
	Bet6QDU11NNZQVS7bS8PmclQMuME6Gbh84RsKhKUeZ/IaUz3iqx5YFDaVZWIhfuC5qjQgb8WYkWsg
	HObEMwOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmNn-0000000GSwC-02XL;
	Tue, 30 Jan 2024 11:34:27 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmNa-0000000GSqC-0p8W
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 11:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706614452; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GdYYOGY5uiaHI7PkfK1bus7O/ox17phLvFfIukUr4uA=;
	b=AKQAyZvSSidVZCEUfWzB6P56Yrwo8EwO4v3h8q7QoeKV32uLgk075jEdaLiZBieQFFPYkdmzQb5PtWmoihWdxBocbdRCfJbikN/4MAvXPxudNbB/R5TflwD+rhOPjOrIlfM/d93cK3YTM2MGqH79a28s4jsljE3y8efU2T4O2S8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.g6-uV_1706614446;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.g6-uV_1706614446)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:34:10 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/3] *** nvme: add some commands tracing ***
Date: Tue, 30 Jan 2024 19:34:02 +0800
Message-ID: <20240130113406.8414-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_033414_976838_13F7D78C 
X-CRM114-Status: UNSURE (   6.46  )
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

Hi guys:
    I found that there are no reservation commands tracing and some
commands's parsing aren't fit the newest NVMe spec, and aren't readble.

Changes from v1 to v2:
- Remove idr and idw parsing of dsm command.

- Remove lbafl and lbafu variables and add a comment for the lbaf
calculation in nvme_trace_admin_format_nvm().

Guixin Liu (3):
  nvme: add tracing of reservation commands
  nvme: parse dsm command's attr deallocate when tracing
  nvme: parse format command's lbafu when tracing

 drivers/nvme/host/trace.c | 73 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 4 deletions(-)

-- 
2.43.0


