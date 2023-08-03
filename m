Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33F6C00528
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 11:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=whRpVNOo9lq7kny18/1eRp+tYPOKUAVmJApmC1+Z7YA=; b=mtW3SU19A9ut8h74op6L1S4KbR
	T17oU6wXqlCHSSJdfTGCxgMSmrETaE8/JgSWvVRyphCQvgaNCiGHmCAIiRyEDdUCmDoHVNw+YtjGE
	gu8j+LYGtQpNyPNE7I28kHTgMeIWkw1E0iLGmmhQkwvF++/U8nbydfxOMakrUl8ZMgy58sHhTz0qe
	d8Eh9vaFyyi7zLDGJKVsX1GUl32CzIllXwtPsz3HuijLZ+ik07CtNbP6tJssOWW9qEIglwhYX9YzF
	SQxoplo0DrHWLveI7/3gQ0zpJ8GLHpHon0Lh+m+mFgBDoiXvSCxJC7nn7FOqJtcz1Q0iZGBZQJHrP
	N6r3bcFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRWOr-007lG5-1u;
	Thu, 03 Aug 2023 11:21:49 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRWOn-007lBr-0D
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 11:21:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691061705; x=1722597705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aD8+6nrwVnyws6t/zmJ/qsAuAehWXLN4+06fSklE4Kw=;
  b=XiMOs9lrpC/t+sTW/rpJ0Q3G50sWU+Xmq4n7sdQfDZeyaEZi8oLSLDi1
   It4rFKk/8+L2F9sGP3x1QOSiRs6QyOiaTQhtGD41MUspZBGpEZuKvfg9L
   pdHBjhWeVkjw/cutoAupBktsIoaxm1Nfm3cwLTGT+DqfHTahXjKzFO7Pe
   VUmFag7QdFszSCdsY96kNPABbA04y9qJhmwTL56B3lOKi6iCWTG1nKKfs
   0DF1ctRw6cdhiHYiN2fBPaMv12Tf25vjZKnCRBCqjFhroDpjKLwMB7ZAF
   Nhi59BmLWbGxB9S7Ppp+G+PjmCXmNUgJUaPpy9L+hHNJWxpUHUWJP3H87
   w==;
X-IronPort-AV: E=Sophos;i="6.01,252,1684771200"; 
   d="scan'208";a="345113685"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2023 19:21:41 +0800
IronPort-SDR: PGX0szcP/GdYodiIPvnfTPSj4v95QJTSXllyTsJbMcVzigxwF2s82snnxWe0jTBsA2AwR9eTKT
 1GJtXs2tOlt56ynwO3ZOwEjwiYjgTX9fLuTodxmwCsVio62rBswLInx482KLzPlWvFbVGTmKkk
 2cdHfbf78+8fcJ6uRnRmMPq3BvhJulAtYGKYolGKBL+kzOIdtETxZGPNsQB7CO1BAy2MFc16Wg
 YTSBu2dsIBSfF636J6Iu7UlUK2CHTo3beyosov5FUck1tEyM5HsjdH1SthgEcmAvq1JoNjdAP/
 +FY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Aug 2023 03:35:14 -0700
IronPort-SDR: KOVKgRIOdwS4BO3lsqpugBTkd8lyNcaw51WiBq0v9KquwQnDy4ZokNhqlP9JlUDowfndJe5AVd
 toKg9rHOgAI7lUQyMEgy7+hU84090XU5rV3pFjS2RIfwKagYEdfJUYish1tTxbPY1SEFfJi7H4
 +0E46EriSWAQ+6R1jAj3F5dvSjXl4JHGPU49t3WG2HIddJEJOvu4v/Vhm7lzQfSY+TeReDpOeF
 rfFWfZ+zwqLesdn6KHW/boyZPQ54qObYfJCN7+YXad1gxtIx13u2t93hDNafOE/01OLQsbQST9
 Cbg=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Aug 2023 04:21:40 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH nvme-cli v2] fabrics: Use corresponding hostid when hostnqn is generated
