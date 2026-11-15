Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C1606A881
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2026 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gENqzU73;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZU1nKBIC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=wJNVAE3hGD0xcBHiAlWrWhW4WsfP9kLdE+Td0+I2msM=; b=gENqzU73ppq9/9lUnneNrD5NjW
	Xubf3a0yr8ZUXc834b7GKxiMO2ZtLO0t6qn5WON7dhsDgBYDJBzGvdatAlRD3WS8dvfvrmyP64GBA
	JH9DEDUlJOOPlNIlUHXYakXbBbbTzRgJGkOj4s0NujtnXQCib5ryGUn5U46ZUy2euk8rwpGF/V3mr
	PsAcFofiLvUHLcEezbL+pqzb4xnnUXl8ckVHGuQEIF8wOQ5yeybOW0n1YdDa9kQAOBPjT9cnD8KBz
	Jw5h+fCSX8SZUYA7rIDqacmxHOIGWrBqGg3pCuUNI4ZacxFKgV+SmcdXHfhhhrTW/puoi6oPVb8An
	5e3GuvCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSPmb-0000000GzZ3-39FR;
	Sun, 15 Nov 2026 02:15:53 +0000
Received: from out-41.mta0.migadu.com ([2001:41d0:1004:224b::29] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSPmY-0000000GzYJ-3dN9
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 02:15:53 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=3drfX2ZBZryBc5zS9B5q86kzE5mXeu2a2mkIXNoI62U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794708946; v=1; x=1795313746;
 b=ZU1nKBICQ1DeTN0JCAINs7K+BGUZlJpHxQPhe+9PaVtZvHgM1usp4/5Rabd2cb2RFYtyZpGF
 KmCfJPygT+F4Gik6ePgzOsYQIpXrCIh81u85Pg2mUj9bqAb9hEh7XEzOmy6GmXoI3QjxlON1peY
 nXgUzsN5rHPdLfrX2W8kJwcQ=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id c4ac8462579227ad;
	Sun, 15 Nov 2026 02:15:45 +0000
X-Mizu-Trace-ID: c4ac8462579227ad
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v3 0/2] nvme-multipath: requeue work fixes
Date: Sat, 14 Nov 2026 21:15:37 -0500
Message-Id: <20261114-bug-nvme-mpath-set-live-srcu-v3-0-d84651de6334@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMkV+WoC/43Nyw6DIBCF4VcxrDsNoHjpqu/RdCEwKIm3gBIb4
 7sXXblrM6t/Ft/ZiEdn0ZNHshGHwXo7DjHSW0JUWw8NgtWxCac8Z4xRkEsDQ+gR+qmeW/A4Q2c
 DgndqASV1WeXCsEwUJBKTQ2PXk3+9Y7fWz6P7nGuBHd8/4cAgnhGlzKiQ1JTPzg7LetcYyAEHf
 sXYD4wDBaOKglcs07xKr9i+719Vsf5qFQEAAA==
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_181551_268712_AF5CA12C 
X-CRM114-Status: GOOD (  11.12  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch 1 applies a new delayed_removal_secs to a head removal that is
already pending, so that clearing it fails the I/O queued without a
path right away instead of when the old delay expires.

Patch 2 stops nvme_mpath_set_live() from waiting for an SRCU grace
period per namespace, which makes an ANA change with many namespaces
take tens to hundreds of milliseconds.

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V2 -> V3:
- Requeue a pending head removal with the new delayed_removal_secs
  instead of only kicking the requeue work when it is cleared, as Nilay
  suggested
- Rebase onto v7.4-rc2-470-g7e1392a42ea2 and update the numbers from a
  new run
- Don't carry Hannes's Reviewed-by on the v2 patch 1, which is rewritten

V1 -> V2:
- Add patch 1
- Take the SRCU cookie under head->lock in patch 2 (Sashiko)
- Rerun the tests

v2: https://lore.kernel.org/r/20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev
v1: https://lore.kernel.org/r/20261110-bug-nvme-mpath-set-live-srcu-v1-1-1f58b405b0f8@linux.dev

---
Qiliang Yuan (2):
      nvme-multipath: apply delayed_removal_secs changes to a pending removal
      nvme-multipath: don't wait for a grace period in nvme_mpath_set_live()

 drivers/nvme/host/multipath.c | 18 +++++++++++++++++-
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)
---
base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
change-id: 20261110-bug-nvme-mpath-set-live-srcu-cbd8965f1457

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>


