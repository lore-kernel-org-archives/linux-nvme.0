Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3179BC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 12:00:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD68961994
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 12:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD68961994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WzyPQzBr554bOTq4GWCxapRlnmtIf3PyFnnGTzT6iZU=; b=HzfRa73ulZDW7cIkWaejDFYIJ
	pZ08mO4t9NCk7GiAKN+Fbci0Ry8Tj3wT3Q/njIYXBhEEvv7FX10KYNz0BqruFMVqgn7HUhOGHlDlT
	rFdfDPz5Wlf7LkpFomCapsoTwHTSl+fJTdgiKEJAoW7DCUHVYc3qY+MTLW6fVRFx4LamCVWXMPHIx
	ewCPLxKclxlkUb3s4cPs+HK2sXod5J9vJfizoAcfMJaycqCFdB9LyGF6IiOEw3RWtw+r+8wh24lps
	mUVJ14xDVofASCD0VFdWmRKozueSd1D2cDr5DAFmT2AFeUWStDu7y33g6udDGly+j2+XG+TRL4qZM
	b0i4ucSWA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRD2M-003dZ4-N4; Tue, 30 Mar 2021 11:59:58 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRD28-003dXJ-7E
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 11:59:45 +0000
Received: by mail-pj1-x102c.google.com with SMTP id
 f2-20020a17090a4a82b02900c67bf8dc69so9347557pjh.1
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bHeHLDovc8l6wtjYQO0yONEkogTqNiKE9cLdGCZyG3I=;
 b=qD/btFcWMmPYKH3iYtCtZPNnMjqwmg5dXIaLG1XjZM3KilY8OB31DCy82cF11LCdiQ
 qfo0KQBxLf8JkhHgdfREuoI7xNCf7PWScVFS5OK/dBLjVN8O0G2M28BWtAhma3vAptJ5
 abDfI86NdFkLRJMmwh1Bvxe2/CR1p/azjWmlhCcuV/x4O53ni83pf+G0nSCdMjTLDkhT
 iczJ2MY93NdmrpjUJ5zbobNC/2ewkTmYUjmltQhPOLs/ixPUFwCJikIOHuNw9uVfjy2d
 Yi5+lbsXkQwoYfDIDB/ValdZ0U6dFoEfvSOVtnzQ1dz7caR9Dzbu4WNGsKVlMhHqwBAD
 GRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bHeHLDovc8l6wtjYQO0yONEkogTqNiKE9cLdGCZyG3I=;
 b=NlzI2f9zpJS/Emr3aTxYAprkfQRzQdcBnT/9gB/6poVvy5FFJQoP77+1FOP7FU70eU
 lclUUaMgBmLSk8gJlKBIGPauuiKqQe4iN5foQSsQArsplGcErKjLMixTIat6MV5TDXB+
 8XEKuReZmou5N0OhnMAn3mUrfAcLOAM/UUTJvUIINkQ7EbPyVOk9Dj6Dbjs43lRUaKaZ
 cJvbhVzTHWsVCC4joJSwSo+DjOvaJ/xee9b00O0D65JO+Q5hK0VWDJuvOzM/i8MKR6y4
 H+KwEMlRFelZ4ISXb8pCwj2smt7ns8frdVpqXPizDjBzMBV9dShFY49Lv6IAQrjcObNu
 8dsg==
X-Gm-Message-State: AOAM533kV4NcNWa7Jrkn3a31zf7tvj0eOeuq0xNI390FOVE6Id16EHkL
 BxOlM/vqeVZEAeg4gRelSYQ=
X-Google-Smtp-Source: ABdhPJwThaQi9CxmFynupr6m2CBI+EqyEI37gVKpoE7AD3xrtrtdm87JqhhHfpO2NJv+QAuLOzkzPw==
X-Received: by 2002:a17:90a:c587:: with SMTP id
 l7mr3777265pjt.115.1617105583129; 
 Tue, 30 Mar 2021 04:59:43 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id a204sm20088284pfd.106.2021.03.30.04.59.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Mar 2021 04:59:42 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH 2/2] nvmet: remove unneeded code from nvmet_alloc_ctrl()
Date: Tue, 30 Mar 2021 19:59:07 +0800
Message-Id: <20210330115907.15432-3-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210330115907.15432-1-houpu.main@gmail.com>
References: <20210330115907.15432-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_125944_376084_D17F5246 
X-CRM114-Status: UNSURE (   9.82  )
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

Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/target/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a027433b8be8..1c2130b344f2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1325,7 +1325,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out;
 	}
 
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	down_read(&nvmet_config_sem);
 	if (!nvmet_host_allowed(subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
