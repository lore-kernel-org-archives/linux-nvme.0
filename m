Return-Path: <SRS0=LlAf=2K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE229C43603
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2019 03:31:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C45824680
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2019 03:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qqVJbrSc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7yZ9sYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C45824680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+gDEoRVvN3uikEkLnJuCJ7zpAb7nLv8yg6wn7xunwyY=; b=qqVJbrSco0lkoT
	t+a+D8ATJqj8hM5ugROt9DsvL/lP23WuisAt8AoYOT4tkNy1/io8G5ti2pIhzbU3lagIWPIKv+iH4
	1UFquscpIN4cL7HdFouHGv1hVO+0lm+PLDwT7RWx76VBEYTiTw6FkMbKzI0rP+spRUHsNNt3J/QUl
	80fs33mU7c2qyixPXzzSTOVdv2E24RjE5lXOfZHuFVyrulQCtawGEXwhNhmHMoD2el55clk12x2tn
	vcZ6xItqgIIXIiTvvI8G3iqaK5PLhaAf1cmkVmJhjOSzCtbBlI49vbYRUy/t+JS8TM3Exb1+H/zW0
	dnyfg6wUP5eFFvd+C+Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ii90p-0006ey-Pw; Fri, 20 Dec 2019 03:31:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ii90W-0006It-Ml
 for linux-nvme@lists.infradead.org; Fri, 20 Dec 2019 03:31:18 +0000
Received: from localhost (36-236-5-169.dynamic-ip.hinet.net [36.236.5.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7B1B424680;
 Fri, 20 Dec 2019 03:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576812676;
 bh=VKjqSfzYJMI8JQSukhF0YE/191RZUx7HfH2xgBZhUfQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E7yZ9sYKaywobVEXGU/S90ffkk/Zq6QLeYJhyivRtePD8FP9bAehqB91bctTdgF//
 u5DoXXIvQ8US4RI2nwUmGXYmRrBfv9/a+zKnXmYXakW2MB0Kq0DZ1d1vOegoA6kRRA
 OPRzfZ2in4Qm7ZOvxwzRkJBLs2IReILrHt8SJMFg=
From: Andy Lutomirski <luto@kernel.org>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] hostnqn: Fix the systemd-based NQN namespace to comply
 with the spec
Date: Thu, 19 Dec 2019 19:31:02 -0800
Message-Id: <c4224eee27e76b803238048a54e6a27f8cd367b6.1576726427.git.luto@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1576726427.git.luto@kernel.org>
References: <cover.1576726427.git.luto@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191219_193116_802700_31FFA727 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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
Cc: Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The NVME Base spec, section 7.9 explicitly states that
nqn.2014-08.org.nvmexpress:uuid: uses an RFC 4122 UUID, but we
weren't generating one.  We could change it by actually generating a
compliant UUID, but we can also just invent a new naming authority.
Use "nqn.2019-10.us.luto:sd_id128_app:"

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 fabrics.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 655bd36c5639..12be2e73986e 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -691,7 +691,12 @@ static char *hostnqn_generate_systemd(void)
 	if (sd_id128_get_machine_app_specific(NVME_HOSTNQN_ID, &id) < 0)
 		return NULL;
 
-	if (asprintf(&ret, "nqn.2014-08.org.nvmexpress:uuid:" SD_ID128_FORMAT_STR "\n", SD_ID128_FORMAT_VAL(id)) == -1)
+	/*
+	 * "nqn.2019-10.us.luto:sd_id128_app:" is hereby defined as an SD_ID128
+	 * app-specific machine ID as generated here.
+	 */
+
+	if (asprintf(&ret, "nqn.2019-10.us.luto:sd_id128_app:" SD_ID128_FORMAT_STR "\n", SD_ID128_FORMAT_VAL(id)) == -1)
 		ret = NULL;
 
 	return ret;
-- 
2.23.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
