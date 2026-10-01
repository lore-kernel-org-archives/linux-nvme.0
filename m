Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D2ECA5FA5
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2026 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e7JKuc+UM6J7vMN5pxtMu3jOLdN1mwy5ealpXQmuqWg=; b=ffUXwvtXoMwT+s0keda1TwMc4j
	X23OkEfnlQwaeRs38bm0yAArcsbnDjZM34e47+aHt7MsgqrSCI1llARl3oJ8ef2y5tCmMJxcaCVNQ
	ZWVNoY4Ad14+LRS2waKTJJPqvuGdS6C0wGOMLnvhiw2CdfkbgfQCLHC9QaegPjqnr8NBWUReOpDc1
	7wM6bKihZURnPkDAjbynYjJo9QhjZ0TPYn3lzfZF43RgZ4KR+ojma/p3pOEXOGIPiZZrHJu34zfED
	/IwrNAfrkYicfioptSs9Z2BL3QjRX50gYGDQYe1aBjFxqT+552ov4hPbxzauxhHa7mm+J4p+kTMfH
	9dCgH9GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCDPZ-00000008QDz-3qRE;
	Thu, 01 Oct 2026 09:49:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCDPU-00000008QCf-0kXJ
	for linux-nvme@bombadil.infradead.org;
	Thu, 01 Oct 2026 09:49:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=e7JKuc+UM6J7vMN5pxtMu3jOLdN1mwy5ealpXQmuqWg=; b=VKmsjO2M2no/tCts43mM3gtwXE
	9v/QoE2UFx0su0Z3p6OXZuGToEd3+QGa6wqBkXIot+5Dg4hLz98583HGCw2Dr0gAVdCDJaScONaWh
	LrJWmTl+xFiGuyqyr8MI6OmZGpAv8UjzUs/ulhwmEMoXWlgxgUABHi38oGRJo5YAVRpOWMj/DXqCY
	IuxQ83dKQGo9V5Wwh7znZRTtNG990I7Zyq/fD1W+ciH4JbCJpqWW6ncQG/qxFhWqMglEuKKrC+sae
	wUoTcd37muTYwF0SgHW8tKkFGdWL6MnlGR24FSWRrhBO1ph2uZsfWmm/w4RwSf+f4hNVAm+BmLH25
	xkZUrW7w==;
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xCDPQ-00000004oQc-48zK
	for linux-nvme@lists.infradead.org;
	Thu, 01 Oct 2026 09:49:03 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso57813775e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 01 Oct 2026 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790848139; x=1791452939; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e7JKuc+UM6J7vMN5pxtMu3jOLdN1mwy5ealpXQmuqWg=;
        b=PAg80HiivXQyEYnohjBs9BBaV+6I+nx4ECTSpc0XUZ8cY2fz4Dy0ZFynH0MCzxCpau
         VYoubvFI3D8p+WBn/jaWj25n9fZTQiUYl23dSkcW8+1alLV84oW4I7kFmSvyIrlE241B
         4akP6neJhYeefgdQsqDgn1RZX09qp5RU3BQ5CPw0/ZdhXk+IEYFvPvqW32xC/YDmgVYX
         mMpZSfxx9FrQma0a9SmZKQiaD2fRyOdArx5QFWtD6VBLi7OYehvyAoOqbfVNyT3t5x2p
         +FqQdOrey4/aYxBel27SRR8YSadyTCvuAAQQgMbDhdxOn3tjOy8zuuAIjMx+YwhBdkQ6
         SboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848139; x=1791452939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7JKuc+UM6J7vMN5pxtMu3jOLdN1mwy5ealpXQmuqWg=;
        b=LxkHUCrGPAwnXXFBYS2iiXewEw5wbbPSaBxdOB0GsrofdxyuNOVo9DHhJD5Gl/dr4N
         76uNlxpyekYgx/Nqh761AcvigbKRf3e1lZt6fxK0YhKTQLCN6awq0uGnXPwneI89fxAN
         Rew+607nU/MxQ0/kgKgTHyPa/pL/HrFwoVKjgmpDMLpfCiN89g70IjsPXzvQ3vegrgcB
         k4luaB+L13jUEC4rsN4lVX6382pfHEAM5JVhW0XqYQV5+aij5aXXhm47r9WcWjpaH3lQ
         mmUlTNb0ioDfd4Qdv9XjJWWVCWcrPTv3etbG3DvoBSSEC0P5MIxx/KG8FYCvXgQyG/6O
         rwtQ==
