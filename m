Return-Path: <SRS0=76sU=ZI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77BEC432C3
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2019 15:48:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBD720815
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2019 15:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hhY4FUKQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKJYyvff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBD720815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KIohE8LXgtKeIMaP/ku3h8Bk8Z4q9B5AFqk2AfXoqbc=; b=hhY4FUKQ9DKfE7
	7dSxEX6cUqFyh/vVHCwRloCMnSYkoXOV68PUXRAithdSeTeLr2hbu88RpBlU1fqDhLQmkWBz52sFt
	WWaAS7AH52TH0h/pPKGFwSh7+fNUNEclCTdpCq5vUK7Ke7AODtpfBnHb21Sat3XMN1WHK/ERkko5t
	gNVmbjCjWe1akyhndJtCpKzKtiwKLZ0qOmTSzDIXbWSATe1pPxrryd6J7YfPLtTRh1kzS+sGB4GgD
	xqEJ+TG/YAqcehQ/Q1t2r22dlDfMobyEfMbAp/Pc5Vryxs57fFLMF2cRd1/YEQbSllZ8Z22DYqzOn
	dgyUC4KjMyuQVoGQCBnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iW0Ix-0002eI-MZ; Sat, 16 Nov 2019 15:48:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iW0Iu-0002dV-VG
 for linux-nvme@lists.infradead.org; Sat, 16 Nov 2019 15:48:06 +0000
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5630420855;
 Sat, 16 Nov 2019 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573919284;
 bh=+NB0s+LCRAxdroStWyCsfEPiUhK5zPehk0eeSME6j/Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HKJYyvff/NB5qVseErzFzLIn3+kEpIRFweDitfIBniWK11I/rN3uKQLTy2haPhQdi
 T17+VePeQaRU4FsB0ZxWoObvoPsMRIYhiuiv6q066IDxNjwB0fPkfDaDMX6ajyHLmT
 5NESn7UOfnkebIpf7ahFVWZS8oV8FjdED+bi3oYo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 035/150] nvmet-fcloop: suppress a compiler warning
Date: Sat, 16 Nov 2019 10:45:33 -0500
Message-Id: <20191116154729.9573-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191116_074805_026059_106DFBEA 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: Sasha Levin <sashal@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 1216e9ef18b84f4fb5934792368fb01eb3540520 ]

Building with W=1 enables the compiler warning -Wimplicit-fallthrough=3. That
option does not recognize the fall-through comment in the fcloop driver. Add
a fall-through comment that is recognized for -Wimplicit-fallthrough=3. This
patch avoids that the compiler reports the following warning when building
with W=1:

drivers/nvme/target/fcloop.c:647:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (op == NVMET_FCOP_READDATA)
      ^

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fcloop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 0b0a4825b3eb1..096523d8dd422 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -535,6 +535,7 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 			break;
 
 		/* Fall-Thru to RSP handling */
+		/* FALLTHRU */
 
 	case NVMET_FCOP_RSP:
 		if (fcpreq) {
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