Date: Thu,  3 Aug 2023 20:21:39 +0900
Message-Id: <20230803112139.2116899-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_042145_278232_95A6C6A9 
X-CRM114-Status: GOOD (  13.89  )
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

After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
of existing host"), kernel ensures hostid and hostnqn maintain 1:1
mapping and "non 1:1 mapping will be rejected". This makes 'nvme
discover' and 'nvme connect' commands fail when they generate hostnqn,
since it does not use corresponding hostid.

To avoid the failures, prepare and use corresponding hostid to the
generated hostnqn, taking the hostid from the hostnqn string. Also add
checks for prepared hostnqn and hostid. If the hostid taken from the
generated hostnqn is different from the hostid from file, print a
warning message. Also, if the prepared hostnqn are inconsistent with the
prepared hostid, print a warning.

Link: https://lore.kernel.org/linux-nvme/l7vk7fnzltpmvkwujsbf2btrzip6wh7ug62iwa3totqcda25l6@siqx7tj6lt3l/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Moved the step to check hostnqn and hostid per review comment

 fabrics.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 14a91cc6..40aef693 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -689,6 +689,43 @@ static int nvme_read_volatile_config(nvme_root_t r)
 	return ret;
 }
 
+char *nvmf_hostid_from_hostnqn(const char *hostnqn)
+{
+	const char *uuid;
+
+	if (!hostnqn)
+		return NULL;
+
+	uuid = strstr(hostnqn, "uuid:");
+	if (!uuid)
+		return NULL;
+
+	return strdup(uuid + strlen("uuid:"));
+}
+
+void nvmf_check_hostid_and_hostnqn(const char *hostid, const char *hostnqn)
+{
+	char *hostid_from_file, *hostid_from_hostnqn;
+
+	if (!hostid)
+		return;
+
+	hostid_from_file = nvmf_hostid_from_file();
+	if (hostid_from_file && strcmp(hostid_from_file, hostid)) {
+		fprintf(stderr, "warning: use generated hostid instead of hostid file\n");
+		free(hostid_from_file);
+	}
+
+	if (!hostnqn)
+		return;
+
+	hostid_from_hostnqn = nvmf_hostid_from_hostnqn(hostnqn);
+	if (hostid_from_hostnqn && strcmp(hostid_from_hostnqn, hostid)) {
+		fprintf(stderr, "warning: use hostid which does not match uuid in hostnqn\n");
+		free(hostid_from_hostnqn);
+	}
+}
+
 int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char *subsysnqn = NVME_DISC_SUBSYS_NAME;
@@ -765,10 +802,13 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 	hostid_arg = hostid;
 	if (!hostnqn)
 		hostnqn = hnqn = nvmf_hostnqn_from_file();
-	if (!hostnqn)
+	if (!hostnqn) {
 		hostnqn = hnqn = nvmf_hostnqn_generate();
+		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
+	}
 	if (!hostid)
 		hostid = hid = nvmf_hostid_from_file();
+	nvmf_check_hostid_and_hostnqn(hostid, hostnqn);
 	h = nvme_lookup_host(r, hostnqn, hostid);
 	if (!h) {
 		ret = ENOMEM;
@@ -978,10 +1018,13 @@ int nvmf_connect(const char *desc, int argc, char **argv)
 
 	if (!hostnqn)
 		hostnqn = hnqn = nvmf_hostnqn_from_file();
-	if (!hostnqn)
+	if (!hostnqn) {
 		hostnqn = hnqn = nvmf_hostnqn_generate();
+		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
+	}
 	if (!hostid)
 		hostid = hid = nvmf_hostid_from_file();
+	nvmf_check_hostid_and_hostnqn(hostid, hostnqn);
 	h = nvme_lookup_host(r, hostnqn, hostid);
 	if (!h) {
 		errno = ENOMEM;
-- 
2.40.1


