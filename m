Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90969C04A94
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UqHXroF0EJl+GQpEdHdxmBrPdAQdE5qHCwe+sk9yKxY=; b=XNOqt51erp3iUBhxhChjjW3Qnz
	ks5/fUtRnTF/O0/andU0xGFaZCaNg7wxG3gIvLUvnvKDW+mQriixJJ719f2s8Is2zw3lawN7WVSCu
	oNikBBrf24Lr4hp/3Ntp2gtUkQzasRg+QN4wTGmNGVjMKQ0VCy7DkqcZXU6wH8ywE3QqwfqeNRgtS
	ZL2pVbtxP35UWNOyGCCq2Gpiop1yU1esUtdeIPjOF9evRj1750+IgSdlY34mHea8TQcHuCXuEhAph
	0acQ9bTsO/8fmknDZo5mxSaGL5OimVBz0u/cDmVgfoTQ0P41T6AkIDo6AOXV9nzSwo17QrKFTEtl3
	lWzC+tbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIor-0027KK-2q;
	Tue, 08 Aug 2023 09:16:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIoo-0027IR-0b
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 09:16:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33CFF2247B;
	Tue,  8 Aug 2023 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691486155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqHXroF0EJl+GQpEdHdxmBrPdAQdE5qHCwe+sk9yKxY=;
	b=snqUzZ/B6zgsf/a2M2yhOjHmsHNeE9mHSaQedd9HVD8zCfvICExE8fF8i2wK6Mxfya9hLZ
	2/YPrWwNzvAADwz9fiEJCcm5eGVH4DwVehewaNCgTRA4QOA24R82BZ5h8KzZzAsfuMyASc
	7NNIIhFghv9O3Yq9DX7O1mnhEB4tgtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691486155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqHXroF0EJl+GQpEdHdxmBrPdAQdE5qHCwe+sk9yKxY=;
	b=A2nzBfaKm1XJcZKFQiPgvBxqO4IyAZZq1GHglpbsmBy2zo0jaP1RAVWN0z6khC9NMN40dY
	wK+XojC5yp1xewAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 256AB13451;
	Tue,  8 Aug 2023 09:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pT4SCcsH0mRCEwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 09:15:55 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Caleb Sander <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v3 1/2] fabrics: Read the supported options lazy
Date: Tue,  8 Aug 2023 11:15:49 +0200
Message-ID: <20230808091550.25349-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808091550.25349-1-dwagner@suse.de>
References: <20230808091550.25349-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_021558_383377_460C9CD7 
X-CRM114-Status: GOOD (  11.88  )
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

From: Sagi Grimberg <sagi@grimberg.me>

Read the options in when we need the for the first time.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
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


