Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79041C433E9
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFC922B2C
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFC922B2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bV5Vr7X3IGy7ievsGx1HCVdlX7d7ZqOjLFl/n4wH8HA=; b=adGO5ov7xlMsMoFfqlMnpgBjd
	T8MdHKka5F4BIUCsUUBVAVN+w274VlkXvd+ectkAYg+JKFXq6lMsJuI0jw+y1vcPycSQztQW+3Tx8
	On3OQF2QAzfeXPN2H6sHgbIRgMDbYPn1uXap4NDeiVgh1reV5cup1N7DpwY4D/plRf1kazwvqBZWz
	CvELPH4YaMPyQJPNglphK+cX4Un+VqIxdAaPtB30oGNeqvOWkRwXhXYLInCc5kpjt/Z79oxU8RpRY
	l+wN3z35cAbEscPjSLJTGXMeworSxB4TPl0vgFN16OnNJH8R5alt7YMUws/xr1I6tza5J5R3vvn/T
	xHMU+qZaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2i-0001C9-Dx; Tue, 26 Jan 2021 20:34:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V25-0000wW-DP
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:53 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rX5UD/u5zQS8VWigV/UqTC3ZjVB1d1mABwI3NlAD/hA=;
 b=YZ9YJIDe8YdbVNfykVHMA7pKXYTI3qsS6BD4cWodZ01z6n3HBI1WiSzDUzkoihtfsfrbwb
 4d0DDzMC0rpu/PYRom+oLrZRKT5Wix8IJBs3eZdGzN/WavnK2DaOY+/JuT9czLX+V7fax9
 LWjIn7xKNkS79LBLmas67M1p9UbhYBo=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F187FAFEF;
 Tue, 26 Jan 2021 20:33:44 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 09/35] nvme_get_ctrl_attr(): constify "path" argument
Date: Tue, 26 Jan 2021 21:32:58 +0100
Message-Id: <20210126203324.23610-10-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153349_633225_2E1923FA 
X-CRM114-Status: GOOD (  12.54  )
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
 nvme-topology.c | 2 +-
 nvme.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme-topology.c b/nvme-topology.c
index 71371c5..f62446b 100644
--- a/nvme-topology.c
+++ b/nvme-topology.c
@@ -45,7 +45,7 @@ close_fd:
 	return subsysnqn;
 }
 
-char *nvme_get_ctrl_attr(char *path, const char *attr)
+char *nvme_get_ctrl_attr(const char *path, const char *attr)
 {
 	char *attrpath, *value;
 	ssize_t ret;
diff --git a/nvme.h b/nvme.h
index 3fb1060..382e625 100644
--- a/nvme.h
+++ b/nvme.h
@@ -109,7 +109,7 @@ int scan_subsystems(struct nvme_topology *t, const char *subsysnqn,
 		    __u32 ns_instance, char *dev_dir);
 void free_topology(struct nvme_topology *t);
 char *get_nvme_subsnqn(char *path);
-char *nvme_get_ctrl_attr(char *path, const char *attr);
+char *nvme_get_ctrl_attr(const char *path, const char *attr);
 
 void *nvme_alloc(size_t len, bool *huge);
 void nvme_free(void *p, bool huge);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
