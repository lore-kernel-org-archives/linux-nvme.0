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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B82C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 09:54:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F8564E68
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 09:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F8564E68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2BWpgZGLl98DXc/aNwsqzJktCrgZWfaf79wWgwMwMj4=; b=fGX4nO7Fp9KQJ6ThIYJogwcias
	L9DClCFDw5or6KTHbBoQE57OVC8MOl8tgKyFEoEqg2FCdLb2WJT9GXoWPGFAtjeIMmc6fQBHWqcVA
	VhQFqiWItATlrFEWUJThXBBR2Mk2v4NBnIpvai8tbEaEbzy0DkmwQlgiLhUUtIvEkqCg60V70Vzp1
	PAtX4gbuFVajW31htbYZKxTNQE7zwXYkwvMVsW5UQV6OJ7iQYSFP8mhOsSRbn01jcPeI6aAwO/Q1N
	xKM/68/w0PsQRh4eKlma+nr2ehXrOAv7WjMrt205Whzq8wq8QF1ZBp/nLy2FqiGRAOY2MC5Jr0i1U
	ucmlt1Vg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCg1F-0008HB-CX; Thu, 18 Feb 2021 09:54:45 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCg1D-0008GG-3c
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 09:54:43 +0000
Received: by mail-pf1-x436.google.com with SMTP id j12so920335pfj.12
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 01:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SawbHnTbqrSgLTZJHoWvbEr25OWNcAhtISLozeZKGM4=;
 b=VodXYJqRc8YCh7VcFFKT/FHMPzyE11MzKfvIcpBZsWmJbk0UzsBBGPQ6MZcwNxF1oB
 86pPuZeWfA6JQXqAQGBg/P9g9ipbWM+nIIP41UU1KaFlZ43tFy73kR6tgexHfFzuRwD4
 mOD3za2KI/Jb9aA235olUGB0Dsk3aY3eyOCJPfMPfOxIDjM+Y2e8aQjCZ40hsWW3Od7d
 0otjHsayyGQPLDyESXvd5VyMq7CUVHMErDbXFu8OI2/YFGg7tsq+X5rPq8xUnEhdu98w
 yS0c/hVjY+U+R8a2Jm74sNHpPuo8fBdCn9php2UcxGclBXGVtNa4fbdhCD/4ScwSHEhR
 ppCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SawbHnTbqrSgLTZJHoWvbEr25OWNcAhtISLozeZKGM4=;
 b=qjO/uF14qziphlr9VwQwjSz/SOGBoTQFHGUxcZsZl84StisKaTwnORBeOjob+92hx8
 FBDkh4QBfMaBjbWZAsT+muExQxUNSYaBbVlyVD81BE+WyOtdxZ8QbzZUAMJN51BCQA2f
 YXzrGL5dHraBX7RkS5wwYzyGdkUUHP9HLE5cndosgXxxtko0cs+2qn8YAvuXAaA2Rbhn
 szzBkELrrrYOgdw2DlA4sDuqdFviWOvhtNoocH4djKMwnfcsEs7fHxrjzYS/HT3BwG2b
 4LYW9pwp0qwsv+gE0KshS0IOBOsHQCSGA2mn4/WWoBwVN4/NBP8lz3ULMDMOTYw+Jbuu
 Tukw==
X-Gm-Message-State: AOAM530CZiA63sfGIDSHy57DlzKtv0LttVv4DY3imHfHjiqYgm+QvE87
 mOoztB4igMzimcRbbz0a1XLvF6xHjHrmYg==
X-Google-Smtp-Source: ABdhPJxGNdjBZ060q0vALPUJxG8LYTb7KZiuz6sAiTLDmHZ3PlCtIA3tEvTR4e2l7p++V/exReU4rQ==
X-Received: by 2002:a62:7697:0:b029:1dd:fc37:9542 with SMTP id
 r145-20020a6276970000b02901ddfc379542mr3589028pfc.35.1613642080438; 
 Thu, 18 Feb 2021 01:54:40 -0800 (PST)
Received: from marting-pc.vpn.netapp.com ([202.3.121.4])
 by smtp.gmail.com with ESMTPSA id i15sm5414855pgh.47.2021.02.18.01.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Feb 2021 01:54:39 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] fabrics: ensure zero kato for non-persistent controllers
Date: Thu, 18 Feb 2021 15:24:22 +0530
Message-Id: <20210218095422.5696-1-marting@netapp.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_045443_209998_B48A28ED 
X-CRM114-Status: GOOD (  11.78  )
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

Along with ensuring a non-zero kato is passed to a
persistent discovery controller, also ensure a zero
kato is passed to a non-persistent discovery controller.

Signed-off-by: Martin George <marting@netapp.com>
---
 fabrics.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 1880a5d..ed15e08 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1399,6 +1399,8 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 
 		if (cfg.persistent && !cfg.keep_alive_tmo)
 			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
+		else if (!cfg.persistent && (cfg.keep_alive_tmo > 0))
+			cfg.keep_alive_tmo = 0;
 
 		if (traddr_is_hostname(&cfg)) {
 			ret = hostname2traddr(&cfg);
@@ -1474,6 +1476,8 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
 	} else {
 		if (cfg.persistent && !cfg.keep_alive_tmo)
 			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
+		else if (!cfg.persistent && (cfg.keep_alive_tmo > 0))
+			cfg.keep_alive_tmo = 0;
 
 		if (traddr_is_hostname(&cfg)) {
 			ret = hostname2traddr(&cfg);
-- 
2.30.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
