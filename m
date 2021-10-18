Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1A3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 17:57:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F5260F0F
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 17:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9F5260F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YH4oGe9dRfdZQ1d4CvnTMZ1r7HRf2QBAQWpHy9E3Wng=; b=E3CPekb+zuP3TjfCiU3G8h/DXv
	N/Nx/YIIcLR/kwMfjapTrrbdeJOU3JQPlFCIF+0A5Qo3tgp3wm5TRtX5UV3iLlI9B9YjQDm4V2TbW
	r4tq73pj00jjZiCXTEtTMqD5bSw4/E6hCfZPZnVsYpEOiK8BCzFMYQTvBIabMtsE7eOA9FC3Wmata
	cf6Vpc0mdLSPJk8NVGWovQx/NNWfm/9jOPZV+A0h9uCLN7xcE0MKrxu283NiRKpcnDBzcMXiJTwQP
	Ot5m8u8AOOm29vhTqBqUZ1gjSbpw7BtIrzuZo84i8475PwN1fzEf4VYiYx27cKuxNSgTDzzwNbnm2
	EQeBkWwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcWt1-00GjDV-Kh; Mon, 18 Oct 2021 17:57:23 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcWox-00GiIY-Ou
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 17:53:13 +0000
Received: by mail-io1-xd31.google.com with SMTP id e144so17310193iof.3
 for <linux-nvme@lists.infradead.org>; Mon, 18 Oct 2021 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YH4oGe9dRfdZQ1d4CvnTMZ1r7HRf2QBAQWpHy9E3Wng=;
 b=UdB/aADcuFPlPcZ5zloyGSC8r8sjGP46bdFZgOczbw//2VtX+qD5PI/hTVyCm/RwVy
 FXAjDscH1TQ3fsg0fSzaSQe7AynSLix9FEl76DQK4y8MTjp/aJVzkmTFFG7c2xS8iXPi
 s+lRVm4eViQimOGv1xw+YUEHZjc66LhnruY2OKJU4kNG1W3nUI3yYhopF97varulsEhH
 lrAHcDhmWx+Ldz3ca7hK3R16UzzOUjcC//cwEEUu4EBzTbKGlwl++3WbIOKHwppSidbZ
 J2GwRHTpqmvpQIvUpXH1LIhuUZWDULALzfc74tUrBZWM1yZdKVE8ClvuVU+5LBey+DKb
 N3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YH4oGe9dRfdZQ1d4CvnTMZ1r7HRf2QBAQWpHy9E3Wng=;
 b=Y+azxcLUOf7loKt5gI9qWaoTN8WMsMrL/Sungy7JyTI5DlTE66M9nVw7YvLBnD+pfj
 Fg2dvP6+unYoJvNgdREaw7ZimplXKQHoz8JjcxFrb4+Y36LMy7m9psXY5t8mKEm9LPND
 Pbm7Ic+16nHqeC19z0tB0R63OrcJWkVNjF81azO+IDLHWXS/jAJRMwhSVvrByFQnCk6R
 XnwvWMLAl7vR6YHW4hEp21yyBFv42q/zNU6m9Sq/bqCGdQPg/NAdEhc3TQwE46+uxc5R
 et/+8Fm8YtIw3o27JZdanQFwDgE7v5JwOHzXrE+tIQGAH18BVmztl9a8HMZfgnvh+GbU
 Q3Yg==
X-Gm-Message-State: AOAM532OpsXLzhFbPFp6EvUzO0309dDtdFhrLlw0FTEfsJpzm9TaAe73
 A0zIZn+mcyehiMDdE52qorcPMg==
X-Google-Smtp-Source: ABdhPJzaVpRAohIh75kPuEB6cvjZHptUXsyrO2OyQP99Xt2V/uaZI2XjjHTplRgkBKRlsFA7V0q64g==
X-Received: by 2002:a6b:8dd6:: with SMTP id
 p205mr14846469iod.192.1634579590519; 
 Mon, 18 Oct 2021 10:53:10 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id m15sm3303730ilh.73.2021.10.18.10.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Oct 2021 10:53:10 -0700 (PDT)
