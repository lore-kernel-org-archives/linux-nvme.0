Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FF9C54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 19:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hlsj0CNm0FNhCgCvXMuT7qCEUtEyzcx7IgOufwzD5bo=; b=vMpl61M2r+VyDdnIDEEiOuI0ZI
	cAq+hLnnvabzkUD1c5JdVlcgaag1dIR3ikD8SRApdmYE2xmJ8nQvWTl8MEmrvAf6jP4YsVE4BajOp
	AGjspq9cPV/rLRKTP9IAVD7wwbSqw1dZmossb8UIwIvyLAGXtzdZ2Gs2iXceCl/G1ZKjDcgVAlt8S
	KkTjc/6dxz2NF96OjBl12/a/48VR9HxFHdkESpeREep1kGV/vKJnE8wysM9lf+R5acRhDMU7ND895
	bu413xOV+76fCj855lP4AHC+J9CgoCtetIwM+En70tS8Fbnvg04C25nNWx7PNVELZjLTVxHX6VfxD
	XHHzxutQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIBbJ-000000021ja-39yT;
	Thu, 22 May 2025 19:29:09 +0000
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIBUs-0000000214C-1Fw0
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 19:22:31 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b3J8N64Fzzlvq4c;
	Thu, 22 May 2025 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747941747; x=1750533748; bh=Hlsj0CNm0FNhCgCvXMuT7qCE
	UtEyzcx7IgOufwzD5bo=; b=I4KEani9lRtHMVQz8LZym4oJiZWsUYPwqCqDUkWx
	oLNdjofBjmy7L4vFMTAj5iDAZwOnhT1uPb+qYEIZbMGr3uQSKIz+kxbmuohMKSy8
	jtpIfg65ueHQt4dtND2c6C718ENRVh5kwOAJ/GIWFgaDKwGzD+kbaY4aUbDd13b4
	mhc4X3XSq/VGLoMHB/HnVNgNANjn6WFmlI4j5A5GNrp6isNpRqaUrF89WmYdG8Vt
	JB7XVVvnyLChSXwG+Cd3hu+4sUBXis+pi5tjz1sS8uBTK3p+SW5+vjGcm1xKY7jV
	JvgnaaimBk7C8NGnSc8Qjd3Lkr7hb/k3bKTri3i5jHxOLw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0odirWVGG6U8; Thu, 22 May 2025 19:22:27 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b3J8K1tWqzlvnMh;
	Thu, 22 May 2025 19:22:24 +0000 (UTC)
Message-ID: <468be217-40d5-4674-891e-d11cc96b1c2a@acm.org>
Date: Thu, 22 May 2025 12:22:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] block: new sector copy api
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250521223107.709131-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_122230_420691_A56221D9 
X-CRM114-Status: GOOD (  15.67  )
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

On 5/21/25 3:31 PM, Keith Busch wrote:
> +/**
> + * blkdev_copy - copy source sectors to a destination on the same block device
> + * @dst_sector:	start sector of the destination to copy to
> + * @src_sector:	start sector of the source to copy from
> + * @nr_sects:	number of sectors to copy
> + * @gfp:	allocation flags to use
> + */
> +int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
> +		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
> +{
> +	unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
> +	unsigned int len = (unsigned int)nr_sects << SECTOR_SHIFT;
> +	unsigned int size = min(len, nr_vecs * PAGE_SIZE);
> +	struct bio *bio;
> +	int ret = 0;
> +	void *buf;
> +
> +	if (nr_sects > UINT_MAX >> SECTOR_SHIFT)
> +		return -EINVAL;
> +
> +	buf = kvmalloc(size, gfp);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	nr_vecs = bio_add_max_vecs(buf, size);
> +	bio = bio_alloc(bdev, nr_vecs, 0, gfp);
> +
> +	if (is_vmalloc_addr(buf))
> +		bio_add_vmalloc(bio, buf, size);
> +	else
> +		bio_add_virt_nofail(bio, buf, size);
> +
> +	while (len) {
> +		size = min(len, size);
> +
> +		bio_reset(bio, bdev, REQ_OP_READ);
> +		bio->bi_iter.bi_sector = src_sector;
> +		bio->bi_iter.bi_size = size;
> +
> +		ret = submit_bio_wait(bio);
> +		if (ret)
> +			break;
> +
> +		bio_reset(bio, bdev, REQ_OP_WRITE);
> +		bio->bi_iter.bi_sector = dst_sector;
> +		bio->bi_iter.bi_size = size;
> +
> +		ret = submit_bio_wait(bio);
> +		if (ret)
> +			break;
> +
> +		src_sector += size >> SECTOR_SHIFT;
> +		dst_sector += size >> SECTOR_SHIFT;
> +		len -= size;
> +	}
> +
> +	bio_put(bio);
> +	kvfree(buf);
> +	return ret;
> +}

Is avoiding code duplication still a goal in the Linux kernel project?
If so, should the above code be consolidated with kcopyd into a single
implementation?

Thanks,

Bart.

