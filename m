Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D115C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nHhf76PYFmomNFpbAlManyiGljxoFUYE5tUMpOM8J2E=; b=ALcPPrxAYxxa9HbBg+rVzLHS95
	CvvK6dYlaFsjG4dxq394AEBoxf5RkeccN5i8VLvQisaV2kAPhMA+HxzF8sdrv7sqk0SrbgGRtV9rU
	wByT04pCaHEyrmMyQICEwIjN2daEAIkF+JqdySRYertDFASikluHLGeXPX6S5MbVAKSSQ9TVyos2W
	JuTbbvPbzrNOUMJGE760jQH7T44tDGPGwUGQ0LJfqZtOBwGMoxElKHXj4yuX7wbJYTmhcbiOQWe0j
	SIZtBfYtvZ0Rfa4KHghQVTIm1X9IxobuATS7WtyFM1IianBA7RYXecemC8S3/zKU2DfV0AzyWtbaT
	SKHRZ8tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvjkn-002rvA-Rb; Fri, 10 Dec 2021 17:32:17 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvjkM-002rkK-Ik
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 17:31:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 37040B8294F;
 Fri, 10 Dec 2021 17:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A502FC00446;
 Fri, 10 Dec 2021 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639157508;
 bh=DEr1eeNEgIMwe8OqZ9EO4Ggitam4siswH8i855qimaA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=py1ejWh+Vq9zVCDiwGoqEt4XVOVVI6b3PBxUa5AULMhEk0xYiTOHzlSfDmHPgqnXR
 7WE3wSUe86kJ87CVmqxHJVHYUgp2E4uSWRatj3WCo73VIPqELlSXlTgqgg01o5sHML
 6dAUc1U67b5m/OWRVl1yhIt7gX+iorekjHFwYlM5pozoCYZARh8J7Mz9lfKtbVW5n0
 upQ2qSEk4pCsV2oFTsTCo79rrjxhiAVIATcsRxR/YpVxd9x/grKmBoooldCKlkDr0O
 PK6eiJjongtIE5PmlzqR71uUvvzAdtFdU0VpTr1HyfhFjFilIexwGQsa9gEyZuLKU5
 0iMC9CeeH9oxA==
Date: Fri, 10 Dec 2021 09:31:45 -0800
From: Keith Busch <kbusch@kernel.org>
To: Zheng Wu <wu.zheng@intel.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix possible initialization failure for
 P4500/P4600 SSDs
Message-ID: <20211210173145.GC3856533@dhcp-10-100-145-180.wdc.com>
References: <1623945952-18861-1-git-send-email-wu.zheng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623945952-18861-1-git-send-email-wu.zheng@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_093150_814022_1E251A82 
X-CRM114-Status: GOOD (  13.21  )
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

On Thu, Jun 17, 2021 at 12:05:52PM -0400, Zheng Wu wrote:
> From: Wu Zheng <wu.zheng@intel.com>
> 
> Subnqn isn't supported in P4500/P4600 SSDs.
> It's a fixed unavailable value in each P4500/P4600 SSD.

According to ark.intel.com, P4500/4600 were released nearly 4 years ago.
My understanding was these were a popular product. Why are we hearing
about this issue only now? Is this issue specific to a particular
firmware version, or has Linux really been incompatible with these this
entire time?

> @@ -3326,7 +3326,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  				NVME_QUIRK_DEALLOCATE_ZEROES, },
>  	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
>  		.driver_data = NVME_QUIRK_STRIPE_SIZE |
> -				NVME_QUIRK_DEALLOCATE_ZEROES, },
> +				NVME_QUIRK_DEALLOCATE_ZEROES |
> +				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>  	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
>  		.driver_data = NVME_QUIRK_STRIPE_SIZE |
>  				NVME_QUIRK_DEALLOCATE_ZEROES, },

So the generic P4600 is broken, but Dell's is not?

