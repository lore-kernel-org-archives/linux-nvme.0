Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0A8D3C550
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 06:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eeh7ekKkQYcrs75J5ObC3O3XK8/UzyW5cXGpqZFp+AM=; b=kWBw8TiFhX/lCjL+v/Sm1P2jR9
	mVLBoa32w9gIx6iZPDU/Kl2zVcBBIKApeDm3QHSWxAJN94ce01He4Sj9Nm4gnYXmDcF+RTyWYrI2E
	jAOxc2NdlRZX9KeGP6k+SMLggo24gjo2Ggt99Me463WL5JRS7uE/9LvfzyrZgUvNNyKPL6Wnw71eH
	h5c4QkGw+YNAdEhJ71HQggC3DSDNPLr3uJ9Z2wwrCtEL5FT0wtwo+Mkpdx3mmM3E8bZaEqMMHGwi8
	k25U4v0gsddQTrhiVMREFcmbt9mLL4NXPZxqeBbZ3d82olSk8XoecjLCoeHccxw8VrBQvvMnF5JCT
	Bu1dkDvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1gZN-0000000H97m-0LI8;
	Fri, 18 Oct 2024 06:34:41 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1gYu-0000000H91L-2HEA
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 06:34:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 91EA6A40DE2;
	Fri, 18 Oct 2024 06:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88E2C4CED0;
	Fri, 18 Oct 2024 06:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729233251;
	bh=pFqbPRAdiuRsY0v5qj58v/zUdbaLboMBN8uycfJ3/pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctBp7Pee0WLSThkhL3amFtZrGnwNh4gzXGNPB9shRA8R7nSGEboSi4+qF8OHH9aa7
	 tSFkGhtZXoi7f3etun8Kn0ESaVp54WMHxn9H6G/8KAiF+eQBIyTE0lU5pyRcW51muU
	 zVJ4zsgHZdwe6qxN2I+CV0beyQJP/6eZYIfiOkjqSVTIl++9cTup/GRM8QQbbkRyv1
	 DmcJMPswp+Qdplzn7YAh1eQ2k6vTBqxjebEVu+Krvlz7p0rVmDwhqsk9RZeRekgZ5p
	 1Y4o/C0PRR8N8Oc+/Y9NVGvZKYejiRArcR6lSGB3AIDQph5VAJnfaMsNsJoAjafCm9
	 64vCXfY7rTWyw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/9] nvme-fabrics: reset admin connection for secure concatenation
Date: Fri, 18 Oct 2024 08:33:41 +0200
Message-Id: <20241018063343.39798-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241018063343.39798-1-hare@kernel.org>
References: <20241018063343.39798-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_233412_690485_9D27B3B3 
X-CRM114-Status: GOOD (  11.71  )
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

When secure concatenation is requested the connection needs to be
reset to enable TLS encryption on the new cnnection.
That implies that the original connection used for the DH-CHAP
negotiation really shouldn't be used, and we should reset as soon
as the DH-CHAP negotiation has succeeded on the admin queue.

Based on an idea from Sagi.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b8a3461b617c..04f0ac57855e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2251,6 +2251,15 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	if (ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
+		dev_dbg(ctrl->device, "restart admin queue for secure concatenation\n");
+		nvme_stop_keep_alive(ctrl);
+		nvme_tcp_teardown_admin_queue(ctrl, false);
+		ret = nvme_tcp_configure_admin_queue(ctrl, false);
+		if (ret)
+			return ret;
+	}
+
 	if (ctrl->icdoff) {
 		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
-- 
2.35.3


