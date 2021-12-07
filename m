Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4C3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Dec 2021 13:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UKN9r+cmbQb0IRkq21ipfbEsnSPBQABGnbdsMMouX2g=; b=tYMDuA+JhZ5b0ST/mfR+hezdhD
	jatjtr1SW6dL/HM/7koCLPzPiObgsuh52m49qvM9Ky7S/Q2fpFNs5XRRLGB3Ntk7npIcjR+1CSwj1
	vE1YHb1iAnhofWJRMyAk8m3cHak1QovXK4zppCNMtbe1afJHtJDbtwGueBOT6+VZHSOclsqrAI9E+
	BQ1zy8U8j8l6JL3uPUaq94SDPz9gOngLiZ/jqQlj8jyGZlHyogqd3jq5cLEY1MDAn/fTEvBlPZC5Z
	Ewv9HkQMUT/D6yZF5GtVCRQ3TA+QrM+u73cII37easCTelfU8oi/ZJO1bE74JHDK4p0s7GiOc4upY
	cj314jqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muawu-008myM-De; Tue, 07 Dec 2021 13:56:04 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muawr-008mwp-2T
 for linux-nvme@lists.infradead.org; Tue, 07 Dec 2021 13:56:03 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7F15B1FDFE;
 Tue,  7 Dec 2021 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638885357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UKN9r+cmbQb0IRkq21ipfbEsnSPBQABGnbdsMMouX2g=;
 b=YU9ECsCsC0LhYggsJsDbciVawmGEOT4c92G3aePctS9PbcJGoR+kmPnniJ4q2+oLEJLTeX
 sADtn3Mr5Z5eP6KBWDzARx0HTxGqAqLfq5coxdJDm5nlMfcxo4JRAsSZrUfKYa1df/tF35
 2y/qn05CJ/3X+EUjGoJ5McsFbuVGGTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638885357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UKN9r+cmbQb0IRkq21ipfbEsnSPBQABGnbdsMMouX2g=;
 b=KHoDVHdasQQjsbuwPeaWD4UW1ldZoLyc5cBsp1Xo+wGtLRiqDnpno63vLj5Gw7h8y4Na9+
 z3mAPw1BQM97gfCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 88B56A3B81;
 Tue,  7 Dec 2021 13:55:56 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 73CD65191ED0; Tue,  7 Dec 2021 14:55:56 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Martin Belanger <martin.belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Date: Tue,  7 Dec 2021 14:55:49 +0100
Message-Id: <20211207135549.100950-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211207_055601_304118_DCAF5B67 
X-CRM114-Status: GOOD (  13.69  )
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

Currently applications have a hard time figuring out which
nvme-over-fabrics arguments are supported for any given kernel;
the ioctl will return an error code on failure, and the application
has to guess whether this was due to an invalid argument or due
to a connection or controller error.
With this patch applications can read a list of supported
arguments by simply reading from /dev/nvme-fabrics, allowing
them to validate the connection string.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 282d54117e0a..7ae041e2b3fb 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1069,6 +1069,26 @@ static ssize_t nvmf_dev_write(struct file *file, const char __user *ubuf,
 	return ret ? ret : count;
 }
 
+static void __nvmf_concat_opt_tokens(struct seq_file *seq_file)
+{
+	const struct match_token *tok;
+	int idx;
+
+	/*
+	 * Add dummy entries for instance and cntlid to
+	 * signal an invalid/non-existing controller
+	 */
+	seq_puts(seq_file, "instance=-1,cntlid=-1");
+	for (idx = 0; idx < ARRAY_SIZE(opt_tokens); idx++) {
+		tok = &opt_tokens[idx];
+		if (tok->token == NVMF_OPT_ERR)
+			continue;
+		seq_puts(seq_file, ",");
+		seq_puts(seq_file, tok->pattern);
+	}
+	seq_puts(seq_file, "\n");
+}
+
 static int nvmf_dev_show(struct seq_file *seq_file, void *private)
 {
 	struct nvme_ctrl *ctrl;
@@ -1077,7 +1097,7 @@ static int nvmf_dev_show(struct seq_file *seq_file, void *private)
 	mutex_lock(&nvmf_dev_mutex);
 	ctrl = seq_file->private;
 	if (!ctrl) {
-		ret = -EINVAL;
+		__nvmf_concat_opt_tokens(seq_file);
 		goto out_unlock;
 	}
 
-- 
2.29.2


