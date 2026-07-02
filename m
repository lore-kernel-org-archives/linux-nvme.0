Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEEAC43602
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OmPDG5zpelBzp1x16FrznvBRGW4vmQwRreGx2S1hzW0=; b=WWZ/yfZc5ccJcuM4OIusajqOJN
	1fi1Q8uVJyZR+ND94ekJcc8YI6jkT7qjf53svEh1hKeAFS9zBENEJ/Nxlpa8zuXTnj3ySFoYvUl7A
	Dz49dShhNiSoLr5H9ghB8cNo3pIem/pfxhE5JPUbqVCsn9gI3VmKUaDt0YXVgIVfMmrXyhCxhWsxI
	fljTs/I0t0jqHVXYAUv1BKoPhfeWI89j7EfvD+iJql8BRnEZ7FYOf1YhT6JCL9MeiPp3LLdWjDeVN
	EKsK3lZn5ZQyPwUsZibj+KbRGGx2NKfhovZxfkuwEEp/aZwLqzuReo9499vu+2MZ/Ppot616/4Uyk
	MlYys1+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfE9G-000000046Ny-37VD;
	Thu, 02 Jul 2026 09:55:58 +0000
Received: from out199-10.us.a.mail.aliyun.com ([47.90.199.10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfE9D-000000046Lm-0snG
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 09:55:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782986151; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OmPDG5zpelBzp1x16FrznvBRGW4vmQwRreGx2S1hzW0=;
	b=KIw6OznagI/bQLehsyNKu3lFlEWhWwsq3whUEf7rzbCpwkCy3o6g2NHv9jC6c6NSF4lDWXc/1KZL3oaP7hIyq/+uOxrT1qAhDDRVRPVLrgyfh7W+pJmpVnoNUDNMPAfPxu8/6szGfbmzZBsTqb2d+3pe2JVoRnPFIBblL80Vmrs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6Dy5AO_1782986149;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6Dy5AO_1782986149 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 17:55:49 +0800
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
Subject: [PATCH v2 3/3] MAINTAINERS: add missing NVMe documentation files
Date: Thu,  2 Jul 2026 17:55:41 +0800
Message-ID: <20260702095541.1145128-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260702095541.1145128-1-kanie@linux.alibaba.com>
References: <20260702095541.1145128-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_025555_593436_C4A0D06D 
X-CRM114-Status: UNSURE (   8.74  )
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
v1->v2: Add Reviewed-by tag from Hannes Reinecke, thanks.

 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..7f8d52f8aab1 100644
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


