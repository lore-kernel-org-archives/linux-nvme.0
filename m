Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795060A2610
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c6Pbf5yE;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GLaLwY0a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=XSFLB3x5cg4Qq9AhX900ctXiU2ys0/PVB2JmwFmlE1g=; b=c6Pbf5yEvkkue6uF10UFNsXX+I
	ANb1FVZtbetZnqKG9Jams0yds2/wRXFDVJUIqfThSrlbHo+FnR0iuhqUXI9qV89WaO06JpVvVHBDh
	S43krrgE2Kxz3FKlDt88Ok2SeandUFvTN8Q/uY0lys6mQ/RA47AWr45zAUVsCtMes//acy2Cc8RZv
	3Ap5FJ5Uie2YWVZw32wDo4lTgEmOfGniD+gNG0mG7xQjs20O9V4OwcIUWQ66zY1uwSy41CKa13hFC
	vJIwUbatGuZygY29/D5/rD0GXp0Ga4vmQTn404y+d4DVF2TtBbDT7ZziKEd7Rm8jFL99OV65qvUaX
	LtKqNjtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xThl1-00000009Ku1-3Sqk;
	Wed, 18 Nov 2026 15:39:35 +0000
Received: from out-117.mta0.migadu.com ([2001:41d0:1004:224b::75] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xThky-00000009Kte-3dD7
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 15:39:34 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=wUWWwiodN86g+paMqAUcRxyaftQCwMM005OvWBKzt2E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795016369; v=1; x=1795621169;
 b=GLaLwY0aS1PLPVQ5UQtgNzy7ZUeKFAQ7FuEmrpiri9k3rxSwFzrhf9vn+TkC5j86ltZj7QfW
 E5xlNZrNKOXlzgbXGj7CHWRl8kuQVNW8WTkGqjnAtrMmRHPy5D+gcIRVk7R8N86ttxKxNV28zJN
 UyIfVTJU+Jx9tSDAN3b7gBak=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 68c2d5c81287a1c0;
	Wed, 18 Nov 2026 15:39:29 +0000
X-Mizu-Trace-ID: 68c2d5c81287a1c0
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v4 0/2] nvme-multipath: requeue work fixes
Date: Wed, 18 Nov 2026 10:39:17 -0500
Message-Id: <20261118-bug-nvme-mpath-set-live-srcu-v4-0-21f368376c8c@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKXG/WoC/43Nyw6CMBCF4VchXTum0wsXV76HcSF0Ck0ATQuNh
 vDuFlfEjWZW/yy+s7BA3lFgp2xhnqIL7j6mUIeMNd1tbAmcSc0EFzkicqjnFsY4EAyP29RBoAl
 6FwmCb2ZoalNWubaodMES8fBk3fPDX66pOxemu3991iJu3z/hiJDO6rJWXNfclufejfPzaCiyD
 Y5ij+EPTAAH2xSFqFAZUclvTO4x9QOTCTOlyjUayqVUe2xd1zdrY1HkYgEAAA==
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_073933_103315_767376A4 
X-CRM114-Status: GOOD (  12.62  )
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
V3 -> V4:
- Don't requeue the head removal in patch 1 if a path came back before
  nvme_init_ns_head() cancelled it, drop the module reference it held
  instead, as Nilay asked (race reported by Sashiko)
- Rebase onto v7.4-rc3-178-g20eef29b7c84 and update the numbers of
  patch 1 from a new run

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

v3: https://lore.kernel.org/r/20261114-bug-nvme-mpath-set-live-srcu-v3-0-d84651de6334@linux.dev
v2: https://lore.kernel.org/r/20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev
v1: https://lore.kernel.org/r/20261110-bug-nvme-mpath-set-live-srcu-v1-1-1f58b405b0f8@linux.dev

---
Qiliang Yuan (2):
      nvme-multipath: apply delayed_removal_secs changes to a pending removal
      nvme-multipath: don't wait for a grace period in nvme_mpath_set_live()

 drivers/nvme/host/multipath.c | 26 +++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)
---
base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
change-id: 20261110-bug-nvme-mpath-set-live-srcu-cbd8965f1457

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>


