Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E591C04A6A
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jul 2023 08:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ouhue5HJ72u/ul7KK5vmzGeximgQzpPt0WukpIsMq3Q=; b=sC2zwW+bB+2j/jo+r5YQSzAYr3
	mRNA/FqIo/FwAi63uBINcyG1joErQHhY1FvCWV0nGO8QWRuV8jZ5puev9aqycjOpCq3HUXp++9ugk
	aMi3bdQZOfQKD8G2lUEaHpLj6T9/c1EASWyAOqhAjEWPws+bzE0AQu4FVzeOA/W5Zc3LzXL9zyY6A
	lNXejqAQBD5jjxVwv/EpEesdG0Cc9fLKZdfrDeVYJ4Nyu2o6GzytDsVb4DA9herQdXYq3Yp9bMgrT
	laElOZeZMkajF8EYd3r6nbuR5xcI543lvTpUDfHHcx58b3fhgcVQPWSp/z8EKBs4ab2/fG2enwxd4
	VaLewnMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qODc7-006nBZ-1b;
	Tue, 25 Jul 2023 08:41:51 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qODc4-006n9e-0p
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jul 2023 08:41:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AC2F1F854;
	Tue, 25 Jul 2023 08:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690274506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ouhue5HJ72u/ul7KK5vmzGeximgQzpPt0WukpIsMq3Q=;
	b=QMGcbUi6ATI5HGyw7WRp0piklUvOSTR371myduF62Vx/l3rxRz0YkjtRlG91KDEIYxR19A
	YR/C8GJ03zR7ygfbsG6lJa8xc3n7/TTd7gA/LsN38R18/G4w7C0JHnlRufpn/6ONVMV5/G
	TL7pTcv931kzuMV69nxgxgNeOsmHqw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690274506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ouhue5HJ72u/ul7KK5vmzGeximgQzpPt0WukpIsMq3Q=;
	b=hkpsPfboW64vtesWwDFnySZ5YppM+XpCS8uWOwwykUy3oNpfT/ZiZP7b1S6TxBQilAj4LB
	Dl/7+lYixFidkAAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09B1A13342;
	Tue, 25 Jul 2023 08:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wVqhAcqKv2SYPgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 25 Jul 2023 08:41:46 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATH libnvme v1 2/2] fabrics: Do not pass disable_sqflow if not supported
Date: Tue, 25 Jul 2023 10:41:37 +0200
Message-ID: <20230725084137.16139-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725084137.16139-1-dwagner@suse.de>
References: <r3xuoptvmxqnbt6gi26b6av2jj4wbi3eixgd74lmdauxip63jt@pxmvqyljanjr>
 <20230725084137.16139-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_014148_439421_17C33B8D 
X-CRM114-Status: GOOD (  19.82  )
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

Only retry a connect attempt with disable_sqflow if the kernel
actually supports this option.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/nvme/fabrics.c | 85 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 2f26c2b7f39a..e2953e7ef2a4 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -227,6 +227,32 @@ static const struct nvme_fabric_options default_options = {
 	.trsvcid = true,
 };
 
+static const char *default_options_strings[] =
+{
+	"ctrl_loss_tmo",
+	"data_digest",
+	"disable_sqflow",
+	"discovery",
+	"duplicate_connect",
+	"fast_io_fail_tmo",
+	"hdr_digest",
+	"host_iface",
+	"host_traddr",
+	"hostid",
+	"hostnqn",
+	"keep_alive_tmo",
+	"nqn",
+	"nr_io_queues",
+	"nr_poll_queues",
+	"nr_write_queues",
+	"queue_size",
+	"reconnect_delay",
+	"tos",
+	"traddr",
+	"transport",
+	"trsvcid",
+};
+
 void nvmf_default_config(struct nvme_fabrics_config *cfg)
 {
 	memset(cfg, 0, sizeof(*cfg));
@@ -652,6 +678,62 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 		continue;		   \
 	}
 
+static bool nvme_check_default_option(const char *opt)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(default_options_strings); i++) {
+		if (!strcmp(opt, default_options_strings[i]))
+			return true;
+	}
+	return false;
+}
+
+static bool nvmf_check_option(const char *opt)
+{
+	char buf[0x1000], *options, *p, *v;
+	ssize_t len;
+	int fd;
+	bool supported = false;
+
+	fd = open(nvmf_dev, O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	len = read(fd, buf, sizeof(buf) - 1);
+	if (len < 0) {
+		if (errno == EINVAL) {
+			/*
+			 * Older Linux kernels don't allow reading from nvmf_dev
+			 * to get supported options, so use a default set
+			 */
+			supported = nvme_check_default_option(opt);
+		}
+
+		goto out_close;
+	}
+
+	buf[len] = '\0';
+	options = buf;
+	while ((p = strsep(&options, ",\n")) != NULL) {
+		if (!*p)
+			continue;
+		v = strsep(&p, "= ");
+		if (!v)
+			continue;
+
+		if (strcmp(opt, v))
+			continue;
+
+		supported = true;
+		break;
+	}
+
+out_close:
+	close(fd);
+	return supported;
+}
+
 static int nvmf_read_options(nvme_root_t r)
 {
 	char buf[0x1000], *options, *p, *v;
@@ -1038,7 +1120,8 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 	if (!ret)
 		return c;
 
-	if (errno == EINVAL && c->cfg.disable_sqflow) {
+	if (errno == EINVAL && c->cfg.disable_sqflow &&
+	    nvmf_check_option("disable_sqflow")) {
 		errno = 0;
 		/* disable_sqflow is unrecognized option on older kernels */
 		nvme_msg(h->r, LOG_INFO, "failed to connect controller, "
-- 
2.41.0


