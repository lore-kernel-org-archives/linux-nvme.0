Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421E1ECE58C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 17:24:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D4F21D7F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 17:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L0Jk+Xl5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT9M21ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D4F21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VSBkuCoabKKkCHgbXlXTmGWDyE/MWV4RVtMJM8jzR8w=; b=L0Jk+Xl5Hpq+sQ
	IeBoxKgaC4qTNEATM34gmQ3tdQ0puBrGQbL9OAwb1mGvzl5xtIb4NEuU1Ub4KuCkzCYAqOe08KeyX
	IYCUSVy7WfRF55uBHPdf2OnlPfuwcmSH8ZNUUGydI2UmDvYDymx9NLkOZQjTME/qJBwPVlWL6Fn5j
	AyDNo3E9F4KN1eWdl/Nte4ay+XEswy2bjULqYkbHqcNLMAs7l3wwVFYeUv85TsilmTvxHtheQZMXt
	cXWh+14JteyEzNp4GE0ocvRRcMX+VAHe7YZPrxDNKzYnFN5BXKmsTNpiS8Ar/sSfSk2jy1KSvLrNL
	AtyIMgupxqAGSbTT/q5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIFgz-00045l-6y; Wed, 09 Oct 2019 17:24:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIFgs-0003xU-M3
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 17:23:59 +0000
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5A4B721929;
 Wed,  9 Oct 2019 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570641838;
 bh=p1HFA6X3IDlFuyTeWwZLG00ihvwnsActcDW+mlTwb1U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TT9M21ot8y8eR7hbW5QJgZ8bhOXHsHwSTxh8j+33eQCegSj32a7GgW6SBsQdVfn7F
 5Z2dVrdY4CdnqQHx1putX0fcvkmWi8fqyCITu9blC8WHbTRd6N5wIHPklHIglci5Pn
 zjd7usVVXCw+ZlAwxjnMWsnRfARqHzr3f6gCTtYY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 18/68] nvme-tcp: fix wrong stop condition in
 io_work
Date: Wed,  9 Oct 2019 13:04:57 -0400
Message-Id: <20191009170547.32204-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_102358_741533_90F08514 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: Sasha Levin <sashal@kernel.org>, "Wunderlich,
 Mark" <mark.wunderlich@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: "Wunderlich, Mark" <mark.wunderlich@intel.com>

[ Upstream commit ddef29578a81a1d4d8f2b26a7adbfe21407ee3ea ]

Allow the do/while statement to continue if current time
is not after the proposed time 'deadline'. Intent is to
allow loop to proceed for a specific time period. Currently
the loop, as coded, will exit after first pass.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 606b13d35d16f..bdadb27b28bbb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1039,7 +1039,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
 		container_of(w, struct nvme_tcp_queue, io_work);
-	unsigned long start = jiffies + msecs_to_jiffies(1);
+	unsigned long deadline = jiffies + msecs_to_jiffies(1);
 
 	do {
 		bool pending = false;
@@ -1064,7 +1064,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		if (!pending)
 			return;
 
-	} while (time_after(jiffies, start)); /* quota is exhausted */
+	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
 
 	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
