Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F089C7EE22
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MQxKVjgaqSmXD3lokM1qSNX88ZOCqyaRaxNY37jakuc=; b=eG8DqOnk/vwQ3jLL5FUW6Im3br
	zeiMWQugBeoP3QJmQwXrB3C5iNm7E+FoUZ2dr3ePGLofLFqxQWgLJGxEMvzU2yRiJ1LCJEK0JN0Wr
	jbFdhsJ/G9P7WX4ggnLmQayfIOy24pMK+lMPDPt1nUHPojkQCZXlPfi+oNIEAf82bi/s8yrvfSZYl
	/29nBQpy4Cq4HRDw2qMfjZAO4ZiqCK5TorlTN06wE4ZpoKYVFRDNVG3Mw/Vdnpa6VwPdncv8WqUb+
	pGqAsrMZwK42OORzZy5N9WFzmar/6WKd0Mu+3hpyg7U6kt2swuUOzw6h8gzLzx3Shj6xtOgiypUwg
	Xd1Pbwng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyZda-002U7B-0s;
	Mon, 15 May 2023 14:57:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyZdY-002U6a-07
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 14:57:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBD36205E;
	Mon, 15 May 2023 14:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500C1C433D2;
	Mon, 15 May 2023 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684162638;
	bh=Lvb/jAR/Rt/djBvTnLBFzlXdbYPnOO5R4aD47E8bZtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyzFZrJ/eh4B5r69p7kR8qkjnuhd6Rv6TQoMK9ENArUDcq0mFtxousWnYEp2VZI8P
	 ngKf0SgduzlXAQdRi0h06auu45YVFeIQu6FoA+T/caiUaeFbbepE5GGiHR6AmyC9N7
	 ahxmHwwRDToxjCPAEv75dVyiKgNyupMOK36l8DHNLKnyZRb2hCgZuHkk12YkOANIkl
	 dbgmE5MAJUpS3VkpcGqtJ2CrEBDwVHxXdfpA2I6A4LHcT8KwxnbGKtg5QA0Q4p3jBr
	 KdDm48iE37YeEaK6R+z2EJAywLGO37M7RnHC1kQd4xtY9IwL/+4xExljBKniUweIBD
	 iUnI4lYavXLZg==
Date: Mon, 15 May 2023 08:57:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, oren@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH v2 1/1] nvme: move sysfs code to a dedicated sysfs.c file
Message-ID: <ZGJITKis7X6Eaot/@kbusch-mbp>
References: <20230424211242.19614-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424211242.19614-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_075720_114063_C4004644 
X-CRM114-Status: GOOD (  14.21  )
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

On Tue, Apr 25, 2023 at 12:12:42AM +0300, Max Gurtovoy wrote:
> The core.c file became long and hard to maintain. Create a dedicated
> file to centralize the sysfs functionality. This is a common practice to
> separate sysfs/configfs related logic from the main driver logic .c file.
> For example, in the nvmet module the configfs interface has its own
> dedicated file.
> 
> This patch does not include any functional changes.

Thanks, I applied this for 6.5 with a couple minor changes:

I merged Chaitanya's dhchap memory leak fixes first, which touched some
of this sysfs code, so I simply used the the result when moving the code
to the new file.

I also added an 'include <linux/nvme-auth.h>' in the new sysfs.c file
for when CONFIG_NVME_AUTH=y.

