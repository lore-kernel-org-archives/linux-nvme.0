Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412C6C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5811C2177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kflZ2CQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5811C2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jce/5Dlu8vn54QRuBTtzobO8JtLuLcN9rDL+289c9kE=; b=kflZ2CQLTCSTLNi77Sqekqs/C
	epL8yXX1S/hQzM3gAIeFSK/TnOgcliqfXrxRYQ+BXKPIkllZuWBS3q3C7RfGh9pg+OZ6MKZjOO8fH
	jPiNI6sgfiBXA/h9keaUCGwaF3Xc9ndaxrWsiK54nv4Qn+AKP34XPD9h4oh+ru5RsmAQPOy76g2jX
	XRsYWq1f6+rHWBkKlspT/PN2y839YK/SVnyju1Irdw7+A42gOylej8CPbGFX5yYRzfEIyfdEwO0a+
	Wx9nqABCXLhhDhXkAQxgCROgvpcEf9QxsWb7qSz4khsNE4AnHhZJRgXSu137+A5g41HMB1rdXroRg
	E6FUgnOCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lMi-00017c-Lz; Thu, 06 Aug 2020 19:15:48 +0000
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lMQ-0000zJ-SQ
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:15:34 +0000
Received: by mail-pl1-f174.google.com with SMTP id p1so28279099pls.4
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E6rPl/XQAx312kYBDl1D3OvoqQvb50hFc5fzpRw9mLU=;
 b=qagN/Fw+obxaifZq50ZTqBnh1mnjp7eUnJIrMx9SHNbD1Dkaa5+fZwHlXZeVsjnDf4
 DxjvSFqVZB4J8soxXi7Np2MfyjB6G4JZ/AdEjt5rBgMjXtGN475y6xWV5pvUQuPLU8L/
 VfrniCstfrTofidjC7ovdZhr6YczK+P1lIGoXpiTm7Q8EAlfXBNqdoxB3eFDMcOHnLKC
 nadHthHqRSq0drHyLYqAtwCQM8cXyUeVyjCoJ6zf2zTGewN/KWe6koI2g0ja5utgVoBz
 3KjbCvi/lHBWNIjfEbfHMVIemsltmL1PkNX+6DbYjh1MCS4JdQCBPFwiIgp+mk362aW5
 8DHg==
X-Gm-Message-State: AOAM531JCI86nUGY25NWlzLO0MZzvn5lAm7L6WmF1OPTQGZMvCTQ0/r2
 jXkH87Ez0AheYuGCa/IV6CN+eti2
X-Google-Smtp-Source: ABdhPJxx1Gzq5Y58oYCHXns8Ubqh9zuEiQhgOOdlCkCivBLSnydc7oGr6mq1NZ0HRu6qeIiNAx7Pvw==
X-Received: by 2002:a17:90b:4d0d:: with SMTP id
 mw13mr10252988pjb.159.1596741328976; 
 Thu, 06 Aug 2020 12:15:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id q16sm9784014pfg.153.2020.08.06.12.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:15:28 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2 5/7] nvme: support nvme-tcp when runinng tests
Date: Thu,  6 Aug 2020 12:15:16 -0700
Message-Id: <20200806191518.593880-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191518.593880-1-sagi@grimberg.me>
References: <20200806191518.593880-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151530_967833_E811BD1B 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

run with: nvme_trtype=tcp ./check test/nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index a2cb0c0add93..69ab7d2f3964 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,10 @@ _nvme_requires() {
 	pci)
 		_have_modules nvme nvme-core
 		;;
+	tcp)
+		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
+		_have_configfs
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
