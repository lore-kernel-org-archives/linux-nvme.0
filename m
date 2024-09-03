Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537CDCD37AA
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rEtrU71KtZc72tZU2CSDMH0awSFNOCVm1mmNp0Qye1w=; b=KqZz6/ZJ/QahtLiwJYM2vq0rdb
	2fGbnYtWl22F2sRlbuJjqmi4TXQRVpZNwMx4xM3PhfrfuI1zqoJEIqrVeH+0dpGiene4Z1ajEmXR5
	NJqX5kh9y4cK1AwdxnwAqWFivR85BBYiVmNeNAtSzGO9J+rDSO0cTN96sx+KYv/L3pxytH+VAx52A
	F3uPvJ2E1lrbXfGBxQ4rKNqkRKiVjavUk2PV4S9sgSFSWGhjHYbN6ccLGHD9363OrGOej6W6xvV5a
	Y9rIUZ8ePJ9d6ZTQy/eDvJe2xdddp2w3c676uCmqwsvuIL8vIyPRrwMOZsiLS51pREsPD1tyqx+hz
	47mLjinA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXsm-00000001PJQ-35r1;
	Tue, 03 Sep 2024 18:04:00 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXsh-00000001PHH-0YOq
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 18:03:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B4D84A43D25;
	Tue,  3 Sep 2024 18:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BA0C4CEC4;
	Tue,  3 Sep 2024 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725386633;
	bh=4j/PP6WlOl91qm9w+3XgQDqzh+qI19i8nzFZA/mL4lo=;
	h=From:To:Cc:Subject:Date:From;
	b=Md8SKqADQ1AAnQtYsztphc0rFoatSk095sA7b2Kl/OifTTsPsY980cEt/j066chyy
	 P82hpz0FR6q9PHjk6F0OAuSS0xYMep07IhCI3zai+P0n/aC4kIBiFlV2sRpJR118U3
	 9ROKILR8xu52jAHHtlRSkrk9RVJVp2KwQTRyOD/cf59c7NjyfAv52pPwukjIRzw8iy
	 rOl76EHDdequMpJf4r1Ewp+GSdPKsAU3GBEQtSF3+W6WptX5P0fgTJz8GYuatUx9K7
	 9NvGlIYe1jG+DubLyh4Zw3+femLwT+ylAIxHKUpqAiHSvCi7Qh8im2lEZljwXJv3F0
	 mmnWwGcRoz6Cg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/2] nvme: NSHEAD_DISK_LIVE fixes
Date: Tue,  3 Sep 2024 20:03:43 +0200
Message-Id: <20240903180345.35253-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_110357_468464_40DD6E12 
X-CRM114-Status: GOOD (  12.93  )
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

I'm have a testcase which repeatedly deletes namespaces on the target
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

Changes to the original submission:
- Drop patch to remove existing namespaces on ID mismatch
- Combine patches updating NSHEAD_DISK_LIVE handling
- requeue I/O after NSHEAD_DISK_LIVE has been cleared

Hannes Reinecke (2):
  nvme-multipath: fixup typo when clearing DISK_LIVE
  nvme-multipath: fix I/O stall when remapping namespaces

 drivers/nvme/host/multipath.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.35.3


