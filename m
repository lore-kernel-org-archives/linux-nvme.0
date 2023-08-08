Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBF8C04A6A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v040X3bbG8rwj8miJhJh2+3eKSy6UH/JXHnLAefyE1w=; b=dg8VjdOmj3aC+o6Fn4sFe8UyDU
	DRusCjDj3nn2jqJY+MNFxvc0PVJ0YIzCnkUAyQxmIg2p7D9Zg8WWN0NHyUzge0cGKc8dh9HT544j4
	P2rRAOyhFLzRy35Uf6qqg+bXAhV6hrOH3c7XTdLRMvev1KcYTHpbZgEIHTHm9SriKYASNWA8RoDk8
	RIVpBxOn+Cm8RgwPoXck8QrLCr+79PTPTUWQU4OUJdaL7n9k3EN1O5NR9erUYpQPM1W2KE89UOzxN
	DsjPQ8GShDwemkAQGNUriwaZHkKWQdrEJJZ07Dzqx9q3B0Mz13RPHFyj20EfiBXPiwP+NGWKMFTdG
	xKAfciFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTMnJ-002eCc-2G;
	Tue, 08 Aug 2023 13:30:41 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTMnF-002eBM-2G
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 13:30:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0640D22375;
	Tue,  8 Aug 2023 13:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691501435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v040X3bbG8rwj8miJhJh2+3eKSy6UH/JXHnLAefyE1w=;
	b=gv9pHSQWayWzaJgCKUrXyX85apFrocM7J45d+CslC1yLrsTgyF+UKQXtRiIyin5teN23Dx
	wkGxcFYp71gzrzaI4mnMqfT2tg/4GXAjsxXtouR/QtITP1lr0S5dBoIiIaJr6OcVNaBQfP
	tE45M41vBE4R6aegkvLcY0mBH2e+5dM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691501435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v040X3bbG8rwj8miJhJh2+3eKSy6UH/JXHnLAefyE1w=;
	b=q/wpHwQ+08uLozIzg8sho1m28fHEJitFZXm8AyXNj7AB4iXA5ksQrmoTqNxVbY2LJ6Ee/3
	zwDbYVsLmhqH3QDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECCB3139D1;
	Tue,  8 Aug 2023 13:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yS20OXpD0mSsGAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 13:30:34 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v4 1/2] fabrics: Read the supported options lazy
Date: Tue,  8 Aug 2023 15:30:27 +0200
Message-ID: <20230808133028.14643-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808133028.14643-1-dwagner@suse.de>
References: <20230808133028.14643-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_063037_889951_7846E7A8 
X-CRM114-Status: GOOD (  11.92  )
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

Read the options in when we need the for the first time.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/nvme/fabrics.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 800293e2a8e7..9725eeb3cda8 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -357,10 +357,18 @@ static int __add_argument(char **argstr, const char *tok, const char *arg)
 	return 0;
 }
 
+static int __nvmf_supported_options(nvme_root_t r);
+#define nvmf_check_option(r, tok)					\
+({									\
+	if (!(r)->options)						\
+		__nvmf_supported_options(r);				\
+	(r)->options->tok;						\
+})
+
 #define add_bool_argument(o, argstr, tok, arg)				\
 ({									\
 	int ret;							\
-	if (r->options->tok) {						\
+	if (nvmf_check_option(r, tok)) {				\
 		ret = __add_bool_argument(argstr,			\
 					  stringify(tok),		\
 					  arg);				\
@@ -376,7 +384,7 @@ static int __add_argument(char **argstr, const char *tok, const char *arg)
 #define add_int_argument(o, argstr, tok, arg, allow_zero) \
 ({									\
 	int ret;							\
-	if (r->options->tok) {						\
+	if (nvmf_check_option(r, tok)) {				\
 		ret = __add_int_argument(argstr,			\
 					stringify(tok),			\
 					arg,				\
@@ -393,7 +401,7 @@ static int __add_argument(char **argstr, const char *tok, const char *arg)
 #define add_int_or_minus_one_argument(o, argstr, tok, arg)		\
 ({									\
 	int ret;							\
-	if (r->options->tok) {						\
+	if (nvmf_check_option(r, tok)) {				\
 		ret = __add_int_or_minus_one_argument(argstr,		\
 						     stringify(tok),	\
 						     arg);		\
@@ -409,7 +417,7 @@ static int __add_argument(char **argstr, const char *tok, const char *arg)
 #define add_argument(r, argstr, tok, arg)				\
 ({									\
 	int ret;							\
-	if (r->options->tok) {						\
+	if (nvmf_check_option(r, tok)) {				\
 		ret = __add_argument(argstr,				\
 				     stringify(tok),			\
 				     arg);				\
@@ -913,9 +921,6 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
 		free(traddr);
 	}
 
-	ret = __nvmf_supported_options(h->r);
-	if (ret)
-		return ret;
 	ret = build_options(h, c, &argstr);
 	if (ret)
 		return ret;
-- 
2.41.0


