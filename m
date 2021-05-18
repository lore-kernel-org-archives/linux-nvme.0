Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF755C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 01:10:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2F3613B5
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 01:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2F3613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9wxPncMJbl+M+G+ZnjapsYWr9p3OQRiHEZdhLWw9fvI=; b=WzAQ+krTMg0E65bUALXn5S5KH
	9KvgLuKS2GTo3g6oHsaC/4d84EioGNCc32695IpiIpOf1N8RNcNtxraKvRHCcvWWkRRm20oUR4cK7
	Yx4ELBbu7AvFpAqAFZxSOYW1L16teL7PQsMnTBSPKRJMu2cEMhMqc0dVMn2YrqJz8dqXZcoKCjJk/
	HCopC7oy37bmTLNfoVj/OsIV8F4UJUCQ6y557XKf3aqOW5qH/7VKaS8VctgwDjbFvMzL+lwMtxOmR
	lLQd6FK+XZzpwoNzzVikdyNo+0je8tVBgEmt1lAnVYrCwVUx6IvDn/U9x0S8DwrW8nykbDFU5P2hK
	acRtHvF/Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lioG4-00GasI-UT; Tue, 18 May 2021 01:10:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lioFW-00Gamz-EO
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 01:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=zo0Xv09zJto/buK6AQu5ZJ+9w58LBVLwprk4mNtl41c=; b=2TmM8tPYVcso6D7W4guCtcDORY
 miR4CLVSzG2I0coQMd5EAvEWeLJyaOetDNUPl+ESA55Uwz7t1sNMgjUvMMicnXXDO+0KmiOQCt/ay
 iqguGHmnpuP9hsEZXF+RQDX6s5c4ddHrup/vswuRTAWWy2eYUxfUelB5wsCd9Q5WFiQHpLLndrMdo
 CyKguYWEdi+mywpxDLVR/CC3gy4wh5ygymo5g1p8EFuEysTNsOErESzPeLymH2RWEseXFg+6JkPGI
 8+4mW/LObg3hTWONyHVmF41vmjnONTXLF4tQUiRzBj+/nmIDdiSE0JsWvlv6wotF7GhKj5kWx24Lb
 uiL+c4Bw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lioFO-00EFOO-NF
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 01:10:17 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F8DD613CE;
 Tue, 18 May 2021 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621300210;
 bh=wj0QOsfNOBtX701n2BDKmsB94m/zURdKlOYZuzfEqXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CH557ljF79DrPWmJ1/0B841wSJjwrNkKqZS1m4/7e3bLQPys7sbQIuzBEAd6/d1XA
 DCw/JHgUNrmfjwxQZjIKHT9fru7yAAsGgKS+oWvb0j6JqLcSdjJYV3VAybP3kmDr8J
 9Lpe3NtcK648ssB2dY2+jtWegg1mnVy4WdVHiHrG96ixYVId6AjFdcbW5x77ACxMFP
 b+nXL7a/Jkj/m2Oda069Kc+eG0eAAlS3RY2qkXsjU1Se7cn1NlITpPgptgaQANqrRc
 YWU8mgjxcCaJLq6qbxvLy6ThZXV206D6K/qF16w/LniW6HLQnkfdg1WqAwDmeXc9Ph
 HAeGwtJ6oPMyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>, Enzo Matsumiya <ematsumiya@suse.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 2/2] nvmet: seset ns->file when open fails
Date: Mon, 17 May 2021 21:10:06 -0400
Message-Id: <20210518011006.1486026-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210518011006.1486026-1-sashal@kernel.org>
References: <20210518011006.1486026-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_181010_808273_24DA498F 
X-CRM114-Status: GOOD (  12.96  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 85428beac80dbcace5b146b218697c73e367dcf5 ]

Reset the ns->file value to NULL also in the error case in
nvmet_file_ns_enable().

The ns->file variable points either to file object or contains the
error code after the filp_open() call. This can lead to following
problem:

When the user first setups an invalid file backend and tries to enable
the ns, it will fail. Then the user switches over to a bdev backend
and enables successfully the ns. The first received I/O will crash the
system because the IO backend is chosen based on the ns->file value:

static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
{
	[...]

	if (req->ns->file)
		return nvmet_file_parse_io_cmd(req);

	return nvmet_bdev_parse_io_cmd(req);
}

Reported-by: Enzo Matsumiya <ematsumiya@suse.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 39d972e2595f..ad6263cf7303 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -38,9 +38,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 
 	ns->file = filp_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
-		pr_err("failed to open file %s: (%ld)\n",
-				ns->device_path, PTR_ERR(ns->file));
-		return PTR_ERR(ns->file);
+		ret = PTR_ERR(ns->file);
+		pr_err("failed to open file %s: (%d)\n",
+			ns->device_path, ret);
+		ns->file = NULL;
+		return ret;
 	}
 
 	ret = vfs_getattr(&ns->file->f_path,
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
