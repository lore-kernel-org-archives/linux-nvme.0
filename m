Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EFCC624A5
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 07:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DudSYiu0l51smEG9rCcrUuSsdx8R0ivwHpjL+SnU4yU=; b=UUGfBmUf7cpuNYySz/oAWxvpen
	DZ9MeCu/CGjbPPLH5cU06nQYGqgx9ivh0CmZz2WiF+iVXurg+x4KfvTaKczy7bnbUOwfJCWO9fC6w
	TQw+0Jdeg1szN95b/PaIge5DZCA2guNw5ml8UoHE5gRhaSQzxRzHxx55mdznmn6jV6TAv87woNJJ1
	6Oe43wIlCEDDhOdfkWBXxQZ+NGBygb3hiosEMrnj3ypKXaMUSzoJBNRmRf3CWGwOM3iDfmIilxLAv
	N4bEUYeF4t8lHQG7FcWXhrsyaeonsKCnBJTnVpTaniLQ8MzlpnUVvUE0+wrDxn+srbpk+zKrVXdFZ
	e10Soxzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wBb-00000008gyh-1orP;
	Mon, 31 Aug 2026 07:12:07 +0000
Received: from smtpbgsg1.qq.com ([54.254.200.92])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wBY-00000008gwM-3BLg
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 07:12:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788160285;
	bh=DudSYiu0l51smEG9rCcrUuSsdx8R0ivwHpjL+SnU4yU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nuiD1pJAM8ojjnbqB33xFTcwQ1S12lACAJYXnj1Uc6cvBQxbot+RtxrW/PmQB7jBj
	 0ecUTWTvZTbDxvfy9eZNPHvbSek2BeV2IZ76YEL1pPjmMCqaSojna0v35+oGB4wQjy
	 AeOSfFi5ZFlRBXK8jvmwXfRkgH7iDJMU5XvnAiAM=
X-QQ-mid: zesmtpgz7t1788160268t89cf4e0f
X-QQ-Originating-IP: Fh5PH39AwLrLan57aQHZ2A7JReatCG/JrHg1/GeKfsU=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 31 Aug 2026 15:11:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13442412379462899091
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 v3 2/4] nvme-fabrics: add helper for owned string options
Date: Mon, 31 Aug 2026 15:11:05 +0800
Message-ID: <9910C0FE65DE86BB+20260831071105.638107-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <B1A2864319EA3B6C+20260831070557.631487-1-raoxu@uniontech.com>
References: <B1A2864319EA3B6C+20260831070557.631487-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N7zE+17nr98Tuu8NN7U6OByhwVKSYd/ZoPys7iwpQb0uDMhKb9ncm0tU
	HV+SnbonUYM/aiyhRNwtP8sliUJsnDF7/s1lnsFESD16onu0O9skeuXY/kGF2t4HPfw9tRN
	nL2+LpjmYEDJ26AhjNjNirq+lX5LSu0tbAb5fBhX6YueYkzzBec8WGsmtWV3Asniec5iaRX
	OsZMgB5Cq7UeKefhXLV4boKTF2ZQUxemRXahj/NEJWBEXU4nwnk6m9UaYQ1RJYG8jF6xtvj
	lyuGl+P0lkFv33EL1NdUMx5LsixzSVBD2xC1/g3d11vDBUVzgJpsDZ601SjM1mZ6oo+Vq0P
	1geALBXP7V65FcAaPhzdWS1xCkqKpP7B/RoO2dRHE4oygDDo4yGZj8P77smoUjCuZeQ3Qz9
	0R++ewHUhAH6/du+mCl2tWtsFAVrYrXUjFKdmojKPaNO1hHIMssD5OetY2maBsCN0yUuGcV
	UAryNxuTbxWC6Ve8SN3i00zxOLb+PhJHs7XWn6JQrN/SsbcleQDkhOWF1KuKosGqWF0arcM
	vDbyz4OS5//KCqCvPM9CiTF2TNKTQB7gjI14QRkijwS3SAHm7HKmQmEeepHBiQe7rw1m6Jj
	aX2yULnHdxD8OXjxd8ra5XdqUYd3zOE54J1sEuh1zK+G9GUPxKihFTRfKyvcokyXEBJgYHN
	u+yda4dGh2U4tYTIJ6SkJoGtRkKeuQRVOHsaGq/T3v59jxX3fWyK76K1ReFXdFYXDndD+pw
	nrRHhYVEuFkhobgX/Z+Q9Q8K5khUdPJnS9lQpl51POX2VE5NvJNQVLbvmWANerJQ2NlTafG
	fnyJwOxLCR1AcVi9Goyy9O8HUDtm00PmObrs6FG2/Qp4AtZ5yrfXpD0kB5S6v6FRWRY98kq
	vGFkcTweL7OfrT/R04njWVPVkPJ5zMMJ2/RyTub4nMQmTfeYVceCPE3rhINIZCiMqLwuG27
	GDVdoyiNo5+nDXcwLp9t1mr08o4/sD3DEOUTPgGY9rDoIMYxLtwDJOAXdbrdYdnOyFvlEqk
	g10CSnZWtFmA/91R7N7degoct14pSlt8WAlkULBhK/AGLbd0IsooqkLyQmfzvFS84VNvLUP
	4pPYcKKfy3zKgdqt2AeWtKRaEYwXLzTSg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_001205_142184_F04E76F2 
X-CRM114-Status: GOOD (  12.17  )
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


