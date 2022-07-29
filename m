Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCF1C00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n+jqLIA0nj3yyAUrz5z+A6Qfny+BInBWCrGx2cyZMLM=; b=CXdA1aWXm3WMknIsh4XHKED1hc
	LHN+XWSPDTgjxlSDrWhWmQ3+GBoIG7gN5mxvNYST1KJ5IhwK/6aZJh4wVgPzZ+/IW0kbi7E3VN22L
	SfaqMYFUEPnu9tuOFDoUO4TgoLOVveegReWRFDZR1nITn5h/VGbWExb4jrfH0UNJ/dy7W1cwgvtDX
	wHiiuO0FikE07Pu5WCQNrPXStW68L9CkerCj+/4sA+vRAxrTOvq3b5hiyGlruxAL6fS2QtL2d2j49
	Y8WKMeH7pRyQCa4SN4wgEvfiIcqVqGkiFqBHRBQaww1Dlnun2lGi9pd7qLn9fpR9WOQXbcdqqP5YH
	kxTWgtTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHQwq-005VFU-QV; Fri, 29 Jul 2022 14:26:40 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHQwn-005VCL-81
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 14:26:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E3AD2105C;
	Fri, 29 Jul 2022 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1659104792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n+jqLIA0nj3yyAUrz5z+A6Qfny+BInBWCrGx2cyZMLM=;
	b=fZIjFcMXPjeULoTGT/qleyAea9yg1lk0MZFBrFxZwY0Gbih6Vj/wrurxZTCf3HRb9DrkEc
	MvdXTHNyIeqSCDqAWLFf5AkzjlsOLD0OmXDIyiYsfwF5/CDMr9V2Djvf20k2zjEsHsAnHc
	0DqzUrVFSfDqpw/mbttnhk1LDKLTkPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1659104792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n+jqLIA0nj3yyAUrz5z+A6Qfny+BInBWCrGx2cyZMLM=;
	b=mmYZxgbPQxFDc4UFJef3/BP2IbKaTh1biSi0FlG3MqHoTgn1vn+Jfi1UZZZWyy0Yq42xBK
	D5N8n8t00vJLfBCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3196013A1B;
	Fri, 29 Jul 2022 14:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ussIDBju42KYZQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 29 Jul 2022 14:26:32 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3] nvme: consider also host_iface when checking ip options
Date: Fri, 29 Jul 2022 16:26:30 +0200
Message-Id: <20220729142630.13504-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_072637_485602_141BF5F2 
X-CRM114-Status: GOOD (  12.99  )
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

It's perfectly fine to use the same traddr and trsvcid more than once
as long we use different host interface. This is used in setups where
the host has more than one interface but the target exposes only one
traddr/trsvcid combination.

Use the same acceptance rules for host_iface as we have for
host_traddr.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

tw:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f enp1s0
tw:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f enp1s0
Failed to write to /dev/nvme-fabrics: Operation already in progress
no controller found: failed to write to nvme-fabrics device
tw:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 
tw:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f enp7s0
tw:~ # nvme list-subsys
nvme-subsys0 - NQN=nvmet-test
\
 +- nvme0 tcp traddr=192.168.19.54,trsvcid=4420,host_iface=enp1s0 live optimized
 +- nvme1 tcp traddr=192.168.19.54,trsvcid=4420 live optimized
 +- nvme2 tcp traddr=192.168.19.54,trsvcid=4420,host_iface=enp7s0 live optimized

changes:
v3: same check rules as for local address
v2: added NVMF_OPT_HOST_TRADDR checks but to strict
v1: initial version

 drivers/nvme/host/fabrics.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5207a2348257..2d948bcc31e0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -965,13 +965,17 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		return false;
 
 	/*
-	 * Checking the local address is rough. In most cases, none is specified
-	 * and the host port is selected by the stack.
+	 * Checking the local address or host interfaces is rough.
+	 *
+	 * In most cases, none is specified and the host port or
+	 * host interface is selected by the stack.
 	 *
 	 * Assume no match if:
-	 * -  local address is specified and address is not the same
-	 * -  local address is not specified but remote is, or vice versa
-	 *    (admin using specific host_traddr when it matters).
+	 * -  local address or host interface is specified and address
+	 *    or host interface is not the same
+	 * -  local address or host interface is not specified but
+	 *    remote is, or vice versa (admin using specific
+	 *    host_traddr/host_iface when it matters).
 	 */
 	if ((opts->mask & NVMF_OPT_HOST_TRADDR) &&
 	    (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)) {
@@ -982,6 +986,15 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		return false;
 	}
 
+	if ((opts->mask & NVMF_OPT_HOST_IFACE) &&
+	    (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)) {
+		if (strcmp(opts->host_iface, ctrl->opts->host_iface))
+			return false;
+	} else if ((opts->mask & NVMF_OPT_HOST_IFACE) ||
+		   (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)) {
+		return false;
+	}
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvmf_ip_options_match);
-- 
2.37.1


