Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C61C021BC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=d8dkwCK8yD9XDYA1bMBdn7W05LDQzmeCRDVPt7P+pqI=; b=Bny8Q/wUGLYoD9
	Ux8FHdPhxAaDuxIl+cFfUNyULbRH6EvUqG+lGIR/TTbLaqU1uvD6hg293vrufyjwfwliFNdtPUrCJ
	DpOr7fK7Pfkg6qJnLrB/uRkYsAFgbGKaCN2MEckj3ZSXrA1K3ogUTzQLI24sVv+Y6MNKkcxRunSjd
	fNcgcri9wqKBndZQAdiPUTIku7nExxhje3EF5URb3yB7DndqOpzoFo6druQAC6yEtWU90h8LVS3Ej
	iBcLB7A+R32rM9Os3kxi9QTdCaEgNIOktbZPDyk7+GDMJK+ADk1PJII04e+066T+4sb55/VvC7gKc
	eXGibBDYWTxTT8JHoKeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMPv-00000005058-0KkR;
	Wed, 26 Feb 2025 18:45:59 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMPt-0000000504p-3LBl
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:45:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 546DD61503;
	Wed, 26 Feb 2025 18:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC58C4CED6;
	Wed, 26 Feb 2025 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595556;
	bh=l7UD7IetAj7BmrCoDO0U0uQx/vTHlH3SaHjBpIIiXwo=;
	h=From:Subject:Date:To:Cc:From;
	b=gHoCcHaE6zHSuAJOBBTmSXgjrkQwNsFNU+3QHgpgWz47MT2/kNVqBR0KK6ILdr1Yj
	 NR+lhGDlUw6ppeSmY0xTyMvMGEm2OX7k5u0/cWa/YJJHx0BmMVZMbb01qRcGvLgIUr
	 bLOUyv2tuQnaGUPQqKejvmpYWOViVWCJOBV647o//9XYxpPauzd3EA/cICfkNutxeS
	 I8ZTcVa8UqdhUIKJmqg/Z40uFXU0NeFmLYGI3wWQognmPAO2+gwtjx8CgpCQ6t4Xyk
	 VP9agKNXiTXmdCT7y9CUj27BYAhINMi+HfCqqW0o346swVwR+ghr4aXF5fTFY69nqm
	 wb6XgpdaCQnFA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 00/11] nvmet-fcloop: track resources via reference counting
Date: Wed, 26 Feb 2025 19:45:52 +0100
Message-Id: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGBhv2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MT3byy3NQS3bTknPz8At1EMxNLc2OLJPNUs1QloJaCotS0zAqwcdG
 xtbUA6pQdMF4AAAA=
X-Change-ID: 20250214-nvmet-fcloop-a649738b7e6e
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

The fcloop module is mainly used for testing, that is with blktests.
Unfortunatly, there are shortcomings when it comes to releases resources.
E.g. unloading the module can result in UAFs.

I've written two new blktests which are triggering reconnects. The first
one is doing this by removing the target while the host is still up and
running. The second one is trigger a reset via the new debugfs interface.

Both of these two tests cases work fine for TCP and RDMA but not FC.

By introducing reference counting on various objects the UAFs go away.
Also KASAN is happy. There are also a bunch of fixes for nvmet-fc which
got uncovered by the fcloop fixes.

I still see one UAF sometimes happening. When the association attempt
fails (looks like yet another bug), the test case removes all resources:

 (NULL device *): Create Association LS failed: Association Allocation Failed
 (NULL device *): queue 0 connect admin queue failed (-6).
 nvme nvme1: NVME-FC{0}: reset: Reconnect attempt failed (-6)
 nvme nvme1: NVME-FC{0}: Reconnect attempt in 1 seconds
 nvme nvme1: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
 (NULL device *): Create Association LS failed: Association Allocation Failed
 (NULL device *): queue 0 connect admin queue failed (-6).
 nvme nvme1: NVME-FC{0}: reset: Reconnect attempt failed (-6)
 nvme nvme1: NVME-FC{0}: Reconnect attempt in 1 seconds
 nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
 nvme_ns_head_submit_bio: 29 callbacks suppressed
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
 ==================================================================
 BUG: KASAN: slab-use-after-free in nvme_fc_rescan_remoteport+0x56/0x1d0 [nvme_fc]
 Read of size 8 at addr ffff88810b662890 by task kworker/u36:10/1876

 CPU: 3 UID: 0 PID: 1876 Comm: kworker/u36:10 Tainted: G        W          6.14.0-rc2+ #48 d5f3bf6340950de08bebd912d815fcf6b60c18ab
 Tainted: [W]=WARN
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-3.fc41 04/01/2014
 Workqueue: nvmet-wq fcloop_tgt_rscn_work [nvme_fcloop]

static void nvmet_port_subsys_drop_link(struct config_item *parent,
		struct config_item *target)
{
	[...]
found:
	list_del(&p->entry);
	nvmet_port_del_ctrls(port, subsys);
	nvmet_port_disc_changed(port, subsys);   /* XXX triggers the above UAF */

	if (list_empty(&port->subsystems))
		nvmet_disable_port(port);
	up_write(&nvmet_config_sem);
	kfree(p);
}

The nvmet_port_disc_changed is a bit useless, because these event will
never be seen by the host. Anyway, more debugging is necessary.

I'll send the new tests cases for blktests soon.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (11):
      nvmet-fcloop: remove nport from list on last user
      nvmet-fcloop: add ref counting to lport
      nvmet-fcloop: refactor fcloop_nport_alloc
      nvmet-fcloop: track ref counts for nports
      nvmet-fcloop: track tport with ref counting
      nvmet-fcloop: track rport with ref counting
      nvmet-fc: update tgtport ref per assoc
      nvmet-fc: take tgtport reference only once
      nvmet-fc: free pending reqs on tgtport unregister
      nvmet-fc: inline nvmet_fc_delete_assoc
      nvmet-fc: inline nvmet_fc_free_hostport

 drivers/nvme/target/fc.c     |  82 +++++------
 drivers/nvme/target/fcloop.c | 326 ++++++++++++++++++++++++++++---------------
 2 files changed, 255 insertions(+), 153 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250214-nvmet-fcloop-a649738b7e6e

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


