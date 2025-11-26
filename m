Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D1DD10F21
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+7Z5fB60os7q6kICOUWfVrojZn8uG6QfVCWYuFSkjtA=; b=Zqrk3uHtiKH7qTu/06/O4Y8T4r
	LClZxL2AQ7rH8mTL+LE1QzSGV0o/ge9h+ZrmzW0CQn+PAgPKepkJITP+QDIJPuUd3YR9p2LhzOZFb
	onLdU1m8+jLHk6JuVP+UEyitlzpf4gtz1Xrd338SqrA9QdIWYuJmnu+AJUVTfmIGQhGifp66hHyp+
	DYeZxW4D31ITbE+jcPJwd64F2D7MgH+KQlmfuNAq98gDSDUtBBuwHvInkyf1MsU2iy/wHzfBwT/hp
	hbKxqAMjnJhw1a88qC5uSqLFhVTGTtqT7hSo00pTLajU/LvFWqjzi7e3/Feoeo1forOw1+m57LQq4
	XzLTS+DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOCq8-0000000Entl-3yNd;
	Wed, 26 Nov 2025 10:33:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOCq6-0000000Enst-0ISa
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 10:33:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3FC8868CFE; Wed, 26 Nov 2025 11:33:24 +0100 (CET)
Date: Wed, 26 Nov 2025 11:33:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH V3 6/6] xfs: ignore discard return value
Message-ID: <20251126103323.GB26228@lst.de>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com> <20251124234806.75216-7-ckulkarnilinux@gmail.com> <b18c489f-d6ee-4986-94be-a9aade7d3a47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b18c489f-d6ee-4986-94be-a9aade7d3a47@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_023334_418898_8EF68751 
X-CRM114-Status: GOOD (  10.33  )
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

On Wed, Nov 26, 2025 at 10:37:10AM +0800, Yongpeng Yang wrote:
>>   				xfs_gbno_to_daddr(xg, busyp->bno),
>>   				XFS_FSB_TO_BB(mp, busyp->length),
>>   				GFP_KERNEL, &bio);
>
> If blk_alloc_discard_bio() fails to allocate a bio inside
> __blkdev_issue_discard(),

It won't, because mempool allocations will not fail if they can
sleep as they can here.


