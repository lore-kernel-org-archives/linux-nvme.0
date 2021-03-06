Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749D8C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:37:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB4B65076
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB4B65076
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x+zdh/OMYn/kcZDW4M6xy8BlzyvBgpd04ufLCiEftVE=; b=oDtE47VvTG7Q3TQBgNuleYq3J
	Mxbjgb6jRAvrnTPRdO/ZLz/fLffdx/B+PYl2aKmKM7ho078/hoLCPFfG4JFLuWiW2js4NWFmAx3yn
	Ll4ERJqJqFUF9+q3xt7VDhSFJsfFCEx4pNSBMwRhcqp/aucGpMIPUR+F4EFriYhAFb7UaeM0n07Si
	GAnn7lOKRMbM7mB6WY8XqOnlz1wmyUDaz3eq1MEwcI3akVL5/PIHdZc254V9ugbT4BU/SUT2O7g6G
	MwO3tsRpiJurpXk9ffd3rUfcq0jB5AWKAgPqOrtUGuRsjbDuF4yyDVsaedIqMa2DA6t+73wUd9SKt
	t+BRqqXGA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKwd-00HVin-M7; Sat, 06 Mar 2021 00:37:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKvy-00HVRR-KR
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:36:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3FMfrZuImUe5IsbLzaSIpF+bhqwF9zvrW+iMjOpIgRw=;
 b=FHb8oRBgdx+l3GsJh+Z6F4/ns3q2WB3T2BfyMoqkoyYJgzx5IDG68lJSTRz8g2DHhDbQcd
 uGwhVsNO/p7jOTchdRczUrlRcEK97pP2YfRvcZ2m/9CkcvcZMRYCM78I5rQ6oyfLH15WGD
 5exbwrZgK6POX2nK2kcgn4HVgLHGkO8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E78DAAD87;
 Sat,  6 Mar 2021 00:36:39 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH 03/10] do_discover: free cfg.device when resetting it
Date: Sat,  6 Mar 2021 01:36:17 +0100
Message-Id: <20210306003624.21102-4-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003624.21102-1-mwilck@suse.com>
References: <20210306003624.21102-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003644_163041_6F7C8E00 
X-CRM114-Status: GOOD (  11.80  )
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
index dcee0c4..223bd04 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1378,7 +1378,11 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags)
 	if (!cargs)
 		return -ENOMEM;
 
-	if (!cfg.device || !ctrl_matches_connectargs(cfg.device, cargs, true))
+	if (cfg.device && !ctrl_matches_connectargs(cfg.device, cargs, true)) {
+		free(cfg.device);
+		cfg.device = NULL;
+	}
+	if (!cfg.device)
 		cfg.device = find_ctrl_with_connectargs(cargs);
 	free_connect_args(cargs);
 
@@ -1562,8 +1566,13 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
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
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