X-Gm-Message-State: AFuF++l+wUqHBSjCxXLb0LlWcFg41Om4ExQf5Zfl/SYu3808dCzNQWuZ
	RO363NeHQxXbJW7L6HS2ZzeZKTKahvjnLdfsT+ydzkl3aq+JOsmKlkhSs1BMYKpZA4E=
X-Gm-Gg: AYBFou01ppg6sVJx61dBh9q9ZWzdRvw580eGi+bh+GX3VL8Hxe5LJl0lpc2iFqKhL6j
	dsj6SbVVVFwxkYjvIe/AH79GENho4+y4a1yAana7pp/suZ8Qgu/XGPqmNWrADsncClvLGbz++aL
	nhR0Pn4qijHS3NEWh3fDIGZyANt8JDfxCoFC9G19w4UoBvo/L2lP6gjgbmIesATBA8pqfJictB1
	hhqxXwAtXRw15mzimbbEHi86bktCXuhxoh/6xZ691EfzmNFTGtuqBL9qgsGb+HzXEI9rCvXKq9Q
	dVptx/AoP4QqFTvvsivpcFOIuxutAXLGicfsohAAf1ActPQ/Be1tzGLq1w+b5W99bZM0VmAnZyw
	50UE4knLfPznQsGyc4g6KWtELjtB0isB2ivWj6hA9IijqK6qC/Qp6GkhS+BFUQbFmoujJw1vM3z
	RqIaTsWmPyleBItMbxRieaVeCjLMnPNY1iqa2AVTMnwd4dX/ubpP+Jtb8yw90ABuIyg7MaS1mze
	enKIbP9j80LGFCWmJrKta3c6n2BQCgln/y+
X-Received: by 2002:a05:600c:6815:b0:49f:bd3c:bc28 with SMTP id 5b1f17b1804b1-4a01b13532fmr71687085e9.35.1790848139033;
        Thu, 01 Oct 2026 02:48:59 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([83.71.242.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0db6de0dsm1938341f8f.43.2026.10.01.02.48.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 02:48:58 -0700 (PDT)
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
Subject: [PATCH v4 0/2] nvme-multipath: fail I/O when no usable path exists
Date: Thu,  1 Oct 2026 02:48:55 -0700
Message-ID: <20261001094857.74567-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_104901_237034_678DC317 
X-CRM114-Status: GOOD (  16.76  )
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

Patch 2 adds the fail_if_no_path attribute, an opt-in per-namespace
policy that fails parked and newly arriving I/O instead of queueing it
when no usable path exists. It is the namespace-scoped counterpart to
the controller-scoped fast_io_fail_tmo, needed because sibling
namespaces behind the same controllers must keep queueing while one
namespace whose consumer is gone releases its parked I/O. It sits
alongside delayed_removal_secs as a per-namespace policy in
nvme-multipath sysfs. Controller state is untouched and reconnects
continue.

This answers the question from the v3 review. The intent is exactly per
namespace differentiation, some namespaces stop waiting while others
keep waiting for the same controllers to reconnect. Patch 1 fails the
conditions the kernel can detect, an expired failfast timer or an
inaccessible ANA state. It cannot detect that the consumer of a
namespace has exited while its paths are still connecting, so that case
still queues by default and only an explicit per namespace opt in can
release it.

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
 - Patch 2 now carries only the fail_if_no_path attribute, rebased on
   patch 1's corrected defaults: it gates the CONNECTING case and
   overrides delayed_removal_secs, taking precedence over
   queue_if_no_path when both are set.
 - Document the fail_if_no_path vs delayed_removal_secs (queue-if-no-path)
   interaction in the ABI entry (Hannes).

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

Krishna Iyer (2):
  nvme-multipath: fix path state evaluation for failfast and ANA
  nvme-multipath: add fail_if_no_path sysfs attribute

 Documentation/ABI/stable/sysfs-nvme | 16 +++++++
 drivers/nvme/host/multipath.c       | 74 +++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h            |  2 +
 drivers/nvme/host/sysfs.c           |  4 +-
 4 files changed, 87 insertions(+), 9 deletions(-)


base-commit: 2ee54f01f07c0307deaf90ca8691a4643ae0357b
--
2.54.0


