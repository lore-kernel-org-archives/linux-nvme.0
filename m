Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116EDC47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 23:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4BL9YkvsHxZF+N90otJjttq9jOeIS5iP5m+mMKWCFlc=; b=Y2lNU0JN9PRNQRPZGg3F9gISn/
	qd9FB36z01YnQzfmR933gW5THAcKr8C1ljLnmaXYvKOQGlsc4tpvYfeFu8bw0oediJrdXCYw22Lpz
	/bwxKJlLBNKjh0wzgploUbO3O3Yr0m7o1sXgfsPa1MsC8npQovNly16Et0azpIWZMBNLvIFqeqObZ
	p5odG8WcZoM5oujLLyas5zIJAjLc87au5zaNGVQnrt28FRZmIZTZ/khoUHe81bAYYnkrJKKNAG4GP
	CP3cYhiUXN+uwLL0+JkRH/mSqWdPSfqBkLLB5wG2Gq91bJa3dhFrij3qCrTPCg1E+dFij+zMhAk/v
	xrN4Kvng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUb2h-0000000EaId-2Tex;
	Mon, 29 Jan 2024 23:27:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUb2e-0000000EaHg-29AH
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 23:27:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DAD506256D;
	Mon, 29 Jan 2024 23:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1237C433C7;
	Mon, 29 Jan 2024 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706570871;
	bh=Mdn+J9ySgQDC0oIOmuVaL01BXzHtXOiqj1R6pkOEXjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jRmN35v5/TLg+E/6GKrLcZzc40NYxmcq8gYRNw3u3sie30Rz+d4av7V7MegSsvqxG
	 KAiuOGk8tu1E8XEbv7dckuFrLaVvYOpq53UYRA227YbeEkM9B2tRSdYDDjlpShY8Rg
	 t89UsvoRUr8Xjtv/+1ilsuMwibhwjrERvpTSDoPSFskCTLvL24IQNVeLqQduEKgJcC
	 JqA7KuJS+iTk3EagquaUHipVQpJUytNEzUi33la2Et2MbK9oVD12OV2tPIqOg7zsY3
	 ymEpmNGW3zFiJot8m6q+DnJAvGWXMjv93tIrljuszNfyQhfzZTx3LriKq9mqEaCvH0
	 Ff5p4GJAKdBfw==
Message-ID: <cb6d6cc2-25bd-4ce1-baa8-9ba94672977b@kernel.org>
Date: Tue, 30 Jan 2024 08:27:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] f2fs: guard blkdev_zone_mgmt with nofs scope
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
 <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_152752_655916_CFD03EA4 
X-CRM114-Status: UNSURE (   7.30  )
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
> Guard the calls to blkdev_zone_mgmt() with a memalloc_nofs scope.
> This helps us getting rid of the GFP_NOFS argument to blkdev_zone_mgmt();
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


