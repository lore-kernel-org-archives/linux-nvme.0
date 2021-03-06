Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCEBC433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:50:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3146508C
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3146508C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RjgGddGbcQU6ZAWthEzEvEE0b5I5tkJshzGY27xJWCU=; b=Sr8qZu1cGhage3f8yFJsmCEK8
	kFqXHhUXtWbZ8P11tAZ6msQFHUsjOMehy5/MF1ebx1QoLRkowBWNVsGJ1gG+l3zzlhndU4BA+6K26
	4dM/JUEjjxRTaFi7eeeQRnazSG+dz1RQzX4WhxJuOduHoR8ch5OWpkE0uqjGr75oKqmX3ybzhQCx/
	MIoWYdpXFK4wKm3JjW2YtLhRR5M3beqJTOOBIg8TxvTmK51lDi/K7BBzUDrOevp5ovXnD2rEkONeM
	LNVC1S5JPVmW1teNe3sdBz30fpjvRrGZNvwUQHZ5WegHcdgRuKs3TEAG1US1JUw8Le3vXMUJGiMy2
	2KTPeyNiA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL8a-00HZuo-4E; Sat, 06 Mar 2021 00:49:44 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwf-00HVkK-Mv
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:29 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXF81V40o79K3bSwL2urSMHnDPlcWpYtBw//B4abpVQ=;
 b=s8bW/MnL5SRlXYe5SSAhoHU3Aha/6g8LUrO2qJjuXf/gFbr1kJuAidcmayGJHmAIJYmlg9
 cI2xLaLSc5Wi4wQKEzb9h8+oJYgX8hKOj4DiHsA09zooR4Murj9Hz1YcrAlcR9lQANNVYz
 HstlRKlM2MIhJfxfOKgYNIH5HX/8wvs=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 48427AF55;
 Sat,  6 Mar 2021 00:37:20 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 14/16] completions: add completions for nvme monitor
Date: Sat,  6 Mar 2021 01:36:57 +0100
Message-Id: <20210306003659.21207-15-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003726_994063_124B4CD7 
X-CRM114-Status: UNSURE (   8.09  )
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

Add some completions for the monitor command.
---
 completions/bash-nvme-completion.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/completions/bash-nvme-completion.sh b/completions/bash-nvme-completion.sh
index 7ab4226..f142981 100644
--- a/completions/bash-nvme-completion.sh
+++ b/completions/bash-nvme-completion.sh
@@ -12,7 +12,7 @@ _cmds="list id-ctrl id-ns list-ns id-iocs nvm-id-ctrl create-ns delete-ns \
 	write-uncor copy reset subsystem-reset show-regs discover \
 	connect-all connect disconnect version help \
 	intel lnvm memblaze list-subsys endurance-event-agg-log \
-	lba-status-log"
+	lba-status-log monitor"
 
 nvme_list_opts () {
         local opts=""
@@ -242,6 +242,10 @@ nvme_list_opts () {
 		"disconnect")
 		opts+=" --nqn -n --device -d"
 			;;
+		"monitor")
+		opts+=" --no-connect -N --cleanup -C \
+			--hostnqn= -q --verbose -v --timestamps -t"
+			;;
 		"version")
 		opts+=""
 			;;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
