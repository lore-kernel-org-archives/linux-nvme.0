Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD4BC61DC6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DudSYiu0l51smEG9rCcrUuSsdx8R0ivwHpjL+SnU4yU=; b=e6G/kYOuDx6kBYJjYNDZAdOQCr
	SN16aBKX53+j+P8xVm2iXN6z4V/qLsnjkmz+bwI95oCgilag3j7GaxP2dNxkZR/uOJK9WhgwJKBPp
	nHi89eMwvkWdobIdnkGRKQNEEWk7VaUcms7qxHzPzkP4wSMnycB2lYT3Lz6pVA8HvChQVh533WPzv
	tU5DuE5c+j6gfYq2VNSXrpFIFEL4hKOrpK8wTVF2RySjsaGk4nlo3Qg7wfK5ykdV7NStNCB+4Me3r
	GZ88f4LZfrfYoxDQEpw50tYQFpTkTdldiK9XoxQ6m4bILb9cBmwHpJzXCk2meJ0ouTdLFyHExh/i4
	T6jV4pTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzZmU-000000041FC-2uVe;
	Thu, 27 Aug 2026 13:04:34 +0000
Received: from smtpbguseast2.qq.com ([54.204.34.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzZmR-000000041Ac-29UU
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 13:04:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787835839;
	bh=DudSYiu0l51smEG9rCcrUuSsdx8R0ivwHpjL+SnU4yU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZfgG4wnbzGRdwf7CkqJj8ptZrvGPfaEKYQSxdtJNWtIxIqX47ZBBDxrqiwauKOiEw
	 L11M7zbKsXzzgr89NyuIu5gjEtLXzCxl2hYPZ/k7uUXkdeNjAwaZnP8uAREzw72Wi+
	 5CsT9Ec3teM6JNiPgUDfzwIIbumI7cPQ/+xQEbHM=
X-QQ-mid: esmtpgz16t1787835823t85a16d86
X-QQ-Originating-IP: WPzcot1uElX5wBNmxkZ7Vir9EpYhUzqvQOGUV0oKGjs=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 21:03:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17996740236134004177
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 v2 2/4] nvme-fabrics: add helper for owned string options
Date: Thu, 27 Aug 2026 21:03:40 +0800
Message-ID: <92BDA706885092E8+20260827130340.1390531-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
References: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NWth7vBa++Gd6mfcxCMtAhqX+p60hOcvzQEJq0+432Zdddw1dG5Ln2ys
	yu9v20ggu23w2TYrlbbss146UZWKdka17cBXhDcVzhHmRfp+E7bGA2OD/FKNoI86sRV5ZWA
	KgFZXbeUAUdg/nFYq3NikTu3Br1E+WtakXSgqIA3yyDwyI+HvKalNYrOAc3s9xhnJSCD3gn
	Oct0JysX4rkpzTCx3yuGI5L3vLxsy71BxwxCiA06SyPiH1AjoVV3J1aCj7rComMCV1wKnT6
	X7ZZg473VAbQ+eCBl+KeXrQrygH+x4wkEjhRo01BF3bjYxJ5aMnXKtM8xBKmZm1tyXQUnnB
	aJJ+huqY8VO0VZpIjklnvuTFJtFlIoDTzjdOc5D56Q+BO0OCQMtjstq2c1gcfgoO6m9MNLh
	kKs2WeB/eNMAAA5o7lLrZUiFrETZ1JR2T8+WhzbzZX7sOBENAkp/9haPaKRY0cOyA9HbpRb
	li8EFg05w1PWJEMPlnyC5owJl2cuTI586xXk8beaFcvfBJz145NYtLPeR6/H0cuiVt0YLT3
	AModY112uo7Fo1IVO3gxkZQ+vYx0goXIJurVe1yYKT3cXA1uBYculD3b7Jw3+xJxxie2JRT
	HBSzVWVsuSXXxEzryNM3dbutuJsEAIgVYzxodEsTLQbQP0C8YFBG5SGyoMiWNvrjLPNqy71
	2IQlBnuMN28RV+bXMLqM404xeV6D2BCXwEyS7ctYIkTkzQA+X89zBzxYD8jBUMENGDeCztJ
	BO9443jtJwMuW3529zmmITAVj5nJ2uBvkyigRW3aDGu92cUR3WBrwVE2FRBAGGW4jiCcjbv
	XDKp796WvJ2rI9TbPCw9pc4CrVRCDGzwKR0ov+OVrMwkfmCqIahZpIQzs6iSyKs0ODpfRAP
	aGh3wCl1RW2m6+2xiui6C522lbMk2XMpRyAv7VLW/z+XZUITouHetBRLsxxqvo49UJHasnV
	YfpmQ/8U/AaRfuSAHkb3nQxS/matkIbNEcMaSiQ4R0JpOZO0F7dJNEo3qgmx2DJ/0h/E08g
	tvMOyGYlXj21rqd1RZ3aL0rPtU5qBRv1EfKSesqaHfsNazYvBHekBCPl5F1DC05QqpQx9FO
	A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_060432_092799_39CC5BA1 
X-CRM114-Status: GOOD (  11.84  )
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

Five string options -- transport, traddr, trsvcid, host_traddr and
host_iface -- have exactly the same parsing and ownership rule: duplicate
the matched value, free the previously stored string, and transfer the new
allocation to the corresponding struct nvmf_ctrl_options field.

Add nvmf_parse_string_option() for that common operation.  The helper owns
the match_strdup() result until it either fails or stores the new pointer
in the destination field, keeping this simple allocation lifetime in one
scope and removing five copies of the same sequence from
nvmf_parse_options().

The helper is intentionally limited to direct string replacement and does
not absorb option-specific validation, conversion, or sensitive cleanup.

No functional change is intended.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 53 ++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1ec6da49167d..aab3fd279d0e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -712,6 +712,19 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
+static int nvmf_parse_string_option(substring_t *args, char **dst)
+{
+	char *value;
+
+	value = match_strdup(args);
+	if (!value)
+		return -ENOMEM;
+
+	kfree(*dst);
+	*dst = value;
+	return 0;
+}
+
 static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		const char *buf)
 {
@@ -755,13 +768,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		opts->mask |= token;
 		switch (token) {
 		case NVMF_OPT_TRANSPORT:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
+			ret = nvmf_parse_string_option(args, &opts->transport);
+			if (ret)
 				goto out;
-			}
-			kfree(opts->transport);
-			opts->transport = p;
 			break;
 		case NVMF_OPT_NQN:
 			p = match_strdup(args);
@@ -783,22 +792,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 					 NVME_DISC_SUBSYS_NAME));
 			break;
 		case NVMF_OPT_TRADDR:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
+			ret = nvmf_parse_string_option(args, &opts->traddr);
+			if (ret)
 				goto out;
-			}
-			kfree(opts->traddr);
-			opts->traddr = p;
 			break;
 		case NVMF_OPT_TRSVCID:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
+			ret = nvmf_parse_string_option(args, &opts->trsvcid);
+			if (ret)
 				goto out;
-			}
-			kfree(opts->trsvcid);
-			opts->trsvcid = p;
 			break;
 		case NVMF_OPT_QUEUE_SIZE:
 			if (match_int(args, &token)) {
@@ -907,22 +908,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->reconnect_delay = token;
 			break;
 		case NVMF_OPT_HOST_TRADDR:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
+			ret = nvmf_parse_string_option(args, &opts->host_traddr);
+			if (ret)
 				goto out;
-			}
-			kfree(opts->host_traddr);
-			opts->host_traddr = p;
 			break;
 		case NVMF_OPT_HOST_IFACE:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
+			ret = nvmf_parse_string_option(args, &opts->host_iface);
+			if (ret)
 				goto out;
-			}
-			kfree(opts->host_iface);
-			opts->host_iface = p;
 			break;
 		case NVMF_OPT_HOST_ID:
 			p = match_strdup(args);
-- 
2.50.1


