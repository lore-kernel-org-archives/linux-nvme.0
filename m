Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DDBC531F9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xEse3H3CTfdkt6NUu3SJ2E0YxsADuDUSw7abs2FnGuQ=; b=bIMyww3ngM0Dv3g95eHR4tP8Ka
	Op07teBNmB3dMbruc8YYgr49rTyiodiW65/LzzUB0I4MuStSEz26/mFhbjSAUeatwWbffPyj06BGd
	txUZbIS8mojVik74/jjibp6KBlfY40+GHThIYq6Te6HTy7VkxQ29Joo9cNg4ewO4X36SYtz7wDTZI
	rGf+AAIQ953XIdepCrlObHOSZSV6nrhEFDxAJbhaYmz3G0QXh98baNca+Q5Hv02ogq1XWzGHxPExF
	rlHkCn4dRuQWvSIUZqGgEXw4hW8JEsw8wlG8KINSPFWrbhZYop4O+m9f8PFgjYyhHW2CzPajHMewR
	dHiqWWGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnBlZ-0000000FtXI-0CxN;
	Fri, 24 Jul 2026 09:00:25 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnBlU-0000000FtVI-2OmK
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 09:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784883615; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xEse3H3CTfdkt6NUu3SJ2E0YxsADuDUSw7abs2FnGuQ=;
	b=v78QEL9b3onF7VfVL2zmZz3KH2fTCGhFWbOlQIJdjinLRvA1hzab6Oh0hzNNUEYqyi1oaAhA2CoQSbCTfov5zqsNk//1BNWJu+5u11iunyvQYBvlQ3s+/4tCkv15EX4v7zBEWI2YdbvOFSH2STL7CTijA38yUE8IJ+dDrBkrXbk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X7iiffr_1784883614;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X7iiffr_1784883614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 17:00:15 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v4 2/2] nvme-multipath: document path_state sysfs attribute
Date: Fri, 24 Jul 2026 17:00:04 +0800
Message-ID: <20260724090004.1146014-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260724090004.1146014-1-kanie@linux.alibaba.com>
References: <20260724090004.1146014-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_020021_371223_A2E9B6A3 
X-CRM114-Status: UNSURE (   8.80  )
X-CRM114-Notice: Please train this message.
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

Document the newly added /sys/block/nvmeXcYnZ/path_state attribute in
the stable NVMe sysfs ABI file, describing the possible path states and
their meaning.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 Documentation/ABI/stable/sysfs-nvme | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index a2f5d0710db4..04bcea5bae45 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -326,6 +326,27 @@ Description:
 		currently selected path. Returns empty if iopolicy is not
 		"numa". Requires CONFIG_NVME_MULTIPATH.
 
+What:		/sys/block/nvmeXcYnZ/path_state
+Date:		July 2026
+KernelVersion:	7.2
+Contact:	Guixin Liu <kanie@linux.alibaba.com>
+Description:
+		Shows the current multipath path state for this namespace
+		path device. Possible values:
+
+		"enabled": the path is usable for I/O.
+
+		"ctrl-down": the path is disabled because the controller
+		is not live.
+
+		"ana-pending": the path is disabled because an ANA state
+		change is pending.
+
+		"ns-not-ready": the path is disabled because the namespace
+		is not ready.
+
+		Requires CONFIG_NVME_MULTIPATH.
+
 What:		/sys/block/nvmeXnY/delayed_removal_secs
 Date:		May 2025
 KernelVersion:	6.16
-- 
2.43.7


