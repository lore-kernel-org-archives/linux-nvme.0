Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE58606A32A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 01:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zr4W0mAe;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W/oOPQgR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=k/SrSoqD0XKlGfHllc4/8SbwU+cxTP9RsCoMnlVdirg=; b=zr4W0mAeP78pCp4gbbSxCoNYKS
	rQJCPQFn9xfDz3CLnSYHJwOLZYSQhKbwL8BKh64SH/nsz/BvWwV2AGCQuJxRHpIS6gom+hMwEzn1c
	EGQ//ghbWgctwK+KDsl55inI32PfCi/5sd8BQiH+BnTgdnWNd8RcNKdmAIPmNkbnmsIvigHLdzb4F
	Ad7hwqzOZnoTjcdWqvI88+SeFnfUDiuUQ5QD8jGcwgXBt/a+gP0NkeMGUWNgbxWcnizEfjRx9hGyO
	Nc1MxVkNBe9YHu+PWcrqWiMk4nNLwkkvX+3eDNKegV66kXnv7dU9Ws0GGx1Xi6Uw1rDBsrAKqoII4
	M0E7P1OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUDNY-0000000DpNF-1j6Z;
	Fri, 20 Nov 2026 01:25:28 +0000
Received: from out-242.mta1.migadu.com ([95.215.58.242] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUDNM-0000000DpMR-2Qg0
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 01:25:19 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=tnm0JuXY2qIER75j9eVktrXznS7mUHR4O4OAjzn9HFM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795137911; v=1; x=1795742711;
 b=W/oOPQgRb6oHHy2CXVS9ZiP99hqzgydy3q3wUc6JtpJKlmpkmZQp9YjaeSE6c4WY4dFCsW6l
 UVNGwvu9GiEYbqpndbDfStJTOROAyl5OimthdCJqpMmtJGjbxix4THxCW6dMM/xYGiiHePOh4gM
 GsSyymD3meFCbDxAvRUHWVH8=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id d2d3f08acb5ce771;
	Fri, 20 Nov 2026 01:25:11 +0000
X-Mizu-Trace-ID: d2d3f08acb5ce771
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v6 0/3] nvme-multipath: requeue work fixes
Date: Thu, 19 Nov 2026 20:25:00 -0500
Message-Id: <20261119-bug-nvme-mpath-set-live-srcu-v6-0-da85b18b274b@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG2h/2oC/43NsW7DIBDG8VeJmHuVDw6MM/U9qg4xHDFS4kRgo
 1SR370kk+XF1U3/G37fU2ROkbM4Hp4icYk53sYa5uMg3HAazwzR1xaykQYRG+jnM4zlynC9n6Y
 BMk9wiYUhJzeD673tjA5IuhWVuCcO8fHmv39qDzFPt/T7Xiv4+v4TLgj1grY9Nbpvgv26xHF+f
 Hou4gUXucZwB5PQQHBtKzskLzu1xdQaox1MVcxbMho9G6Voi9EaszsYVUxiUMaq1jjrtpheY90
 OpivGSFaxZKI2rLFlWf4Ak2PNr/wBAAA=
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_172517_719276_0BA944CC 
X-CRM114-Status: GOOD (  14.22  )
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

Patch 1 keeps a large delayed_removal_secs from wrapping around into a
short delay when it is converted to jiffies.

Patch 2 applies a new delayed_removal_secs to a head removal that is
already pending, so that clearing it fails the I/O queued without a
usable path right away instead of when the old delay expires.

Patch 3 stops nvme_mpath_set_live() from waiting for an SRCU grace
period per namespace, which makes an ANA change with many namespaces
take tens to hundreds of milliseconds.

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V5 -> V6:
- Add patch 1: compute the delayed head removal in 64 bits and cap it
  at MAX_JIFFY_OFFSET, so that a large delayed_removal_secs doesn't
  wrap around (Sashiko)
- Patch 2: kick requeue_work when delayed_removal_secs is cleared, so
  that queued bios also fail when paths remain but none is usable, and
  use the capped delay of patch 1 (Sashiko)
- Patch 2: keep Nilay's Reviewed-by, as only these two changes are new
- Update the numbers of patch 2 from a new run

V4 -> V5:
- Cancel the pending head removal under subsys->lock in
  nvme_init_ns_head() and drop the list_empty() check and module_put()
  from delayed_removal_secs_store() (Nilay Shroff)
- Rebase onto v7.4-rc3-230-g4405c18c95d2 and update the numbers of
  patch 1 from a new run

V3 -> V4:
- Don't requeue the head removal in patch 1 if a path came back before
  nvme_init_ns_head() cancelled it, drop the module reference it held
  instead (race reported by Sashiko)
- Rebase onto v7.4-rc3-178-g20eef29b7c84 and update the numbers of
  patch 1 from a new run

V2 -> V3:
- Requeue a pending head removal with the new delayed_removal_secs
  instead of only kicking the requeue work when it is cleared
- Rebase onto v7.4-rc2-470-g7e1392a42ea2 and update the numbers from a
  new run
- Don't carry Hannes's Reviewed-by on the v2 patch 1, which is rewritten

V1 -> V2:
- Add patch 1
- Take the SRCU cookie under head->lock in patch 2 (Sashiko)
- Rerun the tests

v5: https://lore.kernel.org/r/20261119-bug-nvme-mpath-set-live-srcu-v5-0-e1483e2e447f@linux.dev
v4: https://lore.kernel.org/r/20261118-bug-nvme-mpath-set-live-srcu-v4-0-21f368376c8c@linux.dev
v3: https://lore.kernel.org/r/20261114-bug-nvme-mpath-set-live-srcu-v3-0-d84651de6334@linux.dev
v2: https://lore.kernel.org/r/20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev
v1: https://lore.kernel.org/r/20261110-bug-nvme-mpath-set-live-srcu-v1-1-1f58b405b0f8@linux.dev

---
Qiliang Yuan (3):
      nvme-multipath: keep a large delayed_removal_secs from wrapping around
      nvme-multipath: apply delayed_removal_secs changes to a pending removal
      nvme-multipath: don't wait for a grace period in nvme_mpath_set_live()

 drivers/nvme/host/core.c      |  7 +++++--
 drivers/nvme/host/multipath.c | 37 +++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 41 insertions(+), 4 deletions(-)
---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261110-bug-nvme-mpath-set-live-srcu-cbd8965f1457

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>


