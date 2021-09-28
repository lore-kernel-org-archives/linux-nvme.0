Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99913C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 12:34:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595F061159
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 12:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 595F061159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Zx7URaILBK3KfSN0SKMJfYJRUK8sFyv95zp/l8Rimow=; b=IJLkrgpOnqeAvc
	/O/oWIhs6cE8ftRgiBbx4tP9GfOgQpL/vNqPutkyWg+oaMdz/qC57dWmWuZfgNJX2XafahRFbMXZZ
	CeeD6I7Oc1WteMZtEQNdYXJH5efUAgZJdSb3B2ENIuovKHXQdDYlsZZKOtXjP/cd86N5OscJCQopE
	RSN3s87Y4ZtqKyDQ/S5jBHbNXxTZeDGvH5UKMNiSCFFhLZV6MDy7upyfg6Vas4SDop1I6wNgxdblp
	2hUsoqOs1V3AZVWNB1FR30Cl6uMzpS52br7NJDAVYA39N+zeP2jykaLMwmVtrqYXjHRTElDMqHoj1
	wpDM2zQEkU8jfVAbbMXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVCJ4-0079Ax-Jk; Tue, 28 Sep 2021 12:33:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVCBY-00769Y-LD
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 12:26:14 +0000
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id B6CBF220EB;
 Tue, 28 Sep 2021 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632831970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hM5YldtK1iGt5pLHE5nN4NDqATXuJNCKZSXrCNlrCVQ=;
 b=HJmzkHzCwLrUFZzDUr22Rr4EeXrwHQmotU4zbIuygCPESB4P+JNIJ+F1Lib6//1HaIBgJg
 6t6FM+hroXIRnQzb7xNo2yHu+gjnaWox6hRghKXmVCkV19c5X5vnVBhQNs3CQUGne7+S1C
 KGndLTZV0CDl10nWdRdOmSL47HuUoRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632831970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hM5YldtK1iGt5pLHE5nN4NDqATXuJNCKZSXrCNlrCVQ=;
 b=QioN5iqLWL2ZHh27izA/HcVf0pFxHV2u+2BTMs/ngsiHZAzX8bSTAWIC2c+LWoNyGLjz+/
 PEySqy1jAyEW6oCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay1.suse.de (Postfix) with ESMTP id AFC9825D4D;
 Tue, 28 Sep 2021 12:26:10 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id A3CF8518EE63; Tue, 28 Sep 2021 14:26:10 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH nvme-cli] nvme-connect: Add 'dhchap-secret' and
 'dhchap-ctrl-secret' arguments
