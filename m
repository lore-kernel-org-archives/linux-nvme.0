Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA6C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 13:35:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9013D610E8
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 13:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9013D610E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MqKbMNsexnrRDFmAM9MEgj9aLCPgfmJ5YOCtdYZBhjw=; b=EzradNjD7dCA0g
	31CwR9v+GELxATGYuR+/UJpGJ7xpEWDpbEdd7aVeyR9oT35QVRvU/5cFSiQgbtIWbqm/TezZJpE/F
	4SM+/ys9/BqAhuKAjl9mqVXnHhWHW5PA8hVTahT6hcTYHXvYY0oAGAB+sBbrqTe+mh6dZ+yh6pZng
	Jct42QtE7ucl6zkAvH4vYgVI9sOzadOi2mEA8SVQOJNXuecb7VaS70gb7IZ71A1zZIQa7x0LcyYSh
	/AHocq6Fbg7XCKYHDdRnHUpRDgt8StaJAvGm49ckpO5OUTiYfFXO22prKAH2M2rxGmsUfRXN/K42w
	FI60riMPyQMx2NL/8gFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maePt-00Gvy6-AO; Wed, 13 Oct 2021 13:35:33 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mabjd-00G4Xm-1m; Wed, 13 Oct 2021 10:43:46 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9F96E2233F;
 Wed, 13 Oct 2021 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634121823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91hISCii4Or1ILPgadTSW2G7i/WxLx55yWUH14ngMGo=;
 b=urePYUhd5OF9+eOS15sOdNKf/9CEfoiJF0sOJ+CUtOdrV78ouAHrD22Jwd1x7RDJ1X7NXU
 38K6W/8xGxP7iJLbOT3v2KEmBRctpIhbWooGrkxGTpdozRprjw2uPy1C7rv4VVv0/JqU+P
 /z6fu4NATPhJE4NTFVWUnjzU7Jcj6qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634121823;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91hISCii4Or1ILPgadTSW2G7i/WxLx55yWUH14ngMGo=;
 b=iV9JFoqqPxqNVUQiZzwRblLXbUXiC4lcfVm33k6YuJt29JfUmlOuSAxx4ULbDL3QwDFt/o
 bWYhIgn68fkyB0Bw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
 by relay2.suse.de (Postfix) with ESMTP id 7DF06A3B81;
 Wed, 13 Oct 2021 10:43:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 27DE61E11B6; Wed, 13 Oct 2021 12:43:43 +0200 (CEST)
Date: Wed, 13 Oct 2021 12:43:43 +0200
From: Jan Kara <jack@suse.cz>
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
 Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH 21/29] reiserfs: use bdev_nr_sectors instead of open
 coding it
Message-ID: <20211013104343.GF19200@quack2.suse.cz>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-22-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-22-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_034345_289277_14334405 
X-CRM114-Status: GOOD (  19.48  )
X-Mailman-Approved-At: Wed, 13 Oct 2021 06:24:27 -0700
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

On Wed 13-10-21 07:10:34, Christoph Hellwig wrote:
> Use the proper helper to read the block device size and remove two
> cargo culted checks that can't be false.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index 58481f8d63d5b..6c9681e2809f0 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -1986,8 +1986,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
>  	 * smaller than the filesystem. If the check fails then abort and
>  	 * scream, because bad stuff will happen otherwise.
>  	 */
> -	if (s->s_bdev && s->s_bdev->bd_inode
> -	    && i_size_read(s->s_bdev->bd_inode) <
> +	if ((bdev_nr_sectors(s->s_bdev) << SECTOR_SHIFT) <
>  	    sb_block_count(rs) * sb_blocksize(rs)) {
>  		SWARN(silent, s, "", "Filesystem cannot be "
>  		      "mounted because it is bigger than the device");
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
