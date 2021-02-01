Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600E8C433E6
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:30:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF3464EA0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF3464EA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:From:Subject:Mime-Version:Message-Id:Date:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5x7hyLGYa75CQG7pYBgD9PMns3nrGRKDgGNtHLjZQPg=; b=Oej9nUt2M0wJfrqN19fIouIobp
	8/bOuVuOtPeNHgXKstOnxNxv7HX/rqI6u8FCBsXMW/A5egfxhDp3qeg+KwuHr/iegTVeVdF5xVk3W
	4y2hJJiolXoGBfBUEfjT/IHZZwxL2difQI+K+tS7l39xBbd03Za+FGzAzOu7zcU8Yv4jD7vaMP8Kc
	2BcZdaYIEI9CcuouorRcNH/3Xd+4jOv20PnFODz2LfRxU2AwQitbTFdC8/rrsC0JHxUMOm23VdmXx
	qIo80h4BKhLCjCMv4Xmw+eCrivUUtISvYO3YZ1ocyAPhc7fLzIShTZ1SI8fWTwwDknb5131eduC2j
	/LlzM6tQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6dy1-0000de-3g; Mon, 01 Feb 2021 18:30:29 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6dxx-0000co-4y
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 18:30:25 +0000
Received: by mail-pj1-x1049.google.com with SMTP id b20so84848pjh.8
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 10:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to;
 bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
 b=SosvEstR48V1+HoHfiXGnSkDBo6c3RZs6iuOhiDQyZjm9TnrH7JIfkwKv8wGZRq6yS
 XEA9LefU8MB1mV5RA1WAXX5j+n+LUBkbMdz/mQbd5QviOoZKCN/lnUw618TSSfUPrrYt
 xePuFn6+rn4FC4tEsd5IgP9j2ohvNJ1tDqb4IHkjJpRq0v0bTyuPGPgimqUJD9Jhcpvb
 4eWManaTi4YMg0Rub+JEsVfoVWQEXxetnYgoJZ8btWoXceKQv1pjC9+aIMJQi1EQs479
 GVHei57xNQZbS00ckImI9fdie1QtctBpwObaFaZCvzO1heGZs6zbDzRc922TaadtIIVX
 Ui/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to; bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
 b=G9iKHNr9Y+6aITV+77cEXZZDy5EDKRqW7lzPBBwx5gtISPEbaOOBI8P+YIyac4AnbP
 OnyjkI792uyvFLJmrOAzbo1RKbV/+k6r1DHMtPi/WA1qO1m1f4L8UHqdajM2+eNeMHGz
 SE3hheqVj8ushtq8wk7EgQBBC/kCf6FviYZbSPwXTw+RitasPRps6ehvA9NgPpO0LyMH
 hLKBl1Rnl/7fWPA0GudwSHMfyJnL5OC1HruYmvfElTNMyKBO90sS5LJBP08Pqd6mexCS
 8cxDZQL5ZlbrcyKcaUMIUUqbJvzbi8k8yW+F6ymiTfmWCbLmsseY/LQckWBmjgwP2ugX
 etXQ==
X-Gm-Message-State: AOAM5329WaftrfFNjD8foNF2arYOZVh9Vs3yVCtU/H7HF56nngdJCv6l
 SZQlbJMsGNuR0TNe/rSKT80KGCf/3w==
X-Google-Smtp-Source: ABdhPJw91byWRyJEd+QII2hd/UYZLifFIxJy6ksqPbqPXXoI12a7ZnTaYTpJH9qVyZ2rTyjQMxFgH+s6dw==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a17:902:6b88:b029:df:ff72:7bc6 with SMTP id
 p8-20020a1709026b88b02900dfff727bc6mr18389861plk.23.1612204221515; Mon, 01
 Feb 2021 10:30:21 -0800 (PST)
Date: Mon,  1 Feb 2021 10:30:14 -0800
Message-Id: <20210201183017.3339130-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 0/3] SWIOTLB: Preserve swiotlb map offset when needed.
From: Jianxiong Gao <jxgao@google.com>
To: jxgao@google.com, erdemaktas@google.com, marcorr@google.com, hch@lst.de, 
 m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org,
 saravanak@google.com, heikki.krogerus@linux.intel.com, 
 rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
 dan.j.williams@intel.com, bgolaszewski@baylibre.com, jroedel@suse.de, 
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org, 
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_133025_251367_28352BAD 
X-CRM114-Status: GOOD (  13.26  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe driver and other applications may depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. This
patch adds an option to make sure the mapped data preserves its
offset of the orginal addrss.

Without the patch when creating xfs formatted disk on NVMe backends,
with swiotlb=force in kernel boot option, creates the following error:
meta-data=/dev/nvme2n1   isize=512    agcount=4, agsize=131072 blks
         =               sectsz=512   attr=2, projid32bit=1
         =               crc=1        finobt=1, sparse=0, rmapbt=0, refl
ink=0
data     =               bsize=4096   blocks=524288, imaxpct=25
         =               sunit=0      swidth=0 blks
naming   =version 2      bsize=4096   ascii-ci=0 ftype=1
log      =internal log   bsize=4096   blocks=2560, version=2
         =               sectsz=512   sunit=0 blks, lazy-count=1
realtime =none           extsz=4096   blocks=0, rtextents=0
mkfs.xfs: pwrite failed: Input/output error

Jianxiong Gao (3):
  Adding page_offset_mask to device_dma_parameters
  Add swiotlb offset preserving mapping when
    dma_dma_parameters->page_offset_mask is non zero.
  Adding device_dma_parameters->offset_preserve_mask to NVMe driver.

 drivers/nvme/host/pci.c     |  4 ++++
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 17 +++++++++++++++++
 kernel/dma/swiotlb.c        | 16 +++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
