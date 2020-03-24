Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE867C41621
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 08:53:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE6E20836
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oC4t6qxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE6E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1++I7/eyZUe2cOrRSf+3co4fJqgYeb1k3qJWERZU5UU=; b=oC4t6qxgFNGeoc
	Q8T0BMCH6xpYyuXZO9khjx2W1x0czrpL0ZpfmhdyeEClAA136gvglZQcgo/1BYpwm0vNqIHL1iVGx
	G/euCUVMMIedGs0aLcxGSD9P//fL0dLm5qAuKsiGvE8eA/c9JmyOu5voCzjV61Oi4MnEH/OogTJ8z
	rQNRCIaXqr514CvWJGG5NUj9gL5so8j4tXGWiF1wtJShFwTBUN9z2NfhIR8Rnb7HZgz4TJqHVeegt
	YkS85JalGHrYMPnBZ0pt5Cytgy8Bn8kziTBVggnzLz2BQjpKUZMRFVPSXt/F9vLz12MPmYINNpmR/
	EPcK5/VUxrX4l5YFdtXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGfJW-0007Kz-96; Tue, 24 Mar 2020 08:53:34 +0000
Received: from [2601:647:4802:9070:45a4:15de:f2dc:1149]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGfJT-0007II-7v; Tue, 24 Mar 2020 08:53:31 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvmf: use discovery controller host identifiers for
 persistent controllers
Date: Tue, 24 Mar 2020 01:53:28 -0700
Message-Id: <20200324085328.23387-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324085328.23387-1-sagi@grimberg.me>
References: <20200324085328.23387-1-sagi@grimberg.me>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

It is possible that the user will create a persistent discovery controller
with a specific host identifiers (hostnqn and/or hostid). If we get a discovery
change log event on this discovery controller we need to use the same host
identifiers that otherwise we will may not see what the discovery change log
event intended us to see (as we connect with a different hostnqn for example).

Note that we take these identifiers only if they exist in sysfs which gives us
backward compatibility (as hostnqn and hostid are still new).

Reported-by: Yogev Cohen <yogev@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index a112f76c146c..e2c9bfb37177 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1079,6 +1079,16 @@ static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 	return ret;
 }
 
+static void nvmf_get_host_identifiers(int ctrl_instance)
+{
+	char *path;
+
+	if (asprintf(&path, "%s/nvme%d", SYS_NVME, ctrl_instance) < 0)
+		return;
+	cfg.hostnqn = nvme_get_ctrl_attr(path, "hostnqn");
+	cfg.hostid = nvme_get_ctrl_attr(path, "hostid");
+}
+
 static int do_discover(char *argstr, bool connect)
 {
 	struct nvmf_disc_rsp_page_hdr *log = NULL;
@@ -1117,10 +1127,12 @@ static int do_discover(char *argstr, bool connect)
 		free(cargs.host_traddr);
 	}
 
-	if (!cfg.device)
+	if (!cfg.device) {
 		instance = add_ctrl(argstr);
-	else
+	} else {
 		instance = ctrl_instance(cfg.device);
+		nvmf_get_host_identifiers(instance);
+	}
 	if (instance < 0)
 		return instance;
 
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
