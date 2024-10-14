Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA24CFC528
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 09:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o7Jsq9VK08icpuHm5DwOaStudIi+XDXJGYtuwnNd5hU=; b=w7MyJPXyBxtt9I/Ol2g3v0e6ET
	Lif0VrpcxD+lrz+ODg/sD9oxNmkB+oVsjLnlZ2vm02HCFDgBze3O9MJVwXy8cGnvdkxBj5jeVYzQE
	wLcEhlrMVW3wqtPjAtYQf6AcJgCz81UdnmiBFJ01hPEvVZNf661h2yVvHRN72vXf4Gwzy26mUbSgM
	8maHChPCCmmtGlVdEHLc5DE2vbVGSCf9JZPiYOdgJlZEzcRTQzQcrD8iBcYWna+X3XhmdMoiX4uvs
	95MNo3M4gqmdhGMVIt9BxmqiClR0cpRr8SnGh2dyelb7h5kS/HBsEvJM77vGu/5lt5vosmdQ062I8
	vsWyLUiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0HDx-00000004Tlo-3NlA;
	Mon, 14 Oct 2024 09:18:45 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0GxB-00000004POi-3zPt
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 09:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728896483; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=o7Jsq9VK08icpuHm5DwOaStudIi+XDXJGYtuwnNd5hU=;
	b=Vd8gF1XCBrBshi2JD3vDI4zb/DsuhmMUq3mheRife7SCRaSx4XYk45U+eXRdASpGxoXreB4BJzelqDyVGPVNWTYHlJ8CLeRMxCgpLIoT44EZ7GJEC81NFeQQDi5UYTvAs/vuqNq7lM6LRCxgWh/zLyav33MPbQtBbPZcV967vhY=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH3n2Jr_1728896476 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 17:01:21 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v4 0/2] Test the NVMe reservation feature
Date: Mon, 14 Oct 2024 17:01:14 +0800
Message-ID: <20241014090116.125500-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_020126_155881_D9F03D07 
X-CRM114-Status: UNSURE (   9.14  )
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

Changes from v3 to v4:
- Introduce var test_dev="/dev/${nvmedev}n1" instead of using
"/dev/${nvmedev}n1" everywhere.
- Filter the resv-report result.

Changes from v2 to v3:
- Put calling "resv-report --help" to the beginning of test_resv().
- Introduce a hlper resv_report.
- Fit newest blktests version. 

Changes from v1 to v2:
- Add a new patch to add a optinal argument --resv_enable.

- Make resv-report fit the new --eds argument.

- Filter the hosid output to make the new test case independent from
hostid.

- Change the new test case name to "Test the NVMe reservation feature".

Guixin Liu (2):
  nvme/{md/001,rc,002,016,017,030,052}: introduce --resv_enable argument
  nvme: test the nvme reservation feature

 common/nvme        |  89 +++++++++++++++++++++++++++++++++------
 tests/md/001       |   4 +-
 tests/nvme/002     |   3 +-
 tests/nvme/016     |   7 +++-
 tests/nvme/017     |  10 +++--
 tests/nvme/030     |   6 ++-
 tests/nvme/052     |   5 ++-
 tests/nvme/054     | 101 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/054.out |  68 ++++++++++++++++++++++++++++++
 tests/nvme/rc      |  11 ++++-
 10 files changed, 278 insertions(+), 26 deletions(-)
 create mode 100644 tests/nvme/054
 create mode 100644 tests/nvme/054.out

-- 
2.43.0


