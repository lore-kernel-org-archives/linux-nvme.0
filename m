Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9AAC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 10:53:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A021B64EBB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 10:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A021B64EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T928ID81sfWbpE+5z3fRWymMcCA2Mtf8jZd2+XzqdYY=; b=jzt42D4CoUalvjWNm6IZdKBMU6
	p2bjbDvLALU7fkbcuq9Kn4E+vLiQcYh93ERp2BqA7x6qDIM9uvu33fvHUB7U3S/Yn+PpOG0/jCZiF
	GU2ItHcGv188Neks2e+okqBWlIvfLU/DMeCvk7oiAO/Ts1wsSUMGGPRATdcYD1LBgWBBl8E5W/6A9
	FtN/YOVsS5+r5Lcl1NEQALCJNYNma34GHjPjdrGA96da/Alr7Q0dPH7SLPMA9Bx/B0GZNdqhfd/Gm
	usfs3ESZR520i/9iHQ7NFP1zNA1dnhasnC1CQoCKSws1YAg3jfBMZimOPaP4daHCeJIkTl38B/SXM
	GY+2/bhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lErmk-0001p3-7E; Wed, 24 Feb 2021 10:52:50 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lErmi-0001oP-3k
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 10:52:48 +0000
Received: by mail-pf1-x435.google.com with SMTP id b145so1092554pfb.4
 for <linux-nvme@lists.infradead.org>; Wed, 24 Feb 2021 02:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XigoJ5g60dSxsJtV71Bn/BKOiF/mDL4DUlENy7zFf8s=;
 b=iQYIsaOFgbQFl/0FVngcquLH8DS518KcIIOdN6x4PUE6gc62tebZSNdJase/bBZGYU
 fJ1iGZJZb1PSGmdJ1mTcpvzptCsbugVPJZ+K5Solyqp+zgz6lZEU342lBsCAISRXyR2q
 hj8hExepkG93n61qD1Y2aSLEBGgdI7KxgNCpSiadj5dRMmuqoiW8z0zP5ddOgejvKqzX
 zsJu122fGdge2im0ZcqYHkBMGtJ0x+pewBRCAxunlEbcK2ZmdVgB+tdcR7WGpP4VtjA7
 3SF/VAW/QB+xc+2VYarcE0qpb04N+cmH9YasAGoYUyH9FbwEa0LeGebEXETsU1WZ4qGn
 C3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XigoJ5g60dSxsJtV71Bn/BKOiF/mDL4DUlENy7zFf8s=;
 b=XKLMFyWLecM0l1BxR/4dL3zljIKKsCPpzcEhSaJdMyTmu7FJdrW6pXrXB/Je2Rhc8d
 V5tWwLB8ZRLt6cE1Gtj/uFdftTGbnkyfieZuwYByAQ8uZlCbGAyxwIkuSLBq4rqDwJee
 zfwdbWe+pqxJA4UJVoWu4woPg0zid/SYdIMweEVnQNRoihsE0x4VqxckBDThTfacLXyp
 rnh7uFCJHZPBXjken0Z9m888v1ZKJrj9DYUETvKO9t1xG4aTExFapXjak0491BSWhyXq
 rPVh8Hiv7049kx1o0RQOxDPVqkHMfIjJVzBA85IayBfPYC7SPesKnsNRUSV6V2JymbTP
 lQVQ==
X-Gm-Message-State: AOAM531a6nZ4H8ie/RMrs7A9Bh22Y85pPnhlYuFLFCHh/avFoBnLQlNI
 f+9HSitzRk3hvV1Cnay/IB0=
X-Google-Smtp-Source: ABdhPJxq/dUSbJlrHm6F8d6pOFsCfHn5r3o6yuADjMnPSVAQvta8AM1ivyA+NIhztIS2sEwKU7/wiA==
X-Received: by 2002:aa7:948d:0:b029:1ed:a489:dd7a with SMTP id
 z13-20020aa7948d0000b02901eda489dd7amr14428195pfk.29.1614163963563; 
 Wed, 24 Feb 2021 02:52:43 -0800 (PST)
Received: from marting-pc.vpn.netapp.com ([202.3.121.6])
 by smtp.gmail.com with ESMTPSA id d189sm2377243pfd.42.2021.02.24.02.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 02:52:43 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2] fabrics: ensure zero kato for non-persistent controllers
Date: Wed, 24 Feb 2021 16:21:23 +0530
Message-Id: <20210224105123.7050-2-marting@netapp.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_055248_203688_94FA7746 
X-CRM114-Status: GOOD (  15.02  )
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
Cc: Martin George <marting@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a helper function that sets the default kato value for the
controllers. Along with ensuring a non-zero kato value (i.e.
NVMF_DEF_DISC_TMO) is passed to a persistent discovery controller,
it also ensures a zero kato is passed to a non-persistent discovery
controller.

Signed-off-by: Martin George <marting@netapp.com>
---
 fabrics.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index e38657e..c780040 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -918,6 +918,16 @@ static int build_options(char *argstr, int max_len, bool discover)
 	return 0;
 }
 
+static void set_kato(struct config *cfg)
+{
+	/* Set kato to NVMF_DEF_DISC_TMO for persistent discovery controllers */
+	if (cfg->persistent && !cfg->keep_alive_tmo)
+		cfg->keep_alive_tmo = NVMF_DEF_DISC_TMO;
+	/* Set kato to zero for non-persistent discovery controllers */
+	else if (!cfg->persistent && (cfg->keep_alive_tmo > 0))
+		cfg->keep_alive_tmo = 0;
+}
+
 static void discovery_trsvcid(struct config *cfg)
 {
 	if (!strcmp(cfg->transport, "tcp")) {
@@ -1401,8 +1411,7 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		if (err)
 			goto free_and_continue;
 
-		if (cfg.persistent && !cfg.keep_alive_tmo)
-			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
+		set_kato(&cfg);
 
 		if (traddr_is_hostname(&cfg)) {
 			ret = hostname2traddr(&cfg);
@@ -1476,8 +1485,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	if (!cfg.transport && !cfg.traddr) {
 		ret = discover_from_conf_file(desc, argstr, opts, connect);
 	} else {
-		if (cfg.persistent && !cfg.keep_alive_tmo)
-			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
+		set_kato(&cfg);
 
 		if (traddr_is_hostname(&cfg)) {
 			ret = hostname2traddr(&cfg);
-- 
2.30.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
