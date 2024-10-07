Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B85FCFB440
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c9/GYNINPgoYXdkkiavTv9Ei1TiLYiyt1Di2ZpkwtMA=; b=ync/JsEFYBNsza6pgPptsPHdRK
	nKLxqBKHWi7KzRe3QbknWFVtFflqjGUyxasIaxfuJg4diL4p41HYFV4afPVfDhmkbcXKuDpEi/KvM
	0ND75hqRhKGNCs9hbGWThuVamP2WPNPkYnS4+FEb34VBmj6CnQc3jl26oOt9iaBpaOc8QmT8d5lQQ
	aTV/fRtlE2HsdrG2NXpDC2V8RWAOu/Y8My0BTwVhhRlluVz5M6po/k8Zpe33ERAxbnIBFNCCrOJVn
	O88MSYsDkqXS1VPG7ZRfGdm5h7OcalrROv7zsxaVcz44ebENPLM5hyWuNXNVIC+j+84Zzdfp4TJBl
	mq1tj9ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkZA-00000001zEf-3hP8;
	Mon, 07 Oct 2024 10:02:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkYl-00000001z8v-1lP8
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 10:01:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EC64C5C5BC1;
	Mon,  7 Oct 2024 10:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98233C4CEC6;
	Mon,  7 Oct 2024 10:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728295305;
	bh=Mxuc0QNPbZhZzjpYYRtLpwX4YijKKl2cpRFRKLBrL94=;
	h=From:To:Cc:Subject:Date:From;
	b=n21Revm1ic5o6vOnk2gH7IaFUKQucCZtBu3YssFGHJ551yqyxL43GiMlyKeh1ThAO
	 FEG1c3e0Wv8Fe8ferRBLt2M98vqdAbtHQip+pUq4zW8G0bNeg7RPrQ5O/cHMVrl3Eu
	 tUEKbhITWOM1qOt2OD4jExzGbMBHrwXbJQqDdlfDGqapDHnPYCa8WIonQWI8staT4f
	 MarZOHtUlugxw+qGn/4wSlC3JCvaH2mHTsXp+0ewsQQhbt2gR2vKNILWvuUhvSnOsm
	 c+w59aNinkTiaMSMaUHl2L+sMmF41zsOsC+CdYYpFgKYcoZx4KFfvoCL16kI0ymumD
	 +1gzg7OJ8XyRg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/3] nvme-multipath: fix deadlock in device_add_disk()
Date: Mon,  7 Oct 2024 12:01:31 +0200
Message-Id: <20241007100134.21104-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_030148_394484_2FE1AC1F 
X-CRM114-Status: GOOD (  11.63  )
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
Funnily enough the very same issue should have been fixed with
ecca390e8056 ("nvme: fix deadlock in disconnect during scan_work
and/or ana_work"), but that fix seem to be imperfect.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme-multipath: simplify loop in nvme_update_ana_state()
  nvme-multipath: cannot disconnect controller on stuck partition scan
  nvme-multipath: skip failed paths during partition scan

 drivers/nvme/host/multipath.c | 51 ++++++++++++++++++++++++++---------
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 40 insertions(+), 12 deletions(-)

-- 
2.35.3


