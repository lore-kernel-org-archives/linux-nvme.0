Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12049C7EE23
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pkgYdGDWuK0wmgKS4U/70ySedsr0U5XZ+57P7WD4+Gk=; b=s2ltapGLE3eCYMgWfctojsBUy7
	6wZpmos3dX1DlzFrzJkm7M/iBTuIJx0ZktvcrCRaYFAGikm61wYchQ87KmjRwYsWVOeCLbENk0iWC
	g2DvgwTNI+yYZBoGVwT55pFfMYrcsyFRSC15gI+Rh9xwgl9u5Wvhe8px5VXLplGOXm/2WB/lzRSKO
	D970NiiCM4uOV/CZJBbcQzpcmpvY+vvJiGiYI5SF4EeEonHmZlu2Aaw0Rt/ba/4H/mwH8ezce/fy2
	AldjwTqhogQtzJlpi/9g40nyaiWAZxTALFZaC5QPY8SsrrEYiskggiDryFiqBp7EuCYcJ79xR5QnU
	8wNTWIYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ohV-0050mo-1L;
	Wed, 07 Jun 2023 08:39:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ohR-0050lA-0O;
	Wed, 07 Jun 2023 08:39:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA2963090;
	Wed,  7 Jun 2023 08:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3A1C433EF;
	Wed,  7 Jun 2023 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686127163;
	bh=KpWcSBDck/xwxFkd8Vk7fAgf7Ve8mFKgiGPrEW6K2Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uA7EJ9P/L5+3z/cwnQO3ez6heNBOh2ztm0tByBVVVWSG+Ty9bViARmYghliiiTOjF
	 zfyDKZ/WVZKnKqb27eoLFNy9Gp4VWJLbdFkpxtUdjTW1ihovnzx9mCqpvHlcVKl0Th
	 Rf10QupAAvqzcAYZp+8tXsnFlejznxrDCiS1fwCDYebGVZXivhfNLwt2PfA+VtSam8
	 pCcZzAUeaQGLwZNEeJwBUOIWm8QeGe+wPLl1Arn+PXC4T9/q84iyVBg8Og8sHsu9AC
	 ymPxr4yq3cRtmcaUpMPCw2/GSyLHKDd4l8T1R7oWgm4TKIqgSNoA6xqMxcENCVvjqq
	 jYZClevsYWR4w==
Date: Wed, 7 Jun 2023 10:39:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 14/31] rnbd-srv: don't pass a holder for non-exclusive
 blkdev_get_by_path
Message-ID: <20230607-deckname-gewettert-cf7a2bce127f@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-15-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_013925_206409_EA6D5B90 
X-CRM114-Status: GOOD (  10.67  )
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

On Tue, Jun 06, 2023 at 09:39:33AM +0200, Christoph Hellwig wrote:
> Passing a holder to blkdev_get_by_path when FMODE_EXCL isn't set doesn't
> make sense, so pass NULL instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

