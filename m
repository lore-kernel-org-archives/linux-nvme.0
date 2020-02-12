Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D853C3B186
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 20:02:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D239E21739
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 20:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l1e/3GEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D239E21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7aPeB79ETAxaMFMSUlCv+nCzBHIRWc7jDT5Y64B+nsI=; b=l1e/3GEbsl4eWb
	oLv1jkhCkd4f6WDzFhpY74qfQ/ETj2ttwbLWuMvtDd6nehc74uJNqhasG5Uspdzmzu15gDpUaOhku
	/+yeBTix3sU32looptNGuVb4UiUvwUojJCYGpka0u4JV3Zqk9cwuhayqNe5XeFduPWehITTGNmCmh
	HqNcoPoxNWg/1Apn7bqxEB+wBw7UOhWAuAGFC7R/l49Bopnm2/O/wqlsOGHORbh2ig/tAyp1K2i3h
	z+zt9bd5R52t10838s7H8/ZhgjDgdERcLRzfTRNJErwLPpIKgWSDZ0+ht9oZFO58Kl/D6AFm5iwzf
	AIs0YhtjAz9Zrt4febSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1yD5-0007gS-Mn; Wed, 12 Feb 2020 20:02:11 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1yCx-0007bx-Hc; Wed, 12 Feb 2020 20:02:03 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] fabrics: set keep_alive_tmo also for discovery controllers
Date: Wed, 12 Feb 2020 12:01:58 -0800
Message-Id: <20200212200158.14237-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212200158.14237-1-sagi@grimberg.me>
References: <20200212200158.14237-1-sagi@grimberg.me>
MIME-Version: 1.0
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We may use persistent discovery connections on referrals
so don't restrict it for discovery controllers.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 4b5c9669edc7..14b453d00e87 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1000,7 +1000,7 @@ retry:
 		p += len;
 	}
 
-	if (cfg.keep_alive_tmo && !discover) {
+	if (cfg.keep_alive_tmo) {
 		len = sprintf(p, ",keep_alive_tmo=%d", cfg.keep_alive_tmo);
 		if (len < 0)
 			return -EINVAL;
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
