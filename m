Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE44606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=E2PvZYko;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ApNlzF6l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=jDnww6JI8klr6K2Oh65kdjtr6PFrG0V4ksGmbutISOU=; b=E2PvZYko+b8yqK1gTUYRH3SA36
	PrjytDl0n8aCdx2ghDKewijf3pPFMkZpxLolm4XX7raPqjWXcHCwDDPnhuesYGvcpkSQP2ZXjIdeZ
	jUDl+JL57zzXko32rpKQe+lB1iLf7ng4A0jD+atVDsz+zmiBkhjlzbxCTX01sIxlzgSlXZ4P2Bn6B
	0pzYFV38GLmV9N1S+PxJzt8YzBJM03bZlr8Zp18PRbfLxtVNtu5YAYCNYh+RNt2Dj9o6PTTJBnYfz
	GJFdSPer6rmrFUohwe9y/nAE/TwcVbTNp6W+lbfT+rNI0wIBnOapJjIfBK2ESgT/RDmwvYMJeBW55
	H9DiqMYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQO4x-00000000bS1-2ykB;
	Mon, 09 Nov 2026 12:02:27 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQO4o-00000000bMS-142q
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 12:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794225733; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=jDnww6JI8klr6K2Oh65kdjtr6PFrG0V4ksGmbutISOU=;
	b=ApNlzF6lync4F1VQtHaZW/UCYVmFAAP7AzEfLYOCnain0wFHj4njgES9vFkjwv6OVIywIzRGE+22hrmD0KuErJjK7/DP9yC4bxsve2fuqYg5vU72Zt+K1rAB8GmVGiDfjUdIsWKd3TRQxGONUaKByn61xYSGIvMP06g1dw/4jjE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEONUq2_1794225732;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEONUq2_1794225732 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 20:02:12 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme: make SMART / Health Status AENs reach hwmon alarms
Date: Mon,  9 Nov 2026 20:02:02 +0800
Message-ID: <20261109120207.1352165-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_040219_952110_69590664 
X-CRM114-Status: GOOD (  11.50  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NVMe hwmon support exposes the temperature alarm as a plain sysfs
attribute, so monitoring tools have to poll temp1_alarm to learn about
a critical temperature or spare-block condition. The device does send a
SMART / Health Status asynchronous event when its health status
changes, but the host never subscribes to it, and the completion path
silently drops the event.

This series wires the event through:

  Patch 1 defines the missing OAES bit in the uapi header.
  Patch 2 subscribes to the event and wakes pollers on temp1_alarm.

The alarm read fetches the SMART log on demand, so the completion path
only queues a work item to call sysfs_notify() — nvme-pci completes
asynchronous events from interrupt context, where sysfs_notify() cannot
sleep.

Testing: verified end to end against QEMU's nvme emulation (with a
one-line local patch reporting OAES bit 1, matching an NVMe 2.0
device): injecting smart_critical_warning over QMP delivers the AEN,
poll(2) on temp1_alarm wakes immediately with EPOLLERR|EPOLLPRI and
reads alarm=1; clearing the warning produces no event and no spurious
wake; re-injecting the bit wakes again.

Guixin Liu (2):
  nvme: define the SMART / Health Status async event bit
  nvme-hwmon: notify hwmon alarms on the SMART / Health Status AEN

 drivers/nvme/host/core.c  |  8 ++++++--
 drivers/nvme/host/hwmon.c | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h  |  5 +++++
 include/linux/nvme.h      |  2 ++
 4 files changed, 43 insertions(+), 2 deletions(-)

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

-- 
2.43.7


