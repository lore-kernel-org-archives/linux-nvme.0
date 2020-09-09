Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918D6C43461
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 21:21:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A1D20BED
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 21:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tdMxwrSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A1D20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tXISePjyTD5nda+UwDKUx0M2DTUh1pj4d/PgWuSrUAs=; b=tdMxwrSOShodAkGsBdDrbp3xxZ
	I768jkwy96jA3ZdB6XXc8v0lYHNzSnUUjSTv5o7Zn+/0WUXzvj4wqPdl9qsbdbIZXxw7UuSRZcH/y
	qURPEY3RO1t1lT71bdJFW3hTUxYSDaqt9IbcA/U1AdiMwNJ8OFjwlBQz8qeu2/HgCsop4HojMaxy4
	TE/ZoltGsMD9tAjDQuXCL9p5lbdpLydZRGyv1IWC4KcQC41g6ugDQckKbmZgCU3hQ7IaCQvWII6Es
	p+xKxkE2JP5ePX8rC1Svrv6dhosP3GlPUVbINDEMdy2QJrZtZD/wD01HCSYuYQPnojepbEnBbUTR3
	/oWP9TJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kG7X4-0005Tq-SC; Wed, 09 Sep 2020 21:21:34 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG7X2-0005T9-W0
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 21:21:33 +0000
Received: by mail-pj1-f67.google.com with SMTP id b17so1988462pji.1
 for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2020 14:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xxTzsvfn8wcs75MVtuCIR+QMAv+SsXLZ5qLWdwRVP7M=;
 b=hVkcmG8sINnFH7liQbT8F/qbHGTNTCdsPgk1FihWBSRE57t0cs6EMt43jpSYrlN9hC
 uoxwmU+E0lRaf+VtR5CANkxvFSAfAUr6eCBjkGIf9X4H00YVurn7bOiIvI5SzoFK9mKa
 mhOmYQtkjd8XV4kB8jYBporfQSQ0JbeUAO2LC3v7UuDuri9jkoRdSYmEbTYUo1wGhgeb
 qCz2mby3BsB/c/BAmfD+2VN0DdL3mU9esjVY+SxBdFTan43X0tfQs3nDSds6o54eswFP
 u+B9e/feWzmvudzhEN7D197vM8acTx8pLN1FB7CZk+wnNUPLkFKkueRhEmN2zhgzLe6a
 FR7Q==
X-Gm-Message-State: AOAM533A6uJMywf4m94qtDyN/6Ms8I05PmVxZbf5dgbULvyDdYC1pP3R
 QuSbtDPxqCfCgQUAkAb7zTGHp3+NmAc=
X-Google-Smtp-Source: ABdhPJwuLZO+qwPqQ8qnIiMwhrOPPrhum2lBkyMpMch/CwIFGHBgq2SGXAkLexhFO+l1ywQJVRZmKQ==
X-Received: by 2002:a17:90b:793:: with SMTP id
 l19mr2444384pjz.154.1599686491528; 
 Wed, 09 Sep 2020 14:21:31 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:5905:3209:6aa:d817])
 by smtp.gmail.com with ESMTPSA id v5sm3293889pfv.199.2020.09.09.14.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 14:21:30 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH nvme-cli] nvme-status: Don't reduce all negative statuses to
 ECOMM
Date: Wed,  9 Sep 2020 14:21:29 -0700
Message-Id: <20200909212129.309888-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_172133_031020_72738D33 
X-CRM114-Status: GOOD (  12.92  )
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

There should be no reason why we should reduce all the semantic status
codes we are getting from the device/driver to a single meaningless
status code.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 nvme-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-status.c b/nvme-status.c
index a78c1fd02797..29982541466d 100644
--- a/nvme-status.c
+++ b/nvme-status.c
@@ -142,7 +142,7 @@ __u8 nvme_status_to_errno(int status, bool fabrics)
 		return 0;
 
 	if (status < 0)
-		return ECOMM;
+		return status;
 
 	/*
 	 * The actual status code is enough with masking 0xff, but we need to
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
