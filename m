Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01CA606A333
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vbCvJjEQ;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MMblfEVv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=RS9OuHr1dxcqz7WXLuJ9jvyk4W3FJXhyR6I3+QSBSRk=; b=vbCvJjEQcVYvPwytwUH55SrQTX
	yzbi6KaLhkAvxitdhtlSspArZ+1zNTvd01W28JWruCyISt6n9CjYMRt/+XP9Fsnyt/3vObCu3rrfG
	Y+A+byQyz0jCEnoeFZuc7LX2hK5m2qCZffjw3XAxMZ/STcCphHCD+BOXcYHdU+9NfprBQ5OHZ/6JC
	5I4I90mNo+MTAwl+ffLvVUejMaRyi6h6EcAZiD92ZLXIp4DiDQ1Pnv1GYRO2XJyJDmPGcckLOvJgZ
	NStYtFnQCoSYh5FzVK5FFy6SJTUWCpwPdz6CZTX/41Fsu+cZJ6rgYrP98rPDjJgUlMj5MY4gw+e7c
	nnivIoqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzyy-0000000Bf9p-43d6;
	Thu, 19 Nov 2026 11:07:12 +0000
Received: from out-53.mta0.migadu.com ([2001:41d0:1004:224b::35] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzyv-0000000Bf8t-1umb
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 11:07:11 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=JsHAg6d6Cqa/NH83H8PlasuyEv2XvEqbyZiTKCMiSGU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795086426; v=1; x=1795691226;
 b=MMblfEVvZWR/EGEysiTwmEwLlupqu07FWJbz7D6lGgpumJXw8BlCc3jXGroGBz3iec9So7N3
 GUEHGV7MUyAvb8VHbvdVHQFCJNglYLuv52zyadd/aRi/5pdRBknEUFb8ABVyt87fR3+cKQsCPfG
 jdFVrlZ4V+Lk7hKeWtiNKoIQ=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 5d0a2c69608c45af;
	Thu, 19 Nov 2026 11:07:06 +0000
X-Mizu-Trace-ID: 5d0a2c69608c45af
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v5 0/2] nvme-multipath: requeue work fixes
Date: Thu, 19 Nov 2026 06:06:59 -0500
Message-Id: <20261119-bug-nvme-mpath-set-live-srcu-v5-0-e1483e2e447f@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFPY/moC/43NPY7CMBCG4asg1zsrj//iUHEPREHsMbEECbITC
 4Ry9zVUEU1WU71TPN+LZUqRMtvvXixRiTmOQw39s2OuPw8XguhrM8GFQUQO3XyBodwIbvfz1EO
 mCa6xEOTkZnCdt63RAZVuWCXuiUJ8fPjjqXYf8zSm52et4Pv7T7gg1Avadorrjgd7uMZhfvx6K
 uwNF7HGcAMTwCG4phEtKi9a+Y3JNaY2MFkxb5XR6MlIqb4xtcbsBqYqJjBIY2VjnHVrbFmWP0j
 oVhWvAQAA
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_030709_703963_354E1693 
X-CRM114-Status: GOOD (  13.30  )
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

v4: https://lore.kernel.org/r/20261118-bug-nvme-mpath-set-live-srcu-v4-0-21f368376c8c@linux.dev
v3: https://lore.kernel.org/r/20261114-bug-nvme-mpath-set-live-srcu-v3-0-d84651de6334@linux.dev
v2: https://lore.kernel.org/r/20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev
v1: https://lore.kernel.org/r/20261110-bug-nvme-mpath-set-live-srcu-v1-1-1f58b405b0f8@linux.dev

---
Qiliang Yuan (2):
      nvme-multipath: apply delayed_removal_secs changes to a pending removal
      nvme-multipath: don't wait for a grace period in nvme_mpath_set_live()

 drivers/nvme/host/core.c      |  7 +++++--
 drivers/nvme/host/multipath.c | 21 ++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 26 insertions(+), 3 deletions(-)
---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261110-bug-nvme-mpath-set-live-srcu-cbd8965f1457

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>


