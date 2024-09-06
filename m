Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90D0CE7AFF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zitg1bo30R9vTF7ZiWmBNgk4sk5T5iqNAWqvxIK95XI=; b=EHCGS1bEUiWqCQ94NBincUOZGk
	C8FymYZSx5SzYmVPZYVueyQai6B2IpzL3yWiJTspQRUB0Bz2OknJzsCXxzED8swhE+Qi1JBBIcSsF
	poWrK/R41l7un9sga3S/EnZwlYK7ty6LCzVSGTugWDlGnOAaotL85ElQ+qZ9qx7VX9KfLfk468dk/
	mwFAJcx2V9LdoS3wIbo4KdF+rrLk+RHEYEAkqEaRznS4HObN8xWNJreBW4+U1Frrb/PS96Rg+8C8w
	YS6l+h0si7R2gYHokOf9PHF/Awderq1LufqpSEjExk9PQKPMqdDyWVKYN8rcedzsj2HBjVEhtTrbn
	nIHNYliw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smWAn-0000000BkZ1-0u1x;
	Fri, 06 Sep 2024 10:26:37 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smW1U-0000000BiFi-2R9l
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 10:17:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5E5F8A44DF7;
	Fri,  6 Sep 2024 10:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B46C4CEC4;
	Fri,  6 Sep 2024 10:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725617819;
	bh=wgeqfqyT0Kv6pHRRSeEs5KOPt76hxNkYoKV/KJrq8Tc=;
	h=From:To:Cc:Subject:Date:From;
	b=khmKlCwMGh+3BVGW8hubXBPvu594wvaWh96WylG9iSZYxgywYQmgO10Pen7SgaEgw
	 XyO9lWKz3ZveFOWusyxhApT5q25IVdcNH+KF7ZFpFObwV+AYtqKWN2kI6ZP/HiEu01
	 hWRaz8i/A/jePvLGJkOw+TcUljqlCiXJR9vAbCpTTugnbx0zglsv5XsONAmiZlwQot
	 lznKLc70a7RSTFzHicqTVnUAx30QiyFSlQ8dch/rVMVYKho83uzbcMPU/Eg7Emy+XS
	 zjdjbiUN56sxC2CLQG8bQ70dfPE6nMD9eC47mt5uHKd7XsrRmTjApNQYCAHL8uAtaN
	 7X4r0Tp1HixTQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv4 0/3] nvme: NSHEAD_DISK_LIVE fixes
Date: Fri,  6 Sep 2024 12:16:37 +0200
Message-Id: <20240906101640.44417-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_031700_704945_744B8A95 
X-CRM114-Status: GOOD (  17.03  )
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
  nvme: 'nvme disconnect' hangs after remapping namespaces

 drivers/nvme/host/core.c      |  7 +++++++
 drivers/nvme/host/multipath.c | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.35.3


