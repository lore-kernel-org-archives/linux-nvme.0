Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B691BC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69041221FC
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69041221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l9vuLlIgifXOFVl/Ft2PlkfMOSq4QryW4Yl8oc0Z4eM=; b=f60CwBNW/9EEjxhFW1PiDCbvh
	l30SnpoSdKiglTNsVwB4jgX0jK7+Em6iSYz0hvGkxWNxelQ2fWOaCins3+KCLxUvk4Zs5hSFCkKF1
	HfD7mVtCbQ3hoOb7umPM0bp2ZLUZILsXNqOHS5bOMVqAKXtOWh557V8scoNuAe1eUqJ72XvTVWktt
	cdbGMCrXGdf0J6Yta9Bo1r11nPJ0+J+RUxq3vt9pIiMdwdgWm5hi1GyLoqIbBp95pJNxys59RUblq
	7gEWB+wVPxL+8OARWtJP4tGKyGGpcDOFAtcrdqZ7Fo6U4PTI10bn4M8q07ocu/LbFUvDOEmzOmkzo
	hR8eL8/+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V34-0001MX-8X; Tue, 26 Jan 2021 20:34:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V28-0000yB-Km
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:57 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hIfTO9lXwcryHk4jOwN3sBwbjhZvCOc+Yny2iHnfBU=;
 b=m3ibKGIfs3eSDkAkdHb2ZEwzEOk1sIoM7r1CxyMwOJlDfS3dHfncku6CVLJv3w3MSE0P/N
 EauULrv6cPC0jxXQsc0NhI/a3+HV7C2sQ1jPfZyBJ26PCerBCdcSrNI0IltMtiX+l1L0Uu
 lZgJ+anrXtLlvS809gVg677UyEf2Oyk=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C5E17AF4D;
 Tue, 26 Jan 2021 20:33:47 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 18/35] monitor: add "--persistent/-p" flag
Date: Tue, 26 Jan 2021 21:33:07 +0100
Message-Id: <20210126203324.23610-19-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153352_853064_722FD0A1 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

Without this flag, AENs on created controllers won't be received.
While --persistent is probably the behavior most users will want,
it has to be explicitly activated, to be consistent with the
connect-all command.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/monitor.c b/monitor.c
index 8db40e6..419c5f5 100644
--- a/monitor.c
+++ b/monitor.c
@@ -487,6 +487,7 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 
 	OPT_ARGS(opts) = {
 		OPT_FLAG("autoconnect",    'A', &mon_cfg.autoconnect, "automatically connect newly discovered controllers"),
+		OPT_FLAG("persistent",     'p', &cfg.persistent,      "persistent discovery connections"),
 		OPT_FLAG("silent",         'S', &quiet,               "log level: silent"),
 		OPT_FLAG("verbose",        'v', &verbose,             "log level: verbose"),
 		OPT_FLAG("debug",          'D', &debug,               "log level: debug"),
@@ -514,6 +515,10 @@ static int monitor_parse_opts(const char *desc, int argc, char **argv)
 			ret = 0;
 		}
 	}
+
+	if (cfg.persistent && !cfg.keep_alive_tmo)
+		cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
+
 	return ret;
 }
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
