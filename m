Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A23CF2566
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Oct 2024 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0WZzXU/RPPADO63xVPX1HrAdtftwLLDpevHHz2xeA68=; b=BID9z6UYmgof+6dzx+yZrkUvH9
	ci+BneIpPzK+rcHY98kyeDdIVLCjKuaClUX++haf7Rf439Xpp4edym+SVPXlbcEy5tN0yCU6ouMG7
	+Gea7F+4YjWh9lbk4L/8wCYelFtFWFXrUyUH/wRMoo8okk7ry+BpPg0ahf8BMqyxpWfof8V8egpOr
	S5A+ylTDmjF23VAvabuOcyEnk5ZrgbBqOcntVKO1xB/RaxNtOrtuaDDJUi0PmUC4WQt/0Sz5XSwEg
	eD2YOjr0oFgLwvXmopETTmmdDvxRhNg4dMkB2Lrkl6v2FBFu5mEl4BF4T5i8T2Z0lK1FusyOlfCe2
	4QD5SodA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szaAz-000000012oo-1zhI;
	Sat, 12 Oct 2024 11:20:49 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sza2c-0000000124D-3ea6
	for linux-nvme@lists.infradead.org;
	Sat, 12 Oct 2024 11:12:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728731524; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0WZzXU/RPPADO63xVPX1HrAdtftwLLDpevHHz2xeA68=;
	b=jcTnmaHztYfzNXndCxeKRTaA90gXBMlxtBIFB+H0yPA1u4RXg18mBSzOuBsnsJKZ9sSpMMpurpBOi0kdL4du+zhPcAXLGP8BEBz0euhvgckCdmEpPQsJSgvSaXb5fOe3Kz78O4sWARqhInT0msvPnJ3Ys1nOESglpM0lGgoYgh8=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGvl9YH_1728731517 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 19:12:02 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v3 0/2] Test the NVMe reservation feature
Date: Sat, 12 Oct 2024 19:11:55 +0800
Message-ID: <20241012111157.44368-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241012_041213_146455_3133724E 
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

 common/nvme        |  89 +++++++++++++++++++++++++++++++------
 tests/md/001       |   4 +-
 tests/nvme/002     |   3 +-
 tests/nvme/016     |   7 ++-
 tests/nvme/017     |  10 +++--
 tests/nvme/030     |   6 ++-
 tests/nvme/052     |   5 ++-
 tests/nvme/054     |  99 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/054.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc      |  11 ++++-
 10 files changed, 316 insertions(+), 26 deletions(-)
 create mode 100644 tests/nvme/054
 create mode 100644 tests/nvme/054.out

-- 
2.43.0


