Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C9EC433FC
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 17:09:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3138A20775
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 17:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tf8xypkH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMrGkN0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3138A20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:References:In-Reply-To:Subject:To:From:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/lnZXweUpRhpCgnlRCNVCmEqXzffr2OHEOF7ZcD4dU=; b=Tf8xypkHfaeT1ioRuR17OKiFsW
	3gCFOXbU+98MZlt4YH1VulkAI1grHI7upl/dCBohMjhbxo5BbbGyZeaiBjxN6RLIU0gck+/e+GGSG
	Gn0JJlisZls2XKeVZ8wC6TlBhuBx5AYI2bbw/EzbOWphqAeF02cihPqqqpZ9hit85TZqaJausAgN6
	gWuEUEHb3kS4X+LmvZizhHMgdyLQRVe6xuAJnI3xceGANF+jGBiYeAMgruZ8aG7wjnW8UDpQSdOGq
	rIsxJksbdQqVIqCkb0Y1Pilyvdfix9f4LR39PhAK6T9q58g8XVegoiKuWi13dTBXwIYrMpsETEzi/
	WXabT4LA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwTqw-0001jy-NH; Fri, 17 Jul 2020 17:08:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwTqq-0001hd-BW
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 17:08:50 +0000
Received: from localhost (unknown [137.135.114.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E402C20717;
 Fri, 17 Jul 2020 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595005727;
 bh=nngL0ckNf8/smwBwPZWSKAozcrsj4QkjLpABavd1ntw=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:
 In-Reply-To:References:From;
 b=tMrGkN0UUwRSBqkwgXeS8ViNy7E7W7ZTQRfessXN68QJVXhi4u6w5iniLwjK3B3P8
 8e3RkGNrGR3vPbNogYivIWuDEyvmN7yYUIlW7lCz8WNHo+H+s5lr2Hl7FHoHOiioBC
 P0pouD6/7hJN6dZ3ORVKLFrPL0o/izTH6VsVdFqw=
Date: Fri, 17 Jul 2020 17:08:46 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Coly Li <colyli@suse.de>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] nvme-tcp: don't use sendpage for pages not taking
 reference counter
In-Reply-To: <20200713124444.19640-1-colyli@suse.de>
References: <20200713124444.19640-1-colyli@suse.de>
Message-Id: <20200717170846.E402C20717@mail.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200717_130848_515485_F8111581 
X-CRM114-Status: UNSURE (   8.75  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>, stable@vger.kernel.org,
 Coly Li <colyli@suse.de>, Hannes Reinecke <hare@suse.de>,
 Jan Kara <jack@suse.com>, Philipp Reisner <philipp.reisner@linbit.com>,
 Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.7.8, v5.4.51, v4.19.132, v4.14.188, v4.9.230, v4.4.230.

v5.7.8: Build OK!
v5.4.51: Build OK!
v4.19.132: Failed to apply! Possible dependencies:
    37c15219599f7 ("nvme-tcp: don't use sendpage for SLAB pages")
    3f2304f8c6d6e ("nvme-tcp: add NVMe over TCP host driver")

v4.14.188: Failed to apply! Possible dependencies:
    37c15219599f7 ("nvme-tcp: don't use sendpage for SLAB pages")
    3f2304f8c6d6e ("nvme-tcp: add NVMe over TCP host driver")

v4.9.230: Failed to apply! Possible dependencies:
    37c15219599f7 ("nvme-tcp: don't use sendpage for SLAB pages")
    3f2304f8c6d6e ("nvme-tcp: add NVMe over TCP host driver")
    b1ad1475b447a ("nvme-fabrics: Add FC transport FC-NVME definitions")
    d6d20012e1169 ("nvme-fabrics: Add FC transport LLDD api definitions")
    e399441de9115 ("nvme-fabrics: Add host support for FC transport")

v4.4.230: Failed to apply! Possible dependencies:
    07bfcd09a2885 ("nvme-fabrics: add a generic NVMe over Fabrics library")
    1673f1f08c887 ("nvme: move block_device_operations and ns/ctrl freeing to common code")
    1c63dc66580d4 ("nvme: split a new struct nvme_ctrl out of struct nvme_dev")
    21d147880e489 ("nvme: fix Kconfig description for BLK_DEV_NVME_SCSI")
    21d34711e1b59 ("nvme: split command submission helpers out of pci.c")
    3f2304f8c6d6e ("nvme-tcp: add NVMe over TCP host driver")
    4160982e75944 ("nvme: split __nvme_submit_sync_cmd")
    4490733250b8b ("nvme: make SG_IO support optional")
    6f3b0e8bcf3cb ("blk-mq: add a flags parameter to blk_mq_alloc_request")
    7110230719602 ("nvme-rdma: add a NVMe over Fabrics RDMA host driver")
    a07b4970f464f ("nvmet: add a generic NVMe target")
    b1ad1475b447a ("nvme-fabrics: Add FC transport FC-NVME definitions")
    d6d20012e1169 ("nvme-fabrics: Add FC transport LLDD api definitions")
    e399441de9115 ("nvme-fabrics: Add host support for FC transport")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
