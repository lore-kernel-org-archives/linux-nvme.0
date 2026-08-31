Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910BFC624A5
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 07:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PcaU8lb3oJj5WuAfj6w4L5H3SWpj2dSt7KUf4MB3SiQ=; b=JoyQgdEp0vueWA+duOYUaOpjON
	gGOk7fsfTouU6Tr2UgBB3qd/mDQBQoAhUdDZjznOZKahcmbE1J7LlQB1gLHBqfYw/FXwQEYOyClkh
	hjJEHhDBB0F8Losb6v+0TtDZ4P+HEgKufE/l3Rb2qWXSLn0lt4VehKX/mRjjix1aXcnOITte+FkBE
	X9mVkYeZ17S6CFrJ2wmXhKrMlMSCkL3/xfaM2PY1jD4/h/PemDe/f9mHZBFv0+dun67dCIM/BtWZ+
	SQi32ZkjARICOe45P8XCwfWnZbFQyoAGt1kQR86Da2kFzFoLlAnyVI8VC7Fazq1zaK+xlMRnBior7
	2AG9QTnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wC3-00000008h80-03hA;
	Mon, 31 Aug 2026 07:12:35 +0000
Received: from smtpbgbr2.qq.com ([54.207.22.56])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wBz-00000008h1V-2zYU
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 07:12:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788160318;
	bh=PcaU8lb3oJj5WuAfj6w4L5H3SWpj2dSt7KUf4MB3SiQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Dj++rs6pzbvsQNmG3xWg5R3x+CDom0l6GJjuxPhmouw6yjTypRFgY4srETzHcuMa7
	 aYeOAmaOQRcULpj4Rd0feXbK5+JWh2VWCZNzoBVCA3CBCuOlALqrAaj+iMNM5SDtc7
	 am9akZR/ihaQZ1NzfrfgQr8AdhHLAc1wjJ62XslU=
X-QQ-mid: zesmtpgz6t1788160300t215cf119
X-QQ-Originating-IP: mimRkE15pwQbL131ohYG4c/XYUQeUbxmUBZI45Khlhc=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 31 Aug 2026 15:11:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9551787566103979334
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 v3 4/4] nvme-fabrics: add helper for DH-CHAP secret options
Date: Mon, 31 Aug 2026 15:11:36 +0800
Message-ID: <1E3563FE22B8A343+20260831071136.638787-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <B1A2864319EA3B6C+20260831070557.631487-1-raoxu@uniontech.com>
References: <B1A2864319EA3B6C+20260831070557.631487-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MTGYztYhR5ET5H/R20ph7EtmGyJY00Ph6krl3NhEgcygu5UtHbuul/V7
	W8s3nmH3zv/Oj2lqSsyDlk23t6lE3L70Q8UFgcUkmEvv/byMjRfenaB5JhumfVXDKI2tDec
	Cmn9eAySh823EpJguLwgnL88IrlwS7Meh/tE3DI+xATrAVeUQwTFk3uHDysz+pk+atWMMl0
	1079NYGnnhheUTnbH/X/nJg29NmiY9VVB9H/JNDBh5Fez6ZKLpP1JdFmhfjrHtnlOCJ0Bdv
	dqKlyq24afXthR6N0wf5oOtVNmnwuxsU0AB7fmzOAQb7YbUfPlJIJrwnFWtloQQWttUKsZd
	5JlDDnRbqMtj7vIKalh57AMUVQbfsV0jkkJ3+w921SZgh/xJL6Axud3YymyFEMuWJoLBsB7
	ANkHfUsGISbgvZPZpneIwTtMKbdabLxaVK8vz70nqXZFDFoWxYerdPFJtGFUJ9mXLlqsVND
	Ngk61vcZ4xcyuQN45RdGs4ci4/rBWHg9G/8R9OKEegPdwx7dHGrAsqL9C1hZArkjJr0TLJq
	kl5/gA0ew6xxELMLuWfa8R6PtvUA8yprO5C6qi6978n+0tTy+dalXjLaMHa3y2pCa238MSl
	pDr4mEQ517cVmYJ9bJeUobH9qJHwh1mwuHzLrYZXdw1LyD0DQPJWZeOIpFyhXBW9dKMcAvw
	9ly21nL58piximwsdxUBFd/ioXzXZ2lneqwe2MwqOi85g5HJqfGjhFlRtDEzAW4AAwCQ4f5
	h+8gqOpagdqnf7PSps1sSEYloirAXnly17XJEADZeoxeDdRpUPFk2BKsm+pkvU52mGf2Jy7
	EqdqIASy8f8a6bEqtBh7oAVynGOvjNInCyiAXUM1VA6CO7OeoXRf49d4c3w0acF3vANgaGr
	gr9O/WQzZiVP65sbVkKhrz3I433bgBtDre5oDb6ccC2/bRXuVpT+49WSlq+n8Gnk+QZLK3B
	HdO1hVdMHxIG6fKAHAOSfYjDkddXecDosNQcYvub3Mc0ityCMRfnuHftM0zIPcOWzekoE73
	fIzHDmbjJlxQPn6uPglAsV1ulU5U/8LiCQiNAR2RgOizmf33a44jNFRfn7e0NT3WnAdsp5N
	Q==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_001232_625908_7A0B748F 
X-CRM114-Status: GOOD (  12.77  )
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

The dhchap_secret and dhchap_ctrl_secret options share the same string
replacement and DHHC-1 validation rules.  The replacement step can reuse
nvmf_parse_string_option(), leaving only the DH-CHAP-specific validation
in a dedicated helper.

Add nvmf_parse_dhchap_secret() to reuse nvmf_parse_string_option() for the
common allocation and ownership handling, then perform the DH-CHAP-specific
validation.  If validation fails, discard the installed value with
kfree_sensitive() and clear the field so the normal options cleanup can
safely run after nvmf_parse_options() returns an error.

Both secret options share this helper because their parsing and validation
rules are identical.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 47 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 24385e777307..207b05ade022 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -725,6 +725,24 @@ static int nvmf_parse_string_option(substring_t *args, char **dst)
 	return 0;
 }
 
+static int nvmf_parse_dhchap_secret(substring_t *args, char **secret)
+{
+	int ret;
+
+	ret = nvmf_parse_string_option(args, secret);
+	if (ret)
+		return ret;
+
+	if (strlen(*secret) < 11 || strncmp(*secret, "DHHC-1:", 7)) {
+		pr_err("Invalid DH-CHAP secret %s\n", *secret);
+		kfree_sensitive(*secret);
+		*secret = NULL;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		const char *buf)
 {
@@ -1010,34 +1028,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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


