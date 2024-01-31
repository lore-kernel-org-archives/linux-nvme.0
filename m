Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F84C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 07:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V4YAZDel5OBwMG24YgZ8kPVmC8xWyteZPVcV1z2w9Sk=; b=kR4yZOMeTHPpsj6ZSNCV9kRZCJ
	iu6bDSiIHRz+47/f3dP1ifD3TS2cA9kB70JgCZxkxI1HikOfORG328AKZE7Q1X0BGgGXrFiNUA4Z1
	Y9MlO7s+zA0ozIODOZA/Txb97wuP4LYVYb2HWESz/sh3wQMgIG0WaPfqEgicTiJn02/Eu3EcaY6Gu
	G9GpGLsfh3uhJktHvFtornDrbJlDcMYP5Zn/DeRCtEqpNlvBGWl8Jp7h0SGCQrN2KKmmjhuQsXM+C
	okauCp7q7uPa9a5YnW+Px//Y4HoqYrFDDbTXyg4y5L0cW8Ix9KtIthbZpMC3uK/bwB3VpKMzrNoK+
	kpG6H2DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV55N-00000001qqU-2SqH;
	Wed, 31 Jan 2024 07:32:41 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV55K-00000001qoY-1kkd
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 07:32:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0D3DCCE1D9F;
	Wed, 31 Jan 2024 07:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2C4C433C7;
	Wed, 31 Jan 2024 07:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706686355;
	bh=sxA/BQif6UosZYq9bEM7P35Kp7rNc5yXcyj9qFUfD4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sXgRqJl/mMi2kUmYZA/bTZQ70FhzSCKpqsJprAywphSWPE15pORJFWbnfKjrJ8FqL
	 FbArM8c44OdB1yyxg99MPlRtVdaX2d36hFPLV2AIVx6sK5wuRFanJeAmmkeosV2jeO
	 i/tEvG5AAbqeAW/XsqxaSasMNCN9W/WIfyupoc/USjWkoFBPzkcYi+XaYHcMORh6mG
	 bZ6HHZH/1YaM9xkgVDWPrRkj0gPXkQPS1y8kM6feJtdxy7PdpZ8fI9sAxeuqlUijBF
	 H/mkTru9fO3Nf9nW21Ssl6kU7nEjmd5iZKNHS78J3STgJ4BuvnPKcX2HN0sirrqqx+
	 2DFYmNgfg0rLg==
Message-ID: <a73d0808-b6ae-4d78-9846-379b83540c72@kernel.org>
Date: Wed, 31 Jan 2024 15:32:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] f2fs: guard blkdev_zone_mgmt with nofs scope
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 dm-devel@lists.linux.dev, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_233238_664998_926A18CA 
X-CRM114-Status: UNSURE (   7.09  )
X-CRM114-Notice: Please train this message.
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

On 2024/1/29 15:52, Johannes Thumshirn wrote:
> Guard the calls to blkdev_zone_mgmt() with a memalloc_nofs scope.
> This helps us getting rid of the GFP_NOFS argument to blkdev_zone_mgmt();
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

