Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8DCC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 09:47:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D7764E79
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 09:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D7764E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QRL7+xWuLF9J7j/SS3MnDrmrhYH5e252boMvDOfpBzk=; b=xd7Zy/NDoxUDi8JBX5mn70obOR
	EqD8AGVk5mzyfPlSxm+2dzPiogFZewLFHy8oRAwczdedTmHoLe5xrekWhkgSHG6fndsEVUEXeAJF2
	z2J0BUmQUMH/oFkQyn2+mU/1lQE6h+regGVrohzkepKCf3HiMb3dD2daL2lKG760u/xnRiLd2gZ8K
	rKHJEvkTA9OAwhVx1VwAi7r3FJ1hCvEefmxoC1uhFLnPAojiKN28spzqdAzadqLFWe8pWFqOCKd/v
	qu38qlb8Y62G9OfZfAp3m1X829KKDqGwK96gPReCPZSM6t0rAnd49F5lvE8MYE4qc3f35jBH1Zeau
	Lu1wChDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCftz-0007Kg-RK; Thu, 18 Feb 2021 09:47:16 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCftx-0007JY-4I
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 09:47:13 +0000
Received: by mail-pg1-x52c.google.com with SMTP id a4so804619pgc.11
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=++Kasfgky7JdoDWOHoDZGP48B3DA/nC0TkNizHwUjdo=;
 b=nCsqKDaGF5XF1lxgiDPuIxDazJkABmuPZYONZpXWclsSLTifi9ShtR5W73TWSzPY1s
 RWShVHduMZLVjqm12/RTJyy1DAg/fj98Z++tHQoW9nxA4WoknC+gREjYj/Ghd9mHCZYF
 WGqd0p7xvLW5xy+2uMvb+nmElq0FZjULWC8KoSMCUh4ZqkzT9qE3sDRIJGbSntGs3cnd
 JM33EjFfsgYoVqxKp3J/46DpL9ANXjBciw/kQKJIBne1fOJaf5QRT5D1AXTnHzfnH5iV
 36f0yiMLa7xtz+vBtrpZRhpHON1nNUll644O65ukL0cLwp+PyhCmrcDswXyN95/1YW/0
 ziPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=++Kasfgky7JdoDWOHoDZGP48B3DA/nC0TkNizHwUjdo=;
 b=VrCoIKRcjdE6VzxhAksQUVv6SnPVuXp2TjfrrQGwYSkfcJyfZLwBrWX2r/yKtThIlg
 TH5ez4OkHd6C2EQX53lcUdoftu2syHp6mUMMY3TiKXqV6DwvEKhKROfh9AzRQKoLhhYs
 alXfdpQZLcDmjtawx2VCr1Zumk0fgStcm16iQZLhY3C7b//IA+GIeuWGT3GBJ3N2rJeO
 djBGd5PbH0GF+cyPqWBgisaoHynoynEUzW8/5f2rqmAnINVwV3O3KeRPdUnltF7OjB3I
 EeHUTSsjgzztSVCGwtEzhvbt9b0r9qG3r9/0MFnxWl+hEEM8HWJJCGhLHgKl2XpJCilF
 qA/g==
X-Gm-Message-State: AOAM531IKZb7nUeZyl0CPgyBtNK7Q2ODLSngVYUKLDrKgIuctIC8cybt
 110SbPxDrLCyTVEcLqSB7y6PF8HmR3GaAw==
X-Google-Smtp-Source: ABdhPJz+hbyfSlccO6/7uzomGzYzMVnzAtCoXGNGDKBZRmZZJghX/8Oaq5q+5Ptbji0fdCPagafGQw==
X-Received: by 2002:a63:221a:: with SMTP id i26mr3262674pgi.71.1613641629797; 
 Thu, 18 Feb 2021 01:47:09 -0800 (PST)
Received: from marting-pc.vpn.netapp.com ([202.3.121.4])
 by smtp.gmail.com with ESMTPSA id r13sm5871916pfc.198.2021.02.18.01.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Feb 2021 01:47:09 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] fabrics: permit kato int argument for discovery controllers
Date: Thu, 18 Feb 2021 15:16:42 +0530
Message-Id: <20210218094642.5616-1-marting@netapp.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_044713_220019_73BD693A 
X-CRM114-Status: GOOD (  10.66  )
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

Given discovery controllers can now accept integer arguments
for kato, permit the same in build_options().

Signed-off-by: Martin George <marting@netapp.com>
---
 fabrics.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 1880a5d..9cfe26a 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -896,9 +896,8 @@ static int build_options(char *argstr, int max_len, bool discover)
 	    (!discover &&
 	      add_int_argument(&argstr, &max_len, "queue_size",
 				cfg.queue_size, false)) ||
-	    (!discover &&
-	      add_int_argument(&argstr, &max_len, "keep_alive_tmo",
-				cfg.keep_alive_tmo, false)) ||
+	    add_int_argument(&argstr, &max_len, "keep_alive_tmo",
+				cfg.keep_alive_tmo, false) ||
 	    add_int_argument(&argstr, &max_len, "reconnect_delay",
 				cfg.reconnect_delay, false) ||
 	    add_int_argument(&argstr, &max_len, "ctrl_loss_tmo",
-- 
2.30.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
