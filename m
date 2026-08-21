Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D462BC5DF7D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 06:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oc0tsd/qnr+dthL6cOQcW19IpqD6NfIrrZqh8QhIXEg=; b=lL1JrUXwX338umxVldWuqQIgfk
	9GE8L48s/FWMAnlq2GCluDqkyaOeG8ASCiXx5/K8+yh7iuHL5jl6TqUUKbNetl9iQr3T1wxWreNM5
	P3MdfEdFqtp9nmKP42OHfn4DA8pYOGe/NNymEjERVGNU/rCVElVxRY6qFvt2wqpp6Sl2D4tsYujwo
	ZgjuQhBa8WrLbIETR0DuEJnb2XuuADTzL3UWkQTlj741uy0+PGRYAMxg+qgNaScyFcPTESXk2rjuK
	xa2goDYVbi5U7QvPTh2r4+M/8uL4p45X+ChtCwGQXC2QAq5Wz8f+vg5UIBCyZPVk+6n05S8HVIqSP
	dHDLqpRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIi1-0000000Cbhz-0OGX;
	Fri, 21 Aug 2026 06:26:33 +0000
Received: from smtpbguseast1.qq.com ([54.204.34.129])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIhw-0000000Cbdy-1QHW
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 06:26:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787293550;
	bh=oc0tsd/qnr+dthL6cOQcW19IpqD6NfIrrZqh8QhIXEg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=h/F6nGTTnDlRfSwT99NSzb9mdHHCk5lGBw49aidB01WnkGJd2hGYRQOQAsT4gMkjp
	 KO2D3toBpnZ4PMYGYY9cgaFIH7FWLOVbp487du1VZH/cMS5+AwBpebqdYat6nYNIVc
	 l6FvQDgG5t2TRbqcoGX8MUB/OatzVlQU/2l4jmJ0=
X-QQ-mid: zesmtpgz1t1787293533ta406d61f
X-QQ-Originating-IP: uwIlmkkzJUjEBE79/V03SyRLT8QgDw41hxHM3xRMWb4=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Aug 2026 14:25:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1572066740897638065
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 3/4] nvme-fabrics: add helpers for subsystem and host identity options
Date: Fri, 21 Aug 2026 14:25:28 +0800
Message-ID: <450E21059686C852+20260821062529.1936914-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
References: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NG63YEgwc4yzgqZn6HjyULnIgTGCKrRz7kjDzRkiN6Yw5Sg0YOGv6qGn
	6rNill24PE1rocqkyceZrABwv7jS5mWZk638dAZpUZY75yunsDV06yFMr5NF4KePNCnKgaU
	p31z4+3YFRAjGR/53iY96Hi2uISL9QbdRA083164+NdXTXB1N0VuuR+8FwvvK0ah8AgKTyZ
	H/O576DExy1hiTnvouWXWXWwLcb2opNgvyELpGB3AiGnLLWxE7ocNMX1KM/XBUtwFTuMBoQ
	uswVgBUkBRN2VdGHsLC18BpsMn6HJ6WfnmELABSDcV43s9/1yDiSL3EGGqKIzR/hmQido1s
	46sGvgSeoZFzcxhCJ2KYIF4JjPry6ujI17ycv3TW/kGEjuvyGH0qAVU1Ga4dhG4dNZ/Cqs4
	I2YTWLecvpXFh/x+EFsuWnSuCOCCsdaSvnj0UdFZLGMcVGImv4TF29ZT+GAEDCUdF+en4hr
	q1AbJDEl8vbhOrKl2jI8KxV+NRSN9dcSbzqgOtyVxmNJND3RjJTEvl3XBR3wMueLwIhNNK8
	IvwmQn4mrHS3JewuIs262/wr7z0Cf+khjLmAjaF5c4rN4Kbh/nkIB+gFsR8vLazxnC4/0QT
	NeIY+muW5k57pwzgVwWz9Nw8vW3MJuRxixUaimlgU/6QCveRUpQnb12Yvc7HhrD99MKMIce
	hgguQ5UF/iT/V5OKvgQlaRkL7h75LxGbmdrkJz3VlNHml/y33OHUWvhQlzbfgvd7Io1FH3U
	kYVzA+fvp1UB9XEVHxbYdN7/Vt3qNzKV3cwt+8hFoGJJoi/+N7IPooiRQflZLJ7Wl6aXHli
	S6WyXpd3DhW4lN7AbbOovRGmZOtMrhjtJtWmv68x7dj9wAnxEfp65RybjQAcgOxm0e5nJwz
	KedXnW4eLanuHWUVDsunCYcKdJIR7OD5AIvbwxaN0nDCYZIUBb8x8fmkbNgd0m4J8Afgw6p
	c8FMWo89IaUsVK95gC+Kc3aC1FX0DjAmg752qM+O1qogBpOuQ4dcvMVCZ7g27irYvAnrLzb
	LPhB6zt4r/NYilqSNkWRvEj3RmhjRO4Oce/lJKMrwccIxZIs590yci3MjEt8FXER93TrF+E
	g==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_232628_923384_EDDE46D3 
X-CRM114-Status: GOOD (  13.70  )
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

The nqn, hostnqn and hostid options also start with match_strdup(), but
unlike the direct string replacements handled by nvmf_parse_string_option()
they perform option-specific validation or conversion before parsing is
complete.

