Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB0C10DAA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285B1206B7
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rckvE4Yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285B1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UUmXb0b4qBCV5r63ZhxCnYRfEri5YVCoNVWruF20nCg=; b=rckvE4Ynrf1HeWLt7HnE9sgFW
	quRbdOBtQfy8s9wWd2S6QdunY4pJQ7BKZ8lSQXyozxmnLp3Qui8kEtA88TWKQ3R+8jT7F2qSIu5/0
	JGKbalM/HREjQ3OFUWblp/6mX6IATuKROM06Tt79yxQgKLqm2OMtYFVPBJXpceqDdepCL8hfXc6UL
	9grVQIpFfr3W39VQZm6grcTQfMhllm3BdXE8fso2K/8QVUto2J5r0BdMdbJa0p+ap2sbJ4u0Ezqqr
	iXr8Us11BkuInbxfdtl56sEmb7zMA/7cAt0zRzYONkPLP5dO90o3WdrMIV1hmqenPPfScTbfVuwpp
	oVB2PMgZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDz3L-0001rJ-Oe; Thu, 03 Sep 2020 23:54:03 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDz3J-0001pw-BP
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 23:54:02 +0000
Received: by mail-wm1-f46.google.com with SMTP id w2so4478096wmi.1
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 16:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iuto2pxfODOk9zAl9MpiH41FtDUvxGxjWYhRICRrL4Y=;
 b=T/VBMziUBW5DlTACSsMJ1eh8F5vKtJr8gpYRPTyE+MGoNDhbvIVYtvnIE+Qms5p6Uc
 uaGAACp4GxpWv7CzqtvpgVGaOShgASMwol8ZOeleHYJkrcJGe5cEkQVIVQBZfcWb7c7K
 bbtlpJY4ZyuNYpqZOBoXRMoPYY6kmnKaYlgVZECKc96BG9Xr11/afNw1Yur7nNhkzBO1
 MUnfI2mPFsE7Cm8RQ/lTtqAVriS6E2ms3j+QoTcbRt20aDulFwtP2NtK7c6AQJIXYYXl
 4or+Acq2hzw/phvJxJuQDVz4zyPT+nPLuJtvg37JPIEW9p5gCO93LIOOwJZDUJouAgtO
 dR3w==
X-Gm-Message-State: AOAM532S567lWS/WLimQ4hO2UdDfccyaKcgDs5QsLaTuSCSUV9riZtLp
 p+PpD1tPRc6X9+Qa7NhtcVM=
X-Google-Smtp-Source: ABdhPJzP5enYrr9v2JKs6+l576WmBa5UTPasfbquiO07LvKGOUgc1eeI3A6E8sP8EvjMl1RHXfQxjw==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr4730403wme.89.1599177240135;
 Thu, 03 Sep 2020 16:54:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id u17sm7024992wmm.4.2020.09.03.16.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 16:53:59 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v7 5/7] nvme: support nvme-tcp when runinng tests
Date: Thu,  3 Sep 2020 16:53:35 -0700
Message-Id: <20200903235337.527880-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
References: <20200903235337.527880-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_195401_427597_538AED1E 
X-CRM114-Status: GOOD (  11.60  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

run with: nvme_trtype=tcp ./check nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 3b8754669af7..8df00e7d15d0 100644
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
