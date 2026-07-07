Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADAAC43602
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2026 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cgkSvSppzHySradbD3t6x82HbpSVJBSkax5Zi/5zde4=; b=S80Jj+75lSGvhIlBMhbsRopW+U
	LUPcTblLUgUbht6Q10M7D58bolTGbw6ELs3aJQwIRBrmP6RL5/biqtg2RiQ3Auqh9tRMDvgmpPH4v
	jOoM8Maki2r6pBOkeR6uIlsevTnUWgiUmVXEQ8Gxoz1VvFhW8jjRtPwL6MbJl0+shL/JsZE2lPySG
	Q+pslcvcSjNSV+qgF9baq0BWIwNdyN6x5bDcRh+r2ylOtrq/qfER8qVj/NcHENOitCtpXAbKl5QaK
	+IMF/zfn7Aik9vq5WVdL70N0LJfKqhhRj7bCygjEKiCmEw5CcH4byiVajNdz864pKqe2TtvS7fJPV
	8DGNw8rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh4fE-0000000EvRc-3FVA;
	Tue, 07 Jul 2026 12:12:36 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh4fB-0000000EvNH-31hL
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 12:12:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783426351; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cgkSvSppzHySradbD3t6x82HbpSVJBSkax5Zi/5zde4=;
	b=fPgmT/cu5LBAScBhoG6/ZhLBgFC243y4jybuEChZ/P8pz+4q1R5KrM31LuHY2NfQYYc3x6yIs+K2HsYghX6mJLoxnqUxSj7OWrMX0q18k+2YgNhE0ZIjwqAm99Vx/AZ7k/5CL6NWmMfeM/sMyFop/8GnMxbL2W5QmLmVB6GUEno=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6dVpOo_1783426350;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6dVpOo_1783426350 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 20:12:30 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	John Garry <john.g.garry@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v4 3/3] MAINTAINERS: add missing NVMe documentation files
Date: Tue,  7 Jul 2026 20:12:27 +0800
Message-ID: <20260707121227.2274769-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260707121227.2274769-1-kanie@linux.alibaba.com>
References: <20260707121227.2274769-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_051233_946361_D52DFA79 
X-CRM114-Status: UNSURE (   8.44  )
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
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25453040dffb..78723f92b238 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19367,6 +19367,9 @@ L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
 T:	git git://git.infradead.org/nvme.git
+F:	Documentation/ABI/stable/sysfs-nvme
+F:	Documentation/admin-guide/nvme-multipath.rst
+F:	Documentation/fault-injection/nvme-fault-injection.rst
 F:	Documentation/nvme/
 F:	drivers/nvme/common/
 F:	drivers/nvme/host/
@@ -19409,6 +19412,7 @@ L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
 T:	git git://git.infradead.org/nvme.git
+F:	Documentation/ABI/stable/configfs-nvmet
 F:	drivers/nvme/target/
 
 NVMEM FRAMEWORK
-- 
2.43.7


