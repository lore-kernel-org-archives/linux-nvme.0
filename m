Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC40CA600C
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iY/xzhTxB/DcicIj0alQZwLmGEwIgigA+J+BWOz3Za8=; b=kA+Ca+9NxFknp8yo56t1Ew1SwE
	bRi/X2FkGVJTeftwDr4Ge93jeoarKaLsoPR8E2mAp/ysyMHUSzJm7akcn/LCScAfv7eH8V8Bv+Nke
	Mb7KACf1RKPlkriZScUdv9xl7/NLW39QEuc6tutOk46+ZGrYD09A34x7VILfyl7WMfn/bPHbDmiDu
	Mn/Cb1jc6Aaz++MX6r/W/2HaaE0cyvP41aamdYbytrTx8FXCYNxCUakRJaMcIwBfvnSVYz2lAOOS9
	lzaWwUbGX6ymHxHdyzdS6uzewamKtX+AK/VBTIpHLHb5sW+2VT2WXSlx2hy1cGFOHUHIpM3/hBhIa
	ORc3jaNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEosx-00000004WHT-17cs;
	Thu, 08 Oct 2026 14:14:15 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEosv-00000004WGQ-09fj
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 14:14:14 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so3869545e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2026 07:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1791468851; x=1792073651; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iY/xzhTxB/DcicIj0alQZwLmGEwIgigA+J+BWOz3Za8=;
        b=b2/s8saVjELWZVUHn4yv7EaWvch40XxNV2g9i+MmB0IBfPhC1kiw0HSW83qoFgC5za
         NyEZgSRruCKPK943L8kKI7DKM75mtIdsEQ7ElDeV2oPHOzKeYsK4Kc/iDhjO8ryTRld4
         DbbhaHQ5XSRcsgRcmvNuM3aVIghBtw04VggERckX22JeOWxm83iXZpPZL9wk04A+TqAY
         C2H1eO0uJPMzxU96HlqakpNck8Ll+lfK7DTiCriU4/jlFEowmilhm/Hw7Gxxnm2hIk3J
         PaykSQvtoxm5YYAS2p8Mg7+mfiHx091w3nYkzAYgiyI82EoW7pUAouTFQS7jL6iinDJk
         lhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468851; x=1792073651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iY/xzhTxB/DcicIj0alQZwLmGEwIgigA+J+BWOz3Za8=;
        b=S7bQo1QqECafdLnA3roUlq/pRUKU/qHnHGjn2Ni84C8Y4TM0W8A7m6p47RXPF48zTu
         CagRhwRcjaVB0WkS+ZA+N1GgInZBwDr3XZdvk2UPkgzN5pzz/tKdkc0yTVlkkr3bIttd
         rHdHtr06WQsSK9oeGc5upCaEH3k+fvwgZhLtHDO//AZ25UNRNafs8hdbND7WlPdJGA3R
         AzYo36EwOi4RWsUbbSqlKbWXUxuohwKE1bkrVUpvKYL8BU+iJb1b6Fa+qYk37/kF3BNG
         K7GQ48hUHZCanvU5eJ2VJCNyIDbForUka6CF4xiFm6qtkP0psqHBT6auFNtPGF3BM4G2
         sonA==
X-Gm-Message-State: AFuF++nVPlW3eiuzwEqfomTy96hOejy2/F3h4y9NquCIxEQyNbRTQPBW
	E07kg09e3jtVYHjgTmJ72H3TgsLVptpWOClcmXcEg0pMVZTcE4PJDl7wfzWUWaIRdd0=
X-Gm-Gg: AYBFou0Vc2BAj99xG0UbuvfYsNV5jjOH6PD5gQNhKtNIsUAse5mctC6Pew8kSVKNkw5
	Z/+7ENinZBgEXjDT9fzegwNHO8q+5TNhq6guPgZ8oDu/T6YqPvTFxjtmmGaxdsyJ9W0OsOVM8WN
	aq2agQGn8atLxrZXju4sy2Bdj+XbTaGYgN8j9v+0DmIcNAWXXAlo2JBXVFz8a6pD8WSKUpd6Hrj
	pNQgceEgYM6iw9OC0n+/5i5mO4I920DxkRZf2SwUpQsPoLLC/3VCvrBWTmlsrHxaDXmuqMEQ5jZ
	e/n38AD6QuefsDaKA67S0MopEmlXWFn4vFbkGtLZG863Mgz0sBG9kpaZw6/FN8yYZPe6eSoWSQm
	dW48ELmuAeLS38hDKjcP/rvVnkybha2K4plpKIIC7gwMCvmQUsBo2xGXJ3+pL2k4XmR0djBM3br
	xrc4CcFaKburm/+XcfTiiM1Qpu7QiRQNHWyyeAEYkRpR8ef8xTxHrxEBHGrDlrtmFxtSDR2K1PA
	RBQCCphJGCGZZnt0zMJSeP5R3D02p2b0W4=
