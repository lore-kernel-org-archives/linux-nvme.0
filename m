Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAA2C61DC6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URWLRJR30vRoaJ6t+h0dcOE0A9/rLwIDzZpxZ507naE=; b=jN8HyYhbx77K9XpbU4jA4BfyCY
	t6KWi7Yvm98Pok0cW6sy9ZFR4nDC4J9Y9DkNhtXcJLYfdSKj03MAl4speJN1ZCtO4j6Ca+9zsXPHe
	ZJD3YDsdNSCAKfqBX986U9dz+6qymhldoaWs3b049qhh/kGoIHP4qUWmm4NjpqTM2BPoSt9Wubcvz
	thcYcAWxoLTNw+qGgTXtaEHW1O53mK9Xq5DCALpwCVlFi+XBWDg7Bhdf2t2G3b26Ra6XU4ZHv+Suw
	NpQJqPuV+90IWUdZYU1Zm8OPTGKziS7soS23NxK2i7sWGIz4Sz8oYiPh1Pxsl3y+v/EOLHTr2oXtg
	o68gVioA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzZn4-000000041QM-21tr;
	Thu, 27 Aug 2026 13:05:10 +0000
Received: from smtpbgbr1.qq.com ([54.207.19.206])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzZn0-000000041KW-1NCV
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 13:05:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787835866;
	bh=URWLRJR30vRoaJ6t+h0dcOE0A9/rLwIDzZpxZ507naE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nM2qiGk3aXrMOvgTwfPEBoAhbyijwvPSJ7PCNlf89cBQJWjG8SdidCHP2jIlhdvoz
	 FTLxHPZfReSZhpx3cScaC5VnWOD7ylm5shf2IU+0JOHTWgMYD80+9Ht/01LfjyTQ0M
	 m6qiklYIQIQW+Oi+8/gZjJjVB8H7pNY+ONM4y7f8=
X-QQ-mid: esmtpsz20t1787835851tb572156c
X-QQ-Originating-IP: mTHK8769jpSroKAKN3aeJtIDyenvTb4Gn5q3LoxzuE4=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 21:04:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14667445658277018892
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 v2 4/4] nvme-fabrics: add helper for DH-CHAP secret options
Date: Thu, 27 Aug 2026 21:04:07 +0800
Message-ID: <A234F50F1018A58C+20260827130407.1391174-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
References: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MRQq5cyInCgJdQv6dhbTMzU35xbCAj5GKngjDeu1Tf1gBwdn13C0fmdC
	uA8nps4psrwr84xl4NH5VzwOTM13UT7YzpQo20j9GYVjyLMPCEMiPUhqX67EL/Tr7ESicGQ
	OvhQRWpeDk4x7HQ4LpdAack2deZ4SH6gyxEjP6Nme015njkgwDk/P+4Bd+GLYg2OTbkftwF
	C8baW5suo7fXmq8TsQCiVMrb/8KJWAX4UhW4eR3dLRGXbI0q/34f9kDBH74/QAzrBrC2LAs
	A+Jze70re/NFUpSE3cL3avszEb05P9zn6tsxy6Kv9ZQ6T07vFiVeI0R4ARO5Pj6uZA40G7u
	QljX9uEwPwC1QH8KK+BTy/Lp6NZLDzqVTzDsENG01gJini3Mr4UUou/0VBfkfMbYTF7Evj0
	gisWhFlaxTEwkMwVhZie8sUlNzQlx3cCRVgLhLfIqwBXaSAwegNtZzk1QF4ExD4xbc8893Q
	X1oDgzB07eB3DlvC5hgbJJyzZP+KKADUNl0yy9TOVcDqQB1d73wSNUyEENcC/4/KkIieUcE
	KvUs6hKDt/7aPRCmbyHeoA8Yae8qjzG5pifJp5hLB8mXfzK4veaLXSGKuw/edyGXaX0cUY6
	kACR74Y1iyBtv8LlNsfx9Un8Cefe+aFiznz7Zrj+RO9gO9px7zkx1G0u6Vk2HaLEYnb3OXZ
	GEqYsPpPokKo4dP6B9E4AH8lodOB4hITozEOVk+8Asw4KEYj87TGmjhYSjTmJb5FM0A1xvJ
	XkmOCoOEZZrL0np9stTYF+N5majatthpFAthXaTg+SWQvmcSIU+RkSHegBBGioPi/3Iu5KY
	Tp/ZXYp++EztX+PhzIWFZsFioHnKYFykooOaUIJfBaZCG3Mclb2Eiw0TnrR+EovbsEC+HcH
	S61F1/VNw7bgVBhWVQZkrZaZLf+DsjVRHj8SWemar1DFDDSRSG99neGiQmqKdHLLocWFRG+
	QYFzx6uXHPVgsnMGiHtzJj9kdlvX8sG0arr/tCNhq87DBH16Xg+L6WxFs/UzOkLrfdmeGT0
	TuBJ745AHUdSU4zs+tRVfTuubR7KXadrsOXtWaO3MrFJ4yjE0j1U0wNLbF6QsTk6pJogfrn
	A==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_060507_228302_48E3F461 
X-CRM114-Status: GOOD (  12.52  )
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

From: Xu Rao <raoxu@uniontech.com>

The dhchap_secret and dhchap_ctrl_secret options have a distinct string
lifetime because their values are authentication material.  The temporary
string must be checked for the DHHC-1 representation and discarded with
kfree_sensitive() when validation fails before ownership is transferred.

Add nvmf_parse_dhchap_secret() to keep match_strdup(), DHHC-1 validation,
failure cleanup, replacement of the old value and successful ownership
transfer in one scope.  Both secret options use the same helper because
their parsing and ownership rules are identical.

Keep the existing replacement semantics for an already stored valid secret;
this patch only moves the parsing and temporary allocation lifetime into
the helper.

No functional change is intended.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 48 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 24385e777307..dc8883d85f45 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -725,6 +725,25 @@ static int nvmf_parse_string_option(substring_t *args, char **dst)
 	return 0;
 }
 
+static int nvmf_parse_dhchap_secret(substring_t *args, char **secret)
+{
+	char *value;
+
+	value = match_strdup(args);
+	if (!value)
+		return -ENOMEM;
+
+	if (strlen(value) < 11 || strncmp(value, "DHHC-1:", 7)) {
+		pr_err("Invalid DH-CHAP secret %s\n", value);
+		kfree_sensitive(value);
+		return -EINVAL;
+	}
+
+	kfree(*secret);
+	*secret = value;
+	return 0;
+}
+
 static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		const char *buf)
 {
@@ -1010,34 +1029,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->discovery_nqn = true;
 			break;
 		case NVMF_OPT_DHCHAP_SECRET:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
-				pr_err("Invalid DH-CHAP secret %s\n", p);
-				kfree_sensitive(p);
-				ret = -EINVAL;
+			ret = nvmf_parse_dhchap_secret(args, &opts->dhchap_secret);
+			if (ret)
 				goto out;
-			}
-			kfree(opts->dhchap_secret);
-			opts->dhchap_secret = p;
 			break;
 		case NVMF_OPT_DHCHAP_CTRL_SECRET:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
-				pr_err("Invalid DH-CHAP secret %s\n", p);
-				kfree_sensitive(p);
-				ret = -EINVAL;
+			ret = nvmf_parse_dhchap_secret(args,
+						       &opts->dhchap_ctrl_secret);
+			if (ret)
 				goto out;
-			}
-			kfree(opts->dhchap_ctrl_secret);
-			opts->dhchap_ctrl_secret = p;
 			break;
 		case NVMF_OPT_TLS:
 			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
-- 
2.50.1


