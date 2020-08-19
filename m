Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C042C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:32:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DA32076E
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SgwMTuj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DA32076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qFDWMGri9IGjWavaOR9mUwLrX/SOle+EK/5pn3duoaE=; b=SgwMTuj6YKnhfnVIexwFqHuVNu
	zW9bqNaGnzdEnvOYU1MGLvV1s8mSQ1LjAA2W+5gagsCzBvG1YuMw428s88IS4OVuJ+7Jm/mzYMgt8
	1ZSsIMysTq3MGolYk3kphra854AjwAnEXgTnSXc85iNrJdd/QAsUKPSFYWNsa6mTerA29XXNnALJV
	+FTwNPYSGrwI8qyrRIPadlf33AJXuCmTotlJ2ymr9DPzQzD0B+DzkscR91ApiOcHvALriEugO12tp
	WwtbWlLdLVFqDY8t+LDzBqCB8Oc5fKInsQPw5saMd00971tZs+yPDcRCgQoCVobtqqchUxBQZWKMu
	uYDz1ymw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8LNz-0007wf-3F; Wed, 19 Aug 2020 10:32:03 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8LNx-0007w4-1i
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 10:32:02 +0000
Received: by mail-pl1-f193.google.com with SMTP id t10so10599471plz.10
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 03:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sDC1QkzxdDpfraswtJNSR5yoHCFwqn4bvDVLAirVN/Y=;
 b=Ux+HC31gjMo/zlSCzNezhjn9tdIHhTdyiLmnHW/b35ePAe7gMGa6xm89Nmv1v483Is
 7/OpMjQDvBnqcFmCjD5I45wAoiwDsOXMxmVVqyeltWDPHt1EbujU6XP/f2n3fJ1jznQS
 KxlhaaDomunKuTWmu9G8qmOnlR09Sdj90/kKk37rcu0ZSwMMAFS2hWsAPqrjZZMWEyaw
 4gotmL0IMHuzsZiW6vPml9d+siggA1628QN20si+3UE1CwpK9qy7fl+RRVb0EpKmaL5E
 TRFiAQZ8E40BuQzAklWIf/NWbyCq6Wx3uAaWIqZ69eYJek1b0X4VrfWOQUu4yCt7P1jp
 IWvQ==
X-Gm-Message-State: AOAM530DuwtAwm8ZKRpSKZ7qLIZJd+E5ZOOEcbOou7BY8VjQEsXnXFTo
 z44ycxJ7kpVuJ6kJ1RSJlo8HMIuIajY3Pg==
X-Google-Smtp-Source: ABdhPJxDcJ5DnzhVEOiDHNg2p2xjhe929vXrm6Y4Qos/LR2MqF+MYZacNgUYBOVuBx+hvp15n65/yw==
X-Received: by 2002:a17:90b:4d06:: with SMTP id
 mw6mr3658079pjb.226.1597833119562; 
 Wed, 19 Aug 2020 03:31:59 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:bcd0:fda9:d34d:a3ab])
 by smtp.gmail.com with ESMTPSA id m62sm2822868pje.18.2020.08.19.03.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 03:31:58 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH nvme-cli] fabrics: fix segfault when -t <transport> is not
 passed
Date: Wed, 19 Aug 2020 03:31:57 -0700
Message-Id: <20200819103157.50211-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_063201_166530_9FBC0066 
X-CRM114-Status: GOOD (  12.23  )
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

Need to check if transport was provided before we derefernce
it.

Fixes: 9da606b4afcc ("fabrics: allow traddr to be host name for ip based transports")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 73bb37529448..c93b752ff142 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -923,7 +923,7 @@ static bool traddr_is_hostname(struct config *cfg)
 {
 	char addrstr[NVMF_TRADDR_SIZE];
 
-	if (!cfg->traddr)
+	if (!cfg->traddr || !cfg->transport)
 		return false;
 	if (strcmp(cfg->transport, "tcp") && strcmp(cfg->transport, "rdma"))
 		return false;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
