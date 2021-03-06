Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D554DC433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:37:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F78C65074
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F78C65074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ED6LoO1DQehWgZO93yWzFWPvIoZ4FXnxOO50hQIjTis=; b=BJ8eodfcvSQ34rTZaOwEfuTVQ
	phNJbgnH2fx7a9x5PzcaoZLUh8XB1lRUmzFBjAq+34ytij/9qzlGC4eaflUx47Zf/tS9uMcJEMX9c
	YG/7tMWO1+EoN2QIh/PM60uP7RUpxRSQhMTFN7dqSHKUSFo8gaGIelgUoDtlwP5ebDttvMccHkaa9
	MVvrMuTArXMQ4qOvthHo8EGG/18KuassbRMpL2Uv/LEbWniW0xg3bvPu+DRAJxzjbkdsEIUtscAIn
	PDw7tLUcCi0z6I1q4lrcpmEcSFprznpTBmm4UpRG3W7O2/gWiE69OQ198b7dpcvFHKohVtmoM4lU0
	KmodLba9g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKwn-00HVp6-Py; Sat, 06 Mar 2021 00:37:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKw2-00HVUQ-9d
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:36:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8d9yS4zyYMpbvgm1v8pg5W+6bIXB++4rgnbSyaHKTc=;
 b=BGBDMFt/jdXEu7tupr44BjFDBADXxs9W4u4h9GZeUfWVB0rm3+UwFdNo3U0X+czvfHIdjr
 eottN7vatNIWnx8ow/dIWPLK/uZxsfaoVkXc0UPSrwv4jJVgmwbmbf+ufWIwNGCuR67hQr
 yPh8ax2SfKHjfS13vVqQjVRJP0mQ774=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6A910AF26;
 Sat,  6 Mar 2021 00:36:41 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH 08/10] fabrics: use "const char *" in struct config
Date: Sat,  6 Mar 2021 01:36:22 +0100
Message-Id: <20210306003624.21102-9-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003624.21102-1-mwilck@suse.com>
References: <20210306003624.21102-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003646_684776_36C916A7 
X-CRM114-Status: UNSURE (   9.31  )
X-CRM114-Notice: Please train this message.
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

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 8a1586f..c965beb 100644
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
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
