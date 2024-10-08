Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FC3CEF173
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Vy8KnHWRMQKQurdN2A1OY9r3gCTmAtOt29GKsB9/4G4=; b=ikImHM/Q28p1ChTrXEn3Oio70F
	lCYzMu+KyUwUbfPH19K46jbEeA2j7WbyoqWaADDzDK3IY/qNn24SVnrIeIjrmOu5kxpFAfKpXA+t0
	zDkKvMPZtzhcXnlytK3MFjaD++0CEU2uKRRCPNtvwjwDAiZ9rvuDe1PJ3AZnLpUBCAp0Tiq9aAWH6
	5dljHNhfDLY5Jh9xhh4SMiBnIy0ufckQpeCpYtCBsxArQtcouUFA0NuBmcsC8QhlqCaKVbRf5GBmU
	yt29Xl8jAd3avzPAvyUkxzUVeEBggqZHiP0nCG09jOKZK1D6Ue/GZKxq0wZl2oCpvAyWi9AFjkMYK
	VBvqgwEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syAic-000000065It-2t9R;
	Tue, 08 Oct 2024 13:57:42 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syAia-000000065IB-0SFb
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 13:57:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 26C96A41D85;
	Tue,  8 Oct 2024 13:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C3DC4CEC7;
	Tue,  8 Oct 2024 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395858;
	bh=comiIbawU19gnzycBBNXXDTiRojA63LgEu9tbclDGNI=;
	h=From:To:Cc:Subject:Date:From;
	b=gBznnYXGGirClfFV0U5TSM877MM4W2ho45KrZrKEY2I+u64iPmtC900PglzYoE+Ky
	 2VODEI2tKMfAPdcC28AimEggk9VKXhDeFZSnUEDXmUolL/EzI2Ym1rlZxLId2N7L7y
	 llhlkKEiMaMQydZ3NiQh5P5VuHUL1i+6S/73kW3jSHZkXer8kyap+prifNxJPbZssG
	 Wke6O/iwhjC0NJ3X+7wJEf/TdbDYF2601ph4sIoIRRbiTbuFTQM1qcOErU2uFlLXaH
	 HY0Yexx0H5F4Tl1/4zxa70gmtp4blYEmHeIDBXhri+ILX7q1Fb4rSKpOicJgx0KDAU
	 8OXseKiEiIHDA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/2] nvme-multipath: fix deadlock in device_add_disk()
Date: Tue,  8 Oct 2024 15:57:27 +0200
Message-Id: <20241008135729.68810-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_065740_239684_B9A6F480 
X-CRM114-Status: GOOD (  11.92  )
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

From: Hannes Reinecke <hare@suse.de>

Hi all,

I'm having a testcase which repeatedly disables namespaces on the target
assigning new UUID (to simulate namespace remapping) and enable that
namespace again.
To throw in more fun these namespaces have their ANA group ID changes
to simulate namespace moving around in a cluster, where only the paths
local to the cluster node are active, and all other paths are inaccessible.

Essentially it's doing something like:

echo 0 > ${ns}/enable
<random delay>
echo "<dev>" > ${ns}/device_path
echo "<grpid>" > ${ns}/ana_grpid
uuidgen > ${ns}/device_uuid
echo 1 > ${ns}/enable

ie a similar testcase than the previous patchset, only this time I'm
just doing an 'enable/disable' bit without removing the namespace from
the target.
This is causing lockups in device_add_disk(), as the partition scan is
constantly retrying I/O and never completes.

With this patchset I/O errors during partition scan will never be
retried but will cause nvme_mpath_set_live() to fail.
This allows us to retry nvme_mpath_set_live() on the next rescan
to fixup the situation.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Drop patch to simplify the loop in nvme_update_ana_state()
- Rework patches to return I/O errors during partition scan

Hannes Reinecke (2):
  nvme: propagate I/O errors during partition scan
  nvme-multipath: retry partition scan on errors

 drivers/nvme/host/core.c      | 26 ++++++++++++++++++------
 drivers/nvme/host/multipath.c | 38 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 3 files changed, 60 insertions(+), 6 deletions(-)

-- 
2.35.3


