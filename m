Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C78CFD31C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 06:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q35Uzhw2kUdUnX+0WJUFRb4cV3+/l9MC0GtyEz30cco=; b=YVLePsEA7Zp8uVppQFH0RXBTWY
	bKst4lPz7Yb/JO1O4E7SUgqAP+4egfwJLJD34xqib8OyvP3aJkj3Db8oLl4+MnNKRmZQ4c2bL0YAJ
	BSvd+EiVZmNoQT39d0qc35SaGMpG7s5KFwGmJZ099mT6RjqcAt+UQAmqQLzbM7OF5uUgY8hwtsoP2
	FkGQTVKOX5i/4jIIbUAfyOvLNm61DvK9sDxYVTnr9q7Jp5VQKD0Sy33PHD2yZojnH121+9K22nODo
	TAsWsmwNSkbbddINCS/nCpO0x0TP3FncA3OVciv3yNqbQI6h3Jok7oKEQZjxGjEkrWsEh+66ZF7xc
	gar3+hvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQ5a-0000000BAAD-1rY3;
	Mon, 24 Nov 2025 06:30:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQ5X-0000000BA9l-2b8U
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 06:30:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B44AD68B05; Mon, 24 Nov 2025 07:30:11 +0100 (CET)
Date: Mon, 24 Nov 2025 07:30:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org,
	chao@kernel.org, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH V2 4/5] f2fs: ignore discard return value
Message-ID: <20251124063011.GA16808@lst.de>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com> <20251124025737.203571-5-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124025737.203571-5-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_223015_798516_4A50395A 
X-CRM114-Status: UNSURE (   9.73  )
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

On Sun, Nov 23, 2025 at 06:57:36PM -0800, Chaitanya Kulkarni wrote:
> +		__blkdev_issue_discard(bdev,
> +				SECTOR_FROM_BLOCK(start),
> +				SECTOR_FROM_BLOCK(len),
> +				GFP_NOFS, &bio);

This can be shortened a bit as well:

		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

