Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392CBC53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=tpxA2Ucu2odQEZ5IBpR+pezMJ28DKKi3bdV2sXXQRDw=; b=Ii/8z6P2H8h2Njb336atTQ2HF8
	AxesmYv8X6egOaqP3ZiP45Tvq8r3hVZXfLdQTqqSQFvxkUSlI1zlR6WWsmDnIEs5506qNIk//XgqM
	pzq0dyUE2ME6K6yR5QtX598An6AkBJnKht19jNXxBa51tQLM7DO9jiJx7SW2Zq+vZstOuv/qwtkkf
	7+5eTOc9HhbIuCj73Nw60Dc+9lznMDDHsaGKNX5Q023/ZpIBGCltOV+1tOhGo8mWTuIxeid5fubUM
	6/sTBXBVYnzFO2JXAkGOqsQWcJS9ARUB45qPiV5sWztIGIY4cNN1FRN6Ue7Aa+pyym6Pr3+edi9hb
	enYr2buA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp0Lp-00000007Khv-0HzW;
	Wed, 29 Jul 2026 09:13:21 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp0Lh-00000007Keb-44HO
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 09:13:19 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260729091305epoutp01c8b2b04ae41b788e2ce71d547a1b6386~Gt8tGfNLY3035530355epoutp01-
	for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 09:13:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260729091305epoutp01c8b2b04ae41b788e2ce71d547a1b6386~Gt8tGfNLY3035530355epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785316386;
	bh=tpxA2Ucu2odQEZ5IBpR+pezMJ28DKKi3bdV2sXXQRDw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=S7xFH1jb2bk6BPnMlDmKx9itYEgA9B2+EU0vwNb0Enw5MhjoPYSRQg5sLrzPQMcYX
	 hglgfOdhS4jO4ZN+BlZK7YbNus0SNSlKLJG3PtzdguM516txKe61TG4Eg0cxyYREIJ
	 OLOM6B6+mE4D2zK9+5SSBMJE5EOanyv+ly1P7Gig=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260729091305epcas5p2c62fe7a6251b4754facedefa77dab8a6~Gt8s0dH6n0606706067epcas5p2-;
	Wed, 29 Jul 2026 09:13:05 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4h967N6wzMz6B9m4; Wed, 29 Jul
	2026 09:13:04 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260729091304epcas5p424e64983ec4c173930dfa1a4c76e791f~Gt8rvX_GC1407914079epcas5p4F;
	Wed, 29 Jul 2026 09:13:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260729091304epsmtip2e179884d0756dd5601d8d855965a2c31~Gt8rVNq3O1895618956epsmtip2H;
	Wed, 29 Jul 2026 09:13:03 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: linux-nvme@lists.infradead.org
Cc: Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH] plugin/lm: avoid closing migration-send input twice
Date: Wed, 29 Jul 2026 14:42:41 +0530
Message-Id: <20260729091241.142355-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260729091304epcas5p424e64983ec4c173930dfa1a4c76e791f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260729091304epcas5p424e64983ec4c173930dfa1a4c76e791f
References: <CGME20260729091304epcas5p424e64983ec4c173930dfa1a4c76e791f@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_021315_300702_4C58E6F4 
X-CRM114-Status: GOOD (  14.43  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

lm_migration_send() declares the input stream with __cleanup_file, which
closes the stream automatically when the function returns. The function
also calls fclose() explicitly after fread() without clearing the
pointer.

The cleanup handler consequently closes the same stream again, causing
glibc to abort with:

    free(): double free detected in tcache 2

Remove the explicit fclose() and let __cleanup_file close the stream.

Fixes: 6d2a869dd054 ("plugin/lm: Introduce Live Migration plugin")

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 plugins/lm/lm-nvme.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/plugins/lm/lm-nvme.c b/plugins/lm/lm-nvme.c
index ed6fb7505..7b70a47cb 100644
--- a/plugins/lm/lm-nvme.c
+++ b/plugins/lm/lm-nvme.c
@@ -364,8 +364,6 @@ static int lm_migration_send(int argc, char **argv, struct command *acmd, struct
 
 		size_t n_data = fread(data, 1, cfg.numd << 2, file);
 
-		fclose(file);
-
 		if (n_data != (size_t)(cfg.numd << 2)) {
 			nvme_show_error("failed to read controller state data %s", libnvme_strerror(errno));
 			return -errno;
-- 
2.25.1


