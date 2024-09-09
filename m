Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB7FCE7AB0
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ObKGxE9BYdy80KK+MyJ/9FWrKL8Ot/zYPzC1mM8gVBk=; b=WGeUvV1SztS7pRClKNrz4tLshm
	WocQrEju47gC8Pzjnf5JcNm7foZHYrgqcqZJjKgmbtz6uYX6VfIM+ZCzYChk7+GmCa0gWqOj1KRoE
	hifbgAvmIApRy28iMBzU2mtMFnbF3U4ENISbVmU1yz9gF0jPq8JyX063pEW3utAz+fRD7Dfzn5pBf
	8B9EP+Y9Jpf7xX9PyoaHmPVTdBt3DLUxrMFZqQl8hVm3JBv6JXx56WTDWiaqSYKDAfYKWKwTnrBiO
	hgx1KjqhaPGOKEnfnb2/O3VtqJMtgz6kh/+zcyG5ddhZw0ryKrYoGRi852ygYJ1AxxQHIBJ9a5cr6
	YAFwV54A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snYgd-00000000mfF-1aOV;
	Mon, 09 Sep 2024 07:19:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snYgY-00000000mdl-41Ij
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 07:19:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E98245C557E;
	Mon,  9 Sep 2024 07:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2580C4CEC5;
	Mon,  9 Sep 2024 07:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725866380;
	bh=/gC/bimjreAedcKj/2n48mT0Y31AdnjZM/hzC+LYsdM=;
	h=From:To:Cc:Subject:Date:From;
	b=XGEPiJmwKWKgMOmKfW/7QL9GKW3ep294UXY5oJNTwrSq95Io26nXPDuKiTgKIp2f8
	 pWno74zLMQWCguLRjLUE+78n5nyP7ilv+KIEjCrsrYh0+RqrDU/bH0cWDDqCxTR2vP
	 KM+7giEySvV4iDLF1AOL3XQNNUAOXBTjTr0c4Xz2i9bpkn735qYaBg2lN901c5urQH
	 Vc0liiOd2zkRJDocQ1nwMZOA5srHHSuWRrIqamAg+qG1OaBOHF3/IONTYtJbyFgMg1
	 XkvnRIXOIOO0sUd5i6aw0cCp32AEV982SSC1vR8Gt0L5pfZMsCWlDn/UfAfAn5okIu
	 kJ/Pfb3pgLegg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv5 0/3] nvme: NSHEAD_DISK_LIVE fixes
Date: Mon,  9 Sep 2024 09:19:27 +0200
Message-Id: <20240909071930.146343-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_001943_070872_15ABAE01 
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
with I/Os constantly being retried, and we are unable to even
disconnect the controller. To fix this we should disabled retries
for failed commands when the controller state is 'DELETING' as there
really is no point in trying to retry the command when the controller
is shut down.

With these patches (and the queue freeze patchset from hch) the problem
is resolved and the testcase runs without issues.
I see to get the testcase added to blktests.

As usual, comments and reviews are welcome.

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
  nvme: 'nvme disconnect' hangs after remapping namespaces

 drivers/nvme/host/core.c      |  7 ++++++-
 drivers/nvme/host/multipath.c | 14 +++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.35.3


