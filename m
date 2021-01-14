Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8A4C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:15:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A31223A52
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A31223A52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FWC8DlxBGysFudRKEogl4/GKmsmQUVvlPSfdCVNOjgE=; b=qiK9NW8L/lx2jaLaz9v0iughY4
	HVlrLqrhMf3UQTFvGRyDkg6tG1piDMjQVNWDw1P3yAZBKV1/ofsVr0uGRdcGfG0sdqUndVmOe5Dpo
	ze07e/t0pOgFTLjeeMTCvRVhB/O1ifuhG/QnNvg+mD1eSKiwuG2uNgD0A2S5LM83ZRpFQ6L8ZyV5E
	oi4zwt5go1QblhO12YFIANOnV7L4z2yVkI4F+lZtwxHtVr/HiatQy/qYUIP+WxM3SM7ZgS6YSnwxg
	MQVSKBtnCsV3peq0D8TwmUlpcD+hcgxy6+O4kwEta9nPfpQSwAhV2SLbLWkaaT1o77lAtNnTZWBIX
	ly8Wli5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l09xt-0004PH-IK; Thu, 14 Jan 2021 21:15:33 +0000
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l09xq-0004OK-N8
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 21:15:31 +0000
Received: by mail-pg1-f179.google.com with SMTP id n25so4641935pgb.0
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 13:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4UyFY1nM+5p0PY71ZTGURwVuIMdZLOa7Jbcumvhh8vQ=;
 b=A58leZfqGYhh1rdQZ1Ap2/NwECrvAlg+BR5gd+huqPpER4qKjpC7jeMNedRHxbvqXN
 lv0NLJV7heNuaZLTQwfRVs8IRuiIPKaf/yHCszAJhx8b5e+sF0cCXO6eYfEiiVjwMduz
 9DfemCqjGz0AloucZtVWkuhMRadBE7x6uiWhVV2dHD5A2BZFZ+yxyKsC6hTwf7Z2zFD2
 IQ6u8s1wWgbgGyaeMMkxHzX/lj5Jd5GtLe3BN/eIytbXP16TAtCtOOX0sWzHQikjF1aF
 8syUQOkwi9YtreMhiaPrzhC95waej5CasAtNiD4rM0fvbjVbNVRpVThigxHCcg/CGAD+
 4V0w==
X-Gm-Message-State: AOAM533/AUJtiL9WI3H2rN5tTM1ILQYhdnXDNWavIKP6sJh++ni/AkJw
 p1XhrLbZc1VSSeW5aTKnULI=
X-Google-Smtp-Source: ABdhPJzDXIvPRYrnPcF3paXN1+wyjInsHuwkdeejzSsKW/dSJEtCIQxfEWGhyB5ewZMAPan6pgJKcw==
X-Received: by 2002:a63:4f64:: with SMTP id p36mr9234995pgl.374.1610658929436; 
 Thu, 14 Jan 2021 13:15:29 -0800 (PST)
Received: from sagi-Latitude-7490.attlocal.net
 ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
 by smtp.gmail.com with ESMTPSA id s24sm5901165pfh.47.2021.01.14.13.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 13:15:28 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 0/3 RESEND] few simple cleanups for nvme-tcp host
Date: Thu, 14 Jan 2021 13:15:23 -0800
Message-Id: <20210114211526.86946-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_161530_774272_60C86185 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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

No real bug fix here, but some useful cleanups.

Sagi Grimberg (3):
  nvme-tcp: fix wrong setting of request iov_iter
  nvme-tcp: get rid of unused helper function
  nvme-tcp: pass multipage bvec to request iov_iter

 drivers/nvme/host/tcp.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
