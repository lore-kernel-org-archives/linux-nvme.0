Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51848CFC538
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Vj+S6AZs1FovcjG6dnnPoSK6IbO/nlyOLLaV149z7dk=; b=j8mD1QeCPV5CgUDKJUwg91yaTd
	kRsKouuUYhs6geCohj3hgPzaO9qhllVdo6956ICoX9oxIok0vTP0K1mR0VhlBG1UcFPxWCGysNMVJ
	Cgrf8cFfRiv1SJS0935l4LaS0KAkswSvW5NoWP/LSTWbyqoIM4lCCRm23lpnV7sp0dISXvmNUQHGx
	YHlNMUdW7syNr59gVCvdKMLsHH55FHog5P5i1fS/9qe2qR2TS2vXXV0fRuupMDU55vpH6CIk+c3Ek
	QxHspAIzFvAKnlrJeDCYXnBGGUmovhdWP9GxaewVP61RIPA2eMnGOpe5MdRBPN+RqSzuSICNU6fia
	7HkCLpIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0IAw-00000004g0s-2XjG;
	Mon, 14 Oct 2024 10:19:42 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0I6W-00000004fQb-31rO
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 10:15:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728900904; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Vj+S6AZs1FovcjG6dnnPoSK6IbO/nlyOLLaV149z7dk=;
	b=yMf7VgKK/xxBCyhQSQKhCdpbd9B8E2LVXRepFmVxdvsy/Ol7NUPye8GNAY8BXPYnQZQ9pR3/7AagsbfHzxhtOI/Vaz2qLnrt74+rj0FwzgVNIeLifVyHBMbeAdm9Ttbp7bGxJHqQtjun0cULlFVo52ASXfU9Y4UEoDBOkTbRgZ0=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH4T2Qp_1728900898 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 18:15:03 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] Add the tracing of reservation commands
Date: Mon, 14 Oct 2024 18:14:56 +0800
Message-ID: <20241014101458.80491-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_031510_242480_5FEC7639 
X-CRM114-Status: UNSURE (   5.01  )
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

Host:
- Parse the action and rtype to string.
Target:
- Add the tracing of reservation commands, and also parse actions
 rtype to string.

Guixin Liu (2):
  nvme: parse reservation commands's action and rtype to string
  nvmet: add tracing of reservation commands

 drivers/nvme/host/trace.c   |  58 +++++++++++++++++--
 drivers/nvme/target/trace.c | 108 ++++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+), 6 deletions(-)

-- 
2.43.0


