Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45680C433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0929F206CA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k0APUNnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0929F206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tiWPKmJPdc6H9EcOSAb9pvBDMW8Qz6NW61NfPog5Pz8=; b=k0APUNntpi/Y96krWA7O8FeID
	efHfcKubMJE/pU8lz7Rr/k65bMOhPcSp8z2o7Lg+sHfDXh/6w2qy4bIglvEXD1LkqAlJ1mHAe7qrN
	JoSotFOTnDQTeP11IaQPpN9UpJ0Z4faQy95rs3Ks8o86y2Du1TzL7zj98YZw4uqPJqWbwMr5B5w0b
	VhtBWSu+E1seWPqCEa62vBrczeaFAjx0tZ8y5zFzJ9BkBZvWJUmbLAbr9FA62Hy7jtfHYCVwTUdhn
	5pvUHFBafAUaZEetL8bgt+Uh5EtNni0r2QJeWMVuivK5anudOqfQWQSeQjCueZ2ZyC2OnQRv50TLH
	M6pTFyotg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDwlH-0007qb-27; Thu, 03 Sep 2020 21:27:15 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDwkz-0007ii-FQ
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 21:26:58 +0000
Received: by mail-wr1-f41.google.com with SMTP id g4so4703890wrs.5
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 14:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l5f/WhCUB3SYptcds9DMSFGf+leIG0AOF4/byaQGTcA=;
 b=WZOVaeEH73vfOxint9dmv2BA42VvhVe7ikL0adHBpdQ4QBw3YDIxUWX8H65IAu5JYf
 UGNfamaaYp/x7e3w+9c8b1VOIhBW67v2dDQ1J8LNe+cNPDs/HDhaQiPv1jr/iFAAezqf
 YsGjhGQWl9rUKcuhzwx4VEVwdXlxkKRBpq6LWX8uSi+pNQ9mtHF22JBA6tvf6cAb+rnW
 +GIUvQGbQ/USwBGCo/kSGg4hRipRarABivqLfeGdsm9U7HJ2HqPRoRB2Y2AZjz3Wj2ud
 oGQWB/hbwzwmON0ID/cInr3rCKEPXNRH4M1bR7NBd9WlQusYwSfXhlp8MfWuMqJE1pds
 rFQw==
X-Gm-Message-State: AOAM531A62yBRk1gJtak0I1mcxkfoWUWGgWnyiIj8o9EcRvL8f151RDV
 NOH/u5JWZ+0ZuGceAeO2N00=
X-Google-Smtp-Source: ABdhPJzv4njTtIGWuTyfBWaEa0Cwkmm69k1pCPYv1md415sNYtbKw5ENQbF5xTdJ9lGw+R8wVojZ5w==
X-Received: by 2002:adf:f843:: with SMTP id d3mr4782216wrq.226.1599168416288; 
 Thu, 03 Sep 2020 14:26:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id v204sm6659896wmg.20.2020.09.03.14.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:26:55 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v6 5/7] nvme: support nvme-tcp when runinng tests
Date: Thu,  3 Sep 2020 14:26:32 -0700
Message-Id: <20200903212634.503227-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903212634.503227-1-sagi@grimberg.me>
References: <20200903212634.503227-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_172657_518101_8C770374 
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
index fbd5b66c25d5..2b267f1d6ae6 100644
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
