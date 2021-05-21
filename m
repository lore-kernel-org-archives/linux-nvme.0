Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A27C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:45:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E656109F
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E656109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hsxNCYPvqyNzkwxCODJR3B1UIIXXzrlaaBVgPVh9CsY=; b=GwLhL9CY/72xOa
	cKssp6xEbtj6eh2jVk89tglYxtAQGsHWIDoDAgXi+yKzQhscUbaSY+IVy2p/ZmSfsP6iczgp5txoy
	LV3YfxYTaZqzRHPgT1BTSWMWdJeeY7Zm47psTgecIBit/47m6v/0ftRBVev/EPIO+s3lwe1XYR1NQ
	0RBzpmOvse1wpVNGLg1itQ+4Nb1pyPURB6epcusvTxmDegR1GF85SueAfvHH9OwV53ALBMdMQkacv
	ETwOBiw30uEPIuBANSJIttuESKz+DZOMGVTdrQgaASbHEyNxAAnKiDOY/leFKPpix9D1QtjVPHfAp
	bvdzmek8zbXhpoAKGb6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGVg-001jEF-Ek; Mon, 24 May 2021 19:45:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk8lZ-000RnV-VZ
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 17:16:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/6CTfoP+3YhIDA2Sa2Vg3MwIl/4IQc5OvLMHtpk2uwk=; b=z6r1sqT8rwLEzzenuMsHBkDjKp
 Sto1uHT2bGbNoUkGbI9JibG/CfNbxUaIkkbMRNJYM8/vhvNERanZimxoiGp9XpxvtV4IqfunlTKo5
 qLjrZBxE20meRFoIbDI2MjjjPIDHM10nLDEVAE/7Yh4tWZ39fWJBL9TuxvFbtlLmBzFD40iNVlgDd
 j+XdXwQR/c+e6fsVHHjSKakYF0bZbFs1yqLaXlMwCBgmJEnQXwRUNwLCGsjc8P+tAN2P6YppcL1X2
 WuKsrzfPIdUkbhbn1mEiIBLNNhZluqlpyoMjctToO3tRCq55l6jItFd03XGiRVBQ7CBLj55mMh4dO
 jqlMAPdw==;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk8lW-00HItC-WE
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 17:16:52 +0000
Received: by mail-pl1-f171.google.com with SMTP id s20so11318315plr.13
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 10:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/6CTfoP+3YhIDA2Sa2Vg3MwIl/4IQc5OvLMHtpk2uwk=;
 b=TXCKCfk7ww+feOGgwxRlUhHQEEuBK4A5yzF+JdYZt+EBsKE+TeUnsOcXFQJYE7kT3e
 NW0IA0MNUHSatMKoTSbTYLsCbPsRUh/r4ZWhihlvTYYthWoIM2uPAHNrv+huHQ0i/vK6
 fHq8ien7Av0CBVIhHdt024eahV7q4UaAKE7UvV5UuRS2lB0WcnmZDtYLYWo/iXNzFX+u
 iWI7oAhMmKy5kdEwFg3AbAoREm4k/nlIREW6uQn94HXha1rRmNm1FOUYjB8rhGTWdkIT
 9U/Ei904yEt6GJs0ZSIx1/NvHu+pPmBtNIuGgFW8t3hmUqXCoeoE1uO+W6mkuSCuiQd/
 mUWQ==
X-Gm-Message-State: AOAM530NQUWT80zujaEaQYdTNB7LlJxCaYMvfHKihbZCeGMjiZMrOSsg
 PC9W/gEDyM3AsvPUNawu08I=
X-Google-Smtp-Source: ABdhPJxtynqdEQ1F/D+2PqiHL9NmQC5jqLXgWhG+E7yzr8uLp59ObRLAPQ67LxwzZAhslkMqhOa4cA==
X-Received: by 2002:a17:90a:590d:: with SMTP id
 k13mr12082927pji.68.1621617409049; 
 Fri, 21 May 2021 10:16:49 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id q24sm4964064pgb.19.2021.05.21.10.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 10:16:47 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 6461E423A3; Fri, 21 May 2021 17:16:46 +0000 (UTC)
Date: Fri, 21 May 2021 17:16:46 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Jim Paris <jim@jtan.com>, Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-xtensa@linux-xtensa.org, linux-m68k@vger.kernel.org,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-bcache@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@tron.linbit.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [dm-devel] [PATCH 01/26] block: refactor device number setup in
 __device_add_disk
Message-ID: <20210521171646.GA25017@42.do-not-panic.com>
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521055116.1053587-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_101651_056321_D86EC750 
X-CRM114-Status: GOOD (  20.05  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 21, 2021 at 07:50:51AM +0200, Christoph Hellwig wrote:
> diff --git a/block/genhd.c b/block/genhd.c
> index 39ca97b0edc6..2c00bc3261d9 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -335,52 +335,22 @@ static int blk_mangle_minor(int minor)

<-- snip -->

> -int blk_alloc_devt(struct block_device *bdev, dev_t *devt)
> +int blk_alloc_ext_minor(void)
>  {
> -	struct gendisk *disk = bdev->bd_disk;
>  	int idx;
>  
> -	/* in consecutive minor range? */
> -	if (bdev->bd_partno < disk->minors) {
> -		*devt = MKDEV(disk->major, disk->first_minor + bdev->bd_partno);
> -		return 0;
> -	}
> -

It is not obviously clear to me, why this was part of add_disk()
path, and ...

> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index dc60ecf46fe6..504297bdc8bf 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -379,9 +380,15 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>  	pdev->type = &part_type;
>  	pdev->parent = ddev;
>  
> -	err = blk_alloc_devt(bdev, &devt);
> -	if (err)
> -		goto out_put;
> +	/* in consecutive minor range? */
> +	if (bdev->bd_partno < disk->minors) {
> +		devt = MKDEV(disk->major, disk->first_minor + bdev->bd_partno);
> +	} else {
> +		err = blk_alloc_ext_minor();
> +		if (err < 0)
> +			goto out_put;
> +		devt = MKDEV(BLOCK_EXT_MAJOR, err);
> +	}
>  	pdev->devt = devt;
>  
>  	/* delay uevent until 'holders' subdir is created */

... and why we only add this here now.

Other than that, this looks like a super nice cleanup!

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
