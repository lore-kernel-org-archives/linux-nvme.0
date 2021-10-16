Return-Path: <SRS0=EQPQ=PE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC618C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 17:21:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D9F61073
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 17:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68D9F61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yeYbTALLt+81wu8WFfyKx0a33Kod/SnDLZRAl1Frm5U=; b=NUZPy7Z8ujyOM/KWCec6fDI4He
	FtBqqknkfD4y0NPhUoh5Jcwe9s2TcxQFAyeNNzDDC+gMkXwGYIL9Q8UhlZ1JJcUr5FUXgUGUYeetk
	qrvF+7dJIwOx8CAwjxEKcyTjr5WD0K8Uu3sYTtXvHhYkw8KVrY5xnjHin6av5yVjwgu+wHHpOyyoh
	Fo1jj16lnmEYwZUQGzNy07d/CTFuQi6gvxL05wKj/wB+NifiDiXG6LbDA68akWOjQg2u9Hoc/y2Nv
	e2cjlhw8l4Xp1XsJAV2AdForJ3JmPBh97QB6v/f7FSHc41b+oebjJZNqP3U2sZVlQhiVJfo9Bt+JK
	5yCGxtPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbnN7-00B1vk-Eb; Sat, 16 Oct 2021 17:21:25 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbeIf-00A4rN-Ry
 for linux-nvme@lists.infradead.org; Sat, 16 Oct 2021 07:40:15 +0000
Received: by mail-lf1-x129.google.com with SMTP id j21so52250516lfe.0
 for <linux-nvme@lists.infradead.org>; Sat, 16 Oct 2021 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yeYbTALLt+81wu8WFfyKx0a33Kod/SnDLZRAl1Frm5U=;
 b=cVnZ6+l+2XB64KtPGPsew2EuurYnsOpcBevvm/IVGVDWp/Lr378D4lUZAb7Ldqn1aU
 Nechfd+nevnKJt8FFrjsUkhQRsZN4OdAe+y/4UgENJDxkcBm3bvvsqVp0+i7kz/ncskC
 VTNCGAMRL2zXauGox8hUYH0e6cLX9YNzHMmZx68OgeqDdd/IPTSNwVgM/hhe43XfbD/A
 Rsr2ngeAq8MwLS8wYqIQpA7q0jGrbmoIHsnPPXNshCS3yofpN7y1D6hLbuTi/3aHu8Hg
 WHPyyYAgwzwuGQtuqb861mn1fmCGJ4Gxolg4kHeKn8eV14e/nwAYLFHNCnrx2jzkQiPm
 sdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yeYbTALLt+81wu8WFfyKx0a33Kod/SnDLZRAl1Frm5U=;
 b=WieW8lfs97t04aCQ0TODiY8csc90gkIQmpTxbnUPja7gbqF03lQ/oCuNvf1VJgEryx
 d5v/mnm2pzqS9xYH6I/mZoG6gnIWgVKQAYfvzFd6iYKu18JiHzcKfhemwmQE4yxZ2Aq3
 Tl1Qtp5G+qI1e/amlS5A0zYC+VjUxqKI5xTSXPAds5sXTKR+ct5G55x7VXstSvAuMuED
 RmGWImOHjzPm/GEDSNZsNUiWyokNfNgZpSsDFFb8mDZYRjfEqn+5xVFtN70p2Yjha4zM
 s4dskhWTIp325ufSZ4dSc/0LQ2nbiwRW0CnlvlsMNVZHL4KEWsmx1v1t75veq1qzRQUL
 DuRQ==
X-Gm-Message-State: AOAM5305972WIeD3o+mFB6jEzyOSxrqd5klJrXGo4JwA+gCc7Bi5iOaK
 laDKNwdz2oQnthbtYigGjZw=
X-Google-Smtp-Source: ABdhPJz42JllLibAuMU4PSsWo9d4pmXBI6FidoZzBNe3/Oe9MjVOfwHK8qKnrFH4pZzBziLDXJNmxQ==
X-Received: by 2002:a05:6512:3190:: with SMTP id
 i16mr9019031lfe.224.1634370011048; 
 Sat, 16 Oct 2021 00:40:11 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
 by smtp.gmail.com with ESMTPSA id a19sm827633ljb.3.2021.10.16.00.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Oct 2021 00:40:10 -0700 (PDT)
Date: Sat, 16 Oct 2021 10:40:08 +0300
From: Kari Argillander <kari.argillander@gmail.com>
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
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 20/30] ntfs3: use bdev_nr_bytes instead of open coding it
Message-ID: <20211016074008.o6wl7uy3vsrz4v3b@kari-VirtualBox>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-21-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-21-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211016_004013_932281_34E8A113 
X-CRM114-Status: GOOD (  19.48  )
X-Mailman-Approved-At: Sat, 16 Oct 2021 10:21:23 -0700
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

On Fri, Oct 15, 2021 at 03:26:33PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ntfs3/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 55bbc9200a10e..7ed2cb5e8b1d9 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -918,7 +918,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
>  	int err;
>  	struct ntfs_sb_info *sbi;
>  	struct block_device *bdev = sb->s_bdev;
> -	struct inode *bd_inode = bdev->bd_inode;

Linus merged latest ntfs3 stuff and this temp variable is not anymore in
upstream. So this patch will conflict. Just so that you know.

>  	struct request_queue *rq = bdev_get_queue(bdev);
>  	struct inode *inode = NULL;
>  	struct ntfs_inode *ni;
> @@ -967,7 +966,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	/* Parse boot. */
>  	err = ntfs_init_from_boot(sb, rq ? queue_logical_block_size(rq) : 512,
> -				  bd_inode->i_size);
> +				  bdev_nr_bytes(bdev));
>  	if (err)
>  		goto out;
>  
> -- 
> 2.30.2
> 
> 

