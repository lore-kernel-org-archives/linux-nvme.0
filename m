Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72327C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 08:19:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D55B20774
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 08:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JG0e/L/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D55B20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PPl7d0rTT6ZyCszX4uZBB1kkwhfPEks2ux8uMFxDVyM=; b=JG0e/L/XRuDUC4Ezi1uZGcSuH6
	zI+Zh2oNTbrxj9n4k/ibx8wjyyFphc/9seqEr8fNjXmGoU5oGzemgFt+ZtFTTEvcUD5lvr1t+BtY5
	vgrAWef8cnpgQtmeih2Ewz8XR0CdlgOAa2xR9J/QVjCg+yX8kgTOhNajAixRCWopamebR3Mgf+Pyn
	3+CJxKeIHKyMhznuezQdmvD0Lm4pVSWty3ovp4E0EkZtsZkcjBzeNrV9Ehrqwbt0zdNHx4wph/rcY
	8b/4iORdYueBwqmNzvvF1uYTkrEf/4iCai8izutAaM1DCUU0kLAEHYWB6ta4L8/XE5OuxBBsrTBbc
	BrvGxbCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5lyE-0001Fc-Fr; Wed, 12 Aug 2020 08:18:50 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5ly9-0001E6-Cp
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 08:18:47 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 78950CF015B2BA49FB35;
 Wed, 12 Aug 2020 16:18:41 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 16:18:31 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
Subject: [PATCH 0/3] improve nvme retry mechanism
Date: Wed, 12 Aug 2020 16:18:31 +0800
Message-ID: <20200812081831.22097-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_041845_732469_EFAEF110 
X-CRM114-Status: UNSURE (   5.73  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Nvme protocol define local retry and path error. Nvme retry mechanism
should not care blk status, just need use nvme status. The mechanism is:
non path related error will be retry local, path related error will be
treated by multipath. For nvme mulitpah or other multipath(like
dm-multipath), retry mechanism is same.

Chao Leng (3):
  nvme-core: fix io interrupt caused by non path error
  nvme-core: delete the dependency on blk status
  nvme-core: delete the dependency on REQ_FAILFAST_TRANSPORT

 drivers/nvme/host/core.c      | 24 ++++++++++++++++++------
 drivers/nvme/host/multipath.c | 11 +++--------
 drivers/nvme/host/nvme.h      |  5 ++---
 include/linux/nvme.h          |  9 +++++++++
 4 files changed, 32 insertions(+), 17 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
