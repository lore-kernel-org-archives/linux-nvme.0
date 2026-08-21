Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71369C5DF88
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 06:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3QlqMNx60UTUxllJ+Qyp5NymPpAR4Smbf+ePyHffzkM=; b=gYFO28f00b6qMmxbv0uKqeBSYA
	S2bc3du67kxxYRJnqDzKQBA7O+YYcfibtjrQXSjJ7/3qCYUHuXaJWA94Yw9uEwnK0q5/O35YB7+AX
	7NNQawbvpjAV3z6saq3fspVTONsO5dA1qsnGuEWmIdf8bUoshuW5KWI3fYHWp23NggUabuyv1Mu1u
	X0ymIn+3pDSWI/CzQPkic24UABUJb/GiBoybi/dPKnOGFqZV3CQlghpR3iwPeQdTdCYNhpzOvEeQ6
	RwsfGRYM7r4n7VNgQ4CuAMJMDd1Ot5w6PUrpvcaVnH8xsQHIvK3p1HV2auPUy4ehvyS8tU4WJEpgb
	HBmBz86A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIhk-0000000CbeO-4395;
	Fri, 21 Aug 2026 06:26:16 +0000
Received: from smtpbguseast1.qq.com ([54.204.34.129])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIhh-0000000CbcP-3aTK
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 06:26:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787293535;
	bh=3QlqMNx60UTUxllJ+Qyp5NymPpAR4Smbf+ePyHffzkM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=l1eYOg2U6Es3vbJNDBA08gsQkNn38qd+6awHMZb5JrxgO6PZbqhP1nCsCsMxH7dPv
	 1BLkxKZbZriTLn5U2XQJs9cnerk+o7q9VpluhBKm3cDgAKaSGqhaMK9AZLZbVWv+re
	 rmn6DHdoBMXXVltlhqdJ3pgdgIwsKOCB2qSAL2Lo=
X-QQ-mid: esmtpsz11t1787293516td79ba5f2
X-QQ-Originating-IP: 4j3zO0GJ1AxMpZbB6hYX+yEvIhfuHChHn+0GEtdWy3c=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Aug 2026 14:25:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16397503040138716712
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 2/4] nvme-fabrics: add helper for owned string options
Date: Fri, 21 Aug 2026 14:25:12 +0800
Message-ID: <124D3A0A7C82160A+20260821062512.1936554-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
References: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MeGVnsUF9M9xoRzn6QXntqAjV64dtPA9iopAi1KVpl1DKfP1TIFnu6TU
	3HHTAxrKsPY+78tLoIStY3K0Yw4tYkgRyUGMMshhQaMxe6uULC6MiBbrc6OVjzgXFTe9Avs
	ws1/apa26lI/LQl+AzeXn3scHZ5vxZKaU4JYzHPeFKHCtWhfIXTe9qGTLppTKzx9xBy3+5V
	qs1rZgx13b8hYm9F+5bD2esozufAPA8M+cwV7inNDr72Tx09OgcoNXgfKEe4rwkc7FK17c1
	fXEylu8ZVIUe9zn6aujf2iH14V2FAMsFj/5tg6lZeJNfdZ4L7WEXuE12KVBvkyWSZFlvANB
	d9LDFHBXzu7J+1DZQ5g1St/PiNPHQfD6Va12k19IRKWkDFhaq4t0KvXPIctGJObw+RBEPIe
	YXkJWFrlsqCe2uCdKHawPmkMNb4PRhJQAwIUoySf55SmSC+5/H41dg0YQP28wNVoODW/EOE
	qXbqT63ZS9GlNZqu/KtwHAoTtfynJTIh39yqZ173YVaBnTKVx5Ms4NK5n2e8uepxHxV2kL6
	FOJLbuSgEJDwzjTCdCQdxxHSZQed0Dt6LTriwvGJLpHYhVaZM7hMdL7K80eYf3AgD/ELy1u
	J6o3Il+5jcitMbOV/TQW3FsU/yybUJkYYTYup577hzKfDL2ZH+ee5/06yWZrNZAD4oc5NLz
	sCCYamdvs5na7xDZ0RZ2ahncsW1KVNroTtYdrq+zdA0tCuAC/5fKvDL6bHbKFYTnVW8qFh1
	+JErPerR3VnyH7rVdnm2QA2U2FjJBNEixy3L2HGwvF+RdPHchQgxBrDuPmufhcFDzfXlCEw
	yAPckCOnLMPWff8eUHi9BWCitTrApQmZY0QNhOBlH92V+aecUJVXTJsvhzf+jDNst5r9yOI
	MT9o3Snrd0EnyzJApa/q459RTjBoEtkrBtVRGIrLF7rbTTUTAG7wzCSfO4DH8DqPhQjXXo4
	iKzLOCnkbG1j73Pzlq/G6EGlLNU+nGlMTwHGuKqv0Lvh3NX53jL8kadeHQp7nGOsM+dKDOY
	eDmAvQqDtKQqunVSI+9NdszHScGOxdGG7gOmIkygEUaySyZ7cN/dY511Fx9V7r9rrV3AopL
	GflWhc1+5KeflVD5u0PABkdmsrCJSa0WzL/mger2d/5
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_232614_433022_092E3D72 
X-CRM114-Status: GOOD (  12.23  )
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

The helper is intentionally limited to direct string replacement.  Options
that need validation, conversion, or sensitive cleanup have different
lifetime rules and are handled separately in the following patches.

No functional change is intended.

Suggested-by: Christoph Hellwig <hch@lst.de>
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


