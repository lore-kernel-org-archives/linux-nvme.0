Return-Path: <SRS0=mUlG=GL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B3DC433E6
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 23:42:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B29C20786
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 23:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B29C20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nW/9Je1yKVt1FWJG7yhhKFU68K7QhKImpy9PkhoW2So=; b=uDOjrFNdBf1dyXW+8pfhDdBilE
	A1Y4SUg5Ajy4atFtZBDwv4Fd1g5ylW9srbSIzVyk4nfLbSdaj2gdEEy39n4gSf93uDQA/q7JHPGFy
	rH4N/ferzsSXG+MRSynq1pEOfMQsvFsRXgnrBIKiMZakXc7B71QKdEvoOyxPlM3sULomUzelutxKD
	qag/oLyGM+vrghi6khxUnlxIxmra13PhwAErimxzsIyrKtax1CRFkD5crsxJOP7leYUNKgD/boeYN
	jLSx114jS5cs2UiyXorDQ22ZFwK2iu4l+ToU+1VKky/2WCkMhovLi/U7kMv1tnope0hQxyfKhpu+3
	rJqBjg+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ky1P1-0008Qv-BH; Fri, 08 Jan 2021 23:42:43 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ky1OZ-0008QJ-W1
 for linux-nvme@lists.infradead.org; Fri, 08 Jan 2021 23:42:16 +0000
Received: by mail-lf1-x12b.google.com with SMTP id s26so26895829lfc.8
 for <linux-nvme@lists.infradead.org>; Fri, 08 Jan 2021 15:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eyZz1hqJLMdSGm3NpdXWHq0YcTuVoZkMZNwD2LVgx7M=;
 b=Cecy+RexopWWjUY6s1vtGztmGLgfATcKCPFIG5mLLUv+I0kcdPIafkf+eLttj2ZIxy
 Khquk0RpkdgnuRYxOWzXUl3zGO/Vb/avK515O96DDSVhBE2t5yCG6NJmjTXUMdQUQXLe
 S6zmGieztjARWPaOEnKJPhh3VwOMut7KEydHimLebpuMg4x3cPxTRuM44g5pu/hJQv/G
 pYzdmDpBObtKrmVgmP03+H+ILbPlB6Z0kgUqTxyoxMG10T4+nuJ+XIQZX8WEEQV+oLbM
 Pu4TBcRnx8bVWM5OQmI7vPBDIlozJfydd8bswRhgF4fZF/J+WFJHIa+rInz3TQIKP/G3
 YhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eyZz1hqJLMdSGm3NpdXWHq0YcTuVoZkMZNwD2LVgx7M=;
 b=RpVHvjSEDO3OomuCTWGSOh228whaLiNrYNSuYe32BUXwti0/hUUrM5v500NjH0XMWp
 SMdfUvlhOP9Tf+nz6j3GKYOZo1vm21KbcGYuYDYIAql9nrozYEPZR7Q/Gg5ELtTNJCsL
 mdubYQkwY4vdGAWQGdF0rE/5+c3s2j/xqz2tggc0CmIHdvRrBWWIr9vFBLXbarh5AZLJ
 MYMIgd7iMUwFV6pnSkGPu9FlAI5picdI+87F3ISkrS7riDGGU7MBaojtSsB762JsvCC1
 79gN+a1NObETAJLSU2lsu39W4ob+DWcLi0rj7c6mlzoeBmv3xyceT2jTlj8xEargS4lh
 Fj0w==
X-Gm-Message-State: AOAM532mhIfhlJtgUqu1/VPHOmMcA9N0ZdAvfTIN38oE9dntnr65SzFL
 jJ9NmRragQ6Xby55eacEh84=
X-Google-Smtp-Source: ABdhPJwd+anPUdoUfNYPTizWNLk8ABzTMWpv1UNiwTvX+WFB2qYHtLJ4Jz4c8RrOhmzHp0MfS0CcLA==
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr2358170ljj.465.1610149332168; 
 Fri, 08 Jan 2021 15:42:12 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-148.NA.cust.bahnhof.se.
 [98.128.228.148])
 by smtp.gmail.com with ESMTPSA id r8sm2304907ljd.140.2021.01.08.15.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 15:42:11 -0800 (PST)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvme: Constify static attribute_group structs
Date: Sat,  9 Jan 2021 00:41:47 +0100
Message-Id: <20210108234147.42151-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_184216_044443_94DC477E 
X-CRM114-Status: GOOD (  13.81  )
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
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The only usage of these is to put their addresses in arrays of pointers
to const attribute_groups. Make them const to allow the compiler to put
them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/nvme/host/core.c     | 4 ++--
 drivers/nvme/host/fc.c       | 2 +-
 drivers/nvme/target/fcloop.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b61519441..fc3743de53be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2849,7 +2849,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group nvme_subsys_attrs_group = {
+static const struct attribute_group nvme_subsys_attrs_group = {
 	.attrs = nvme_subsys_attrs,
 };
 
@@ -3679,7 +3679,7 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static struct attribute_group nvme_dev_attrs_group = {
+static const struct attribute_group nvme_dev_attrs_group = {
 	.attrs		= nvme_dev_attrs,
 	.is_visible	= nvme_dev_attrs_are_visible,
 };
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 38373a0e86ef..5d3976116558 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3776,7 +3776,7 @@ static struct attribute *nvme_fc_attrs[] = {
 	NULL
 };
 
-static struct attribute_group nvme_fc_attr_group = {
+static const struct attribute_group nvme_fc_attr_group = {
 	.attrs = nvme_fc_attrs,
 };
 
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 733d9363900e..9a0bd9af3f9a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1544,7 +1544,7 @@ static struct attribute *fcloop_dev_attrs[] = {
 	NULL
 };
 
-static struct attribute_group fclopp_dev_attrs_group = {
+static const struct attribute_group fclopp_dev_attrs_group = {
 	.attrs		= fcloop_dev_attrs,
 };
 
-- 
2.30.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
