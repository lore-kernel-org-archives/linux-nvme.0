Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C053CC433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 02:50:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CBB208FE
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 02:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JzNVKBHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CBB208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BI8NMoHpxAn6ARn+1iRuANaPJArUJqvO4Yf45Lq9j9s=; b=JzNVKBHAeJB/exFvLCGHU/9qbb
	pelw3zuu1T85Fl/kZF5WQe9enQrdD3qLgIRD1/SyeLIMqW9JbAHDcXubzb9hw/mfyr6mr88t5ke5r
	qjIbzjUMSwZYn3/J0uCEK3wjjN1fbdP/4UQLBzsrj7PIZF4ayUywA+X66iWTvMzeeEoiVKGTr6bzW
	H2jNM1Spzu7C8NS2zvWrFfnb7OR8HL1efopPUM65JYgf0XIJ93l4jd+DklCepY+2QuRJEF5UrE7K5
	Ig9JmsCTlyBclPE+hef0bmSVGItL+CVEG/Bedct0uwJhJydboAwDlBcAuNyNxMqxYHxffaSHXAlhS
	UJppbQjw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrBlr-0006zy-Ar; Fri, 03 Jul 2020 02:49:47 +0000
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrBln-0006z2-DI
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 02:49:45 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07425;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U1XOWIX_1593744573; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U1XOWIX_1593744573) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 03 Jul 2020 10:49:34 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 0/5] Some cleanups for NVMe-pci driver
Date: Fri,  3 Jul 2020 10:49:19 +0800
Message-Id: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_224943_686647_71DE2A9B 
X-CRM114-Status: UNSURE (   4.56  )
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
Cc: baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

These are some cleanups for NVMe-pci driver, and no functional
changes, please help to review. Thanks.

Baolin Wang (5):
  nvme-pci: Fix some comments issues
  nvme-pci: Add a blank line after declarations
  nvme-pci: Remove redundant segment validation
  nvme-pci: Use the consistent return type of nvme_pci_iod_alloc_size()
  nvme-pci: Use standard block status macro

 drivers/nvme/host/pci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
