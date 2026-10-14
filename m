Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9554DC3DA7A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIwvec8ywWVSJmGxLO9s3tCy/XMVy8O1ZUKsdE77wh8=; b=vcGKI5rR9GEHO4Z2niSJbq0O93
	j0LxdfdVPX/evZwqhLya5B2cHkgP3QU33g3Q8vwWP+qOjT/+HcHOMHuPoH20hREyLmJRojGl520bG
	EdXjDG+UvlwscMnSlaIZuS7r2sJMvSJ8kwcvVeBHTfHptKQwb8SycYcBxN5+x955yNQ8nkU/cj+rD
	9uALq/NCK5WAOw0bgLBOe/qgxaJ6su0V8vDGItSl8C3ZYvlCj0dd2YN/pUCOJSJwW+JFMCjdFVxAX
	+IvkIptaF6kZoQBC7CpLMf6Wbk9YB+S3GcGy6gGCHLLX9MdoaaWaWhR1zvsO8fItIdXWce2ZmxOwB
	OmLhLNKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH4PA-0000000GC3o-3XCG;
	Wed, 14 Oct 2026 19:12:48 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH4P8-0000000GC2x-3uKf
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 19:12:48 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-35b2c599f43so5790250eec.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005166; x=1792609966; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIwvec8ywWVSJmGxLO9s3tCy/XMVy8O1ZUKsdE77wh8=;
        b=EIk7rxAL3yt4zebdGUl6JV7SNEbGU7f+ml/jykOPe16rN9jj+BkKHKTlFjnnSwEB2z
         z07w7S7hNsdD/98gg/GXaX6FchEFVHpYApZ0GRI7VhlA9m7RKumLZsWbwWxC3bBn72gA
         XWQtMSJJs6TrfZP33CcaEWzH09iaWu+d/2Gz1wX1uY9RQB+dF9DvT2kvS+/ENzn6Fbq4
         7T9lbtQ2FHYlu6Jv8L4Y9CZ7u9oFfMb0PJI4SiJDUyV3M2Ca58KytoYW3APqT4UJXJ+Y
         wG/XR1lTIb5oXTSzxveSbFAVKnS/hwpqpwLnUVhRHg2cdP0T811ZVaJEHp49ynVKWet6
         j1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005166; x=1792609966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZIwvec8ywWVSJmGxLO9s3tCy/XMVy8O1ZUKsdE77wh8=;
        b=XESZKiThWqWY47OQycrzCYTD7xCwysSQcai//kyh8tbL1BxyC+TJp1M3j1rg2GnizM
         y8F6Rfp2EPYlsnzDDqrv1Bq8PULQF5WW10jP3ZKNNS7vxnauB0n68MNmPCcYWEGS97oo
         bhhS61ZrfYGtsDccrqUuVloT0Qu37RvnGKP8Ktg9+9ukRoHoQZTbXXAFhqEcaeQlQGKz
         Kjo8LDZcCs4rBPj1yMthQy/aA5Ei67ZLebBiW4PFrrmCBVuOlsGTqAhHmz7jO1pObiCC
         W0W4Wq57MZUy96exLS+wV4sSGUgs10qX8uup62VsDOkU2Tl3OLmQMZvTHtp0lBdD2x8N
         mTzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpzfg6OK/UmqxsknqUqBIevkl17UP23G5ZGN9atT3aNFj41YDE/HLQ9iENkXgt9bNfYyHV50ph0sEN@lists.infradead.org
X-Gm-Message-State: AFq9FYK4Zyyz86GJR4/7BD2Pzp1lWUjh7jtPDMZz3nYUcw3ytMRSeeqX
	h3pEi7EVeyhBQUxdWTUVai/DjM8rPFcYdAalt7qkXmqtCPpJ40W2+wlzfs3ZnFy6d9w=
X-Gm-Gg: AYBFou3V8s8FF/YAzRbnmgPJ0gPs2YbyBzysjU/tu0Ce3OY2gUfOj77MDszz09WMPNa
	2voOhqiJhm7gg8a4jkkqzTHo+BwAj6kP0zvKeO82z3VBxs7sEVp+ZPLb9/X1+GPML4YUVXevWU9
	TMcDjXqHwJTvhxjFNO5ygyRl0/l5XEFPTayCZDLLzQuQ2OkIIP0USnWWscS8fgT/K61Cy4Q9mz8
	MW5SETbLSJ7YsNFjQUWcBlV579mkyIa6dEM4LhSM6cP82cbUIEqB20Rb0sRMKQ3R4X62RSbHQ6+
	5or6sQQWUd8UFgbSB6qRI/rKhWhLxld8iEFz7QXZRPxN72U9vSmohffaW8D01gezZPMNsxwsq8G
	ntbXLCXYAdHALXUgQZwsWIWvWEdn1QMnUC8M2NmfNFVxXrfpn9LQRyHxID4cDMeHVmUEfKZ6pyj
	pBfzqhSUDN2BAW+nYQ3taijJOPma94rjSZCwt7cz6oDgV2R5Lub1E7E3EYZc8jNWzoE3oc1wA+f
	GAanJ9N10xC3HFy7lKSsS2waOoOJW43QfzEyvzuYsoj3DyRcFruRlzNzbyYFIQtacWbAQ0=
X-Received: by 2002:a05:693c:8642:20b0:358:d3d6:207e with SMTP id 5a478bee46e88-358d3d625b3mr19902741eec.11.1792005166088;
        Wed, 14 Oct 2026 12:12:46 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm54329888eec.28.2026.10.14.12.12.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:12:44 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH 6.6.y 2/2] nvme-tcp: sanitize request list handling
Date: Wed, 14 Oct 2026 15:12:36 -0400
Message-ID: <20261014191236.23696-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014191236.23696-1-artem@trailofbits.com>
References: <20261014191236.23696-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_121246_996225_B8C0FCA6 
X-CRM114-Status: GOOD (  13.73  )
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
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2025-38264 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: x86_64 objects
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 drivers/nvme/host/tcp.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 88489a787e677b142c3ce89db0ea06603c021bbd..e270024fe549096b8d8588e73b67cc2aed28d910 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -385,7 +385,8 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 			return NULL;
 	}
 
-	list_del(&req->entry);
+	list_del_init(&req->entry);
+	init_llist_node(&req->lentry);
 	return req;
 }
 
@@ -493,6 +494,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &pdu->cmd;
+	init_llist_node(&req->lentry);
+	INIT_LIST_HEAD(&req->entry);
 
 	return 0;
 }
@@ -739,6 +742,14 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
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
@@ -2374,6 +2385,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	init_llist_node(&ctrl->async_req.lentry);
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true, true);
 }

