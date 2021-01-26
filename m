Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC4AC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943C4221FC
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943C4221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xOzldbCcLfsH1Kt3Fbfz0nvfBiIa8VQyEuPrfhQn0V4=; b=M45Jj0hT7vZDKjDI9v/u84isy
	gpxD0zt6Sze5eQZLqQjAIkm+0Xb7u/BZCovtcRn0MljVJFualDtfCX8KqHPGnkKb1OOriGbYAFACG
	7SnrIpSjKKjT/A+K7J8TCr98dkI6UV3H6D0nCdm/kt0HZPGeSoDAYfRVYWqkrISsuoOPrNpDBzVyL
	yBTMmvrt/4It+ajhPwA1GCKCKhCyWaPl8YsaonPR7sFbMdcQ/NOjIPPigYjk/Am/obapAbr3fjOl7
	TUkLydfvSehtpmXBMnqA6w98wqkGy18A42F6H5nmPUctwfHGrAnFUiMF9WvPzV/WjaVfaDyZp9aij
	lJhtDPFAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V3S-0001ZY-37; Tue, 26 Jan 2021 20:35:14 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V29-0000zD-JH
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:59 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+R4qK439ZE2zPetCKY5IAjiKBZpwOhlHqIUG6rpkCrc=;
 b=KLtKbJwiRb6vjlVtce3kFEGI1/Ru6BBxQc/1iSiJV9JEYKvpExLqOlxsRhiNd1403C+Moh
 /00SecoajIq9wMwc3Ma7L5aXUZP9gfs+2f+bvfuUqNhsIw084pOxwGC1zZQHxiuIFOvF8A
 S1tJ+2d1Z/XDc10zQ1W6XuIftwR7b6o=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 392F8B05E;
 Tue, 26 Jan 2021 20:33:48 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 20/35] fabrics: export arg_str(), parse_conn_arg(),
 and remove_ctrl()
Date: Tue, 26 Jan 2021 21:33:09 +0100
Message-Id: <20210126203324.23610-21-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153353_795977_CA1093BD 
X-CRM114-Status: GOOD (  14.55  )
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

These functions are used by the monitor functionality that will
be added in follow-up commits.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 6 +++---
 fabrics.h | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index e3d2a3a..e2629d5 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -102,7 +102,7 @@ static const match_table_t opt_tokens = {
 	{ OPT_ERR,		NULL		},
 };
 
-static const char *arg_str(const char * const *strings,
+const char *arg_str(const char * const *strings,
 		size_t array_size, size_t idx)
 {
 	if (idx < array_size && strings[idx])
@@ -208,7 +208,7 @@ int do_discover(char *argstr, bool connect);
  * If field found, return string containing field value. If field
  * not found, return an empty string.
  */
-static char *parse_conn_arg(char *conargs, const char delim, const char *field)
+char *parse_conn_arg(char *conargs, const char delim, const char *field)
 {
 	char *s, *e;
 	size_t cnt;
@@ -476,7 +476,7 @@ out:
 	return ret;
 }
 
-static int remove_ctrl(int instance)
+int remove_ctrl(int instance)
 {
 	char *sysfs_path;
 	int ret;
diff --git a/fabrics.h b/fabrics.h
index 1dfbd67..ddc7423 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -12,6 +12,8 @@ extern int fabrics_disconnect_all(const char *desc, int argc, char **argv);
 
 /* Symbols used by monitor.c */
 
+const char *arg_str(const char * const *strings, size_t array_size, size_t idx);
+
 struct config {
 	const char *nqn;
 	const char *transport;
@@ -44,5 +46,7 @@ extern struct config cfg;
 int build_options(char *argstr, int max_len, bool discover);
 int do_discover(char *argstr, bool connect);
 int ctrl_instance(const char *device);
+char *parse_conn_arg(char *conargs, const char delim, const char *field);
+int remove_ctrl(int instance);
 
 #endif
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
