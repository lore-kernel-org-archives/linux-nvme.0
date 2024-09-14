Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3FDC02194
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Sep 2024 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EWY6vj8Fj9nAoR4T1Ij6RnuwdWuvQBQWXyDmKordOos=; b=kLCAEGbGNX55Wn2ufj1bAQ23DT
	pS7Rq0kWmUGqxPtgLuKvCM+dAs/+g5m8Vj4DKSq/T1h7NBQJPLARHqw6G7pxmywPs7N0yU3SntgZ/
	CCwbckM5ATRHmfjBmzhUQMkLUhH4bQjnx0TZtGyva8d9vQPtxFYblQr8J/oqiTllz1GMEBHBXu8uL
	+sGx2aBaDKSik54GMAtqaJ6upaIXkrICQl/Pdjsl4c3q+3H8Q9qple/RngxK9O5Pyu/tAWGS8LtB7
	HUORW+4r0BNOLglPYczmdd+MzyTODhtDiFXN2A7sOjxWqI7PwX6AM0bplLVTyJUrSTIraYJT9zLTm
	reywNFDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spRT7-00000000e2w-0dnJ;
	Sat, 14 Sep 2024 12:01:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spRT4-00000000e28-1Zq5
	for linux-nvme@lists.infradead.org;
	Sat, 14 Sep 2024 12:01:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 10FD35C0015;
	Sat, 14 Sep 2024 12:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BB1C4CEC0;
	Sat, 14 Sep 2024 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726315292;
	bh=k+7sdjfZCQ7wTgatkgGu77zUGxuZTj2pz4I5lsIDUJs=;
	h=From:To:Cc:Subject:Date:From;
	b=pQdP1nRt2BmPZjbOJ2bLqtE+Plq5x/226izGVhg3ImUbIxouyaLk6x1P13MenJVCw
	 QHBmhX9oIO5M2tz8WWhqgF8ii/bsDHji+dUzAmKZ3bDbAb505rWAJmO7XC6F6NfR3k
	 Wg1VjIJDUhhnxSEcrLT5Bd3VtYtBxcROeL4VP2BSSz+uhdlm7XUVkb4O2Ojnvl9dQf
	 33puNDRgWAEiPuzQPrsWxJHDKtsrmRAPiuzgU4FAgCN6e4QrZQIX9W0tjewXrwMcQ9
	 WH13OwlCs8RSI2SG7U5pDziFNKDcK5KV3Mo32dag2vwMh/wTq8nSbsLP8Q6qz5GY3y
	 Z9knEZ+3W8kMQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv8 0/2] nvme: NSHEAD_DISK_LIVE fixes
Date: Sat, 14 Sep 2024 14:01:21 +0200
Message-Id: <20240914120123.125967-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240914_050134_510224_E7E7F750 
X-CRM114-Status: GOOD (  16.14  )
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

With these patches (and the queue freeze patchset from hch) the problem
is resolved and the testcase runs without issues.
I see to get the testcase added to blktests.

As usual, comments and reviews are welcome.

Changes to v7:
- Drop last path
- Update patch description

Changes to v6:
- Rename flag to NVME_NSHEAD_FAIL_ON_LAST_PATH and fail I/O only
  on the last path (Suggested by Sagi)
- Retrigger pending I/O on every ANA state change

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

Hannes Reinecke (2):
  nvme-multipath: system fails to create generic nvme device
  nvme-multipath: avoid hang on inaccessible namespaces

 drivers/nvme/host/multipath.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.35.3


