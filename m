Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3448C11D2F
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:00:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89382084E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GwiaNSya";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z2GjKilb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89382084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qzM1/xDcI+CIKHfz0qLRFTH4WhxYlBppAfMhZ4r9gp4=; b=GwiaNSya8dnilq
	UGfArOZHBHa9XYFDAbGDwysjGxeshEoXFKoZkdXxquOTXYD8KGzprGv5HCi1cbM7rPwxLAr8Cteug
	5QoQeDBF+wbtmjbDSEEsKtk4lek4Wn5ygAwGAJVf+UdtZfbJjoPHdPECX70EPaH5SJUkMXJtEmcMJ
	lDusDaFkMZWiLg6NMy3YEzv+MQGWEr6Yf6tob52lqMXts1oRyFgPIoTLmNIY/ETJqSZZeMN60cIhD
	pONMw7hDO8QV1eq/a3SEORsbQ+Kd00W4XMxbr0OnKx+p7qeSspSh9XEQmuKXjzgog4WkZnCc5yJC4
	aeyPZbQD+o9seVW52ihg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6I1n-0004D9-Rf; Mon, 24 Feb 2020 18:00:23 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6Gro-0001N0-VZ
 for linux-nvme@bombadil.infradead.org; Mon, 24 Feb 2020 16:46:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=TSy4rlqPJBWBM0xWdcwPggUN4jK7UV4ZHfGccNrHvLE=; b=Z2GjKilbhjWq0CeihmDIWVJ8qM
 CWBJodzuhaGpoVsseRboCPmiMfRRUAXSL54Lb3oVejpah1oYUdbgbAjdDis66tkilpS/hozgwrItx
 dg+zfuLbxFBXu72Pp0bwNXyACGXIi5enhhJhT/lF6QOrb6xaOY8BbT77UlmnSP3uR10WGcbRBrMz3
 A1O+jOvcxLLaapHr1Y6TqQ1ogWsxzSGqax75FbigsfkmLt7u5GYVkYkC9P/f7rnPsyD2JbDhNfcg9
 il/zhGEbEu9LG4K+eq78EHTidF6sIwhBrpr3Ui8EYZ3YY2sTf5bMpkc8cV1i4w6/x9Bs4J7t1/V+o
 P5Bo4Pnw==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6Grl-0002EZ-EE
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 16:46:00 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 24 Feb 2020 18:45:45 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01OGji9M013647;
 Mon, 24 Feb 2020 18:45:44 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 linux-rdma@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
 martin.petersen@oracle.com
Subject: [PATCH] nvme-cli/fabrics: Add pi_enable param to connect cmd
Date: Mon, 24 Feb 2020 18:45:25 +0200
Message-Id: <20200224164544.219438-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200224164544.219438-1-maxg@mellanox.com>
References: <20200224164544.219438-1-maxg@mellanox.com>
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Added 'pi_enable' to 'connect' command so users can enable metadata support.

usage examples:
nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
nvme connect -p -t rdma -a 10.0.1.1 -n test_nvme

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 fabrics.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 8982ae4..b22ea14 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -72,6 +72,7 @@ static struct config {
 	int  disable_sqflow;
 	int  hdr_digest;
 	int  data_digest;
+	int  pi_enable;
 	bool persistent;
 	bool quiet;
 } cfg = { NULL };
@@ -756,7 +757,9 @@ static int build_options(char *argstr, int max_len, bool discover)
 	    add_bool_argument(&argstr, &max_len, "disable_sqflow",
 				cfg.disable_sqflow) ||
 	    add_bool_argument(&argstr, &max_len, "hdr_digest", cfg.hdr_digest) ||
-	    add_bool_argument(&argstr, &max_len, "data_digest", cfg.data_digest))
+	    add_bool_argument(&argstr, &max_len, "data_digest",
+				cfg.data_digest) ||
+	    add_bool_argument(&argstr, &max_len, "pi_enable", cfg.pi_enable))
 		return -EINVAL;
 
 	return 0;
@@ -885,6 +888,13 @@ retry:
 		p += len;
 	}
 
+	if (cfg.pi_enable) {
+		len = sprintf(p, ",pi_enable");
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	switch (e->trtype) {
 	case NVMF_TRTYPE_RDMA:
 	case NVMF_TRTYPE_TCP:
@@ -1171,6 +1181,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		OPT_INT("tos",             'T', &cfg.tos,             "type of service"),
 		OPT_FLAG("hdr_digest",     'g', &cfg.hdr_digest,      "enable transport protocol header digest (TCP transport)"),
 		OPT_FLAG("data_digest",    'G', &cfg.data_digest,     "enable transport protocol data digest (TCP transport)"),
+		OPT_FLAG("pi_enable",      'p', &cfg.pi_enable,       "enable metadata (T10-PI) support (default false)"),
 		OPT_INT("nr-io-queues",    'i', &cfg.nr_io_queues,    "number of io queues to use (default is core count)"),
 		OPT_INT("nr-write-queues", 'W', &cfg.nr_write_queues, "number of write queues to use (default 0)"),
 		OPT_INT("nr-poll-queues",  'P', &cfg.nr_poll_queues,  "number of poll queues to use (default 0)"),
@@ -1231,6 +1242,7 @@ int connect(const char *desc, int argc, char **argv)
 		OPT_FLAG("disable-sqflow",    'd', &cfg.disable_sqflow,    "disable controller sq flow control (default false)"),
 		OPT_FLAG("hdr-digest",        'g', &cfg.hdr_digest,        "enable transport protocol header digest (TCP transport)"),
 		OPT_FLAG("data-digest",       'G', &cfg.data_digest,       "enable transport protocol data digest (TCP transport)"),
+		OPT_FLAG("pi_enable",         'p', &cfg.pi_enable,         "enable metadata (T10-PI) support (default false)"),
 		OPT_END()
 	};
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
