Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F7CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FRm5wNvdgM6ElpgLr6sjcaOiTpVu+KuOrP8gLefFeu0=; b=yZsr9vs+Z8hi92TsvX5gWHPqSp
	Xhz1PcNRFg3VuNpRYY+xQ9gZPLNURZa8tkHgLK/oINXR+wqtJmw1k2x+SqYs6+mEHTMM+uZJwMxJZ
	XYYizTHg1ZF5CV1hcrss3Ahk/bYt9bi5aD64lDz+/jvqaECUjZ/FuGXSTl1AYcYVyDVoVCuEFfZUo
	okE00fpSRRTX5pILTCyrZfLRjMfnRePnGt5jCgNH/MNjJv8AXFPQDbTGzbco6Ef7ru1Qbg21NitJZ
	uR45fN7W7l67v96w+RrbskY6cD8AEcdXyXkMWvrST4DSMxvMVxEuLVkyFy4GgNDFUySfaIYqcqJj0
	1KX2cmdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC1mp-003tGS-JT; Mon, 24 Jan 2022 16:01:43 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC1mM-003t0h-MO
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 16:01:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6D228B810FE;
 Mon, 24 Jan 2022 16:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3DEC340EB;
 Mon, 24 Jan 2022 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643040072;
 bh=5NXbiPmUVyXNpYVOqSPCaEFkm6W60TiQ0PNNsqOWJcc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uGHnnHYXoWm8KwuCR/gfWP1n6W0Aja74gXs7JM2Q2n4qe2YnYQH/2UdZ+artUKnx1
 QSgWEp9sX4O0vTXTW7UiQYJocPTik0Ub/TM1BPp28tkLtOHe6aKj8KHU/YhVs0Cxiw
 1NieNy1dH1Ygy1uz+QFDlnQVKjh4B09sOPX0QoqIauorgMEOgTOmOmxwGW5uFP0I5l
 jHhdUjjOnPmYMAyK4x+tRTZDLjhn3buUGd34TJmQ8y4JIvK0vYZFSygNWwcCjB6p/0
 9YDvKY9MmjX4b4vitMwoh5ilocbK0PCAGnPbescNW8+zx548bXFyD0niZUU9F6L6XD
 +4kfNBC/0OaPA==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 arnd@arndb.de, Keith Busch <kbusch@kernel.org>
Subject: [RFC 2/7] nvme: allow integrity on extended metadata formats
Date: Mon, 24 Jan 2022 08:01:02 -0800
Message-Id: <20220124160107.1683901-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220124160107.1683901-1-kbusch@kernel.org>
References: <20220124160107.1683901-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_080114_891806_294938A4 
X-CRM114-Status: GOOD (  13.22  )
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

The block integrity subsystem knows how to construct protection
information buffers with metadata beyond the protection information
fields. Remove the driver restriction.

Note, this can only work if the PI field appears first in the metadata,
as the integrity subsystem doesn't update guard tags on preceding
metadata.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e0bfda04bd7..b3eabf6a08b9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1726,12 +1726,9 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 
-	/*
-	 * The PI implementation requires the metadata size to be equal to the
-	 * t10 pi tuple size.
-	 */
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
-	if (ns->ms == sizeof(struct t10_pi_tuple))
+	if (id->dps & NVME_NS_DPS_PI_FIRST ||
+	    ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
 		ns->pi_type = 0;
-- 
2.25.4


