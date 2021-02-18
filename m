Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E30FC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 10:06:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B7864E2F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B7864E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AXAk/j6ANTinJyFjR1rzRjLbKrZzWpc5lCRMfiVKRD4=; b=J3DvWDYTbu6LyJinQsDoJf3Tuv
	xyJMWGnTltBQj6aLTGS1QHh91LxIZmg+CWHLoLZtWzFYY5cnJPG4CO6ToLJLXgWQrXrIKWqqhDtxp
	7tBGuv53UI9x9srhpQuuAQsIPkRt3YWuRbWRvg7Q/zzIG5cHee2sWV0EcbXSMPr2HZjO0sSmWCaA6
	XaGQhvNjfsgUlUSfUZadTc0HWWD8jO+UnFX9m6IALtqxH3Ew6B7+07WOCmZd/lbc+kpRryq+oYFwh
	O/EdHmOsBXsMF1m+AuynI+YkBWkux37y9AXG5ShX4Ucc0/Qlv300z6Quf3du57aLXFbLalnJdIeKm
	8oUzufkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCgBf-0000tp-El; Thu, 18 Feb 2021 10:05:31 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCgBc-0000tE-US
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 10:05:29 +0000
Received: by mail-pl1-x631.google.com with SMTP id f8so981796plg.5
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 02:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NF1H+X4MbavZWO7G4g1OO/Ta8lEJnIAOgDL3P3tWqSU=;
 b=Op3eNMuoMT2kjM5DU9ITqOgbtVBjOCAvMJqf4dM95ELaNiqxhAwUDh7sKWbPyLLwVP
 NswEcJ/Tf3EPKooyQbDxxjqcecTactxrPet9uM4vhYB7JQJDAjcNOUnl6pLyrDTxY7Sd
 ZNpT805uqAuXpsiQh7HCAZse1vT7wusyndlOnCjztj1JlgazeOC1bPCbP8+lNcRkTDRr
 arFWNAb63/CDK8b1/CRWPnEy94BxQ5oKdAhytJajVrig68Mpnmkx6ZbK09y2FeID5Jpa
 mA+q1ERzAvDi8QOaFrI9eS0tHlDjtCM+sGiPFRf3GKF4351B+N+xi2Fnc49ErpeO/dhK
 zRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NF1H+X4MbavZWO7G4g1OO/Ta8lEJnIAOgDL3P3tWqSU=;
 b=AWsJ8fH9/XPae2s6cOncF3ykkQvLL11T8Jr9ee4lWMwmzLwprObRXQmageHR5NeAnf
 QPwDJlCq3su9iJsI4SnR/JlhMrpMFHIQ0A5Pd8AP3HmoGCApfvyzNM2B28Xy5JHV8m8P
 NcsRUxSSVCuv+p70ToBegaueKPFCA9wdEqe21MSyZWoeFSnzCWCrGPJ/on8BJD5UXrOT
 aDuiBLqUOlHUMYT/M330/HgyTJhkwFVm9898TTlh/BMo/bbFklOAmMY1R6x0lb9sdfhr
 DP6aGboagn0jOmMon8g5sFvckj9J7U+bVowPv/5lBLlf+2aDMgjui5Cp7HT2TvOM1BTb
 +1Kw==
X-Gm-Message-State: AOAM533n4iAcFAKwXV2BSaHAldXT8LLRilOmOC1y0BpO94Zm896aqnj/
 kaKW/neCPjGjnNs+TfWeWUAeuAoSU4WcCQ==
X-Google-Smtp-Source: ABdhPJylBJyWf+NzzaEn7MH1hHVAid1cB78t/y2v1voLAWXawkST7RHJyg4PnkqY6Xtq2SjnNxBE1Q==
X-Received: by 2002:a17:902:b10b:b029:e3:103c:4c47 with SMTP id
 q11-20020a170902b10bb02900e3103c4c47mr3490546plr.8.1613642726864; 
 Thu, 18 Feb 2021 02:05:26 -0800 (PST)
Received: from marting-pc.vpn.netapp.com ([202.3.121.4])
 by smtp.gmail.com with ESMTPSA id oa10sm4885311pjb.45.2021.02.18.02.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Feb 2021 02:05:26 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fabrics: fix kato initialization
Date: Thu, 18 Feb 2021 15:34:43 +0530
Message-Id: <20210218100443.5854-1-marting@netapp.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_050529_038408_FE46BD07 
X-CRM114-Status: GOOD (  13.56  )
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
Cc: Martin George <marting@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently kato is initialized to NVME_DEFAULT_KATO for both
discovery & i/o controllers. This is a problem specifically
for non-persistent discovery controllers since it always ends
up with a non-zero kato value. Fix this by initializing kato
to zero instead, and ensuring various controllers are assigned
appropriate kato values as follows:

non-persistent controllers  - kato set to zero
persistent controllers      - kato set to NVMF_DEV_DISC_TMO
                              (or any positive int via nvme-cli)
i/o controllers             - kato set to NVME_DEFAULT_KATO
                              (or any positive int via nvme-cli)

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/fabrics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5dfd806fc2d2..604ab0e5a2ad 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -630,7 +630,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
 	opts->nr_io_queues = num_online_cpus();
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
-	opts->kato = NVME_DEFAULT_KATO;
+	opts->kato = 0;
 	opts->duplicate_connect = false;
 	opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
 	opts->hdr_digest = false;
@@ -893,6 +893,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		opts->nr_write_queues = 0;
 		opts->nr_poll_queues = 0;
 		opts->duplicate_connect = true;
+	} else {
+		if (!opts->kato)
+			opts->kato = NVME_DEFAULT_KATO;
 	}
 	if (ctrl_loss_tmo < 0) {
 		opts->max_reconnects = -1;
-- 
2.30.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
