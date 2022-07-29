Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE90C00140
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 00:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WC7l1iEeDbXOk8zHk46sFpEQeb+vXKlkWUmFdRnN6Nw=; b=ZjXWU1SmdpUgJCZbdxzmJBRuPo
	DIAqyKvBhtx05Zaw/98KrlUYVFbPRIYiCxoR1m5HlGWERqdrpT4AzqOJbX2yxmyd2ZbDlEdBia8wh
	607Meqfi0ffQN9n0PrM8oX0MSd2JSfYnzzr9sg1abx3C6h02siW7LUBQg1TwNprhYqb1VT7WmgBX/
	Ca7mOqPTA/K2eR3dICwWBt93wHvVuqN0wkYNRGvCCRfCN1hzMUjy9oL5zcw6o59B+IKQ/MICNCrgI
	2IlXYNz7NbelpfqMiT/qW3/DAOqJQy4eXQnbXLZFMwzTCy/owHpiKhmNDodaVzeZTauy+acNWIpWQ
	AVdQo1yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHDex-00GZJf-1l; Fri, 29 Jul 2022 00:15:19 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHDeu-00GZ8G-7t
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 00:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659053716; x=1690589716;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M0OTHg3mgDq2E6UeBsOaBGDK3TLVs1l1xo3oPf+ova4=;
  b=Ar79adpUapDuAzzd1uHMbz6dGhAiyYzJJwL0ulZtDrkHIaOW7ikfIZDS
   Qwu55MrvQtPc7Yjwsbl38bmcpItr4fwP9S4RQIV5z5crx+1HEPj36l8/G
   SpcTyzjPMBvOlqJ7MP3j84Am9qSHzgCNJREV0v5vYnpmEwWfKeUuxcdyU
   AjPXLX811n+f3aIx3GLE2sviGIjUwYiNHdeLpoO9SRu2hKBqRcFFm4hvy
   AblyO1b90i8J2hVNGTJAB17xrovN5lwtWIEBYwsv91RtAr8hs2IyJ+lcC
   +ArvRntX3wZwh2KWCKeazYwoRJcgRHhqVtI9W9+Rns9nW9K0zVABOMFGM
   w==;
X-IronPort-AV: E=Sophos;i="5.93,199,1654531200"; 
   d="scan'208";a="207823915"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2022 08:15:06 +0800
IronPort-SDR: 8/LgOn+Z2HyiyvOGZsTCieWWDc5O1TBHbQuiy1teSmWVNFoiZwcml1kUeTuqTZwhzX9QxRVXek
 t+0NuA2Tk/prkvo/yfz6AiOcTtMZFWK84iBfWMdi6lKd9eiPWN4bJIebQnZwQbevf0Lr0mOB92
 xMy17qYQByanDCVRQj5dh2SCl66z6/n8ZGw/gLb1b9JTqb5mIdou8bRS1CQVjULRg0MZhae5Qy
 nmIfxxiCoFZws4cKmTaBqR3WVoow44fSQaD98dbQD1M4UfirsZvQeZzXa5n/Weqwns7oslMi28
 GCfv7bluwY9373O3sHuK/g9k
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2022 16:31:09 -0700
IronPort-SDR: +W23HH/uZqUDBhTO+P00zSxzi/8pKqo8PiyUwQ0fypmFymf0a6nuFSx/W4NVUbvo7wMct3BVd7
 4GLbSR2p3TA1WWSKpk6KhRGKWGd2754YTKd9FmQ6p7dJKD7l3fpdRLy3KPUkkXWUkWv9Cwo4cV
 7CXnqdivChyQb2s3WSSwNkTj8vZHY3x/DxTBNXeK8+rli+e1Q3gEsvwSj9NOMHK8XypvAr5Pxw
 a83vL2osCHFH9QEg1peW6Cj9GigiAk235fXtjcjNlHTuTrVdEXkJgWmRx584k/4NFGkgFDVod9
 Vz0=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jul 2022 17:15:06 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests] nvme/040: fix write file path
Date: Fri, 29 Jul 2022 09:15:05 +0900
Message-Id: <20220729001505.1489933-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_171516_409991_C308DA91 
X-CRM114-Status: GOOD (  12.54  )
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

The test case nvme/040 performs I/O to a nvmf device file. However, it
specifies wrong path to the device file then the I/O is done to a
regular file. Hence fix the path.

Fixes: ebf197d1aea4 ("nvme: add nvmf reset/disconnect during traffic test")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/040 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/040 b/tests/nvme/040
index 10c1815..04bd726 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -37,7 +37,7 @@ test() {
 
 	# start fio job
 	echo "starting background fio"
-	_run_fio_rand_io --filename="${nvmedev}n1" --size=1g \
+	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
 		--group_reporting --ramp_time=5  &> /dev/null &
 	sleep 5
 
-- 
2.36.1


