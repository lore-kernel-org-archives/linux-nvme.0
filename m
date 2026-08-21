Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4DFC5DF7D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 06:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWzGCrm7qwozn+BjRtmwbFoze9nSI/1rSh5OULkuuDM=; b=1togdOzp9gt+yn+sSw1umuJwDX
	yyH5kUtL8BYpnyPcYCfEQdSTjscJ296uZ9bpv9g2j4cV/dpLRwPiwefNd3px1y7RXuHV42wA8mYPx
	xHCDCpa6eUMQvGJX+gF4jaW9Yl2ubFp8DOgEKF4rd+V2o+iU81aiykQkdsKQIp4xf963Zeh6i5upd
	QGvMLgCX282vgXBZpA2FFmo9fKHuRPCbZUZvujvbct/dzddDnOxvtZBab7CNeuKxzVJzLDj3TTME8
	jbFt6VKhagBqenkAFAWwiu24GKeltALYZk9G0oluwy0gifPFzwy3G8r23zLm1wzj9vxCYouDCitg+
	FBL7Me1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIiK-0000000Cbqh-3dEq;
	Fri, 21 Aug 2026 06:26:52 +0000
Received: from smtpbgau2.qq.com ([54.206.34.216])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIiH-0000000CbjF-0ULj
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 06:26:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787293567;
	bh=RWzGCrm7qwozn+BjRtmwbFoze9nSI/1rSh5OULkuuDM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UR+izRl7DBxkX4TvjHt+ozvUrECNTSfSB49sF9lhCaisHxOxxHkyDy8mgNYRPVdP7
	 x58pnsqamk5ia3bT0WhElAXvwLNwk5Un3sPJu6rIrjQztfN43zgREEPUNCu0kLe/X9
	 F1Qyo2MS6eDd2oKLJLA85S/aq65tVeOcMyzQd4oY=
X-QQ-mid: esmtpsz11t1787293550t274c0705
X-QQ-Originating-IP: H9GmbDhSKjY/GbPN1KK9g9t4qWjKdRaBzchfeG9HLao=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Aug 2026 14:25:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3144338888302720829
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 4/4] nvme-fabrics: add helper for DH-CHAP secret options
Date: Fri, 21 Aug 2026 14:25:45 +0800
Message-ID: <A5B62A1BF62A33C2+20260821062545.1937266-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
References: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mf+wQkWJ2TuY2H5GETP/gumjVOYOp/YPMvZ8+rPjXgQQ2Q0zlouit7CP
	HANefwQq8sHM4ug/0ZeY7+Ll7p5ebOHvlCboGywndXnQLWBgyC8w9XFDYAXpKBsHSEIum5e
	pnIPCp+WUf7Lcu+fj8fhRa7Sj5ku8AP+eAa4kh3YVUm1Gm6WdRJpqSSRFF200+MdOvTcHXF
	sOWe9os8hJ/k3Rexm4O6PtRaAqG6fjVBpRq2jfbCxM88dxex3n2mDQ5a39AQV1S7nE1Ttly
	8btlm8t6paeesG8Fx+JZlybice+yctMMw8ZTII4KyCxFjYZ/arpYMjGgNyrAPPDmEhDpScB
	t5ZIWyzL69NhGDMghyPGD6GrHu9XcMjots/8zMWxq2DmKU6v6Sal+gQzPvD3NFVn4GNZfFd
	GuEzuUxrFVvfzxUxLaHI/6qRggAU729HQewzNjBPUrxAsq871h1d9rdLujl1qxa5rwGGD76
	3h9+TGITMecNWCvf56f8d2XpnWlQOzXm+IfsePvKeQXgRB4Oq/Bc39fJhb7754aRcYvpH3P
	2yKyxF3o/XTZRcoj91YjeYsMmzwRMbgUC3EjIhCrLMf98oW5W1KQ2oRSgDWURFM0DyMM1Q4
	VFJTHKpw2hGa0mPGRcG03iYXM0jvZe/X6knMzu3SLefYfFE8Sw6X5ovi3iRNIHg9ikDjFm0
	n9XnIFQLQt7FYJT4868OuJli9CSDh/3bqKXPHHZxlNQLY+uAzXJVsDpS4d/Bz+W0Z/LyCSD
	8ByRCDbipCQCVS07skVWxF9b+bIoXn01bVcd7GB+pdd8JIj/ekaiQXNAh62hmXWYKHyHL3/
	bZGoSnK2IjPrXsX+pJZX3P5QffEiVULgBfD4XP6G1msp4EgDFBCPt4Dt/ybRApCPcUPmsa8
	QxDB7CEeuMqCj/Vaq1UlpLmOWR6+W6DEx8n5DJoscwr8E8YiITPk7RLGbLUzh6geUNydgUd
	jO8IWZdCFNOsjwCIJkHar45d6w89PYrrUBhZ9s07WN3+spQd1CKC61fXpZlQqXxaWm1kb+j
	B166q9SdpgvN5GuoOATjGxm/pwPrLL2+4EikVJyQlU19PyU5+Oh4SkNxGsn20=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_232649_680259_52DC7C1C 
X-CRM114-Status: GOOD (  12.64  )
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
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 50 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 120e57964cdd..c5ff03ab9e36 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -788,11 +788,30 @@ static int nvmf_parse_hostid(substring_t *args, uuid_t *hostid)
 	return ret;
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
 	substring_t args[MAX_OPT_ARGS];
-	char *options, *o, *option, *p;
+	char *options, *o, *option;
 	int token, ret = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
 	uuid_t hostid;
@@ -1034,34 +1053,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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


