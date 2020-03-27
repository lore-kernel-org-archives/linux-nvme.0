Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BBEC43331
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:19:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE06206DB
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ieARGiD+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jNeNRAJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE06206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M3gGSydTL1RI1JDRIM9N/9MEMsaGpyTHw2503cxIOeA=; b=ieARGiD+T4OVCG
	Z7PRID0usUvrNXPIdh25DMRY8T+yoMiceQ+XeWTBySShDgW47PTmVW+oDmQAhtVhgvfEJdrrMQTE4
	Jq/8w2p/bIglW5GNfhMN8zrFvv4I1pRgB9Ba21/3c8wpWcyF+Q7PKq2GyBg3UbfErRQlVgz6a3/X6
	frvLQCXaR6hmBAj9OQiIzMt0ItE+hMh/hZ/Ne7PjX0xb5OMoImTNoHSNhcaqQrYVrINKaDVPrkZ69
	CsASzQ4C/gdYYojQRxFQltxI0D5MCTcD33SuLbzjX6wQ+jIxRL6ko+lyISBWC3wQUKst8yX/hTDJ1
	Lx1WtGx5Hq0vjNIov1jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHse0-0002o5-RT; Fri, 27 Mar 2020 17:19:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaV-00086I-CF
 for linux-nvme@bombadil.infradead.org; Fri, 27 Mar 2020 17:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ABEOv9NOfEzp+nizJZV8tR2XojLLhtJAcOmi7BUi+vk=; b=jNeNRAJw5B8rm26rg/PEfZ7jy1
 Bp+f6ZF8dDLfewbEQrZqIOcnSqkifZ8dyMlnX7DWS58O0uqU71hevoSrRc/pcqPsjOWpB8MJlqrXQ
 GEpcOU4m9ejyJLQKT7TIqOFaV5c4ZC7sfEbmU471cEzDxgfO39/T0ki1TCCOgPe0THL8tQSEH89W4
 TONpWbSHcZGpxqjMtl8NhNt0vbc0hG1/+A1bNHLQ7Pn1IBeI49DXc2yOW0a0YkbN5BcnnWWNCkjZQ
 zuS5DEaWDYJJfRGDoyhPz0hmXh5HS3A7+NoVx19yehyX05GfCE8XA6zVOkaKPEzLSxLj5QFwVfTW8
 ua3T71PQ==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by casper.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaN-0005Do-9Z
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 17:16:06 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:46 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjj3004869;
 Fri, 27 Mar 2020 20:15:46 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
 linux-rdma@vger.kernel.org
Subject: [PATCH 1/1] nvme-cli/fabrics: Add pi_enable param to connect cmd
Date: Fri, 27 Mar 2020 20:15:28 +0300
Message-Id: <20200327171545.98970-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200327_171600_103046_0C828F93 
X-CRM114-Status: GOOD (  11.50  )
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
 israelr@mellanox.com, idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com,
 maxg@mellanox.com
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
index a112f76..1b5b3f7 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -78,6 +78,7 @@ static struct config {
 	int  disable_sqflow;
 	int  hdr_digest;
 	int  data_digest;
+	int  pi_enable;
 	bool persistent;
 	bool quiet;
 } cfg = { NULL };
@@ -851,7 +852,9 @@ static int build_options(char *argstr, int max_len, bool discover)
 	    add_bool_argument(&argstr, &max_len, "disable_sqflow",
 				cfg.disable_sqflow) ||
 	    add_bool_argument(&argstr, &max_len, "hdr_digest", cfg.hdr_digest) ||
-	    add_bool_argument(&argstr, &max_len, "data_digest", cfg.data_digest))
+	    add_bool_argument(&argstr, &max_len, "data_digest",
+				cfg.data_digest) ||
+	    add_bool_argument(&argstr, &max_len, "pi_enable", cfg.pi_enable))
 		return -EINVAL;
 
 	return 0;
@@ -980,6 +983,13 @@ retry:
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
@@ -1259,6 +1269,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		OPT_INT("tos",             'T', &cfg.tos,             "type of service"),
 		OPT_FLAG("hdr_digest",     'g', &cfg.hdr_digest,      "enable transport protocol header digest (TCP transport)"),
 		OPT_FLAG("data_digest",    'G', &cfg.data_digest,     "enable transport protocol data digest (TCP transport)"),
+		OPT_FLAG("pi_enable",      'p', &cfg.pi_enable,       "enable metadata (T10-PI) support (default false)"),
 		OPT_INT("nr-io-queues",    'i', &cfg.nr_io_queues,    "number of io queues to use (default is core count)"),
 		OPT_INT("nr-write-queues", 'W', &cfg.nr_write_queues, "number of write queues to use (default 0)"),
 		OPT_INT("nr-poll-queues",  'P', &cfg.nr_poll_queues,  "number of poll queues to use (default 0)"),
@@ -1319,6 +1330,7 @@ int connect(const char *desc, int argc, char **argv)
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
