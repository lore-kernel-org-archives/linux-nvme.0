Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E118C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A732422B3B
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A732422B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/uoQzx8QKoXRbK6EMGsdQNdVGQsXb0DXQHi484hVo6M=; b=IuE518K+zL9hLj1FHQ2g2lCwl
	awYFM3FoAyW7D8MAT0uDfkVcm1tnQCz5gc/HSfzR6/A+Qsb03bUz0uDUa6n9mdaqGUgmsBZW+lClr
	E03113rkwo7aT29UGMeb4vd7hUixaScx7HPT3NcZq5JhJPvxa8xlR1k7DkX3Fpcg7XAYq3lZf5YAf
	ii3DtCSnP2j7dbHDqW/gDEshq2VMa0IrU3RA6Lp3YWepS+6hrQHs2pSKdb2fRmOpXTgTr4OArQHxG
	Nrhoijv1Xr+yY3TYYdLfiB5JylvZjyaMuk1ImEM00xssAFtQEz3gNRub0v+Ks8Pl9YDUr/auXK37x
	nPE5JSCFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V2v-0001I2-FB; Tue, 26 Jan 2021 20:34:41 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V25-0000wd-Po
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUUR4ospp3N1xLGLKNZx+Tvb3eAI12jMKqQ3pBUMuTs=;
 b=cI1L0ei7YH5wTRn+MLqxGPnx7bAxi1aRgzwRRu2Kc/amyRaUsBTKpShXt039wNZim5yNZx
 z2SJAPf4Peas+GuqZ2gsyvHEujtNMq+v/nAE756nrzGJOEawCjDNgu6u0mWqTh0CPOkTBt
 ui9mPap0Jxelq0EUHA08JwzYERYumdk=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BDBB8AFF9;
 Tue, 26 Jan 2021 20:33:45 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 12/35] monitor: add helpers for __attribute__((cleanup))
Date: Tue, 26 Jan 2021 21:33:01 +0100
Message-Id: <20210126203324.23610-13-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153350_017405_9E63164D 
X-CRM114-Status: GOOD (  12.45  )
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

__attribute__((cleanup)) is very helpful but ugly. Try to avoid
defining lots of cleanup functions with these macros.

Usage: to declare an auto-cleanup variable of type (some_type *),
write

CLEANUP_FUNC(some_type)

void some_func(void)
{
        CLEANUP(some_type, varname) = NULL;
	...
}

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 common.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common.h b/common.h
index 1c214a4..9386ec5 100644
--- a/common.h
+++ b/common.h
@@ -12,4 +12,16 @@
 #define __stringify_1(x...) #x
 #define __stringify(x...)  __stringify_1(x)
 
+#define CLEANUP_FUNC(type) \
+static void __cleanup_ ## type ##_p(type ** __p) \
+{						 \
+	if (*__p) {				 \
+		free(*__p);			 \
+		*__p = NULL;			 \
+	}					 \
+}
+
+#define CLEANUP(__t, __v) \
+	__t *__v __attribute__((cleanup(__cleanup_ ## __t ## _p)))
+
 #endif
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
