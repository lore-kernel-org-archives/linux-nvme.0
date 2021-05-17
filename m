Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F98C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:27:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C2F611BF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C2F611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LJ22Z/LJFXZ7DTCn5fIsfG9+4s5OZhRF2YSn/WIqkjQ=; b=HAwMWcVoThmbGv
	810DZdaeUsv93wZJZwjkkN4uJGkq59qw2go1pPfX82hily75XUu73iXyRQM58xw9Pvm10XZZZQhrq
	nrGKPa/jPxqez+jiY/c81lI42chz3yaFaoX4FHMjFDhLaaAxai8fVR44HO5dqwHL+/IN9oxoGSWbV
	2EZZRuTRGeE4gRgF36HvGIdL3L2rPl+NVvE/sXFM6h9aGTJ0lD9vPeYyukZoaq0x2Uc+D4dW9sxyy
	bg3Md2EkuuWegSsHFfjOaKnYjNddKcja0OA4PLU+42axF+CR3KSHsWLTimrkaY/dQrl17i6fls7A9
	nsO3/HohJ0fFjtQFPvgQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lihwg-00Fo1u-Bm; Mon, 17 May 2021 18:26:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihwd-00Fo11-2x
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 18:26:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=oKRJAhfZg3W2D0sQ03lFlH978XOSAvFor4xx/SnyfzM=; b=L7Yd3tk2SN4UsIz407z0TtQX7N
 +flEDj0M5QlUAfGuEG+tAh+NNYfHWde9kGRWNmTTVSvL95TNmGg2Z/eInov9qvOEMViGcPW9Cvp8H
 FTVxWocQMGtTeUkczKpnvUEKo2WW3AzBtSBoNAzICtpZW7w2H0Ii9JJGsRdHPG2pj7JaD72IQObaW
 7tM1FriRttyruh92jhUlCggJ2++7E3seCOsu48Ja5mcHUKavSKxtEUsrldlI0jowCMpp1FDfl6fj4
 RJZ67mOQvmDg1CHi7AequBWz7pt0Q+6txdWl30PyC882rs+quWRXgsWk1+aCpuM12/I0bqFEdNhyM
 tlgG/BNg==;
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihwa-00E3di-8x
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 18:26:21 +0000
Received: by mail-pl1-f173.google.com with SMTP id b21so3673486plz.0
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 11:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oKRJAhfZg3W2D0sQ03lFlH978XOSAvFor4xx/SnyfzM=;
 b=uOh47jl5hE3TtTYHfm/N1ws5K6JgPF5Y23/CeN4Km0h4Y3emUqN0WVEMMcppYU9VND
 zD4VFPRkNJ5m/z4tN0qLEGZVkCnX5IGtg7Bevu+iz61n1n8iu53J0Jids5KcwTvD405e
 kevxWkFQsPaB4zprP+jCp/uooLsL6+14WXOca/a3nik53w5V5FuyC3h/9QZtj9iUuCXg
 /CXmep1nw5Z0faCsAzTApawxAOg5szVEYcq6Kpwy+daxTAuxw9m9h+zbpp1kU8dPY0nU
 DILVxJhgTuN/KHvvhak5marHeh0rhXclUmzUN77qQAaHmNjo/NFwFnmcrUDUv1DYCeXb
 tejA==
X-Gm-Message-State: AOAM530nu7CsDP7U4xWZ47CMTt3wQlbwf1JfEcJGTydSH7LKbbHdnLsy
 bHM+idCE8j1+rtrUpoLQog12RAPTFwE=
X-Google-Smtp-Source: ABdhPJyLBf+rrCzWESEPy7eaRzOFk1cWHBoMMMoCWpjILUcM/ELCzrsWwn0Jj12DZ+w8e3ZeWqpAAw==
X-Received: by 2002:a17:90a:6381:: with SMTP id f1mr484895pjj.30.1621275978948; 
 Mon, 17 May 2021 11:26:18 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id c130sm10388118pfc.51.2021.05.17.11.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 11:26:18 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] fabrics: add fast_io_fail_tmo option
