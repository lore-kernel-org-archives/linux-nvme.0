Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AABC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SLM3Ygt2iESODXGmQs63u34UXciqPDbzgQ5fAhca4RU=; b=jsucbsT94WIkSOaHM2ODVEOtQU
	cgkiWhH5OLDNt+odYUFM63TbsyRRllupZKdDHBx0QoJX0YcYsTC4QGMeV8FbpeOUibY6dZpYXX80j
	ZkDp5wGo98t1cgS3Q98OLJHwcssC95SXOITWuIJ8VIYPHC7HmYEh7M4/RAQIHuZBisU9o2LrdWHsd
	94ZDH4vYGrJQd4Eiu7eHSIrxkaLVGSY1YliqPLMfH/tHEmw/zoiRrPiHv4i3pBhdmVWg1r1GYRVQU
	VE+eXPmXWL5e5LaD/oytekWTSY1c651L06LV4McYFH3YYx0HLy6X7o23BOz7CgWqGmnoB8FSV9w/x
	h9uwLXwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlylz-007URT-3g; Tue, 03 May 2022 20:05:27 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlylw-007UQf-Er
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 20:05:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E6D72B82064;
 Tue,  3 May 2022 20:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0282C385A4;
 Tue,  3 May 2022 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651608321;
 bh=2OQ31S8saJK84+b60Nks/1nuGKuObPzODZf658f3HMo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z3gmS/aw/5UbzdnldhQqOG3y2Htd54aWj3NdcFNjD/VuO6MUhIRAXm8gaqDMrbl7m
 0Yd/IIwkIht0j2PXb+Na0iGFxmmXo69g/ybxOPgh9SC99E//dv42kQFiRnnJINmj0G
 WQVouHUD07VcTCvD102p1MYo7k7OtdRH4nZKSxophQWU5wzuRrxx/mIrjlCvn7kjsq
 yDReBNF0aClXwfI3zXeCWlW3e+RBMWhcbp6h1csAmjw9TRrSIgu4j5wxKNCdKT+oKm
 M5ALQh3FJxRyG6IiOBdtF5JBS3VvY3anbsCRiV8IDHss/pgBG5U5QwG09lcuiCVlnW
 Bdy2Z6nmvE8yA==
Date: Tue, 3 May 2022 13:05:19 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
 naohiro.aota@wdc.com, sagi@grimberg.me,
 damien.lemoal@opensource.wdc.com, dsterba@suse.com,
 johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
 chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 josef@toxicpanda.com, jonathan.derrick@linux.dev, agk@redhat.com,
 kbusch@kernel.org, kch@nvidia.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] f2fs: ensure only power of 2 zone sizes are allowed
Message-ID: <YnGK/8lu2GW4gEY0@google.com>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160312eucas1p279bcffd97ef83bd3617a38b80d979746@eucas1p2.samsung.com>
 <20220427160255.300418-16-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427160255.300418-16-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_130524_682387_BA82FC42 
X-CRM114-Status: GOOD (  18.92  )
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

Applied to f2fs tree. Thanks,

On 04/27, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> F2FS zoned support has power of 2 zone size assumption in many places
> such as in __f2fs_issue_discard_zone, init_blkz_info. As the power of 2
> requirement has been removed from the block layer, explicitly add a
> condition in f2fs to allow only power of 2 zone size devices.
> 
> This condition will be relaxed once those calculation based on power of
> 2 is made generic.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/f2fs/super.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f64761a15df7..db79abf30002 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3685,6 +3685,10 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>  		return 0;
>  
>  	zone_sectors = bdev_zone_sectors(bdev);
> +	if (!is_power_of_2(zone_sectors)) {
> +		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
> +		return -EINVAL;
> +	}
>  
>  	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
>  				SECTOR_TO_BLOCK(zone_sectors))
> -- 
> 2.25.1

