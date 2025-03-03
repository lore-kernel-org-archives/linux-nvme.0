Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B73FC282CD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JaHQEzFSi7TEV17qOfuXHvkYAGdpy1yk4j7JpfBPkVY=; b=BFNZdq+KiZ6CHHNzQfiVK+mKBz
	3SlIzklHSGowFkBtI8phwMauaiXkWZ1Zq7+HhvnNtpzwi26lZ9mn5ehzqdDS0fqH26psRys1WONLH
	K3TxLFhQPh+6KjddWOORUK5xHZl/aSsrcWaVI/w12y1/k0DdJlYkumLwGN2nKrNb9s48hsIXZVALp
	JjCE4Anwy+VM+Wz7m5zPL19ZIGaZNkkk6QIqnXHc0v3WYTJG+0h3jJVKVUaxhIj3fUYzRRrj6OEFC
	AZDCbl5DaHzG2vcqwXndPW5HFRIzIUJVRsBG2/5Zqph0vIijNLyYkv5dveYXw+rgEMBjLKzeZdpw/
	pZ7NTp4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6nI-000000016iY-1qhB;
	Mon, 03 Mar 2025 14:29:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6XB-000000012de-0I09
	for linux-nvme@lists.infradead.org;
	Mon, 03 Mar 2025 14:12:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C891568CFE; Mon,  3 Mar 2025 15:12:36 +0100 (CET)
Date: Mon, 3 Mar 2025 15:12:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	anuj1072538@gmail.com, nikh1092@linux.ibm.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev,
	M Nikhil <nikhilm@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] block: ensure correct integrity capability
 propagation in stacked devices
Message-ID: <20250303141236.GB16268@lst.de>
References: <20250226112035.2571-1-anuj20.g@samsung.com> <CGME20250226112857epcas5p1654e62b5fff4551926622f19269c6ff4@epcas5p1.samsung.com> <20250226112035.2571-2-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226112035.2571-2-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_061241_248124_9F24A058 
X-CRM114-Status: GOOD (  17.49  )
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

On Wed, Feb 26, 2025 at 04:50:34PM +0530, Anuj Gupta wrote:
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index c44dadc35e1e..8bd0d0f1479c 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -861,7 +861,8 @@ bool queue_limits_stack_integrity(struct queue_limits *t,
>  
>  	if (!ti->tuple_size) {
>  		/* inherit the settings from the first underlying device */
> -		if (!(ti->flags & BLK_INTEGRITY_STACKED)) {
> +		if (!(ti->flags & BLK_INTEGRITY_STACKED) &&
> +		    (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)) {
>  			ti->flags = BLK_INTEGRITY_DEVICE_CAPABLE |
>  				(bi->flags & BLK_INTEGRITY_REF_TAG);
>  			ti->csum_type = bi->csum_type;

As mentioned last round this still does the wrong thing if the first
device(s) is/are not PI-capable but the next one(s) is/are.  Please
look into the pseudocode I posted in reply to the previous iteration
on how to fix it.


