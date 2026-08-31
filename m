Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C5DC624A5
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 07:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m2C6iY+uu0tPZzhXdnPEQUIgtzuD2N/br4GdpKmMyFg=; b=NqZ8csLPDRoe9/mROYk3IqD9W3
	tEM0eC23Gj0+Dejz3A5aCcJDaV8SuMoGUBBKf8yCK+W0Cj1cvFFfKF++qoGiTp1u7cFyPnZj7LKKH
	QAr3FsYb0HSFu0Z9iOp/2fVi0hiw/dScDXnidZgYJphn/jpOhXi7U8vdgI7zLFKk3/CYpBpCEE6qw
	x3xAC6gBJM66M1wPNS2yk4C7W3rrtHDprzhd5DpLxMZkrRhF4Tys9O4VMUt1ZZ1p7VfupStH57WyC
	u7fHoC1hdhanC4oOaxZjIeWhngAVd79uFgHeJFwepa3FuKwilAqsVJ6Y7Lfl4wbiOqJ2A3mEKqlj5
	czgk6F1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wBP-00000008gwN-1Nvd;
	Mon, 31 Aug 2026 07:11:55 +0000
Received: from smtpbg150.qq.com ([18.132.163.193])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wBM-00000008guk-1g3H
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 07:11:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788160272;
	bh=m2C6iY+uu0tPZzhXdnPEQUIgtzuD2N/br4GdpKmMyFg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VDOp5hm4fTt5VNkfR0Vq6QJkyPJxA3UYxWKwFV+DhxLiDvOVn83mzHm9DNybLK9GY
	 LNCzsDYmO4TF+QQjiLjiF2QUtoTG6b83c3D5wiKmoBmcHuDDKDSK2IlfWHlexTdBHh
	 QDYPIPGWp8VM+DfUQTZkBAIHyeQtGuH5S27Njly4=
X-QQ-mid: esmtpsz16t1788160254t808e05e5
X-QQ-Originating-IP: 2ePWxfxItYJfnyvk1iKRgQ8bRqgDbU+9Hh256R00M6A=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 31 Aug 2026 15:10:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15215064244287525615
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 v3 1/4] nvme-fabrics: separate option tokenizer pointer
Date: Mon, 31 Aug 2026 15:10:50 +0800
Message-ID: <67C2BD21B4A592D4+20260831071050.637726-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <B1A2864319EA3B6C+20260831070557.631487-1-raoxu@uniontech.com>
References: <B1A2864319EA3B6C+20260831070557.631487-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MD5lytsRYqTqSwcRsMIAS+4i85X8qyoUwhZwQlwXC/mAarma/44KGNXI
	ZCYlpezMUTaDUJYXyn0cjl+v3uvyEpBBNjB6Ih+xsDG7z0dh2WXRWioTeiUktTRWlq04b6w
	OYt2fr6USt237UMq5JUjmRZ5tkCwD7PQW0vi0gXaPm5Lt3XLvufA1WCiheYys4wLJztvmAn
	P2ykhtlAwcJZinkGWf6Xtp8WBD6cRNvhsMs7fYTCFvctZPobF7j1pRmTIFYta6DAzmYmBN9
	trqqcMwIe2RZ3JDT8mG7PcQsMh/Dtx9d8E9gY8+ZhTHUrQFjP9O59+ggfSuuXNt0wwAQTYZ
	1kTR7iZZonSi5qad8kgMgJMqUMkbuqXEA2V65MqByJsS/U5IEMWUAzIvY6dQWrv8ZHhUjgo
	o3GJNzHaqBzu+ibYiAgS1e7bemWMFJfdPV0AVz1b6jzU4pE1WdacUchOR5AJSCj6tPZtz2P
	rldkFGSsvDpP/1s4ktdDPBkvgBGXdxg44tQ8a5WTrHDHlZ7+vW0/gHhLVr5PaNp9EOa80ts
	sq5WEuI648LbpsZOWfRbDnFJkSj6wXHo8Cv5bznULnHWBSurv8PifHfIXTjEPuCNYrl/dWJ
	LudEacz0tLdzwpHWm7BmbO1u8Rz/juKginypKY90vxInuoQpYvYEIAJDGwFb8Dr6WwNGOvn
	vcgpqiWklVPr8uRm/yXk93IKTa9zUO1AvrRjrTLkn/3krhO1tiTlyMOAh+GPIbJiVZ7eEM2
	EO7JtgAqxzNgj1bqoYc5fBB1PZ0Fyw2KwMtRqc555jgt3rGB9KnFLkSzO5ObS1oiBqlDObL
	rvgqDkWTc3Z3HXhwRW4wnvHEiQsO1XvUMdv7VdkGcRXOEz3I+p4C7Nu+N7CCFikLEHvACU6
	F8MneK9JYo2y+KiKTxMkCT2GMt1Gu3V0aQBmtaA8czByqzgbX8yOXV6iKSmqpWXOYikAWuO
	EWvd8+wPZyEdp+/Fhu6FdauoOTtNIHOR9kQztY8MBCrs9Awkt+dbHyo59gc/7AgqKBhlwQI
	u5B8/B+wMAhloWzhHTKrr7/ihjQQdpvoXt8SHQWcqf2Lw7PKyTI4DiXTQPfVrGPh+1BFkIf
	sjlwg+kKv6w
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_001152_909357_E287132A 
X-CRM114-Status: GOOD (  14.16  )
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

nvmf_parse_options() currently uses p both for the option returned by
strsep() and for strings allocated by match_strdup().  The former points
into the temporary options buffer while the latter owns a separate
allocation, so the same variable represents two different lifetimes.

Introduce option for the current string token passed to match_token().
Leave p for temporary strings returned by match_strdup(), giving option
tokenization and allocated string storage distinct variables without
changing the parsing logic.

The name option is intentional: options remains the backing buffer for the
full request, option is one comma/newline-delimited entry, and token names
the integer result returned by match_token().

This is a mechanical preparation with no functional change.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 59f823dfbbcc..1ec6da49167d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -716,7 +716,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		const char *buf)
 {
 	substring_t args[MAX_OPT_ARGS];
-	char *options, *o, *p;
+	char *options, *o, *option, *p;
 	int token, ret = 0;
 	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
@@ -747,11 +747,11 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	uuid_copy(&hostid, &nvmf_default_host->id);
 	strscpy(hostnqn, nvmf_default_host->nqn, NVMF_NQN_SIZE);
 
-	while ((p = strsep(&o, ",\n")) != NULL) {
-		if (!*p)
+	while ((option = strsep(&o, ",\n")) != NULL) {
+		if (!*option)
 			continue;
 
-		token = match_token(p, opt_tokens, args);
+		token = match_token(option, opt_tokens, args);
 		opts->mask |= token;
 		switch (token) {
 		case NVMF_OPT_TRANSPORT:
@@ -1068,7 +1068,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
-				p);
+				option);
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.50.1


