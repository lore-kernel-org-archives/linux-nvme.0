Return-Path: <SRS0=CsQm=XR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F7AC3A5A2
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2019 18:48:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA6B21D56
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2019 18:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RT/o0D7/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrEz7EhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA6B21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Trco0IiHIoKOJUV88OT8wBDY9g3/YZgK41OSh96/aUs=; b=RT/o0D7/hHltOY
	oaML6yDJHDil21ZRa1gzj2bVCkcpZTeNTHWmK8DyBcvnfkXq1DE+7mfUjUS5DkTgN7N259pG65CdQ
	U5f4RZFsMQpL1K0GLIhMBho7f7/h/YWsYLWOrqaJDHC/POihdGe17O/a239L0Al0130SctJ0vIFru
	zUPp4EGXel3vTZPBZeVJfEMv/HpKIgKa4eHi3AiDSYLdJ0tDfZ4LvnSAgnBd4tRomSmZLB5+7/KQ7
	OUKKRnhqVon/wryZvzCe0MALq8Ji28jTbTD+dfjyLCd3X6Ec6aOcr5RHVKBw9RoMxDVYDCCVXu4wW
	0dYqRf+HD/X1QOpPii5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iC6u4-0007s3-Jq; Sun, 22 Sep 2019 18:48:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iC6tn-0007i3-4V
 for linux-nvme@lists.infradead.org; Sun, 22 Sep 2019 18:47:56 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BB1D92186A;
 Sun, 22 Sep 2019 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569178074;
 bh=4Ewei6nFu8UH+9+UcQT2aqOUudzBkl/2gZljAtwog70=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hrEz7EhNwM2t3IgO/6YPhoalLXki/n/6YMwxsz8gWXMtHiixwHghLi23inWyR3igb
 PQdpEfV9mcml/2JWQoKoJb53+2klDoIwukR06wtjWuN+CuKk/s65kdGe05Z5N822hr
 OD4N4FNLrlfvt12LBz+PLTT4U8SzAtzJy79aXJaA=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 146/203] nvme-multipath: fix ana log nsid lookup
 when nsid is not found
Date: Sun, 22 Sep 2019 14:42:52 -0400
Message-Id: <20190922184350.30563-146-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190922_114755_216798_2C293E08 
X-CRM114-Status: GOOD (  15.16  )
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
Cc: Sasha Levin <sashal@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Anton Eidelman <anton@lightbitslabs.com>

[ Upstream commit e01f91dff91c7b16a6e3faf2565017d497a73f83 ]

ANA log parsing invokes nvme_update_ana_state() per ANA group desc.
This updates the state of namespaces with nsids in desc->nsids[].

Both ctrl->namespaces list and desc->nsids[] array are sorted by nsid.
Hence nvme_update_ana_state() performs a single walk over ctrl->namespaces:
- if current namespace matches the current desc->nsids[n],
  this namespace is updated, and n is incremented.
- the process stops when it encounters the end of either
  ctrl->namespaces end or desc->nsids[]

In case desc->nsids[n] does not match any of ctrl->namespaces,
the remaining nsids following desc->nsids[n] will not be updated.
Such situation was considered abnormal and generated WARN_ON_ONCE.

However ANA log MAY contain nsids not (yet) found in ctrl->namespaces.
For example, lets consider the following scenario:
- nvme0 exposes namespaces with nsids = [2, 3] to the host
- a new namespace nsid = 1 is added dynamically
- also, a ANA topology change is triggered
- NS_CHANGED aen is generated and triggers scan_work
- before scan_work discovers nsid=1 and creates a namespace, a NOTICE_ANA
  aen was issues and ana_work receives ANA log with nsids=[1, 2, 3]

Result: ana_work fails to update ANA state on existing namespaces [2, 3]

Solution:
Change the way nvme_update_ana_state() namespace list walk
checks the current namespace against desc->nsids[n] as follows:
a) ns->head->ns_id < desc->nsids[n]: keep walking ctrl->namespaces.
b) ns->head->ns_id == desc->nsids[n]: match, update the namespace
c) ns->head->ns_id >= desc->nsids[n]: skip to desc->nsids[n+1]

This enables correct operation in the scenario described above.
This also allows ANA log to contain nsids currently invisible
to the host, i.e. inactive nsids.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
Reviewed-by:   James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index af831d3d15d07..30de7efef0035 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -509,14 +509,16 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->head->ns_id != le32_to_cpu(desc->nsids[n]))
+		unsigned nsid = le32_to_cpu(desc->nsids[n]);
+
+		if (ns->head->ns_id < nsid)
 			continue;
-		nvme_update_ns_ana_state(desc, ns);
+		if (ns->head->ns_id == nsid)
+			nvme_update_ns_ana_state(desc, ns);
 		if (++n == nr_nsids)
 			break;
 	}
 	up_write(&ctrl->namespaces_rwsem);
-	WARN_ON_ONCE(n < nr_nsids);
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
