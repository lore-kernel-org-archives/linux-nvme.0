Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C57CE7AE0
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wX7Jwv4eLaOAe/VUuHWiBtbUedyNtCzsOKGVq84z//c=; b=3oJkVEUBEezDTNnOtvxrY2vW6a
	pRgNqNUswZt75TT35oSeLS9/HCl7c9JY+owp956bHC9rBPpA7+wC0vkZhdHRGNaqU2Jcyc106s8cw
	n8+jTTom4CYF01svkupyYjZUrNWyEyYb/JECIGpbhHDxPig6n73TrXhawhceE/9P3ryZryTbxD3Ff
	tBbFct3v/JS4oTVLh1pXPPCaOrWdgiaJL9gec8M71szOoTIASL6wtI9Gd1Ydv7Xtwof8HNN+JEDyI
	UBrkd3p+47CC0Zzln8guw9FQvo0Zd8dfKffE9OEVpBftHT5D1fc2vhSx2xOdar7+IjPgS0/FTRRQK
	w0aEZ1DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTPB-0000000B5CX-0mlX;
	Fri, 06 Sep 2024 07:29:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTEu-0000000B3T8-0pI3
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 07:18:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B36D05C107D;
	Fri,  6 Sep 2024 07:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B4BC4CEC4;
	Fri,  6 Sep 2024 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725607118;
	bh=eGJHdpU0YIEkr/UIcI//7AQSIv0FJs7QM6KmA9z5DYE=;
	h=From:To:Cc:Subject:Date:From;
	b=Xyj2e64pxA2JsXPo7NoimAy54d2WkDmFe4GaGuJKH4w/Md7oZdXZ+NllT88/St6gn
	 znj7wci16ZwCJMNXQJeA7BNazlXKv3H8ZHUQQclhN7CnC+YDREe0wZX4Sjn/6LW5n/
	 uZDgK5PqwUKfxS8/g9chhNeyoXEfRmFf08nxjLiZpBwrGzoaEVLea/JLaMgAndyuNj
	 920RUw0G4f9JKdhv39MY/X8tuNPpkMiQ9CrjWULgbtoPfjxnoHfusKkQjZM4H1i0vP
	 I8ztjHntjQGkDTdcwOl74y8zMOMLUqoIzO489zKsrxvnyULhSqLrNdVJNcyxUNtsS/
	 xhUlX+5yrma9Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3 0/4] nvme: NSHEAD_DISK_LIVE fixes
Date: Fri,  6 Sep 2024 09:18:24 +0200
Message-Id: <20240906071828.125614-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_001840_324537_07544420 
X-CRM114-Status: GOOD (  17.14  )
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
with I/Os constantly being retried, and we are unable to even
disconnect the controller. To fix this we should set the
'failfast' flag for the controller when disconnecting to ensure
that all I/O is aborted.

With these patches (and the queue freeze patchset from hch) the problem
is resolved and the testcase runs without issues.
I see to get the testcase added to blktests.

As usual, comments and reviews are welcome.

Changes to v2:
- Include reviews from Sagi
- Drop the check for NSHEAD_DISK_LIVE in nvme_available_path()
- Add a patch to requeue I/O if the ANA state changed
- Set the 'failfast' flag when removing controllers

Changes to the original submission:
- Drop patch to remove existing namespaces on ID mismatch
- Combine patches updating NSHEAD_DISK_LIVE handling
- requeue I/O after NSHEAD_DISK_LIVE has been cleared

Hannes Reinecke (4):
  nvme-multipath: fixup typo when clearing DISK_LIVE
  nvme-multipath: check for NVME_NSHEAD_DISK_LIVE when selecting paths
  nvme-multipath: always requeue I/O when updating the ANA state
  nvme: set 'failfast_expired' in nvme_remove_namespaces()

 drivers/nvme/host/core.c      |  7 +++++++
 drivers/nvme/host/multipath.c | 23 +++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.35.3


