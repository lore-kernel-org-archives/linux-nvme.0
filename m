Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02026C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxEj842KuniYKu8LNoiseYurt1UDs9Im0HmbnN7/hxc=; b=Qac578yEV9U5Z5gQAlDgdRdAss
	VpijjK4Ft254wPISF0Ud7Wwx5lj9cOhBJWCU0Kjyz9U5Z8zNfa7Il66jJ7J3S/XEbPgXqRIhW/U6d
	M6NuzTpY7kBT1ws5LVfOrxSalmgwXViiO6NsvWrhBeCT6m/1aSJ0IHhDj5MqU/OYrGqZl5bWuSUXn
	49HZUrNPnNiLANMaNiiV6x8w9MmMS5BRF4FOhaAR1Y+sl1MHqng1K1Cd/x/4rDAp9CyjXn/G3rNvC
	ZNKjnw1aiVGTJkupKz9HYd5f9msFYLRC+AV5IRb4lVaHXyErZEY+vAsCThWPnirQzQD7/UdT65F7Z
	e8MDA6XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vqg-00000008tFm-42sp;
	Sat, 11 May 2024 23:09:50 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vqe-00000008tFZ-2KPB;
	Sat, 11 May 2024 23:09:48 +0000
Date: Sat, 11 May 2024 16:09:48 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-6-hare@kernel.org>
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

On Fri, May 10, 2024 at 12:29:06PM +0200, hare@kernel.org wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Don't set the capacity to zero for when logical block size > PAGE_SIZE
> as the block device with iomap aops support allocating block cache with
> a minimum folio order.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/host/core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 828c77fa13b7..5f1308daa74f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1963,11 +1963,10 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
>  	bool valid = true;
>  
>  	/*
> -	 * The block layer can't support LBA sizes larger than the page size
> -	 * or smaller than a sector size yet, so catch this early and don't
> -	 * allow block I/O.
> +	 * The block layer can't support LBA sizes smaller than a sector size,
> +	 * so catch this early and don't allow block I/O.
>  	 */
> -	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
> +	if (head->lba_shift < SECTOR_SHIFT) {

We can't just do this, we need to consider the actual nvme cap (test it,
and if it crashes and below what the page cache supports, then we have
to go below) and so to make the enablment easier. So we could just move
this to helper [0]. Then when the bdev cache patch goes through the
check for CONFIG_BUFFER_HEAD can be removed, if this goes first.

We crash if we go above 1 MiB today, we should be able to go up to 2
MiB but that requires some review to see what stupid thing is getting
in the way.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240408-lbs-scsi-kludge&id=1f7f4dce548cc11872e977939a872b107c68ad53

  Luis

