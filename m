Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D31C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 02:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VXTyX08tgzQQfsHDBVNXzvTbjGbw2FjmuWzpkJC63rg=; b=0g3fkawaYXW3Y53tgYbfblpvds
	ZSMrkNQiuEiJju9R08wOAU30Qf5A5qDjZBCDvFDcR06ofVlw903p+OjMdV6q9PP4K751N59FaLA7T
	JEXfnv58Qk+ZUGnpHO9l5l/b/iWgVV+J6RrqXChtQEr9fw5RW5VK4S/jCVb71Ptl9dAhaHCEgkqfZ
	g5tPub+7wf8AYPzF+JMKXnkI8hcXJrJWixCPAYbwwREYAAHYcAaZOjwdMIJKsw9+uHIqAVDNkcpXZ
	uiB7gjvRTCkCRsgs0oyOraesz2fhatXu7YyrVZj5RdZJdDYpO5l2x3n5uLjacxSjVFnXMfKcpjEkE
	jxK8BxEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgZB5-0000000BOtt-21zO;
	Mon, 06 Jul 2026 02:35:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgZB1-0000000BOsm-2SGX
	for linux-nvme@bombadil.infradead.org;
	Mon, 06 Jul 2026 02:35:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=VXTyX08tgzQQfsHDBVNXzvTbjGbw2FjmuWzpkJC63rg=; b=nmX6lDmCMj6XZXYXy3ZrOyofxJ
	OVtmHwr0olW8TDhE9pG3qs8G2rmbAhA0NSIDJ7/SW8ISYL7A66u2ZjOei+tbcw3GJlt0hbL82+iMi
	8t9KSWZ/yt/eVT4gHozHrR9D++D2/zbouL54A4PpvIT2omtJOqynYsrRaSaAQn+SvIXGT07LgOkWo
	2vp7ZIoz9RKEsZG0jJdzVi7TIIirXmcYpnCxbHnYNMWOefF5azFdccNR2yw3XBsZOfsk8r9upchSk
	ssly3GlTrDMEYTgHqDmUQN/Ip2C9uq7iZb5la1NaHPDbxBoAIiSPqG0BgTxrvIjAJ0jGWkAVnMRhz
	y3FK3swA==;
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wgZAg-000000067iU-3SCV
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 02:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783305289; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VXTyX08tgzQQfsHDBVNXzvTbjGbw2FjmuWzpkJC63rg=;
	b=ItHRp4fkm9+CEe9uQz8XIrgh/zg1oQITbqGxbFqnBUW5+i3RDF5fAiP+Uzrklp0Px/YBrwVLlzhhVyUQluM6nB0jde8LuKLCAX4cp3wL2OtJQs3jX59ebY6a1cRrLQXgCrPXPlRbi+Cuq1HsQgaaHAGuixsMGmg4mMsaEItgS4g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6PDMKi_1783305288;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6PDMKi_1783305288 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 10:34:48 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v3 3/3] MAINTAINERS: add missing NVMe documentation files
Date: Mon,  6 Jul 2026 10:34:39 +0800
Message-ID: <20260706023439.3054578-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706023439.3054578-1-kanie@linux.alibaba.com>
References: <20260706023439.3054578-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_033502_513962_7508BAB3 
X-CRM114-Status: UNSURE (   8.90  )
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

Add documentation file entries that were missing from the NVM EXPRESS
DRIVER and NVM EXPRESS TARGET DRIVER sections, so patches touching
these files are properly routed to the NVMe mailing list and
maintainers.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25453040dffb..02fed2ef507d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19367,6 +19367,9 @@ L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
 T:	git git://git.infradead.org/nvme.git
+F:	Documentation/ABI/testing/sysfs-nvme
+F:	Documentation/admin-guide/nvme-multipath.rst
+F:	Documentation/fault-injection/nvme-fault-injection.rst
 F:	Documentation/nvme/
 F:	drivers/nvme/common/
 F:	drivers/nvme/host/
@@ -19409,6 +19412,7 @@ L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
 T:	git git://git.infradead.org/nvme.git
+F:	Documentation/ABI/testing/configfs-nvmet
 F:	drivers/nvme/target/
 
 NVMEM FRAMEWORK
-- 
2.43.7


