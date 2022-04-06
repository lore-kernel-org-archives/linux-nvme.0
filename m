Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B63C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6e5T+sIABv1llA3nY2078mDuWVILL0MDZSdgf8H3bng=; b=rvwL2tZ/+2VNJZXcQOvYpgYM2c
	02vKr3qwPtV3ezZWUMvlK1GulYiGMLbQuS0Rn/GTeQqENTS1i6SSLTx9P6rcoU04nDYoXBSEiOYsY
	WY6k9PjEC9QUsz/YelwsNKqo86zbz8AHoBHsPgU1To81YjP40cmVi3JHRASEuYF3w4hK4//gbLa/k
	HYYsJK4nhKAoF15hRS3ZA8cgVE5XVFFAyxK4CTVlmtbQ1x3szz6b3jI3ldPGy4H6mEaIybiwnAK2d
	z0mA4j43Z1oPxTZDmPmZhAr+drg/IeXoaXgSY8bf22ywImUryp0hj4p17EKt3xDY4I4+Qw2pAPzkj
	/VC5aPAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc1PO-004pcI-Mo; Wed, 06 Apr 2022 08:52:58 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc1PE-004pXk-I5
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 08:52:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1649235168; x=1680771168;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=LFM3dJ4XtmmQmpjm/ADKwYliPf/iPacGMSt9/3x5IFU=;
 b=icfaSut3QIuJEg96JMSZpj+RclERzi5NHjCBZtT8CMsm5oEgIbKn0QKC
 8+EoqJk/avHed9Ugyz79ksTwO6oEm/urxVtDiXtWO+We5eSyvtOQEhihU
 fZn0B8+C2sJzfjivBQ99XicT0mMPGEQt6S7TpG3zh8Mn49XRPTfrKI8Wx
 yFH1u95FtCPyCuP2h40Q//P76n5sq0V86qEuhC8A23JJlkM0CBnNQxMR9
 TQSexS1N+ibbP3okHY75Tr57HOGuf6dvo/fF0VPdJYrW+YdD9b+dQnaM6
 F9HRTR+VvcUHwVOSbP+1Eo4/nAS1bP/q19ZdmSxDdXPLtdKSvmRLI/++A A==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643644800"; d="scan'208";a="309182682"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 16:52:42 +0800
IronPort-SDR: nUAjbgT/ikdxwwzyRXv0cQccc3HpRPwkHdz2Pa3CHB5Pn3lfFG/QYOTyX8fIYKF3ijRMT79oMX
 qA6zDf58qpJswVg1HokBs9Bkg2sgshvYvRY9pjRMJwobquR8UDs5RDPhcF4msSc+of2WczhFGC
 zfkJI5bt0lHOL0eD8UCkumUCnEXgwxz5fDeQe8GJDlRbSAyUJU46fXHU3LeUKjNf9/mb+Rc00m
 zwlVUaQnNpLAf24ipIA2pq/rT/9dMMC6jL1/aSbmrEfIuf4cM+NNkEKdqWukvF9YXaPA80GbZx
 yYKV0GAsCHu6srDiz51f3+NA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Apr 2022 01:23:24 -0700
IronPort-SDR: 12AeGaNW09Mlxd4UHt9yUuMbtC/59QWF8I9VXVYpYPf1MBAGHO9if+ukgOfIeH2/MMGibJh9fp
 Y1jIzPcMMaFCfa3NMgY7hde24Ysiw1Xf1slcPlHyFNBDLCZh4hEA+af3H9UeNxRgKTec6VSCqp
 NxgHxsC/n4+cO4ipose76oByvHofXWNnPTgVx/QSXsk9elZx9C9G8iCsBYny/loaDq+tsm+QBN
 UIyJ1D+eQ+9e+fVftdopvpU9q/oEyo9ysKFolyOfuudJZnlf0FJuxQWGxVNf1uCwf8rQJSkrEM
 JRU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Apr 2022 01:52:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KYJDn5MX3z1Rwrw
 for <linux-nvme@lists.infradead.org>; Wed,  6 Apr 2022 01:52:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1649235160; x=1651827161; bh=LFM3dJ4XtmmQmpjm/ADKwYliPf/iPacGMSt
 9/3x5IFU=; b=FzUociJ5h7WAQTsg6/of1WcVO/OsM8WZr8TGwq4XsiCjPsWYnIG
 8/w+gKZQabfM5/6lPmJQreKk5Ou6wFCFKuKzU34LNEBfiEEQgQdKgaFRiQjCbS+v
 bXmYOK12GNp/Ja0XBlu9I1309M6iplipC0iSH4zUASq/4DY1Z1ntJWZZ2gnz7v04
 gr+tHwiyI12IKqfvshI8zep4+bgj/F03PH6lDam0sCy+54uxyIAUOpes7fa1mbqW
 oKbTS+GZl8C4hDtpg8QtlcOVicbeOAAs2w8xnnXnZGy/42U80yMH8z7K4uMfNY4W
 C4OWYxx5B6+JAZVIxV0TMfw3Lljnnr2SA9w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 42UCbIfV7gYb for <linux-nvme@lists.infradead.org>;
 Wed,  6 Apr 2022 01:52:40 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KYJDg4WyPz1Rvlx;
 Wed,  6 Apr 2022 01:52:35 -0700 (PDT)
Message-ID: <ea3d14cb-00ea-8d7b-4615-9347fdd7aa27@opensource.wdc.com>
Date: Wed, 6 Apr 2022 17:52:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 14/27] block: add a bdev_max_zone_append_sectors helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-15-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220406060516.409838-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_015248_619457_C55ADA03 
X-CRM114-Status: GOOD (  22.45  )
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

On 4/6/22 15:05, Christoph Hellwig wrote:
> Add a helper to check the max supported sectors for zone append based on
> the block_device instead of having to poke into the block layer internal
> request_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/zns.c | 3 +--
>   fs/zonefs/super.c         | 3 +--
>   include/linux/blkdev.h    | 6 ++++++
>   3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index e34718b095504..82b61acf7a72b 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -34,8 +34,7 @@ static int validate_conv_zones_cb(struct blk_zone *z,
>   
>   bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>   {
> -	struct request_queue *q = ns->bdev->bd_disk->queue;
> -	u8 zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
> +	u8 zasl = nvmet_zasl(bdev_max_zone_append_sectors(ns->bdev));
>   	struct gendisk *bd_disk = ns->bdev->bd_disk;
>   	int ret;
>   
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 3614c7834007d..7a63807b736c4 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -678,13 +678,12 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
>   	struct inode *inode = file_inode(iocb->ki_filp);
>   	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>   	struct block_device *bdev = inode->i_sb->s_bdev;
> -	unsigned int max;
> +	unsigned int max = bdev_max_zone_append_sectors(bdev);
>   	struct bio *bio;
>   	ssize_t size;
>   	int nr_pages;
>   	ssize_t ret;
>   
> -	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
>   	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
>   	iov_iter_truncate(from, max);
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index a433798c3343e..f8c50b77543eb 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1188,6 +1188,12 @@ static inline unsigned int queue_max_zone_append_sectors(const struct request_qu
>   	return min(l->max_zone_append_sectors, l->max_sectors);
>   }
>   
> +static inline unsigned int
> +bdev_max_zone_append_sectors(struct block_device *bdev)
> +{
> +	return queue_max_zone_append_sectors(bdev_get_queue(bdev));
> +}
> +
>   static inline unsigned queue_logical_block_size(const struct request_queue *q)
>   {
>   	int retval = 512;

Looks good.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

