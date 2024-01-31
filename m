Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75613C47DDF
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 09:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GdYYOGY5uiaHI7PkfK1bus7O/ox17phLvFfIukUr4uA=; b=gyW7GQpBA6DC19LL2BEh2CzPdC
	mN85Mk94Mn0AU0xQHPslsKDw847g4PyJ4r0+ieHHlf5e+3byIbLVsREKoPnDWtJvSZIuHsDUH7p9G
	mM/A+y0rjNEnWydOHlDKGFTQUXk/VLsY8LKdWT3MXB/9QxH5Nr2JRGdCOJkbLwoAolOixPDdzod5E
	K5UI+oXibQpZT20FFTaNoFVYGpOfXCQn9fNhTkH7AA3eGcZAYWtc/8Dt2IZSNf9/ukxgvfWIagp83
	ANcaVLQ7fLJC1AeT2nQqe3Jqczq+mcb209PkcvAwGbKFOn/QD5LvbY9WhWaA+gjeLEfo40xpTaarw
	QTf3Egww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6e6-00000002Moc-1TGX;
	Wed, 31 Jan 2024 09:12:38 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6e2-00000002MlD-3HXz
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 09:12:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706692348; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GdYYOGY5uiaHI7PkfK1bus7O/ox17phLvFfIukUr4uA=;
	b=J7KLE8NHxgTfzKXC27PbhZhvRCsx5C7MW+zRPtRQq6xDx8yaWUdnBXszYtTPfYZIKnI3zcBhSOihoG1GS8LjqK3/bV8JtL6gpToEiL8AvXiKyOxWcCY1kQ97Z3/n/8N3o65MRmMBrv/xbSD5tgFR0jQj6mq3YHqQTUICjF2KyzI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.iyaE6_1706692342;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.iyaE6_1706692342)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 17:12:27 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/3] *** nvme: add some commands tracing ***
Date: Wed, 31 Jan 2024 17:12:19 +0800
Message-ID: <20240131091222.116190-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_011235_490153_962D8681 
X-CRM114-Status: UNSURE (   6.41  )
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


