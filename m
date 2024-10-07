Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821E6CFB442
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V49VG7CUjbIwlo6J1Oij+gA3/vMI2gYp5KIIS65mJRE=; b=nGYUGinBW0mDnRSTfNu/T427az
	urBP2m69EyiY92UjY6wIK6y7V4k7HGX8KBwIRpIGQf88iIbdqfA57PkYHusodIVskuNp2fcu3TpCW
	5RwX2p0NJ/k1EuyUk4t+pSZeMy25XrqgtOQdyCWLtFEXgA6z+fARm2YY14Qu7motZNDWSdbd4yFt3
	f5QmeasAq0KgZNTq2gIdC2SGtEFhgrwdgBvzkFChESwyz8vkNM8LqNR2bfEvBWIPkMc07XFLH24QS
	4kStZZj/g6AuKSaNbImxiF2m7OCVuSK7ZtuGSkfvbvOLCAI9zyoCGsn4WdYefEiF9mlBMwgqR+u0y
	tRMpi6kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkZ9-00000001zE5-46ZP;
	Mon, 07 Oct 2024 10:02:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkYm-00000001z8y-1RVc
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 10:01:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9D5365C5B9B;
	Mon,  7 Oct 2024 10:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F98C4CEC6;
	Mon,  7 Oct 2024 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728295307;
	bh=wXE0creJtOJ1sxTjg+Gldric1cxbTNcx6ktxKEYfk/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2owLwlUHeLcLoo+GT3R9H6QrW5W6zQTT4/rhtuIm/YlIjr1zmBD6CH1zceYeMnF6
	 4YuUFzS1smk1aFIe0G57E0/BrdNSJcDn9vlhjyLZohmqcwiyTOIWyF/f0drA1xF/8s
	 Tlf+qTiUXXDTTLokI87+E6byf/eqQMWKEsi/L+L+4WeGeBLRs63FWxrz/Z3Vu29j7a
	 bc34VUlL/Fad4BjH1WEOXWswRQUYllhSzBBFfFbAbJPqKbMSYuwl/qdinMXYRviXgJ
	 SFqK/Jitv1MnPgIWueO12szFtxUCgIWBvNeYZlxNRShqi/ruZ+aj4CXJabsBh8Z8ZY
	 elK/sFIEJ48wQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/3] nvme-multipath: simplify loop in nvme_update_ana_state()
Date: Mon,  7 Oct 2024 12:01:32 +0200
Message-Id: <20241007100134.21104-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241007100134.21104-1-hare@kernel.org>
References: <20241007100134.21104-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_030148_453192_71A492FE 
X-CRM114-Status: GOOD (  15.47  )
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

Currently nvme_update_ana_state() iterates over all namespaces
with the srcu lock held, and calls the 'cb' function if a
match on the list of namespaces from the ANA log is found.
This assumes that the iteration itself is relatively quick,
and the namespace state itself doesn't change during iteration.
For more complex functions (eg if the 'cb' function triggers
mpath_set_live() which then kicks off a partition scan) the
namespace state might change while iterating, and the rcu-protected
area becomes really long.
So change the loop to iterated over the entries in the ANA log,
and call nvme_find_get_ns() on each entry.
With that the 'cb' function is executed outside of the RCU
protected area, and normal reference counting rules apply.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f72c5a6a2d8e..61f8ae199288 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -745,7 +745,6 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
-	int srcu_idx;
 
 	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
@@ -757,21 +756,16 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (!nr_nsids)
 		return 0;
 
-	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	for(n = 0; n < nr_nsids; n++) {
 		unsigned nsid;
-again:
+
 		nsid = le32_to_cpu(desc->nsids[n]);
-		if (ns->head->ns_id < nsid)
-			continue;
-		if (ns->head->ns_id == nsid)
+		ns = nvme_find_get_ns(ctrl, nsid);
+		if (ns) {
 			nvme_update_ns_ana_state(desc, ns);
-		if (++n == nr_nsids)
-			break;
-		if (ns->head->ns_id > nsid)
-			goto again;
+			nvme_put_ns(ns);
+		}
 	}
-	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return 0;
 }
 
-- 
2.35.3


