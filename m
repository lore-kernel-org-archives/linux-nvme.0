Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E368F8DFD1
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 22:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Um4z0XWbc3Rs+JcXSSpN9m891lEXqVxJ/MK7OHpqgQ=; b=3XI+VnQYmE7tYFWNTIg0wbsLuh
	y1fJLnnZzVKfxsTSvMNx5teV5mOWrc5W1QwUrvECxEdcRVhs0/SsHOYuGwVFLK8VmrlsPceDvpE10
	m6kHpXVBiccGE3l8Kc6rAU/lErcmaHiNq8IibYWTFoPEoZ79mG2lOxzggHqyVSmCD5mY5PcPZYNRu
	my4qPuDz5RQTYeZJDQil8cOeUXc9YDw+kcPg9MbN0fWY4vg9lq6bK/2bV3QoweDFYzrhFvUVkynKz
	Lmmpc9l0hBJs3d7ihM+PCYC5yzqlLTylhaE+0Okztia6VxCSuMLbXGuOXKMzMdnriAf0Wp+cNB5JL
	nRJ6e7tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUwH-000000037sz-2aAw;
	Thu, 16 Apr 2026 22:11:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUwG-000000037sq-2BKW
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 22:11:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E43C560128;
	Thu, 16 Apr 2026 22:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D34C2BCAF;
	Thu, 16 Apr 2026 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776377515;
	bh=KyWB9ycvHqkmpmposSJtxAzlyFaOpjGf/DPS/R71W6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyYDlTI/ahHVBH3cT7RBDmQOh+9tB6lR0gXv+8TBxYY7XSwlOiQHSrHVQK1SPNVZu
	 lAdeOs+E5UoWhY144hpS8F9EkppzizxZrPercOtC/+QJXJ1QIysGZGMFKX4ypbSUHF
	 PqC1RivU/0e2zTQ5RhMLHjfcoDxn/C+xx46ASWS+7e0iRu4mQPujnlMQR5dcP2zAkR
	 ypxucjtsmCP6Qz9vz5SlGTtW8X/iwSaOa4AnvqZ1r+LloDWyT5jIkWjoUAwZkHu4TM
	 AtVVcLp3kge97eZn1QYTQCCMqk/PlPudsiyvv5sHoMzjzGr8/ua57wMKXhRILqumVu
	 TpumQ5ep887CQ==
Date: Thu, 16 Apr 2026 16:11:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tao Jiang <tanroame.kyle@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add quirk for Memblaze Pblaze5 (0x1c5f:0x0555)
Message-ID: <aeFeqc0poJuRPK-y@kbusch-mbp>
References: <1776274035-1604-1-git-send-email-tanroame.kyle@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1776274035-1604-1-git-send-email-tanroame.kyle@gmail.com>
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

On Thu, Apr 16, 2026 at 01:27:15AM +0800, Tao Jiang wrote:
> The Memblaze Pblaze5 NVMe device (PCI ID 0x1c5f:0x0555)
> is detected as a controller on recent kernels (tested on 5.15.85
> and 6.8.4), but no namespace is exposed.
> 
> Tools like lsblk and fdisk do not report any block device.
> 
> dmesg shows:
>   nvme nvme0: missing or invalid SUBNQN field.
> 
> The device works correctly on older kernels (e.g. 4.19), suggesting
> a compatibility issue with newer namespace handling.
> 
> This indicates the device does not properly support the
> Namespace Descriptor List feature.
> 
> Applying NVME_QUIRK_NO_NS_DESC_LIST allows the namespace to be
> discovered correctly.

Thanks, applied to nvme-7.1.

