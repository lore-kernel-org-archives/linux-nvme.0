Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCBBC5B552
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 13:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dEaAQXB4GmpoyUpefg5X0Qgi/CHqlrRhboMjtCckDh4=; b=qmIZxhnOUNHyy+ERCgUrmOnpI5
	+pbkxtzr3TR0tJxKgH8swW1zVB6X8DPoYMysNYPJ7NBO68gLr7e3BnOqEogHMC/Ls/AgTif/HX7Yx
	p79Ng7KJC6fs5+X/Y8WOp44uFhYUVwcCfVGtYP1q0M7yd/SAwaG7wPqzcRbcJcw3R8U+04U1dIrhL
	RmG/pODkt5ducw+87FfOqvUFXhTXnS730+QK10vDj38VtawfRtYuPivWRk3BqoiS9xYWSJol4dPV7
	tHVrYhaC5Azvh8LETXaaqvFG4RWMUrFqU2E6obxhUBWJz5Ik97icaalKWA4jWbbRw6SaqVvPsCs7W
	38/jxLqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOcqB-00000004HVM-4AdP;
	Mon, 09 Jun 2025 13:47:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOcoP-00000004H1H-0GWM
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 13:45:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8A4BA5C0667;
	Mon,  9 Jun 2025 13:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09329C4CEED;
	Mon,  9 Jun 2025 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476714;
	bh=Abs9S2945jQSsxN7n7zFDdFEWQn4R4N3TTzRenZeQXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfzGRI1fkKkVlekEuC9AMFSBOMspR7nCDvewfnxx5mkyc1nyxWhkBwVFz9qlGMAHE
	 IFvnudm1w6J/Wu4Jjlv42iicAQqHI3QZ7jba3rC3k4rqD8sbFWyVhAgr2ypRkuve61
	 6ZIWh+QpqeALawkZegkKV1WMIJtY2FS90dYkp3NmMSsU3dg0V2e9s5wGPf+gXCvoxE
	 SOUEXKZg26U6sGHJl07rp5huatT1M729tfZF8CB8tFwtTIzDbolURGCWnaDhyoipn+
	 E6gnybThqw7QHypbwTWF1kUMy45VMSe41BGzcvFFg7MQQShr6+s4H5c5z+wavatksx
	 487QHzyuSU3Ng==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 02/29] nvme-tcp: sanitize request list handling
Date: Mon,  9 Jun 2025 09:44:43 -0400
Message-Id: <20250609134511.1342999-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609134511.1342999-1-sashal@kernel.org>
References: <20250609134511.1342999-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.10
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_064517_190564_3E8DB3DB 
X-CRM114-Status: GOOD (  17.33  )
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
index a2e825e37b38b..28310b124b4ea 100644
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
@@ -2588,6 +2599,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	init_llist_node(&ctrl->async_req.lentry);
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true, true);
 }
-- 
2.39.5


