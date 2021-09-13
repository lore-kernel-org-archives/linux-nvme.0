Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01117C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 09:48:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05F26101B
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 09:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B05F26101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AdDN4TR6SjrdUJPyccWkoo4leivF855UMzazV4hkrsc=; b=Os+0vhltTnxCCN
	38uko09xdh1gmWuHYLjcNk6tURwPitQjyWzOWcvmqHuIFAkmtRZqAOgNDlbXmPrfmoF/qj+1MjEO1
	6EiY2scv6GlcIZoDASNHQFSqDKLLpIdyt1w6qwvsUkWxG1uaXwR1PFvpwREmtrsebtf9WyGaR+4YO
	UqBDr4bI7eQBYpOsCA1fvOY6OSYlB8QlDL/8htB28zrkxUaVGFAPg5XC1g8OZCTMcKG3/l5KRbhNv
	xL61ts5I/eneyZFuMHpUInSP9Vfh4YaMmOR3Iv5EWs3vN92/NTOcFSM6CzcbZPo4j/14XRuu5DRZi
	7vWcwerofLsRaz0vUX4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPiZH-00183z-AO; Mon, 13 Sep 2021 09:48:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPiTW-0016iZ-Bm
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 09:42:08 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BBA891FFBF;
 Mon, 13 Sep 2021 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631526124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0OR7RBsgexqTS8TjnUrBvXwspW8QaKnmpzvCDV1RmpE=;
 b=cVp+E0l3EZ5LeviqA+megCP+wyOU0ZluY5uFMNoMF91Wh3ye6tggua/Tc4nVpzYB44qkqj
 mM00Wn8YSTbNWS44D7QXC81R4iK9L/s0XF1obVvOQDPE1lHoRyyQqH7x4DpuoLt8s5Q2E4
 fCBS/Dd3ucVM5fl5l2EF4FOF9RCOUKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631526124;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0OR7RBsgexqTS8TjnUrBvXwspW8QaKnmpzvCDV1RmpE=;
 b=n/prpmDX5uKUOhna+l0HOYjiWDnPQM4QmNVAePN3hUUxyKvyzBDNaC3LzRvWW5xAiT9EwR
 J/jrVpORlsKzLRDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id B536AA3B93;
 Mon, 13 Sep 2021 09:42:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id AFC62518E597; Mon, 13 Sep 2021 11:42:04 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH nvme-cli] nvme-connect: Add 'dhchap-secret' and 'dhchap-bidi'
 arguments
Date: Mon, 13 Sep 2021 11:42:01 +0200
Message-Id: <20210913094201.18729-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_024206_620434_79B6AFDD 
X-CRM114-Status: GOOD (  16.25  )
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

Add 'dhchap-secret' and 'dhchap-bidi' arguments for nvme-connect
to enable NVMe In-Band authentication.
This is the nvme-cli patch to support NVMe In-band authentication as posted
on the linux-nvme mailinglist.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 Documentation/nvme-connect.txt | 14 ++++++++++++++
 fabrics.c                      | 29 ++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/nvme-connect.txt b/Documentation/nvme-connect.txt
index 4d7bb52..8cfc34e 100644
--- a/Documentation/nvme-connect.txt
+++ b/Documentation/nvme-connect.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 		[--host-iface=<iface>     | -f <iface>]
 		[--hostnqn=<hostnqn>      | -q <hostnqn>]
 		[--hostid=<hostid>        | -I <hostid>]
