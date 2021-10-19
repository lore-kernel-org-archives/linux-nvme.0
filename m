Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7EBC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 05:01:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD726128B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 05:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CD726128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZB3VynRj4BSJ+DoffwFLiPJvzPYXkayF1wJVNoXqZo=; b=Tc5R/CyIplfWlE2dM5hCZXBZLG
	PwK234u3CRKFjFRUppYeQQrqe9+NmGNJRjxKjs3to8a6tKBDPCQfJYSE0DNYEAbrN2b85lSxVvIa1
	SOJldMwMiF9PnB0JKINhXECVHVnn2PYKh67H/WKL/7MNvjwgpHwLwwY2khe8/5MI06ZiJdYZm0VX1
	0g2LbZcG73l3etowRekKmB+clpL+Or6tuTC0as2xg/TYhRKP4u+zDqxcXsYU7DLaRjvd9SKH704bM
	UJv5fwFtZdkg7Im1+uiSk73Spk7wH4za9vGCDuYqHV5l8v2kB8Q1ETG/aIp8hIcxtjQ/0HKOr7KiG
	pPMNLfQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mchFL-0008yg-Fq; Tue, 19 Oct 2021 05:01:07 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcdYG-00HVc3-Lz
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 01:04:25 +0000
Received: by mail-lf1-x135.google.com with SMTP id z11so3659169lfj.4
 for <linux-nvme@lists.infradead.org>; Mon, 18 Oct 2021 18:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=HZB3VynRj4BSJ+DoffwFLiPJvzPYXkayF1wJVNoXqZo=;
 b=qa7Rg2/+uz+UIDCny84Tw5bep3SlaUI84n/FAaUaxIzAubmeoa1ydJFT64PdI4Dc2i
 AgPnjhE+kBzSH4MdsJeGrFG4f0xqH2HBhd6pbyQr8O8l98NNiVXw+7LLIlFbcV+xxCqf
 RA02zj7IDRlPmKt2XOaxe9T0CtUPo6hRSub6+1M9syuYXVu4HWpZ0mdRM4b+vfFK8OI9
 lTRtKN80UFv+SDfLWbeeA+TcDubhn33n9WeCF3bZ9pFOuoi5rOJVIPb1Sykzu+pmiRnV
 qHPYjU4GPUjtfi/yhGpy4ABO9h9df+GLOdeLNWFNTfyVWJ/R/s+xiv91lAtBOCzSytMJ
 pKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HZB3VynRj4BSJ+DoffwFLiPJvzPYXkayF1wJVNoXqZo=;
 b=HEeRWrs7+jaxO/1gt3YLvMX9OndvrUIpTR9hm/DRQs3upcEXUlum9CKg+zL2mPWO9q
 nIZa0LzWnv9quetB1wy0mGrsBGytRqnwZLTjwyZhh5T4l7BePWQMSVg0lmByizON0Dob
 5pDtVTdkA22zz0TghldmaQSiIFBu9+SGNAJr4UdGJsCFRCg7hSMy8sbUdxzNnqeq85oU
 BFeTXIQKYUukbjv3LQBwknevK1QBGfkd7RtaXFV+bqS2/Rjaj849/nLwfr1+izPybKQe
 Lb63eWbOtTwDu9MkL7HMFRAL+q33V/RxKR40ukMobSQj+GGlmyPHgi2J96frjnRWQxt3
 iQ+A==
X-Gm-Message-State: AOAM530+0wM4ECE3VCQtZCblW4YyRZAD6xOaobWJRht/j6dBFnUs8pdd
 qzsCVEhjoqS4JIgNw2Emeyo=
X-Google-Smtp-Source: ABdhPJzDOI1VPK7ec+9Wvn2TGhELLqlWyRvZ5Uhqz00hPtHEbJZTBFS39lW+J2SjR0uuodKRx0F6pg==
X-Received: by 2002:a05:6512:1284:: with SMTP id
 u4mr3097377lfs.614.1634605459500; 
 Mon, 18 Oct 2021 18:04:19 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
 by smtp.gmail.com with ESMTPSA id f10sm1533239lfs.56.2021.10.18.18.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 18:04:18 -0700 (PDT)
Date: Tue, 19 Oct 2021 04:04:16 +0300
From: Kari Argillander <kari.argillander@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Theodore Ts'o <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 reiserfs-devel@vger.kernel.org
Subject: Re: don't use ->bd_inode to access the block device size v3
Message-ID: <20211019010416.vgecxu6wnvwi7fii@kari-VirtualBox>
References: <20211018101130.1838532-1-hch@lst.de>
 <4a8c3a39-9cd3-5b2f-6d0f-a16e689755e6@kernel.dk>
 <20211018171843.GA3338@lst.de>
 <2f5dcf79-8419-45ff-c27c-68d43242ccfe@kernel.dk>
 <20211018174901.GA3990@lst.de>
 <e0784f3e-46c8-c90c-870b-60cc2ed7a2da@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0784f3e-46c8-c90c-870b-60cc2ed7a2da@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_180424_784700_FD927769 
X-CRM114-Status: GOOD (  12.81  )
X-Mailman-Approved-At: Mon, 18 Oct 2021 22:01:06 -0700
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

On Mon, Oct 18, 2021 at 11:53:08AM -0600, Jens Axboe wrote:

snip..

> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 7b0326661a1e..a967b3fb3c71 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -236,14 +236,14 @@ static inline sector_t get_start_sect(struct block_device *bdev)
>  	return bdev->bd_start_sect;
>  }
>  
> -static inline loff_t bdev_nr_bytes(struct block_device *bdev)
> +static inline sector_t bdev_nr_sectors(struct block_device *bdev)
>  {
> -	return i_size_read(bdev->bd_inode);
> +	return bdev->bd_nr_sectors;
>  }
>  
> -static inline sector_t bdev_nr_sectors(struct block_device *bdev)
> +static inline loff_t bdev_nr_bytes(struct block_device *bdev)
>  {
> -	return bdev_nr_bytes(bdev) >> SECTOR_SHIFT;
> +	return bdev_nr_setors(bdev) << SECTOR_SHIFT;

setors -> sectors

>  }
>  
>  static inline sector_t get_capacity(struct gendisk *disk)
> 
> -- 
> Jens Axboe
> 

