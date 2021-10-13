Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E26C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:17:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1655361053
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1655361053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AVoanO34fsorWRdBBvkWbAFOBs059CEk7j5ZtieT4MM=; b=20bHbmoz2OYhGh
	FyDgCnW2A117JkUI+Fc8zgvCQ54IV3NT9zKhgkmfsu+55qrnI8VIbMBWZXVw28oRd4XgLa9nVuuNp
	XNu7pipMjLMnKKbcKPKDChuevBmHBTreDsdngkazg7BmS4vmZzOfJJDjKZJXD24Wl8UvCvWOqmEbe
	MZQrBoArX73tGZP9ehM96qTixRQwe7WSvW9KblCw6jQvZ2lCR2k9d9ACs0hKSzSdHJGpxzMzCwxTv
	trxu6rG5DpQ0uVKQ7rmAxoS1VjAaXNg4vlr/PiFT+blBpG9qBVRIEmKc0HQJV0OTxAVG7L2TICeQi
	rRG9eUpnF44tLZ1rzksw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maaOB-00Fk0u-D6; Wed, 13 Oct 2021 09:17:31 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maXjt-00F98a-6n
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 06:27:46 +0000
Received: by mail-pl1-x633.google.com with SMTP id y1so1097572plk.10
 for <linux-nvme@lists.infradead.org>; Tue, 12 Oct 2021 23:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=C7+rA9/qIKI+jEKdGT8jq286cyAFBOUDDboMnfms+Z8=;
 b=AlEYQ5u0lf8LlpP+7qsCcuJhK1pgOk4qAHuS3VO4jhvcYvvdHIhevJhnSmtjCxYajF
 GvRWvFMVajscl3jlCv3bKH7RKiMCJHNfpDbORo8xCSB0MCLratUhvvPInP4hPM2sN7/u
 axF+0KLgxbxN6eO5bdOoxf3QMqBfSL0vk4cKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C7+rA9/qIKI+jEKdGT8jq286cyAFBOUDDboMnfms+Z8=;
 b=YRDcbJ7mpbU1E6tY9yScpNHsHOxXHIx5E/sE3tqc9MJOIyHwv7Ka3Ah1gfYnhXeHc5
 zepJKlXjshhxZNiDKDr/B1ffpAZnHbZ7+K/Mvzt7ckBoXjX8V69DUSdQQ32aHzp7EwMM
 gnjGcyuPFGaVXqHSj69yzFd2bI1ZaOclw10Ykhd9ue/d/T+5gwUkPJr6rH/FcBKIARXL
 j/sHrbSoTwyuV6R5U3L259m4kK3vYPH3FIbN2PdVftzNfNd/hQ13Flv9rCIcnqRgeJuo
 KcTRgFZM4ZmJTi/OFo7J4R9KLP7ZD5+MW/sx2J9kDKCZN2cNNPMjTtFGDkDbxHS8v33q
 OZqA==
X-Gm-Message-State: AOAM531IY81FNfGXVlxLGKTzvHNeQavOtot4EqCRbRpN9KzsyExvbCEv
 jH9ntkoB9JGnIoKxwqWLSK728Q==
X-Google-Smtp-Source: ABdhPJz8mp+/J7KQDpbHq7K2lAJxf17Ai5GLPqj67ERcH9Uej4DEhzNclBgAGGyGj3QY5e4RheoMRg==
X-Received: by 2002:a17:90b:88d:: with SMTP id
 bj13mr4255866pjb.211.1634106463887; 
 Tue, 12 Oct 2021 23:27:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id x15sm7730841pgo.48.2021.10.12.23.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 23:27:43 -0700 (PDT)
Date: Tue, 12 Oct 2021 23:27:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Theodore Ts'o <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 24/29] block: add a sb_bdev_nr_blocks helper
Message-ID: <202110122319.3029AE5AA@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-25-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-25-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_232745_285363_F7AED97C 
X-CRM114-Status: GOOD (  23.54  )
X-Mailman-Approved-At: Wed, 13 Oct 2021 01:15:58 -0700
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

On Wed, Oct 13, 2021 at 07:10:37AM +0200, Christoph Hellwig wrote:
> Add a helper to return the size of sb->s_bdev in sb->s_blocksize_bits
> based unites.  Note that SECTOR_SHIFT has to be open coded due to
> include dependency issues for now, but I have a plan to sort that out
> eventually.

Wouldn't that just need a quick lift into a new header file to be
included by genhd.h, blkev.h, and:

drivers/mtd/ssfdc.c:#define SECTOR_SHIFT                9
fs/hfsplus/hfsplus_raw.h:#define HFSPLUS_SECTOR_SHIFT         9

I think that's worth doing at some point in this series since genhd.h
already has existing open-coded "9"s. And, really, a *lot* of other
places too:

$ git grep -E '(<<|>>) 9' | grep -E '\b(block|blk|sector|bdev)\b' | wc -l
240

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/genhd.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 082a3e5fd8fa1..6eaef8fa78bcd 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -245,6 +245,12 @@ static inline sector_t get_capacity(struct gendisk *disk)
>  	return bdev_nr_sectors(disk->part0);
>  }
>  
> +static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
> +{
> +	return bdev_nr_sectors(sb->s_bdev) >>
> +		(sb->s_blocksize_bits - 9 /* SECTOR_SHIFT */);
> +}
> +
>  int bdev_disk_changed(struct gendisk *disk, bool invalidate);
>  void blk_drop_partitions(struct gendisk *disk);
>  
> -- 
> 2.30.2
> 

-- 
Kees Cook

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
