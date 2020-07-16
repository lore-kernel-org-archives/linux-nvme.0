Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C902BC43446
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 00:27:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995D22076C
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 00:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z+XfwwD0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZa7PeNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995D22076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:References:In-Reply-To:Subject:To:From:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/lnZXweUpRhpCgnlRCNVCmEqXzffr2OHEOF7ZcD4dU=; b=z+XfwwD0w0cIngbRMehhktbP7t
	FWj6bT5NC2cGTm6MUoWegg9s1ig3X4gQKdtPfZUkJHUcHEY/5tSb8o7NE/xRjAmiRv0O8PcY+dWbA
	QkZ1jYYx6oYk5oe7uk0kodTDFd4v/A7bjk8ffO6nKAceudNVg7SO+14OTGPexlfJL00BF7d8BOang
	hyKxs0YNJ114t4P63J6E1iCakCNP53J8ISXfMoWmM4ml5iS0n3YzlKQJm1NfpSOfh9T31LuHvKAr2
	J1rG8jxhVuUgPjJkVY3b0siT7w8H/dS5RTsVZI6dS5CM5ZqdDDgXBmZEv1qTrZnCM2UWoaUFLEemS
	NZ7uyBVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvrkZ-0002i1-RA; Thu, 16 Jul 2020 00:27:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvrkU-0002gO-BC
 for linux-nvme@lists.infradead.org; Thu, 16 Jul 2020 00:27:43 +0000
Received: from localhost (unknown [137.135.114.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 88C1B207BC;
 Thu, 16 Jul 2020 00:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594859261;
 bh=nngL0ckNf8/smwBwPZWSKAozcrsj4QkjLpABavd1ntw=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:
 In-Reply-To:References:From;
 b=LZa7PeNwvjlt9hSHZ3aQDm+KNzcovhxphCXJDgGddbA0107aCwiuM+Y0CFw+ULvGV
 mwsyJ+u53l/4xekIz9qgtEnjYEnDCJcvNOn+BW0AOhssIq4bZa3TQlR4vRZ0Xaoth8
 tnfvGCH8XwiT28iQ8xbRf/6cSjW4A0NZkZAcO27s=
Date: Thu, 16 Jul 2020 00:27:40 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-tpc: don't use sendpage for pages not taking
 reference counter
In-Reply-To: <20200710132610.11756-1-colyli@suse.de>
References: <20200710132610.11756-1-colyli@suse.de>
Message-Id: <20200716002741.88C1B207BC@mail.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200715_202742_519957_9086942B 
X-CRM114-Status: UNSURE (   8.88  )
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
