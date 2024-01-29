Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095CEC47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 23:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9sKm4m4tNhVV+szTwnWt+GP7PAM4jvgYxDYa6S+Dn0=; b=SZHy0mYc6ddOxtuTxg6sc6/bdj
	VvsTEEvFwr1HqYtfO4xbJUtancAC/A5dVXSjSberPSuUfNPYWFBpcZRsoa6N7lnsB3Wi8twLSuSAQ
	/ITGhmVhcxqF+bWi+JODvnW0/jE4SeT60MAhzr6RD3BoB/+U2xlhH6UVqxjbV4Qd1Gj+tzpbc3yS6
	+R1z1txwJO9K1m+GWqQdkW9HQP6q9wIEsCiAN6J/adKljtIqga5JZi4e6xZ469fC6INilM8MJQuBT
	3ZmU2h0xVmX1BwKX++eoMExkF4bqKMhXVVTVoTaSMGtkpNTn39HascPw0y89uE2wnaxNBlGmJmUJ1
	n50+T0mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUb2C-0000000Ea8l-2MKO;
	Mon, 29 Jan 2024 23:27:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUb2A-0000000Ea7a-0Pf6
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 23:27:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 95DA762555;
	Mon, 29 Jan 2024 23:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56009C433F1;
	Mon, 29 Jan 2024 23:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706570841;
	bh=DWcUvH+PKWSEd4GyAqc2dx7y2J0qGqIrXW/FrQm0G0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HDQpxYG+LgbG4d8+cVulHIpQIvwQ4Q/z15d4yrLO8SSy1WWcuWxOKQChKZr4WGFwo
	 0IMQbgiBrOUbZIwRu2uHzLfpLM/fJK8WNdEdy1t/Ki213Ic/4x16lZ/PNdIUi6PON9
	 6kjjUYPRwi/roGjStwOpzyhUME/oPHZUP8yomMiheuYYhS4xv4n39Lk+ocFmJO0Zij
	 nNZ3MS/N9X6IEtIfbwGcHQh5OM8uosJFsnEouxTITskevZA4lr268h1XrxT+4e2t3l
	 o7DiaoiuMC85wSkLqyN3haUeJhrgXLBVILmDj3nDt/keuL/uJzwDzZrIGZEcBnKl3h
	 +ZyBgR48wRN1Q==
Message-ID: <9e787a31-8aa1-48ad-8488-770146475365@kernel.org>
Date: Tue, 30 Jan 2024 08:27:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] btrfs: zoned: call blkdev_zone_mgmt in nofs scope
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-3-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-3-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_152722_227030_C2A42BA9 
X-CRM114-Status: UNSURE (   7.35  )
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

On 1/29/24 16:52, Johannes Thumshirn wrote:
> Add a memalloc_nofs scope around all calls to blkdev_zone_mgmt(). This
> allows us to further get rid of the GFP_NOFS argument for
> blkdev_zone_mgmt().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