Date: Mon, 17 May 2021 11:26:16 -0700
Message-Id: <20210517182616.607768-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_112620_340040_7B37B254 
X-CRM114-Status: GOOD (  13.16  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

Option to fail fast I/O when connecting to a controller. It is useful
to set a fast-fail timeout for nvme in case upper layer SW wants to
detect unresponsive controllers early (e.g. mdraid).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 12 ++++++++++++
 fabrics.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 242b03e4dc77..77eb8f4efc9b 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -69,6 +69,7 @@ const char *conarg_host_traddr = "host_traddr";
 
 struct fabrics_config fabrics_cfg = {
 	.ctrl_loss_tmo = -1,
+	.fast_io_fail_tmo = -1,
 	.output_format = "normal",
 };
 
@@ -1004,6 +1005,8 @@ int build_options(char *argstr, int max_len, bool discover)
 	    (strncmp(fabrics_cfg.transport, "loop", 4) &&
 	     add_int_argument(&argstr, &max_len, "ctrl_loss_tmo",
 			      fabrics_cfg.ctrl_loss_tmo, true)) ||
+	    add_int_argument(&argstr, &max_len, "fast_io_fail_tmo",
+				fabrics_cfg.fast_io_fail_tmo, true) ||
 	    add_int_argument(&argstr, &max_len, "tos",
 				fabrics_cfg.tos, true) ||
 	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
@@ -1185,6 +1188,13 @@ retry:
 		p += len;
 	}
 
+	if (fabrics_cfg.fast_io_fail_tmo) {
+		len = sprintf(p, ",fast_io_fail_tmo=%d", fabrics_cfg.fast_io_fail_tmo);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	if (fabrics_cfg.tos != -1) {
 		len = sprintf(p, ",tos=%d", fabrics_cfg.tos);
 		if (len < 0)
@@ -1567,6 +1577,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 		OPT_INT("keep-alive-tmo",  'k', &fabrics_cfg.keep_alive_tmo,  "keep alive timeout period in seconds"),
 		OPT_INT("reconnect-delay", 'c', &fabrics_cfg.reconnect_delay, "reconnect timeout period in seconds"),
 		OPT_INT("ctrl-loss-tmo",   'l', &fabrics_cfg.ctrl_loss_tmo,   "controller loss timeout period in seconds"),
+		OPT_INT("fast_io_fail_tmo",'f',&fabrics_cfg.fast_io_fail_tmo, "fast I/O fail timeout (default off)"),
 		OPT_INT("tos",             'T', &fabrics_cfg.tos,             "type of service"),
 		OPT_FLAG("hdr_digest",     'g', &fabrics_cfg.hdr_digest,      "enable transport protocol header digest (TCP transport)"),
 		OPT_FLAG("data_digest",    'G', &fabrics_cfg.data_digest,     "enable transport protocol data digest (TCP transport)"),
@@ -1650,6 +1661,7 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 		OPT_INT("keep-alive-tmo",     'k', &fabrics_cfg.keep_alive_tmo,    "keep alive timeout period in seconds"),
 		OPT_INT("reconnect-delay",    'c', &fabrics_cfg.reconnect_delay,   "reconnect timeout period in seconds"),
 		OPT_INT("ctrl-loss-tmo",      'l', &fabrics_cfg.ctrl_loss_tmo,     "controller loss timeout period in seconds"),
+		OPT_INT("fast_io_fail_tmo",   'f', &fabrics_cfg.fast_io_fail_tmo,  "fast I/O fail timeout (default off)"),
 		OPT_INT("tos",                'T', &fabrics_cfg.tos,               "type of service"),
 		OPT_FLAG("duplicate-connect", 'D', &fabrics_cfg.duplicate_connect, "allow duplicate connections between same transport host and subsystem port"),
 		OPT_FLAG("disable-sqflow",    'd', &fabrics_cfg.disable_sqflow,    "disable controller sq flow control (default false)"),
diff --git a/fabrics.h b/fabrics.h
index 41e6a2d07b1f..b98f6b0d0904 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -29,6 +29,7 @@ struct fabrics_config {
 	int  keep_alive_tmo;
 	int  reconnect_delay;
 	int  ctrl_loss_tmo;
+	int  fast_io_fail_tmo;
 	int  tos;
 	const char *raw;
 	char *device;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
