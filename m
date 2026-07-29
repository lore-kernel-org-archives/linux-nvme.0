Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7E4C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WmWzbBs5wDCgZCHpYUgA9YVxnXhpn8r9irUn0ZMv/fc=; b=npFTmYhWWBKwrGazYbIUEuJhlW
	Ep+nFCeiJYjpRaJZ+wIWYwtRYHd8+oSi1o7pPLLpocEyd3CcEgKIRrd9L3oEjKo2qACO/sN5/AsZ/
	DQIYrhQIjOaVHtYzT70NnFQEMMtDqAzK+t922I0gsl3IVHlNUA3tAfZxFdFyyBM+6Pp/ff54tiMvC
	BEG/Y2sOTMfRoMc9Bya9RR7ZcXEagCQxdFNY4i9KWohKbZDs1unqqc8JGnyxB2BsH0YQUM/3QFksy
	ObjGK5kViPM9/MDr8GyiGHnAzc5xRYM03HC3FnMtN1RYxssxJsASg9EF7GYlmkIuNZtoAedUelJXi
	AGXBbGgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp216-00000007fO4-1zz7;
	Wed, 29 Jul 2026 11:00:04 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp213-00000007fLw-2wq3
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:00:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785322799; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WmWzbBs5wDCgZCHpYUgA9YVxnXhpn8r9irUn0ZMv/fc=;
	b=aAAkS8wcs2tAzNnKUD2dfczjzzcPDdUuzCdYNF8dvH/Vue+V29D8OcdpZYlZvzEi1PREI94FXCKAekIhb5zBTb2J2763gGyivo2yY3oEqhmvaorKDvWTLQGbXLJngVIYQ6YtV5rFiPaUpFkIzVxB5VrdlZLtS4YYAWyH6OF59DI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X82-wk-_1785322798;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X82-wk-_1785322798 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 18:59:59 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme-pci: return error when parsing a quirk string fails
Date: Wed, 29 Jul 2026 18:59:58 +0800
Message-ID: <20260729105958.1403095-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_040002_111992_8CECBB37 
X-CRM114-Status: GOOD (  10.39  )
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

quirks_param_set() reuses 'err', which param_set_copystring() left as 0,
as the return value of the whole function. When nvme_parse_quirk_entry()
fails to parse a field, the code jumps to out_free_qlist and returns that
stale 0, so a malformed quirks= parameter is silently accepted as valid.

Set err to -EINVAL before jumping out on a parse failure.

Fixes: 7bb8c40f5ad8 ("nvme: add support for dynamic quirk configuration via module parameter")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b53..560560268c05 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -213,6 +213,7 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 		if (nvme_parse_quirk_entry(field, &qlist[i])) {
 			pr_err("nvme: failed to parse quirk string %s\n",
 				value);
+			err = -EINVAL;
 			goto out_free_qlist;
 		}
 
-- 
2.43.7