Date: Tue, 28 Sep 2021 14:25:59 +0200
Message-Id: <20210928122559.46896-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_052612_893569_488567D2 
X-CRM114-Status: GOOD (  15.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add 'dhchap-secret' and 'dhchap-ctrl-secret' arguments for nvme-connect
to enable NVMe In-Band authentication.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 Documentation/nvme-connect.txt | 17 +++++++++++++++++
 fabrics.c                      | 17 ++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/nvme-connect.txt b/Documentation/nvme-connect.txt
index 4d7bb52..489adf7 100644
--- a/Documentation/nvme-connect.txt
+++ b/Documentation/nvme-connect.txt
@@ -17,6 +17,8 @@ SYNOPSIS
 		[--host-iface=<iface>     | -f <iface>]
 		[--hostnqn=<hostnqn>      | -q <hostnqn>]
 		[--hostid=<hostid>        | -I <hostid>]
+		[--dhchap-secret=<secret> | -S <secret>]
+		[--dhchap-ctrl-secret=<secret> | -C <secret>]
 		[--nr-io-queues=<#>       | -i <#>]
 		[--nr-write-queues=<#>    | -W <#>]
 		[--nr-poll-queues=<#>     | -P <#>]
@@ -92,6 +94,21 @@ OPTIONS
 	UUID(Universally Unique Identifier) to be discovered which should be
 	formatted.
 
+-S <secret>::
+--dhchap-secret=<secret>::
+	NVMe In-band authentication secret; needs to be in ASCII format as
+	specified in NVMe 2.0 section 8.13.5.8 'Secret representation'.
+	If this option is not specified, the default is read from
+	/etc/nvme/hostkey. If that does not exist no in-band authentication
+	is attempted.
+
+-C <secret>::
+--dhchap-ctrl-secret=<secret>::
+	NVMe In-band authentication controller secret for bi-directional
+	authentication; needs to be in ASCII format as
+	specified in NVMe 2.0 section 8.13.5.8 'Secret representation'.
+	If not present bi-directional authentication is not attempted.
+
 -i <#>::
 --nr-io-queues=<#>::
 	Overrides the default number of I/O queues create by the driver.
diff --git a/fabrics.c b/fabrics.c
index 012bcb8..8ed618e 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -60,6 +60,8 @@ static const char *nvmf_htraddr		= "host traddr (e.g. FC WWN's)";
 static const char *nvmf_hiface		= "host interface (for tcp transport)";
 static const char *nvmf_hostnqn		= "user-defined hostnqn";
 static const char *nvmf_hostid		= "user-defined hostid (if default not used)";
+static const char *nvmf_hostkey		= "user-defined dhchap key (if default not used)";
+static const char *nvmf_ctrlkey		= "user-defined dhchap controller key (for bi-directional authentication)";
 static const char *nvmf_nr_io_queues	= "number of io queues to use (default is core count)";
 static const char *nvmf_nr_write_queues	= "number of write queues to use (default 0)";
 static const char *nvmf_nr_poll_queues	= "number of poll queues to use (default 0)";
@@ -82,6 +84,8 @@ static const char *nvmf_config_file	= "Use specified JSON configuration file or
 	OPT_STRING("host-iface",      'f', "STR", &host_iface,	nvmf_hiface), \
 	OPT_STRING("hostnqn",         'q', "STR", &hostnqn,	nvmf_hostnqn), \
 	OPT_STRING("hostid",          'I', "STR", &hostid,	nvmf_hostid), \
+	OPT_STRING("dhchap-secret",   'S', "STR", &hostkey,	nvmf_hostkey), \
+	OPT_STRING("dhchap-ctrl-secret", 'C', "STR", &ctrlkey,	nvmf_ctrlkey), \
 	OPT_INT("nr-io-queues",       'i', &c.nr_io_queues,       nvmf_nr_io_queues),	\
 	OPT_INT("nr-write-queues",    'W', &c.nr_write_queues,    nvmf_nr_write_queues),\
 	OPT_INT("nr-poll-queues",     'P', &c.nr_poll_queues,     nvmf_nr_poll_queues),	\
@@ -93,7 +97,7 @@ static const char *nvmf_config_file	= "Use specified JSON configuration file or
 	OPT_FLAG("duplicate-connect", 'D', &c.duplicate_connect,  nvmf_dup_connect),	\
 	OPT_FLAG("disable-sqflow",    'd', &c.disable_sqflow,     nvmf_disable_sqflow),	\
 	OPT_FLAG("hdr-digest",        'g', &c.hdr_digest,         nvmf_hdr_digest),	\
-	OPT_FLAG("data-digest",       'G', &c.data_digest,        nvmf_data_digest)     \
+	OPT_FLAG("data-digest",       'G', &c.data_digest,        nvmf_data_digest)	\
 
 
 static void space_strip_len(int max, char *str)
@@ -296,7 +300,7 @@ static int discover_from_conf_file(nvme_host_t h, const char *desc,
 {
 	char *transport = NULL, *traddr = NULL, *trsvcid = NULL;
 	char *host_traddr = NULL, *host_iface = NULL;
-	char *hostnqn = NULL, *hostid = NULL;
+	char *hostnqn = NULL, *hostid = NULL, *hostkey = NULL, *ctrlkey = NULL;
 	char *ptr, **argv, *p, line[4096];
 	int argc, ret = 0;
 	unsigned int verbose = 0;
@@ -383,7 +387,7 @@ out:
 int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char *nqn = NVME_DISC_SUBSYS_NAME;
-	char *hostnqn = NULL, *hostid = NULL;
+	char *hostnqn = NULL, *hostid = NULL, *hostkey = NULL, *ctrlkey = NULL;
 	char *host_traddr = NULL, *host_iface = NULL;
 	char *transport = NULL, *traddr = NULL, *trsvcid = NULL;
 	char *hnqn = NULL, *hid = NULL;
@@ -459,6 +463,8 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 		else if (!strncmp(device, "/dev/", 5))
 			device += 5;
 	}
+	if (hostkey)
+		nvme_host_set_dhchap_key(h, hostkey);
 
 	if (!device && !transport && !traddr) {
 		ret = discover_from_conf_file(h, desc, connect, &cfg);
@@ -546,6 +552,7 @@ int nvmf_connect(const char *desc, int argc, char **argv)
 	char *transport = NULL, *traddr = NULL;
 	char *host_traddr = NULL, *host_iface = NULL;
 	char *trsvcid = NULL, *hostnqn = NULL, *hostid = NULL;
+	char *hostkey = NULL, *ctrlkey = NULL;
 	char *config_file = PATH_NVMF_CONFIG;
 	unsigned int verbose = 0;
 	nvme_root_t r;
@@ -618,12 +625,16 @@ int nvmf_connect(const char *desc, int argc, char **argv)
 		errno = ENOMEM;
 		goto out_free;
 	}
+	if (hostkey)
+		nvme_host_set_dhchap_key(h, hostkey);
 	c = nvme_create_ctrl(subsysnqn, transport, traddr,
 			     host_traddr, host_iface, trsvcid);
 	if (!c) {
 		errno = ENOMEM;
 		goto out_free;
 	}
+	if (ctrlkey)
+		nvme_ctrl_set_dhchap_key(c, ctrlkey);
 
 	errno = 0;
 	ret = nvmf_add_ctrl(h, c, &cfg, cfg.disable_sqflow);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
