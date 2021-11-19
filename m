Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CDCC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 08:39:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AA861994
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 08:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74AA861994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IxT86EFtoaqR9rzAdpQjy+M3/oFDhqvZFJJQ8rqD9uw=; b=pCS74V3tg1frtEkplIhk1+mp+6
	mjMm8QNsIMurpd5vrE+oCpG7GKdUJhBkaw92jXQsgyGKBC/iJhjleSUggHOFpCm427kvmdjAUINK9
	8P9EXGvm/S+B55SbvHni/IWRcflHJgVyifrEc8B+YemOPjjEH7rk4hJIlxHzDENHMAJnA7PRAThSw
	T1ym4d4RdClWNtiqVDRXY83ck2shfOjyWrkmWZHckr+cgNGJ9d55AKBsvU/L9Iq1VbAjp+jqhg/5V
	nKJTn5D3F+2brVJX3I/KiqJzdeiRycQ1S1MQLsQRtfTMHN1JUTOhnU0ceee+bur6rdgzPqVPLhjOE
	bbpw85cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnzQT-009nFZ-HO; Fri, 19 Nov 2021 08:39:17 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnzQR-009nF1-Hu
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 08:39:16 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A8C2D212BA;
 Fri, 19 Nov 2021 08:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637311153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IxT86EFtoaqR9rzAdpQjy+M3/oFDhqvZFJJQ8rqD9uw=;
 b=LHIb8dPsf3HPherzHymzhQUnjTxz2/e5XK7zFbzufmHZTY01azD5G2O9emaR0C9HL8WUmo
 N8GOKxJvU0hDs1Q+4T6X9a92DWhQHTA2IT1KTydqKRQXqozEtE1JUTQYsC27Wgi2anAQra
 T5ltQ9gt3r3rxrlUDMSV7gePYVmSRc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637311153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IxT86EFtoaqR9rzAdpQjy+M3/oFDhqvZFJJQ8rqD9uw=;
 b=vICFlQG/+UEdXfN+XSderNo/OUrX4WpRJrWX35R3Rav6J/oG+pY3s2mu9RkuAiL3Z1qtKy
 Fw+QpTfD2Db2iFAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 766EEA3B84;
 Fri, 19 Nov 2021 08:39:13 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 63D855191650; Fri, 19 Nov 2021 09:39:13 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Date: Fri, 19 Nov 2021 09:39:12 +0100
Message-Id: <20211119083912.38260-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211119_003915_770972_E01BBAC4 
X-CRM114-Status: GOOD (  13.27  )
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
 drivers/nvme/host/fabrics.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 0ac054f80a82..810bbc8c9b6b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1144,7 +1144,18 @@ static int nvmf_dev_show(struct seq_file *seq_file, void *private)
 	mutex_lock(&nvmf_dev_mutex);
 	ctrl = seq_file->private;
 	if (!ctrl) {
-		ret = -EINVAL;
+		const struct match_token *tok;
+		int idx;
+
+		for (idx = 0; idx < ARRAY_SIZE(opt_tokens); idx++) {
+			tok = &opt_tokens[idx];
+			if (tok->token == NVMF_OPT_ERR)
+				continue;
+			if (idx)
+				seq_puts(seq_file, ",");
+			seq_puts(seq_file, tok->pattern);
+		}
+		seq_puts(seq_file, "\n");
 		goto out_unlock;
 	}
 
-- 
2.29.2