+		[--dhchap-secret=<secret> | -S <secret>]
 		[--nr-io-queues=<#>       | -i <#>]
 		[--nr-write-queues=<#>    | -W <#>]
 		[--nr-poll-queues=<#>     | -P <#>]
@@ -28,6 +29,7 @@ SYNOPSIS
 		[--disable-sqflow         | -d]
 		[--hdr-digest             | -g]
 		[--data-digest            | -G]
+		[--dhchap-bidi            | -B]
 
 DESCRIPTION
 -----------
@@ -92,6 +94,14 @@ OPTIONS
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
 -i <#>::
 --nr-io-queues=<#>::
 	Overrides the default number of I/O queues create by the driver.
@@ -140,6 +150,10 @@ OPTIONS
 --data-digest::
 	Generates/verifies data digest (TCP).
 
+-B::
+--dhchap-bidi::
+	Enable bidirectional authentication (TCP).
+
 EXAMPLES
 --------
 * Connect to a subsystem named nqn.2014-08.com.example:nvme:nvm-subsystem-sn-d78432
diff --git a/fabrics.c b/fabrics.c
index b132546..d1386c3 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -60,6 +60,7 @@ static const char *nvmf_htraddr		= "host traddr (e.g. FC WWN's)";
 static const char *nvmf_hiface		= "host interface (for tcp transport)";
 static const char *nvmf_hostnqn		= "user-defined hostnqn";
 static const char *nvmf_hostid		= "user-defined hostid (if default not used)";
+static const char *nvmf_hostkey		= "user-defined hostkey (if default not used)";
 static const char *nvmf_nr_io_queues	= "number of io queues to use (default is core count)";
 static const char *nvmf_nr_write_queues	= "number of write queues to use (default 0)";
 static const char *nvmf_nr_poll_queues	= "number of poll queues to use (default 0)";
@@ -72,6 +73,7 @@ static const char *nvmf_dup_connect	= "allow duplicate connections between same
 static const char *nvmf_disable_sqflow	= "disable controller sq flow control (default false)";
 static const char *nvmf_hdr_digest	= "enable transport protocol header digest (TCP transport)";
 static const char *nvmf_data_digest	= "enable transport protocol data digest (TCP transport)";
+static const char *nvmf_dhchap_bidi	= "enable bidirectional authentication (TCP transport)";
 static const char *nvmf_config_file	= "Use specified JSON configuration file or 'none' to disable";
 
 #define NVMF_OPTS(c)									\
@@ -82,6 +84,7 @@ static const char *nvmf_config_file	= "Use specified JSON configuration file or
 	OPT_STRING("host-iface",      'f', "STR", &host_iface,	nvmf_hiface), \
 	OPT_STRING("hostnqn",         'q', "STR", &hostnqn,	nvmf_hostnqn), \
 	OPT_STRING("hostid",          'I', "STR", &hostid,	nvmf_hostid), \
+	OPT_STRING("dhchap-secret",   'S', "STR", &hostkey,	nvmf_hostkey), \
 	OPT_INT("nr-io-queues",       'i', &c.nr_io_queues,       nvmf_nr_io_queues),	\
 	OPT_INT("nr-write-queues",    'W', &c.nr_write_queues,    nvmf_nr_write_queues),\
 	OPT_INT("nr-poll-queues",     'P', &c.nr_poll_queues,     nvmf_nr_poll_queues),	\
@@ -93,8 +96,8 @@ static const char *nvmf_config_file	= "Use specified JSON configuration file or
 	OPT_FLAG("duplicate-connect", 'D', &c.duplicate_connect,  nvmf_dup_connect),	\
 	OPT_FLAG("disable-sqflow",    'd', &c.disable_sqflow,     nvmf_disable_sqflow),	\
 	OPT_FLAG("hdr-digest",        'g', &c.hdr_digest,         nvmf_hdr_digest),	\
-	OPT_FLAG("data-digest",       'G', &c.data_digest,        nvmf_data_digest)     \
-
+	OPT_FLAG("data-digest",       'G', &c.data_digest,        nvmf_data_digest), \
+	OPT_FLAG("dhchap-bidi",       'B', &c.dhchap_bidi,        nvmf_dhchap_bidi)
 
 static void space_strip_len(int max, char *str)
 {
@@ -296,7 +299,7 @@ static int discover_from_conf_file(nvme_host_t h, const char *desc,
 {
 	char *transport = NULL, *traddr = NULL, *trsvcid = NULL;
 	char *host_traddr = NULL, *host_iface = NULL;
-	char *hostnqn = NULL, *hostid = NULL;
+	char *hostnqn = NULL, *hostid = NULL, *hostkey = NULL;
 	char *ptr, **argv, *p, line[4096];
 	int argc, ret = 0;
 	FILE *f;
@@ -369,10 +372,10 @@ out:
 int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char *nqn = NVME_DISC_SUBSYS_NAME;
-	char *hostnqn = NULL, *hostid = NULL;
+	char *hostnqn = NULL, *hostid = NULL, *hostkey = NULL;
 	char *host_traddr = NULL, *host_iface = NULL;
 	char *transport = NULL, *traddr = NULL, *trsvcid = NULL;
-	char *hnqn = NULL, *hid = NULL;
+	char *hnqn = NULL, *hid = NULL, *hkey = NULL;
 	char *config_file = PATH_NVMF_CONFIG;
 	enum nvme_print_flags flags;
 	nvme_root_t r;
@@ -434,6 +437,8 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 		hostnqn = hnqn = nvmf_hostnqn_from_file();
 	if (!hostid)
 		hostid = hid = nvmf_hostid_from_file();
+	if (!hostkey)
+		hostkey = hkey = nvmf_hostkey_from_file();
 	h = nvme_lookup_host(r, hostnqn, hostid);
 	if (!h) {
 		ret = ENOMEM;
@@ -445,6 +450,8 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 		else if (!strncmp(device, "/dev/", 5))
 			device += 5;
 	}
+	if (hostkey)
+		nvme_host_set_hostkey(h, hostkey);
 
 	if (!device && !transport && !traddr) {
 		ret = discover_from_conf_file(h, desc, connect, &cfg);
@@ -520,6 +527,8 @@ out_free:
 		free(hnqn);
 	if (hid)
 		free(hid);
+	if (hkey)
+		free(hkey);
 	nvme_free_tree(r);
 
 	return ret;
@@ -527,11 +536,11 @@ out_free:
 
 int nvmf_connect(const char *desc, int argc, char **argv)
 {
-	char *hnqn = NULL, *hid = NULL;
+	char *hnqn = NULL, *hid = NULL, *hkey = NULL;
 	char *subsysnqn = NULL;
 	char *transport = NULL, *traddr = NULL;
 	char *host_traddr = NULL, *host_iface = NULL;
-	char *trsvcid = NULL, *hostnqn = NULL, *hostid = NULL;
+	char *trsvcid = NULL, *hostnqn = NULL, *hostid = NULL, *hostkey = NULL;
 	char *config_file = PATH_NVMF_CONFIG;
 	unsigned int verbose = 0;
 	nvme_root_t r;
@@ -599,11 +608,15 @@ int nvmf_connect(const char *desc, int argc, char **argv)
 		hostnqn = hnqn = nvmf_hostnqn_from_file();
 	if (!hostid)
 		hostid = hid = nvmf_hostid_from_file();
+	if (!hostkey)
+		hostkey = hkey = nvmf_hostkey_from_file();
 	h = nvme_lookup_host(r, hostnqn, hostid);
 	if (!h) {
 		errno = ENOMEM;
 		goto out_free;
 	}
+	if (hostkey)
+		nvme_host_set_hostkey(h, hostkey);
 	c = nvme_create_ctrl(subsysnqn, transport, traddr,
 			     host_traddr, host_iface, trsvcid);
 	if (!c) {
@@ -620,6 +633,8 @@ out_free:
 		free(hnqn);
 	if (hid)
 		free(hid);
+	if (hkey)
+		free(hkey);
 	nvme_free_tree(r);
 	return errno;
 }
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
