Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B046C87FC9
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZqytHcpPjzB8yEmtYaaWrEN6rhRBDlVCJwI/UjO08I=; b=lLImiHinbnYidZp1eeBbNbVQIf
	gdMa4sE4jOw3VORrZo3FuTltop7nfjBveTP2Wx9Ynxtg9h8LxjiwduEtyzTNm+T48GWfr/KYCDxqV
	HEgl6GjqYcXIHWCbqF+xUQSBfTiA8kgjcAduCOyz3pkcitRJnm6DGbIu4RzHsDGGnLO/ywvoqHgPu
	R+HKTZMZbwL5JTsD3UPMTWC224CEyNmArG/kB2kbjr/aTzTttLTSMxmfxv03x46vSbdNGII8YCTDH
	1+7k5YD7t6NVSB7nlWGmo4GWswujNqKBQUi6xsaL8M3Q50nG92zJnhJMIg7d14DNBB+c2Ee89Vb/O
	/h6peOlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQe-0000000G5S4-07IG;
	Tue, 29 Jul 2025 07:07:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQW-0000000G5Pj-2e38
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 07:07:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 08D505C5D7B;
	Tue, 29 Jul 2025 07:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9FBC4CEF5;
	Tue, 29 Jul 2025 07:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772827;
	bh=OMYUEp6XJ5X5ZbAAZGFbSVgl8d6h3Qp2zvqVxVPgmAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beZWS8t0LNIXcIFaw6m3OwthDgPLD19JNM7i7zDYc0goe9uOeyTMd4mqW36xVEdzl
	 fIKhSC4ZSSkjI7g7bobG1mPREhdAw5ARAGo1dAu2f982ZptyBlRT+xbSw7u4DSfupG
	 dpVAPBhwFQIu3H/wCYkbYD6aISKb+Sf/ACnztcq9L+kA24katZ8fc1GgT1hBDIoKwa
	 /QlrNOm1iptc3laP1C3yi32ldmIbemAuEgXZiCYOJkrFAsuGGdeeyLPE4cocc1SaO4
	 IaOrNKc6SWmWvI4lZsE8lvxwg8Q4UcvKKo8Esy0xxX3EwK8rYuFJy+Gt5VlfqZ70OW
	 weKwer73X91xQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/6] nvme-multipath: do not assign ->current_path in __nvme_find_path()
Date: Tue, 29 Jul 2025 09:06:48 +0200
Message-ID: <20250729070653.125258-2-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729070653.125258-1-hare@kernel.org>
References: <20250729070653.125258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_000708_811907_27E31529 
X-CRM114-Status: GOOD (  12.99  )
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

From: Hannes Reinecke <hare@suse.de>

__nvme_find_path() is the fallback if no paths are selected, but
setting ->current_path[] is only relevant for 'numa' and 'round-robin'
iopolicies. So move it out of __nvme_find_path() to avoid a pointless
assignment for other path checkers.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 40 +++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3da980dc60d9..116b2e71d339 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -342,8 +342,6 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 
 	if (!found)
 		found = fallback;
-	if (found)
-		rcu_assign_pointer(head->current_path[node], found);
 	return found;
 }
 
@@ -364,8 +362,13 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 	struct nvme_ns *old = srcu_dereference(head->current_path[node],
 					       &head->srcu);
 
-	if (unlikely(!old))
-		return __nvme_find_path(head, node);
+	if (unlikely(!old)) {
+		ns = __nvme_find_path(head, node);
+		if (ns)
+			rcu_assign_pointer(head->current_path[node], found);
+		return ns;
+	}
+
 
 	if (list_is_singular(&head->list)) {
 		if (nvme_path_is_disabled(old))
@@ -455,9 +458,11 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
 	if (unlikely(!ns))
-		return __nvme_find_path(head, node);
-	if (unlikely(!nvme_path_is_optimized(ns)))
-		return __nvme_find_path(head, node);
+		ns = __nvme_find_path(head, node);
+	else if (unlikely(!nvme_path_is_optimized(ns)))
+		ns = __nvme_find_path(head, node);
+	if (ns)
+		rcu_assign_pointer(head->current_path[node], found);
 	return ns;
 }
 
@@ -798,12 +803,21 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 
 	mutex_lock(&head->lock);
 	if (nvme_path_is_optimized(ns)) {
-		int node, srcu_idx;
-
-		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_online_node(node)
-			__nvme_find_path(head, node);
-		srcu_read_unlock(&head->srcu, srcu_idx);
+		int srcu_idx, iopolicy;
+
+		iopolicy = READ_ONCE(head->subsys->iopolicy);
+		if (iopolicy == NVME_IOPOLICY_NUMA ||
+		    iopolicy == NVME_IOPOLICY_RR) {
+			int node;
+
+			srcu_idx = srcu_read_lock(&head->srcu);
+			for_each_online_node(node) {
+				struct nvme_ns *ns = __nvme_find_path(head, node);
+				if (ns)
+					rcu_assign_pointer(head->current_path[node], ns);
+			}
+			srcu_read_unlock(&head->srcu, srcu_idx);
+		}
 	}
 	mutex_unlock(&head->lock);
 
-- 
2.43.0


