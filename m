Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB7CC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:01:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D68560241
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D68560241
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BZ1dTeT1yl1LR3dpXhA0ZHmOkK1mSJUuA5PZhRkpzWs=; b=SEoh9jfSSIcv/9QWZ/ZWs+Crb
	Xh/17sU7yjvBGZEUprk4ttOP8o74VG+Tw5DGn1SmvagqDigKxBjRW2vG0FiE+uDW2I85V00cmj6Cy
	R7KDnGumvwef2Tx5FdBhqbwrxqbnLNthe/XcLR7Qys4UlF1vngKRTpIOYIzl1q7HZvhYtya+5V+nK
	nk1DEZIpD5xHDNqErSPzoC0tvvXJiwoyKEqtsZ8OjJWmwmRQIV7kRI3dkw8nBLZqFwNv3v/5HuE/I
	fHiJEUIa7a6e2TTXdE/e52i57aAre6MyXZioaIr1HqZ0Hi/J25yhivTshlSu6M5rbC9sQ2pXZWUGE
	soR2uDQXA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRGnh-004Hmp-OB; Tue, 30 Mar 2021 16:01:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRGlo-004HSV-96
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 15:59:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1617119942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Yv30caOo2fEWtG+UnUE2CsnjMwyJq2brQJuY0a9FYo=;
 b=gW37Xvcldjr/Z5C4cgLoF+u75ukSB+QnHNTLrIfQ9vEZ0/7mv5HeY04NahVYas5zUWTfzQ
 8aCWKZQCBlS4rYR2umiRd4L4f285GXR4Tdw/NK77zj3AjbMbavlZqFh0N1PICxBEQnsiBN
 CBqkarO+NQUS4lN3zd987afqvyQfITY=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C8AE3B31F;
 Tue, 30 Mar 2021 15:59:02 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 7/9] fabrics: use "const char *" in struct config
Date: Tue, 30 Mar 2021 17:57:09 +0200
Message-Id: <20210330155711.8436-8-mwilck@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210330155711.8436-1-mwilck@suse.com>
References: <20210330155711.8436-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_165908_608300_989FEFFB 
X-CRM114-Status: GOOD (  10.00  )
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

This is easily done, and allows passing in some const char* pointers
that would otherwise need to be strdup()d first.

Do not use const char * for cfg->device, because we may need to free()
it.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 4a5c2f9..9a694bd 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -67,13 +67,13 @@ const char *conarg_trsvcid = "trsvcid";
 const char *conarg_host_traddr = "host_traddr";
 
 static struct config {
-	char *nqn;
-	char *transport;
-	char *traddr;
-	char *trsvcid;
-	char *host_traddr;
-	char *hostnqn;
-	char *hostid;
+	const char *nqn;
+	const char *transport;
+	const char *traddr;
+	const char *trsvcid;
+	const char *host_traddr;
+	const char *hostnqn;
+	const char *hostid;
 	int  nr_io_queues;
 	int  nr_write_queues;
 	int  nr_poll_queues;
@@ -82,7 +82,7 @@ static struct config {
 	int  reconnect_delay;
 	int  ctrl_loss_tmo;
 	int  tos;
-	char *raw;
+	const char *raw;
 	char *device;
 	int  duplicate_connect;
 	int  disable_sqflow;
@@ -90,7 +90,7 @@ static struct config {
 	int  data_digest;
 	bool persistent;
 	bool matching_only;
-	char *output_format;
+	const char *output_format;
 } cfg = {
 	.ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO,
 	.output_format = "normal",
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
