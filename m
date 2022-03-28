Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036C7C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 10:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aCl644BS86xIuOgxKcQTaXj0Oocl1yF68WtmvUFdCkI=; b=sUtrqQpv0LzjvhgGFooidJJd09
	8lRsaAUJEB5Ycy4Iq6zooq2tcaaCQaLrBFqywRWC0p+V1cQF+WfevcHGcVuS2gHhTlFCuTolJCjF0
	IrEyc1V3PNCPb05bEwzw4NBIHd0jK/JwNjXFQjhfIQ+FIv/5dc9aPFPsz0go9EyVqq/OQAzjRyfos
	p1+AVzL5MYywGwiNaItdyXPiKx2mTbGlJXQbIx06T+Bjq8DqkoLNF0wBvMgtF9f2tRoC3+VcZsVXP
	6IHhxiCKimfNGlfQxTfbAGww1/QpCBzjW0J2cNYNPnhBw71sJr0LEaTBcpqWgpBGiIHHvpFW7cgq7
	B69PGE3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYmTM-00891B-QR; Mon, 28 Mar 2022 10:19:40 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYmT3-0088uZ-Mz
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 10:19:24 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 55DC01F383;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648462760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCl644BS86xIuOgxKcQTaXj0Oocl1yF68WtmvUFdCkI=;
 b=vQkutLkGv4t56m0yZ7wutV51OqsHZ5eQcgpBzrwzOA24ZOzld53jMOIWjFFvY6D4uV8UvJ
 iIk8vptrMiVItvc7ctKt7GoDYFVhoNN4Jm9QW+Yh9Ph+hfx6d3zhxVvwhASNwpZSc9TF3A
 rR7sQiHV2PyGilhzYBUA/KoAMH9gezI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648462760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCl644BS86xIuOgxKcQTaXj0Oocl1yF68WtmvUFdCkI=;
 b=dERgBvhcN33jvTRLp0b4w24mSri2lpn/o9C8NF6cAdmm/zeoUA3BMFjLGNbfgYy01jaZjp
 86+N0NzWZ49MqSBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 41E3AA3B92;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 3487651939BF; Mon, 28 Mar 2022 12:19:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.com>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/10] nvme/rc: clear hosts directory in _cleanup_nvmet()
Date: Mon, 28 Mar 2022 12:18:48 +0200
Message-Id: <20220328101855.73975-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328101855.73975-1-hare@suse.de>
References: <20220328101855.73975-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_031922_051547_6E0A81D5 
X-CRM114-Status: UNSURE (   7.89  )
X-CRM114-Notice: Please train this message.
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

From: Hannes Reinecke <hare@suse.com>

When clearing out the configuration we need to clear the 'hosts'
directory, too, as scripts might have added host configurations.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index aa223df..c284602 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -122,6 +122,12 @@ _cleanup_nvmet() {
 		rmdir "${subsys}"
 	done
 
+	for host in "${NVMET_CFS}"/hosts/*; do
+		name=$(basename "${host}")
+		echo "WARNING: Test did not clean up host: ${name}"
+		rmdir "${host}"
+	done
+
 	shopt -u nullglob
 	trap SIGINT
 
-- 
2.29.2


