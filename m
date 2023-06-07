Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294E5C7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jdBm5kt01ClfCkksSpKK2gFmzKFcQxazpE+ysPIWBGc=; b=vifrBPoA+PJuLlQDBDniHG+lon
	4WuYjWKYX8RO6L/I0WFc8OJhsFRAJrYxz1PZiEhzqRxlHKz8s7tYHCj71b5dC0yVt1vVP//X9KZ5j
	P5w4ogTFepJVDaecL3Vr9eQCp/U7pPldcjv1Jy0zEgK2Ux+JiwGzkhwRotQCxPreN9+cMtpOQavYQ
	HMvvP4Lk+G5M6zuUHAuG6ovdtb0onntnHRAfgEcSWZPZy5VKMaoV7s5M+y36YWk7A1wF50pqRF+PP
	g9rTthrOYYWeJbkLon/XnXdW23/k4IOjfcUC68aMrfDafgsKSvwujDRMeERCmzDq4pVdvdT6NIGkF
	sDCtTdLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ocW-004zL7-0E;
	Wed, 07 Jun 2023 08:34:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ocS-004zI4-0j;
	Wed, 07 Jun 2023 08:34:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5FAAE63818;
	Wed,  7 Jun 2023 08:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A10C433D2;
	Wed,  7 Jun 2023 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686126852;
	bh=WLIiOy1LVRNyW0WZKHMIEfuQqspHlo5YhO+pF9gbKTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOuWu1dlGBSnRsTIERY3XMHE9OvetSc+XVDTNH9LUt5Ur7MEzWHQldJkC0OjFF39K
	 8gGF0zsP8mAReVRRLxbA3ZDMv8aReZJfLmnxqg2TjHMWlP4lcMK9VVsvtBUjxWcffe
	 iriT6wbTkvybZ5ExwZT785rTN0BZKNtthQHc5REmf28J1I7IlqVDJgibRROBA8W6ym
	 o7kZewH3FWNgkyfATBHcyXzIU6aVOCyONuL3m8m1iO12qt2laJZWwD1ve/kVe3HC7N
	 SAc45LJ2WAm7wX6H10W0XR8XlHHzXCy54pHlLC7qCDuxE5H2tx4uNHCy0AYTeLwOxb
	 XjEhfMSt+EF+Q==
Date: Wed, 7 Jun 2023 10:34:04 +0200
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
Subject: Re: [PATCH 09/31] block: pass a gendisk to ->open
Message-ID: <20230607-einlieferung-beantragen-062729bc8f6c@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-10-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_013416_304193_10224CE0 
X-CRM114-Status: GOOD (  15.49  )
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

On Tue, Jun 06, 2023 at 09:39:28AM +0200, Christoph Hellwig wrote:
> ->open is only called on the whole device.  Make that explicit by

Ok, that answers my question in
https://lore.kernel.org/all/20230607-chefsessel-angeordnet-269f0596f9b3@brauner

> passing a gendisk instead of the block_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index a1688eba7e5e9a..1366eea881860e 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1386,7 +1386,7 @@ struct block_device_operations {
>  	void (*submit_bio)(struct bio *bio);
>  	int (*poll_bio)(struct bio *bio, struct io_comp_batch *iob,
>  			unsigned int flags);
> -	int (*open) (struct block_device *, fmode_t);
> +	int (*open)(struct gendisk *disk, fmode_t mode);
>  	void (*release) (struct gendisk *, fmode_t);
>  	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
>  	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

(I didn't bother going through all the individual conversions.)

