Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A0EEE4987
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=94MSOOvbWR3TBePAF9m6wbMokvd81NAjZ6i+OnQgJuY=; b=mtKO8vW1rvHgstAN5uzRyqjFlW
	M5aRfMt0OHKNqEfdM0yKJJldRO4NEbNn/NB9U9TipWcTgAaBuOCAZlVOpDdz8IzTAmwXtBobcBVnX
	yd3DqKfO7FZsOc0GRPA2Ci93vkzj4MogGGZmhTNIybMZB9PjTZy/PX1ZH26g9e+AmM5AXdiDLl1ZE
	NrUgsK/lomr8LK224vCaJ2VaCb/bun7eyOHvnvkwqraJBfqRqA+2CdIuRsOcrcQ6FutoYKD2+PyZO
	Vhpk3ojy2jVXBak3kNp9Q3poRNoVho3ACLPkIoF2lWEoe105ZN2gsZRrWtUcWSqLh1cahH41C1Y0T
	2yFFGsRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soK0X-00000008zQp-1ZoJ;
	Wed, 11 Sep 2024 09:51:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soK0L-00000008zMk-2oWM
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 09:51:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 371765C0509;
	Wed, 11 Sep 2024 09:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A61C4CEC5;
	Wed, 11 Sep 2024 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726048275;
	bh=yykYvq5LQKjlZRJeOVSzrXTSG8f7G6AKOjmvFFErurc=;
	h=From:To:Cc:Subject:Date:From;
	b=ToOzAirX6NWIJoO0HHuH19wDZc89WbFg2g46t41D35u0tym+9+HSca3ntGPOoMtg1
	 ejEIlqyZNIkWgYh+SmjFMmDZezXTAlJtDdjcgvEQZN4mWsNi1lYY01VUPXYg9NwUJa
	 sU5RXhtrnTtrwD6BNM10mhmuhIifxazeQD/sHKPunbLPV8m1uqdXA6q8hPBAQsLbHq
	 VcMKCtdJGqU7eK5DU7w15cXuXDVy7NPtKAkdG8+DvRPkQDtaEHxqY5FVlPjQn6Yed5
	 zyu3iTE86uDBXh/SKFFmzJ8Nmi45Fm+0NrrIxkoD+vQd2s04euLBrjIgf39gpKmDgP
	 n1efbI6BL9xgA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv6 0/3] nvme: NSHEAD_DISK_LIVE fixes
Date: Wed, 11 Sep 2024 11:51:04 +0200
Message-Id: <20240911095107.121688-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_025117_863943_C40FB8BD 
X-CRM114-Status: GOOD (  18.01  )
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

Hi all,

I'm having a testcase which repeatedly deletes namespaces on the target
and creates new namespaces, and aggressively re-using NSIDs for the
new namespaces.
To throw in more fun these namespaces are created on different nodes
in the cluster, where only the paths local to the cluster node are
active, and all other paths are inaccessible.

Essentially it's doing something like:

echo 0 > ${ns}/enable
rm ${ns}
<random delay>
mkdir ${ns}
echo "<dev>" > ${ns}/device_path
echo "<grpid>" > ${ns}/ana_grpid
uuidgen > ${ns}/device_uuid
echo 1 > ${ns}/enable

repeatedly with several namespaces and several ANA groups.
This leads to an unrecoverable system where the scanning processes
are stuck in the partition scanning code triggered via
'device_add_disk()' waiting for I/O which will never
come.
There are two parts to fixing this:
We need to ensure the NSHEAD_DISK_LIVE is properly set when the
ns_head is live, and unset when the last path is gone.
And we need to trigger the requeue list after NSHEAD_DISK_LIVE
has been cleared to flush all outstanding I/O.

Turns out there's another corner case; when running the same test
but not removing the namespaces while changing the UUID we end up
with I/Os constantly being retried. If this happend during partition
scan kicked off from device_add_disk() the system is stuck as the
scan_mutex will never be released. To fix this I've introduced a
NVME_NSHEAD_DISABLE_QUEUEING flag to inhibig queueing during scan,
such that device_add_disk() can make progress.

With these patches (and the queue freeze patchset from hch) the problem
is resolved and the testcase runs without issues.
I see to get the testcase added to blktests.

As usual, comments and reviews are welcome.

Changes to v5:
- Introduce NVME_NSHEAD_DISABLE_QUEUEING flag instead of disabling
  command retries

Changes to v4:
- Disabled command retries when the controller is removed instead of
  (ab-)using the failfast flag

Changes to v3:
- Update patch description as suggested by Sagi
- Drop patch to requeue I/O after ANA state changes

Changes to v2:
- Include reviews from Sagi
- Drop the check for NSHEAD_DISK_LIVE in nvme_available_path()
- Add a patch to requeue I/O if the ANA state changed
- Set the 'failfast' flag when removing controllers

Changes to the original submission:
- Drop patch to remove existing namespaces on ID mismatch
- Combine patches updating NSHEAD_DISK_LIVE handling
- requeue I/O after NSHEAD_DISK_LIVE has been cleared

Hannes Reinecke (3):
  nvme-multipath: fixup typo when clearing DISK_LIVE
  nvme-multipath: avoid hang on inaccessible namespaces
  nvme-multipath: skip inaccessible paths during partition scan

 drivers/nvme/host/multipath.c | 22 +++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.35.3


