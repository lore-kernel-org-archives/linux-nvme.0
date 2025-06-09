Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB34C5B552
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LS2fjjBFWCBXVuv06k2SE+j5wc38KulJZi8IN6OHw40=; b=WvAe4AgnIygGFRi6T+fCn+sMy4
	U1w20K/zQ/R5gOuqgXHNQ8W7mLFlKi6okuQBejU7B2csHtA/oZu2q2l8f/BDL6XKTLZf3JzIINouZ
	bXKqrIQ0iSTFYA6X+4x+OkfmGqngOjmDw+zx8NN2fW3vGyCbc1mKFanwRgbs1cr+baKB0rOzg6m7x
	CC6ydV3nzBJczAKimagZ5MFu2GHNI058rFCaI0RHzGq/K0GaEdWMiitz4YWXPcMMu3xYlsWuwh5br
	nl2VL8lubLreBfTTeKntCwSdDWWqFrG3+dn8Ros3+sqzDLzcGpTHVdd4MYUObhGIsoCx+9T67n/J5
	Yk/NcuyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOcsN-00000004I7N-3ICT;
	Mon, 09 Jun 2025 13:49:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOcpL-00000004HM3-0aep
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 13:46:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 53D63614AE;
	Mon,  9 Jun 2025 13:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C83AC4CEEB;
	Mon,  9 Jun 2025 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476774;
	bh=QDiIjWqI+6vYM4gt8RQdgOvu7LUndg7Sz5IXzR/8vuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRhBvO85lKmPSiNp0Q59l8dEYfZkfjk/PVKBJWAe3SqPCcU6RIbA5PSlteWct411O
	 nn5D5V0DsL/AA4NIJ/jCcjWte2w0WeU324m1LrkMxcoL77MWZAQfmWLX09wipT+ORM
	 PDrMZldGlIESmqZD8HRDQQOfHA7DtyFqL7lDoJdCLKqliVklHYVMWImGJN/AeWZEWr
	 xhXaV/FPoXH+XE/5DWkev0SDo+oOff1EJj3pEymlxoUpZ1xln0rR2lsi76eRAVW0uj
	 XOTYJh+VB6lEWnywGW86iP1ugFpXTq4+y3jDfM7o+Ktb9FSNWAkJBxrp/PQeoi4W90
	 P6ptTyNHQFR3A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 02/23] nvme-tcp: sanitize request list handling
Date: Mon,  9 Jun 2025 09:45:49 -0400
Message-Id: <20250609134610.1343777-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609134610.1343777-1-sashal@kernel.org>
References: <20250609134610.1343777-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.32
Content-Transfer-Encoding: 8bit
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 0bf04c874fcb1ae46a863034296e4b33d8fbd66c ]

Validate the request in nvme_tcp_handle_r2t() to ensure it's not part of
any list, otherwise a malicious R2T PDU might inject a loop in request
list processing.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit message and code changes, I provide
the following assessment:

**YES**, this commit should be backported to stable kernel trees.

## Extensive Explanation:

### 1. **Security Vulnerability Fix**
This commit fixes a serious security vulnerability where a malicious
NVMe-TCP target can inject loops in request list processing. The code
changes show clear validation being added to prevent this attack:

```c
if (llist_on_list(&req->lentry) || !list_empty(&req->entry)) {
    dev_err(queue->ctrl->ctrl.device,
        "req %d unexpected r2t while processing request\n",
        rq->tag);
    return -EPROTO;
}
```

### 2. **Attack Vector and Impact**
The vulnerability allows a compromised storage target to send R2T (Ready
to Transfer) PDUs for requests that are already being processed. Without
this validation:
- The same request could be added to lists multiple times
- This creates circular references or list corruption
- Can lead to infinite loops, system hangs, or memory corruption
- Potential for arbitrary code execution through use-after-free
  conditions

### 3. **Minimal and Contained Fix**
The fix is:
- Small in scope (only touches request list handling)
- Well-contained to the nvme-tcp subsystem
- Adds simple validation checks without architectural changes
- Initializes list nodes properly to maintain clean state

### 4. **Clear Bug Fix Pattern**
Looking at the similar commits provided:
- Commit #3 (marked YES for backport) also fixed a validation issue in
  nvme-tcp
- This follows the same pattern of adding necessary validation to
  prevent malicious behavior
- It's fixing a clear bug rather than adding features or optimizations

### 5. **High Security Impact**
This vulnerability affects:
- Any system using NVMe-TCP with untrusted storage targets
- Cloud environments and multi-tenant storage systems
- Data centers with NVMe-over-Fabrics deployments

The security impact is significant enough to warrant backporting to
protect stable kernel users.

### 6. **No Complex Dependencies**
The changes are self-contained and don't depend on major architectural
changes or new features. The fix:
- Uses existing list handling APIs (`llist_on_list`, `list_empty`)
- Adds proper initialization with standard macros
- Returns existing error codes (`-EPROTO`)

### 7. **Follows Stable Kernel Rules**
This commit clearly follows stable kernel criteria:
- Fixes a real bug that affects users (security vulnerability)
- Small change with minimal risk
- No new features or architectural changes
- Important for system security and stability

The commit prevents a serious security issue where malicious storage
devices could compromise system stability or potentially gain
unauthorized access through memory corruption. This makes it a critical
candidate for stable kernel backporting.

 drivers/nvme/host/tcp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 13ede6e309092..25e486e6e8054 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -453,7 +453,8 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 			return NULL;
 	}
 
-	list_del(&req->entry);
+	list_del_init(&req->entry);
+	init_llist_node(&req->lentry);
 	return req;
 }
 
@@ -561,6 +562,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &pdu->cmd;
+	init_llist_node(&req->lentry);
+	INIT_LIST_HEAD(&req->entry);
 
 	return 0;
 }
@@ -765,6 +768,14 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
+	if (llist_on_list(&req->lentry) ||
+	    !list_empty(&req->entry)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t while processing request\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	req->pdu_len = 0;
 	req->h2cdata_left = r2t_length;
 	req->h2cdata_offset = r2t_offset;
@@ -2599,6 +2610,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	init_llist_node(&ctrl->async_req.lentry);
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true, true);
 }
-- 
2.39.5