Subject: Re: don't use ->bd_inode to access the block device size v3
To: Christoph Hellwig <hch@lst.de>
Cc: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Theodore Ts'o <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>, Phillip Lougher
 <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
References: <20211018101130.1838532-1-hch@lst.de>
 <4a8c3a39-9cd3-5b2f-6d0f-a16e689755e6@kernel.dk>
 <20211018171843.GA3338@lst.de>
 <2f5dcf79-8419-45ff-c27c-68d43242ccfe@kernel.dk>
 <20211018174901.GA3990@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e0784f3e-46c8-c90c-870b-60cc2ed7a2da@kernel.dk>
Date: Mon, 18 Oct 2021 11:53:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211018174901.GA3990@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_105311_844597_C202FD92 
X-CRM114-Status: GOOD (  17.63  )
X-Mailman-Approved-At: Mon, 18 Oct 2021 10:57:13 -0700
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

On 10/18/21 11:49 AM, Christoph Hellwig wrote:
> On Mon, Oct 18, 2021 at 11:40:51AM -0600, Jens Axboe wrote:
>>  static inline loff_t bdev_nr_bytes(struct block_device *bdev)
>>  {
>> -	return i_size_read(bdev->bd_inode);
>> +	return bdev->bd_nr_sectors;
> 
> This hunk needs to go into bdev_nr_sectors, and the bdev_nr_bytes
> probably wants to call bdev_nr_sectors and do the shifting.

Makes sense.

commit dd018a580d0037f65d7dd801cbf3e053f36283de
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Oct 18 11:39:45 2021 -0600

    block: cache inode size in bdev
    
    Reading the inode size brings in a new cacheline for IO submit, and
    it's in the hot path being checked for every single IO. When doing
    millions of IOs per core per second, this is noticeable overhead.
    
    Cache the nr_sectors in the bdev itself.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/genhd.c b/block/genhd.c
index 759bc06810f8..53495e3391e3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -58,6 +58,7 @@ void set_capacity(struct gendisk *disk, sector_t sectors)
 
 	spin_lock(&bdev->bd_size_lock);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
+	bdev->bd_nr_sectors = sectors;
 	spin_unlock(&bdev->bd_size_lock);
 }
 EXPORT_SYMBOL(set_capacity);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 9dbddc355b40..66ef9bc6d6a1 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -91,6 +91,7 @@ static void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
 	spin_lock(&bdev->bd_size_lock);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
+	bdev->bd_nr_sectors = sectors;
 	spin_unlock(&bdev->bd_size_lock);
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 472e55e0e94f..fe065c394fff 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -39,6 +39,7 @@ struct bio_crypt_ctx;
 
 struct block_device {
 	sector_t		bd_start_sect;
+	sector_t		bd_nr_sectors;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
 	bool			bd_read_only;	/* read-only policy */
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 7b0326661a1e..a967b3fb3c71 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -236,14 +236,14 @@ static inline sector_t get_start_sect(struct block_device *bdev)
 	return bdev->bd_start_sect;
 }
 
-static inline loff_t bdev_nr_bytes(struct block_device *bdev)
+static inline sector_t bdev_nr_sectors(struct block_device *bdev)
 {
-	return i_size_read(bdev->bd_inode);
+	return bdev->bd_nr_sectors;
 }
 
-static inline sector_t bdev_nr_sectors(struct block_device *bdev)
+static inline loff_t bdev_nr_bytes(struct block_device *bdev)
 {
-	return bdev_nr_bytes(bdev) >> SECTOR_SHIFT;
+	return bdev_nr_setors(bdev) << SECTOR_SHIFT;
 }
 
 static inline sector_t get_capacity(struct gendisk *disk)

-- 
Jens Axboe


