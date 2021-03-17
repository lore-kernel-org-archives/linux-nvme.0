Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0756C433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:56:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F2464FBD
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F2464FBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cuvQfiq2JzMybUaXSob3b1m1T63ZQ7zVpYqRzg+01R0=; b=BRHOxLkCuC/VDS/4qiRNxZh7h
	dKn+K6OhpwAKBpatdEhxjkBOsRtWwLfQZE19LRNCUAh0T++4MK85/W6jCNl6m1faxkvY1jXY2usY0
	mrN1gKmHqErwMY97uOnZHtdgb2mFwQavThi0T2kNlrUb1OVRsFdla4fURzsSPhOOJ3atDbF3nU95d
	Xi0UrhmbCJ6uGh9Qx8g6J48Iv0XG9XQX69wn0Ml1lBu24S2ppvkYxHIKUCdga+EHGEmPGHKknjFaU
	Q9UlwTLyKapG2b26M79cWadNaZNHkADZ2iGhfFFtbqFU1+R8CBCdG1vqCVj/V05+v+ZVIpGBFzxBk
	/ob4w35bw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMKUS-0026gw-DN; Wed, 17 Mar 2021 00:56:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMKUI-0026dj-1Y
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:56:40 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E545D64FB4;
 Wed, 17 Mar 2021 00:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942596;
 bh=xhC/zSUQmyO9R3baAqSyxeaznB54cFDqoTtNGKDXqSg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tV2xk4VvVRvzytebUg6bpOejq1LqyelNLmBT4hkYRh/U6v0kLpqYTUjBFAEIHfTnv
 axca6JiYIJXed33Ojyuh1Z4GPE8ID6N1o2finYwxFo9PFhUP2Auk3hSMU84/5xdUXL
 E/FU8yS/5o3gntXihtiGPJYoQwGj+tA/j5fdrzxiX13cbojNr1bZca0KlX4wkQ2wEb
 QEWAbA+WnjODDEWXmjcSMGZ2vPiUA86e8pteqUCjFWTpZU3QKJ0zZLCHjvhF61HTKM
 CI4FFfI4CjJP+9XcNMaqBsfJ7h3WaqXEsAo4pXL57Te6Fnvj6/vIuwZ1GXmZh5w0u1
 DsicenORKtH3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.11 49/61] nvme: simplify error logic in
 nvme_validate_ns()
Date: Tue, 16 Mar 2021 20:55:23 -0400
Message-Id: <20210317005536.724046-49-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005536.724046-1-sashal@kernel.org>
References: <20210317005536.724046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_005638_405539_69F3F224 
X-CRM114-Status: GOOD (  14.61  )
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

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit d95c1f4179a7f3ea8aa728ed00252a8ed0f8158f ]

We only should remove namespaces when we get fatal error back from
the device or when the namespace IDs have changed.
So instead of painfully masking out error numbers which might indicate
that the error should be ignored we could use an NVME status code
to indicated when the namespace should be removed.
That simplifies the final logic and makes it less error-prone.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 129e2b6bd6d3..1d6576b6bda3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1425,7 +1425,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		goto out_free_id;
 	}
 
-	error = -ENODEV;
+	error = NVME_SC_INVALID_NS | NVME_SC_DNR;
 	if ((*id)->ncap == 0) /* namespace not allocated or attached */
 		goto out_free_id;
 
@@ -4023,7 +4023,7 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 {
 	struct nvme_id_ns *id;
-	int ret = -ENODEV;
+	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags))
 		goto out;
@@ -4032,7 +4032,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 	if (ret)
 		goto out;
 
-	ret = -ENODEV;
+	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
 		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
@@ -4050,7 +4050,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 	 *
 	 * TODO: we should probably schedule a delayed retry here.
 	 */
-	if (ret && ret != -ENOMEM && !(ret > 0 && !(ret & NVME_SC_DNR)))
+	if (ret > 0 && (ret & NVME_SC_DNR))
 		nvme_ns_remove(ns);
 }
 
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
