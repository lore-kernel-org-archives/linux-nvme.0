Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5FDC0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jul 2023 08:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/uzC6P0AnWsHBpoST9CXhwSTs6fFimXp8dFX8h8LlqQ=; b=kyioJ8EQQoIh1zqmDH3QLVfnm6
	stS47pHyVXvqd/kJlvbfAWbRr5tTeTci0+KytjvklfAOjLRmTSKtKQxqKc6thy6Mm8wdm2hiMTe2i
	9MUGNZL36O9i9/it50tih6oI4CMyxmigA0r+PslPQxQTqY4TrNtB9gXSZzUFTvg176LYqSy9RpWNh
	DdJ4J21t0+nd/9fUtocGjz3oqISuq2sGbEtR1n6cL0dXFIzfJnS+eYHeHfmbf+GtDpnIj5EsM607N
	RQpo95q4M+tBCvtggJYx+QQCN2Ula0zjf4/GPmWhl6G82uXrMA1KPI8UGSSGsocp92we+bRGfLeXr
	vnuVGPNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qODc5-006nAy-2S;
	Tue, 25 Jul 2023 08:41:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qODc2-006n9H-2w
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jul 2023 08:41:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78EE1223AB;
	Tue, 25 Jul 2023 08:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690274505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uzC6P0AnWsHBpoST9CXhwSTs6fFimXp8dFX8h8LlqQ=;
	b=Vzm69ZQzLnG2j6SfVRmf44V/0jMcgAPwfaH3ektGaCo5LLbPqBF5oJwOb9JuxKe4OHYxJN
	hccD2wGPWfNmWoFOS2iJun4+eN/IDNbL8KCY3txTD4c07Bxf3wwmRT55yqU3vLrkxOo+nX
	xOFpcgsr6lxZulDkdlBea+p0saSTMlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690274505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uzC6P0AnWsHBpoST9CXhwSTs6fFimXp8dFX8h8LlqQ=;
	b=JZW2+Svg67LzE10sY+YJEKkLcx8Q7OBZWAna32zKf9OONZx2DfzwC6ivkamdOCbpxLWWRB
	YW3is8u0dUqwBSAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A21813342;
	Tue, 25 Jul 2023 08:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2l3fGcmKv2STPgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 25 Jul 2023 08:41:45 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATH libnvme v1 1/2] fabrics: Shorten/rename supported option function/vars names
Date: Tue, 25 Jul 2023 10:41:36 +0200
Message-ID: <20230725084137.16139-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <r3xuoptvmxqnbt6gi26b6av2jj4wbi3eixgd74lmdauxip63jt@pxmvqyljanjr>
References: <r3xuoptvmxqnbt6gi26b6av2jj4wbi3eixgd74lmdauxip63jt@pxmvqyljanjr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_014147_089220_41C84928 
X-CRM114-Status: GOOD (  13.84  )
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

No need to be extra verbose and using so many chars per line.

Also rename to __nvmf_supported_options to nvmf_read_options
which describes better what the function actually is doing.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/nvme/fabrics.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 800293e2a8e7..2f26c2b7f39a 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -202,7 +202,7 @@ const char *nvmf_cms_str(__u8 cm)
  * Not all of these options may actually be supported,
  * but we retain the old behavior of passing all that might be.
  */
-static const struct nvme_fabric_options default_supported_options = {
+static const struct nvme_fabric_options default_options = {
 	.ctrl_loss_tmo = true,
 	.data_digest = true,
 	.disable_sqflow = true,
@@ -652,7 +652,7 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 		continue;		   \
 	}
 
-static  int __nvmf_supported_options(nvme_root_t r)
+static int nvmf_read_options(nvme_root_t r)
 {
 	char buf[0x1000], *options, *p, *v;
 	int fd, ret;
@@ -683,7 +683,7 @@ static  int __nvmf_supported_options(nvme_root_t r)
 			nvme_msg(r, LOG_DEBUG,
 			         "Cannot read %s, using default options\n",
 			         nvmf_dev);
-			*r->options = default_supported_options;
+			*r->options = default_options;
 			ret = 0;
 			goto out_close;
 		}
@@ -913,7 +913,7 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
 		free(traddr);
 	}
 
-	ret = __nvmf_supported_options(h->r);
+	ret = nvmf_read_options(h->r);
 	if (ret)
 		return ret;
 	ret = build_options(h, c, &argstr);
-- 
2.41.0


