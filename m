Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB119C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPhJ2XQ7X3B6xoZvEqVYRKfySxWuKrEBIDixV1PMECQ=; b=CI42cuR+294u64/uHjcEmezvfa
	D8g3kMgc41pIBwVMR9nHjUad+39Fygp0zZmSlhhWJD7B1L5AUgV15Cc7S56JKJIwMPiJysYuHx8B4
	9X87BTg6A3yLqNfdaFVgbZjvTNxDSnSPSf5b0f2u4MX7iAI1IZ6q6AxL9a0E1Tu/lExunwo/8STv8
	zYGM+pL/i1UIRzTC949fhH/Cm3xH5X98bCm2Ct83nuepn6B0mmSnq0Gya5EwNh1UwGr1HWMTHeV8I
	Ji0ThLtBU+BjtLiqOEC31EFwv+myQQCRfCWPJwRNzLuv6RaY9vQ/s63+oblr2+emuTre/ud2Wt2/K
	uII/kIHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oseZW-00BAKB-0v; Wed, 09 Nov 2022 06:28:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oseZH-00B9nt-P5; Wed, 09 Nov 2022 06:28:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 143A868AFE; Wed,  9 Nov 2022 07:28:09 +0100 (CET)
Date: Wed, 9 Nov 2022 07:28:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 04/12] nvme-pci: put the admin queue in
 nvme_dev_remove_admin
Message-ID: <20221109062808.GE10528@lst.de>
References: <20221108150252.2123727-1-hch@lst.de> <20221108150252.2123727-5-hch@lst.de> <679cf80b-3e30-e393-d5c4-d3941e853bfb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679cf80b-3e30-e393-d5c4-d3941e853bfb@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_222811_976870_ECB5EAFF 
X-CRM114-Status: GOOD (  14.05  )
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

On Wed, Nov 09, 2022 at 04:58:46AM +0200, Sagi Grimberg wrote:
>> @@ -2774,8 +2775,6 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>>     	nvme_dbbuf_dma_free(dev);
>>   	nvme_free_tagset(dev);
>> -	if (dev->ctrl.admin_q)
>> -		blk_put_queue(dev->ctrl.admin_q);
>
> Is the check here valid? meaning can we get here with
> a NULL admin_q?

Yes, the admin queue is only set in the middle of nvme_reset_work,
and for errors before that we can get here.

