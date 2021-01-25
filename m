Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88088C433E9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 19:59:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43392224F9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 19:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43392224F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XPHRaUII6JSURc9HwaxhZeya43zD7GVFpm/bBlkfK2M=; b=FkgPIKbH4LUGa1NK525vrH8s/
	PWU9hqBRrAe00r9M8GgHjvKdfvl3xRF5wtO2uHVo5RAAc60UATsTIGk30Kq0qUCPVb0/KDSgol+Vn
	eLhm7tH7TtCEzgElC5v7eEipI9qLtMo+UeFyCHSlA1Frlo/wioCzqBDQQEbcoLx0eMp7i2j/VBb0g
	pqHG10MoK4fPUtEaa8c4zBo2XB9iAi0xgHsRjeXXKIv1qrdiUoK/K4x6GNuVfXBaN5dBAr86PuqUK
	h5MLdZmgvtsBJQwvOqDtTTA4mr9eldMpCPVRYnk77cNjHux+/sPGIRQjVJeDuvDaQE80w4ROI79cM
	y9NlkgeIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l480w-0008FS-Vv; Mon, 25 Jan 2021 19:59:07 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l480q-0008E6-AT
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 19:59:03 +0000
Received: from localhost.localdomain (10.93.83.20) by SJSMAIL01.us.kioxia.com
 (10.90.133.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 25 Jan
 2021 11:58:55 -0800
From: <clay.mayers@kioxia.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Date: Mon, 25 Jan 2021 11:58:42 -0800
Message-ID: <20210125195844.1390581-1-clay.mayers@kioxia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210105224939.1336-2-clay.mayers@kioxia.com>
References: <20210105224939.1336-2-clay.mayers@kioxia.com>
MIME-Version: 1.0
X-Originating-IP: [10.93.83.20]
X-ClientProxiedBy: SJSMAIL01.us.kioxia.com (10.90.133.90) To
 SJSMAIL01.us.kioxia.com (10.90.133.90)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_145900_365818_67733F58 
X-CRM114-Status: UNSURE (   9.04  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Clay Mayers <clay.mayers@kioxia.com>

Enables fused compare/write to be issued from user mode.

The first patch allows a pair of pass through requests
to be linked and submitted as a fused pair to the nvme
pci device queue.  The second patch exposes it through
an nvme ioctl so a fused pair can be issued from user
mode.

There was a question regarding Linux support for this
functionality in nvme-cli.  With these patches, that
would be possible.

https://github.com/linux-nvme/nvme-cli/issues/318

Local pci device fused support is also necessary for
NVMeOF targets to support fused operation.

Clay Mayers (2):
  nvme: support fused pci nvme requests
  nvme: support fused NVME_IOCTL_SUBMIT_IO

 drivers/nvme/host/core.c | 267 ++++++++++++++++++++++++++++++---------
 drivers/nvme/host/nvme.h |  12 ++
 drivers/nvme/host/pci.c  |  85 ++++++++++++-
 3 files changed, 302 insertions(+), 62 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
