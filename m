Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAADC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C7822B3B
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C7822B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YK2dxwU5r2X6m2Q4QyzCsuFh4Ob8C1gtBig+ii/TGWw=; b=v8dcgOIrYd81dcH2NrX1RsDXk
	inXhj5u/U5FDw3QokQqJUVC4eS1K/NB/S0iv7GsY3iuX2mc+75ugkRMjwAzIG5wsNhxlMv/Kld911
	ezfgCXedPGzU8z+Aen0oQyyD9IbteJKvu6XbG9Bo4BfAVlOYsgDs4iQbkoRioI+9RldPeq0/RD41B
	SnNdfYA+IonMF3DjByKOuV2mGmCNKQ5r6MMVxcY+x8+IcGF1lX+AX5o9kfqz2OGsEBgcEGjixzdhE
	omvIbUd0DG/LzoV8UIRV+Nb+wz/hlWSTzzo44xLeSfFudyIXJwmKk2vXJhvvA6H4FurB0hQFBqU/P
	0UQkgtBKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2V-00017N-IJ; Tue, 26 Jan 2021 20:34:15 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V23-0000vP-Tm
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MN2qQgO+ZguAtHRpcwORDW1cVtx5mD4fZNjcgUWCqh0=;
 b=iJ1mkZEVmaIX4RhzPHSxQKhiZ1YHoDXfQtBKYwhf8jrX09uKFmiPaMVOIvURgffqlbTcL7
 SbJXCNVPbcFmffV90UJVmQ5lTcU9rxLwXhfgWk1EVNyX1pUW6EW4HTqlKuduuAwJPg54J2
 LDLv34CHkw1vetjgR8wM/DzCXZ9FIyY=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D598EAF52;
 Tue, 26 Jan 2021 20:33:43 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 05/35] monitor: add uevent filters
Date: Tue, 26 Jan 2021 21:32:54 +0100
Message-Id: <20210126203324.23610-6-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153348_126492_9C25FA2A 
X-CRM114-Status: GOOD (  12.62  )
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

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor.c b/monitor.c
index 63e26bc..a6c8905 100644
--- a/monitor.c
+++ b/monitor.c
@@ -58,6 +58,10 @@ static int create_udev_monitor(struct udev_monitor **pmon)
 	if (!mon)
 		return errno ? -errno : -ENOMEM;
 
+	/* Add match for NVMe controller devices */
+	ret = udev_monitor_filter_add_match_subsystem_devtype(mon, "nvme", NULL);
+	/* Add match for fc_udev_device */
+	ret = udev_monitor_filter_add_match_subsystem_devtype(mon, "fc", NULL);
 	/*
 	 * This fails in unpriviliged mode. Use the same value as udevd.
 	 * We may able to decrease this buffer size later.
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