X-Received: by 2002:a05:600c:1c21:b0:4a1:6425:be69 with SMTP id 5b1f17b1804b1-4a1804234d9mr120595225e9.17.1791468850603;
        Thu, 08 Oct 2026 07:14:10 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([80.95.100.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a185d914fdsm113358935e9.7.2026.10.08.07.14.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 07:14:09 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com,
	hare@suse.de,
	saravanand@crusoe.ai,
	sjpark@crusoe.ai,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH v5 0/2] nvme-multipath: fail I/O when no usable path exists
Date: Thu,  8 Oct 2026 07:14:05 -0700
Message-ID: <20261008141407.22992-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_071413_108595_4BFD5A7D 
X-CRM114-Status: GOOD (  16.52  )
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

On virtualization hosts we run NVMe/TCP targets with ctrl_loss_tmo=-1.
During a long fabric outage, I/O on a multipath namespace is queued
until a path returns, so a SIGKILLed VM process cannot exit while it
drains I/O to an unreachable target and is stuck in D state.

Patch 1 fixes nvme_available_path() so it stops queueing I/O that should
be failed, by default and without any flag:
 - respect fast_io_fail_tmo: when a path exists but its failfast timer
   has expired, fail instead of falling through to queue_if_no_path
 - a LIVE path whose ANA state is inaccessible or persistent-loss no
   longer counts as available (ANA change stays transient and queues)
 - kick the requeue work from nvme_update_ns_ana_state() so parked I/O
   is re-evaluated when an ANA transition leaves a namespace inaccessible

Patch 2 adds the fail_on_ctrl_loss attribute, an opt-in per-namespace
policy that fails parked and newly arriving I/O instead of queueing it
when no usable path exists. It is the namespace-scoped counterpart to
the controller-scoped fast_io_fail_tmo, needed because sibling
namespaces behind the same controllers must keep queueing while one
namespace whose consumer is gone releases its parked I/O. It sits
alongside delayed_removal_secs as a per-namespace policy in
nvme-multipath sysfs. Controller state is untouched and reconnects
continue.

The intent is exactly per namespace differentiation, some namespaces
stop waiting while others keep waiting for the same controllers to
reconnect. Patch 1 fails the conditions the kernel can detect, an
expired failfast timer or an inaccessible ANA state. It cannot detect
that the consumer of a namespace has exited while its paths are still
connecting, so that case still queues by default and only an explicit
per namespace opt in can release it.

Changes since v4 [4]:
 - Rename the attribute from fail_if_no_path to fail_on_ctrl_loss, and
   the flag to NVME_NSHEAD_FAIL_ON_CTRL_LOSS. fail_if_no_path read as
   the inverse of queue_if_no_path when it is not; the new name reflects
   that the policy stops waiting for a controller that is gone or
   reconnecting (Hannes, Nilay). No functional change.
 - Add Reviewed-by tags on patch 1 (Hannes, Nilay).

Changes since v3 [3]:
 - Split the single v3 patch into a two-patch series: the
   default-behavior fixes first, the opt-in attribute on top (Hannes,
   Keith).
 - The ANA inaccessible and persistent-loss handling is now the default
   and no longer gated behind the flag (Keith).
 - New: respect fast_io_fail_tmo. When a path is present but its failfast
   timer has expired, nvme_available_path() now fails instead of falling
   through to the queue_if_no_path window (Keith).
 - New: kick the requeue work from nvme_update_ns_ana_state() so parked
   I/O is re-evaluated when an ANA transition leaves a namespace
   inaccessible (Keith).
 - Patch 2 now carries only the attribute, rebased on patch 1's
   corrected defaults: it gates the CONNECTING case and overrides
   delayed_removal_secs, taking precedence over queue_if_no_path when
   both are set.
 - Document the fail_on_ctrl_loss vs delayed_removal_secs
   (queue-if-no-path) interaction in the ABI entry (Hannes).

Changes since v2 [2]:
 - Use the nvme_state_is_live() helper for the ANA state check, keeping
   the explicit NVME_ANA_CHANGE carve-out so transient ANA transitions
   still queue (Nilay).
 - Return early when the stored value matches the current setting,
   skipping synchronize_srcu() and the requeue kick (Nilay).

Changes since v1 [1]:
 - Rename the attribute from fail_io_now to fail_if_no_path (Nilay).
 - Make the policy persistent instead of self-clearing. Drop the clear
   in nvme_mpath_set_live() so it stays set until userspace clears it.
 - Enforce it inside nvme_available_path() by controller state. A
   CONNECTING controller and a LIVE controller whose path ANA state is
   inaccessible or persistent-loss stop counting as available. RESETTING
   and ANA change keep queueing. With no controllers left it overrides
   the delayed_removal_secs window.

Validated on hardware with a 6.17 backport of this series: parked I/O on
a SIGKILLed VM process failed within a second of enabling the policy and
the process was reaped, new I/O failed fast during the outage, the
policy persisted across path recovery, and disabling it restored
queueing.

[1] v1: https://lore.kernel.org/linux-nvme/20260904032605.65758-1-kiyer@crusoe.ai/
[2] v2: https://lore.kernel.org/linux-nvme/20260917231647.79956-1-kiyer@crusoe.ai/
[3] v3: https://lore.kernel.org/linux-nvme/20260923004959.88440-1-kiyer@crusoe.ai/
[4] v4: https://lore.kernel.org/linux-nvme/20261001094857.74567-1-kiyer@crusoe.ai/

Krishna Iyer (2):
  nvme-multipath: fix path state evaluation for failfast and ANA
  nvme-multipath: add fail_on_ctrl_loss sysfs attribute

 Documentation/ABI/stable/sysfs-nvme | 16 +++++++
 drivers/nvme/host/multipath.c       | 74 +++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h            |  2 +
 drivers/nvme/host/sysfs.c           |  4 +-
 4 files changed, 87 insertions(+), 9 deletions(-)


base-commit: 2ee54f01f07c0307deaf90ca8691a4643ae0357b
-- 
2.54.0


