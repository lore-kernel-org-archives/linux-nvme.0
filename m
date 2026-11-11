Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E52606A324
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F9g1Re3f;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cDMA6M5s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=j1vhH616yYJJATvrRAm08rA9jOsgZV21h5QRiE4wUNA=; b=F9g1Re3fuarGs3EcoNTBRo9NSb
	F7MGIIzifMAzGYU+3EZORG9JjvevRItetuTRv8MARPyCWL50q/kRieo3Za8XrWWZGdeyqpmF2PYge
	isu1JWHqr7KH8hLy+C2BhgPJ+4GbvH6opB8cA1Omt5Xm9mFI9WAFq6WnA89t4hbataYGWVpgQXKN4
	PJf8TaWw+RUl6IToTyNVM/oBDgq7qOi/q+kwaQCtwKSkf0jCoBQwkGd/tueu7BbS9KfwlwmYKemUe
	w4y5CnKONvcXdc8JnXwbX2IEWHb+RqFXSlI2cH6FSHmXv6qZwzTeOXMzitsvxY6OCps9AAqdUYVOb
	bu1wy4BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR86H-00000006mYu-3njm;
	Wed, 11 Nov 2026 13:10:53 +0000
Received: from out-246.mta0.migadu.com ([2001:41d0:1004:224b::f6] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR86B-00000006mYY-1fS0
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 13:10:49 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=8vsTho+fDtWw7vDJPfwLqBwvgAWnKw0AjJdAWw/f8TM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794402643; v=1; x=1795007443;
 b=cDMA6M5s8fSo2w4M1BMUTh91sL3O1o8xwvFrPxF8wY8umbQdVGAhnOmMWhZu4VBoir1iRah6
 RCa9ZM1sC9Vv+/lYqO4PN3LMNixClTKC8PwD7W1RK52dmXpsCHRqGLQJjhk7XbbMAeP+xMXy/TW
 GxKfwJUE36Jdbd7utI3+fkSk=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 86378f046b01e2b2;
	Wed, 11 Nov 2026 13:10:32 +0000
X-Mizu-Trace-ID: 86378f046b01e2b2
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v2 0/2] nvme-multipath: requeue work fixes
Date: Wed, 11 Nov 2026 08:10:20 -0500
Message-Id: <20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1p9GoC/42NQQqDMBBFryKz7pREjLVdeY/iwuhEBzRKEoNFv
 HtTT1D+6v3Fewd4ckweXtkBjiJ7XmyC/JZBN7Z2IOQ+MeQiL6WUAvU2oI0z4by2YURPASeOhN5
 1G3a6r56lMrJQD0iK1ZHh/dK/m8Qj+7C4z1WL8vf+KY4S04yqdCGUFqaqJ7bbfu8pQnOe5xdMQ
 A7MyAAAAA==
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_051047_604789_86CE9CA2 
X-CRM114-Status: UNSURE (   8.84  )
X-CRM114-Notice: Please train this message.
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

Patch 1 fails I/O queued without a path as soon as delayed_removal_secs
is cleared, instead of when the delayed removal runs.

Patch 2 stops nvme_mpath_set_live() from waiting for an SRCU grace
period per namespace, which makes an ANA change with many namespaces
take tens to hundreds of milliseconds.

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V1 -> V2:
- Add patch 1
- Take the SRCU cookie under head->lock in patch 2 (Sashiko)
- Rerun the tests

v1: https://lore.kernel.org/r/20261110-bug-nvme-mpath-set-live-srcu-v1-1-1f58b405b0f8@linux.dev

---
Qiliang Yuan (2):
      nvme-multipath: fail queued I/O when delayed_removal_secs is cleared
      nvme-multipath: don't wait for a grace period in nvme_mpath_set_live()

 drivers/nvme/host/multipath.c | 19 ++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)
---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-bug-nvme-mpath-set-live-srcu-cbd8965f1457

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>


