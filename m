Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47925C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 15:59:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A2A619C5
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 15:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A2A619C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KpjO7trnwQ7xrbkSN6REaOaR0QkACVLansIxRgkl34g=; b=luxcTwvScK5AY6MjXqzAeJEUz
	XSFxtTcWkKKr8MN7ipxkFQ80XgriH5Fjn0xO7tpYeT2vsy847MaoPPVAlfecTVMiUPJ0JhooAPIIT
	aYj3a2XdwgGWnOLtXby5oe3Bu+pmDrQvIGB6ULlIWz1ewrZ30djoUrrty2isAt231fyKsjpaz4hAq
	WMuiGaC+xcm09+qGwYjeCk6Iop1xqpDT+NY9vFoFKmRpzNM9GUw0PoEmnJ+HScbkyzWcxTJCfAy77
	63X2hiXr4nNR+GLChNG63owCjNwHcDL+XZcHz1EIJ9mWa87fV5lJaGteGezluGiRneKrLnuxMDsH/
	fGK+T+TWw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRGm4-004HVH-0p; Tue, 30 Mar 2021 15:59:24 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRGll-004HQp-Se
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 15:59:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1617119941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekAgia+BfQ+PhvYXxVXP3GfCifh6iI47f591LmsJqJU=;
 b=fi6sEDQva4xXA8Yf6oCYHhn8ZQoJ5hf/7dLPv7mufRmSS94YyIVdMZPCdfYt1U8SB6We5M
 wCKXRK5h67ZnCRwzP9qRjlfeSFUR3TByQRQ1IIl8xIyUIPf1Et47d05J2kxrql8PA3B4Rb
 g+IhFUMpUyCgsDtapdv9cKdTVws2xKQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3B7F8AE58;
 Tue, 30 Mar 2021 15:59:01 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 2/9] do_discover: free cfg.device when resetting it
Date: Tue, 30 Mar 2021 17:57:04 +0200
Message-Id: <20210330155711.8436-3-mwilck@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210330155711.8436-1-mwilck@suse.com>
References: <20210330155711.8436-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_165906_021894_A1812CB5 
X-CRM114-Status: GOOD (  12.59  )
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

From: Martin Wilck <mwilck@suse.com>

cfg.device might have been allocated by a previous call to
find_ctrl_with_connectargs(), therefore free it. We must make sure
that cfg.device is always on the heap, thus change fabrics_discover()
accordingly.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index bdd0679..49331cd 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1376,7 +1376,11 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	if (!cargs)
 		return -ENOMEM;
 
-	if (!cfg.device || !ctrl_matches_connectargs(cfg.device, cargs))
+	if (cfg.device && !ctrl_matches_connectargs(cfg.device, cargs)) {
+		free(cfg.device);
+		cfg.device = NULL;
+	}
+	if (!cfg.device)
 		cfg.device = find_ctrl_with_connectargs(cargs);
 	free_connect_args(cargs);
 
@@ -1560,8 +1564,13 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	ret = flags = validate_output_format(cfg.output_format);
 	if (ret < 0)
 		goto out;
-	if (cfg.device && !strcmp(cfg.device, "none"))
-		cfg.device = NULL;
+	if (cfg.device && strcmp(cfg.device, "none")) {
+		cfg.device = strdup(cfg.device);
+		if (!cfg.device) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
 
 	cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
