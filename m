Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F36C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 08:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VKSN/HGglMKvGkEFRtj1TYIZao3NVoqEoj03kpaJ3f8=; b=wPFxa7xn1symYRCg6PpF17+uah
	shLh5oxCKoBhlMwqrbZVG1oIMdUF0REEISFyKaieIPMVnFuJgix8DU5ni0xG/k2gXLxsGtt9QZOgS
	5FhUg3pkOC9ebC1gFKIU/jy04xDc3VUtsgs0rsLMTRLNwN08AaUnozA+z8UR1eW31ou7dSReIvitJ
	reWKS0G1yY8zPQ10t8yVJ407pkvE77yipUBhoC967lRhyRCGXwNY42sDwTxb4YPxPxv0eO+KmhDCL
	kxCq5Cu39O85wKh92mRG6maoDvTVI+nDqFShiEFyV9f+SFF12BNrez7adNuhwLOiQjDqhdyuNBpal
	cNRUEVfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ17T-00Eq7k-30;
	Wed, 17 Jan 2024 08:17:55 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ17Q-00Eq69-0E
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 08:17:54 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-om2pZ_1705479462;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-om2pZ_1705479462)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 16:17:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com
Cc: chaitanyak@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/2] *** Test the NVMe reservation feature ***
Date: Wed, 17 Jan 2024 16:17:40 +0800
Message-ID: <20240117081742.93941-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_001752_316079_AAC17C29 
X-CRM114-Status: UNSURE (   8.42  )
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

Changes from v1 to v2:
- Add a new patch to add a optinal argument --resv_enable.

- Make resv-report fit the new --eds argument.

- Filter the hosid output to make the new test case independent from
hostid.

- Change the new test case name to "Test the NVMe reservation feature".

Guixin Liu (2):
  nvme/{rc,002,016,017,030,031}: introduce --resv_enable argument
  test/nvme/050: test the reservation feature

 tests/nvme/002     |   3 +-
 tests/nvme/016     |   7 ++-
 tests/nvme/017     |  10 +++--
 tests/nvme/030     |   6 ++-
 tests/nvme/031     |   3 +-
 tests/nvme/050     |  96 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc      | 100 ++++++++++++++++++++++++++++++++++-------
 8 files changed, 308 insertions(+), 25 deletions(-)
 create mode 100644 tests/nvme/050
 create mode 100644 tests/nvme/050.out

-- 
2.30.1 (Apple Git-130)


