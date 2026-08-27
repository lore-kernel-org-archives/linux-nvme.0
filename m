Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBF9C61DC6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NqU/OQY6xhI/9fc50QMVTcXsqM0l3RNkUoJ6o7t1gxg=; b=HENV42dx+/lPhnLp2eONzhHhly
	jAgXxtK6k50RZUAfo3+CyZGtaKFeagJnw9/WyeCbjx0vMwPb6Zm5WGvnvm+QvhY4T9s3Ky+NimSy6
	YQOcX8iKrX80ovygt5hX54Y4RUOqSKSMkQSZy6Qb81TH7mL5Louh7ta/Ewken2zOHh1igCdQmndgC
	4MGz6SXOtVpQPYUHnCMVqnWW/KPmnghLDn8RZqp0yz7TvTPdpqCun8I49dJf0gKWgLaAqvXB+RrUc
	hT8d/1yvpTw0+wi0C4Jy9xut+cvglNRlUaZEJdX4jkwxVDDrhb0msT1fXDBIDDtbEgFHJH4KMt4X9
	DBcKEiWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzZmU-000000041F6-2N2c;
	Thu, 27 Aug 2026 13:04:34 +0000
Received: from smtpbguseast2.qq.com ([54.204.34.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzZmR-000000041AS-29KC
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 13:04:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787835827;
	bh=NqU/OQY6xhI/9fc50QMVTcXsqM0l3RNkUoJ6o7t1gxg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RLlL2+LOzXy2PGCMgo3DWBhTqbBJETRZse9gyf5rJWXg7PBpoJwfPDH/FZ0AtJJi2
	 keoDw3A+tXOHqx2EE6wU4DSoBPmLvS/ADqS7Nj8cYnOcNa/ea5x+T01zZ3CJu3KlEI
	 rMtxPKy/W2f2pZ7qSY1OzHKFw+oQm+Osxl+mG1Kk=
X-QQ-mid: zesmtpgz9t1787835809t88c8b7c0
X-QQ-Originating-IP: mDjmIxSPwg/48udOaXPPDFGt4FwgJ2jGc+3qsTD8nC4=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 21:03:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8082855683011287643
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 v2 1/4] nvme-fabrics: separate option tokenizer pointer
Date: Thu, 27 Aug 2026 21:03:26 +0800
Message-ID: <B5DBFE863C2BC94C+20260827130326.1390222-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
References: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MCEqJnTzsXC9tEXexN3Apj0cm/wYZAyTNRMvty3fdKz4aib8Ja4SlcjV
	ykAdJ/ZtbTackWk7QglTIn1WMuVaE3071hqYGdks1snWUOGO/zJ78j9gI4ujelNoXaL8VFs
	uunk8kHZYsZooR3ESxqHdQZdOjKw1vQfaYfuiTyvp8K+zPpkOpbCgPUPGheYEnG8fSzJc6m
	BGiWTTyPga3XwNYIzMdoLsNTnb2sd/1BwXkR6LVK/YuALvbCnfv58J3+repBm6NILlAQ5bc
	okYD4RmsvRh+JPQLByh2vq3P0Z69jdFtqFinLxRgbz4/w1MHU2iXIPjgoMfhlToaOWvXF4S
	qjU/P2WiYSo/oXQhPQ+d2g7E6SJG7Uq5rI9D/QnXZugAqp0pqFZazymBnRAhIQ9VJZwRSot
	TGq4wJvrqxuJzaWqx7DVolpk0YiEeAD0aB3ZI114sapVsyWsqch1Pqkj3r4wP7kqM1WTAjS
	L0wO6y/jwaD1KaMCD/rIzzFlzPFYQ8YV4wHK2Cn5LFaOm20bUjgETBCCpKF3r4YLl17ZMB/
	f9h0VcSPkh1gKoxIwF4LKHNUkN2y29FUnzxQCs+HiLsr8rFr3kVGjWU/idD0d9A9L9v0xVC
	q31CzI1L4visxKy79LFzLQunTlfSkIvzB8AQk77I00TbNg4TYMJKl2yJt4RWVRQJm8qSxYy
	NZwVRokTvplfumnG3BUU1e3IC1W2WTeTpuuYyldgxechPvVO7tsUZH6u+h0UZL5QooMMeUO
	+04k8+SglqrHjJP+wB5zRrdgpgnEi5vnbVyVNVQqUoFA+NpxAtS4E1SYoHCxrs68sDBy8AZ
	1f+NkQdHiDaHDNls8Qv6vW+X8f58IJuGZ/ESvTckxsBntEwHc7DFVdmzzxMHC6bULEKosgl
	Mu479a8UUaR2AgbgUD2EEU27OoN5WU0ZMGMd1eTSykiMB5vx1mQRv6NVsYbKdfvMeKxSjcU
	SQxkkiCQQGV0P42ne/iboN969KHMST2lQYW3NtZj4cP+/Iae+auSiipPrU2wdYHEP9l0flz
	VCT7XtXny7aE8sa3gNNHHSXTmBMIe9YaFQClPmRhRxKVrO21poEf3Y/xdeJiOse4lR6IoZJ
	gdHpg9nE/5MKzh+vvn/APo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_060432_092833_0FDD36EE 
X-CRM114-Status: GOOD (  13.60  )
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