Move each lifetime into a helper whose name identifies the value being
parsed:

  nvmf_parse_subsysnqn() handles NVMF_OPT_NQN.  It replaces
  opts->subsysnqn, checks NVMF_NQN_SIZE and updates discovery_nqn.  Using
  subsysnqn in the helper name distinguishes the subsystem NQN from the
  host NQN at the call site.

  nvmf_parse_hostnqn() handles the hostnqn option.  It keeps the existing
  host-assignment check, validates the temporary NQN, copies it to the
  hostnqn buffer and frees the temporary allocation before returning.

  nvmf_parse_hostid() handles the hostid option.  It converts the temporary
  string to uuid_t and frees the duplicated string on both success and
  failure paths.

These three helpers are grouped because they parse non-sensitive identity
values that require validation or conversion rather than a simple owned
string replacement.  Preserve the existing validation and ownership
ordering while moving the code.

No functional change is intended.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 118 +++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 49 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index aab3fd279d0e..120e57964cdd 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -725,13 +725,75 @@ static int nvmf_parse_string_option(substring_t *args, char **dst)
 	return 0;
 }
 
+static int nvmf_parse_subsysnqn(struct nvmf_ctrl_options *opts, substring_t *args)
+{
+	char *nqn;
+
+	nqn = match_strdup(args);
+	if (!nqn)
+		return -ENOMEM;
+
+	kfree(opts->subsysnqn);
+	opts->subsysnqn = nqn;
+	if (strlen(opts->subsysnqn) >= NVMF_NQN_SIZE) {
+		pr_err("%s needs to be < %d bytes\n",
+		       opts->subsysnqn, NVMF_NQN_SIZE);
+		return -EINVAL;
+	}
+
+	opts->discovery_nqn = !strcmp(opts->subsysnqn, NVME_DISC_SUBSYS_NAME);
+	return 0;
+}
+
+static int nvmf_parse_hostnqn(struct nvmf_ctrl_options *opts,
+			      substring_t *args, char *hostnqn)
+{
+	char *nqn;
+
+	if (opts->host) {
+		pr_err("hostnqn already user-assigned: %s\n", opts->host->nqn);
+		return -EADDRINUSE;
+	}
+
+	nqn = match_strdup(args);
+	if (!nqn)
+		return -ENOMEM;
+
+	if (strlen(nqn) >= NVMF_NQN_SIZE) {
+		pr_err("%s needs to be < %d bytes\n", nqn, NVMF_NQN_SIZE);
+		kfree(nqn);
+		return -EINVAL;
+	}
+
+	strscpy(hostnqn, nqn, NVMF_NQN_SIZE);
+	kfree(nqn);
+	return 0;
+}
+
+static int nvmf_parse_hostid(substring_t *args, uuid_t *hostid)
+{
+	char *id;
+	int ret;
+
+	id = match_strdup(args);
+	if (!id)
+		return -ENOMEM;
+
+	ret = uuid_parse(id, hostid);
+	if (ret) {
+		pr_err("Invalid hostid %s\n", id);
+		ret = -EINVAL;
+	}
+	kfree(id);
+	return ret;
+}
+
 static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		const char *buf)
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *options, *o, *option, *p;
 	int token, ret = 0;
-	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
 	uuid_t hostid;
 	char hostnqn[NVMF_NQN_SIZE];
@@ -773,23 +835,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			break;
 		case NVMF_OPT_NQN:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			kfree(opts->subsysnqn);
-			opts->subsysnqn = p;
-			nqnlen = strlen(opts->subsysnqn);
-			if (nqnlen >= NVMF_NQN_SIZE) {
-				pr_err("%s needs to be < %d bytes\n",
-					opts->subsysnqn, NVMF_NQN_SIZE);
-				ret = -EINVAL;
+			ret = nvmf_parse_subsysnqn(opts, args);
+			if (ret)
 				goto out;
-			}
-			opts->discovery_nqn =
-				!(strcmp(opts->subsysnqn,
-					 NVME_DISC_SUBSYS_NAME));
 			break;
 		case NVMF_OPT_TRADDR:
 			ret = nvmf_parse_string_option(args, &opts->traddr);
@@ -873,27 +921,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->fast_io_fail_tmo = token;
 			break;
 		case NVMF_OPT_HOSTNQN:
-			if (opts->host) {
-				pr_err("hostnqn already user-assigned: %s\n",
-				       opts->host->nqn);
-				ret = -EADDRINUSE;
-				goto out;
-			}
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			nqnlen = strlen(p);
-			if (nqnlen >= NVMF_NQN_SIZE) {
-				pr_err("%s needs to be < %d bytes\n",
-					p, NVMF_NQN_SIZE);
-				kfree(p);
-				ret = -EINVAL;
+			ret = nvmf_parse_hostnqn(opts, args, hostnqn);
+			if (ret)
 				goto out;
-			}
-			strscpy(hostnqn, p, NVMF_NQN_SIZE);
-			kfree(p);
 			break;
 		case NVMF_OPT_RECONNECT_DELAY:
 			if (match_int(args, &token)) {
@@ -918,19 +948,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			break;
 		case NVMF_OPT_HOST_ID:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = uuid_parse(p, &hostid);
-			if (ret) {
-				pr_err("Invalid hostid %s\n", p);
-				ret = -EINVAL;
-				kfree(p);
+			ret = nvmf_parse_hostid(args, &hostid);
+			if (ret)
 				goto out;
-			}
-			kfree(p);
 			break;
 		case NVMF_OPT_DUP_CONNECT:
 			opts->duplicate_connect = true;
-- 
2.50.1


