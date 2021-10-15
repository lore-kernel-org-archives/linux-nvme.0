Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7235DC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 17:01:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CCE611C1
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 17:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 36CCE611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dBqAYLNOJEEerwqZkr8h1WW5rIZpnbVROvIlOTScyoI=; b=FFUgIAsonSzgOxea1KLCZiLk1n
	eTsG7OQyj7oW+Gv8d9yJeeiVBG+/XoTb/JyNOU1+zHjbINlJJpMirlvyChgmsi7X5bggCHb3BVVyW
	TQaapXNrDBVb9CFQOAFR9yPCNess4twinUy2NHYLLmdb9aG57A9qwpLl82PqKwOG6T4gm8+AEb2lh
	x3ILiJSUr+SvrJ6C5S3JZByDW5Q4Gfv4LzSf2sEM59pvmSmLn2H0Y4duJc8xrnrzGV2YsLdpCyaHY
	0ydITQ83peekLa7IYlrGUW5m59srT2WtnQN58+0VPmYtFinOmYSOSR90dgrQ1rKnrUSZrTPXKrXgz
	9pSKYsNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbQaJ-008D1o-FV; Fri, 15 Oct 2021 17:01:31 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbQV3-008BAZ-2B
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 16:56:06 +0000
Received: by mail-pf1-x42c.google.com with SMTP id q19so8870978pfl.4
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dBqAYLNOJEEerwqZkr8h1WW5rIZpnbVROvIlOTScyoI=;
 b=a7qtweAUbS8K+NvWs4UCJMddQ3rECf/7QZ6zgMst5BcQ7TbdTIW8B/A36zncKdA0GG
 8KMhkxj+OzPkhorCWgeiV72Q4Wcq28WkBpsAyjDJDIhvh57vqCJGOPQwvw9YxRM4d1BS
 rdcHafc3+6KUZpEfQohGLoX5kTVxG/qsPhu90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dBqAYLNOJEEerwqZkr8h1WW5rIZpnbVROvIlOTScyoI=;
 b=e55Nx3WJtc37G3JeIKMTRJpw1e0QsAywfOhp6lV9OOwhnVN7snkipVL/bKTibaPpyx
 t31+nRo//QRmI0mGtkUDFTwA3zpJEzoHtsQytEt5mrShKVqnUM/5sWBJBPcsbDHoz5t5
 HUtroIOFk7NWkEOHSrveIC/bfbMYXuAjs9+6MQn9BjMzTETZWJGN6uFIbWSRPRjhyTY9
 7GwiNDPEu86Wint6+sVcXj5/PO/qx2ZxN1tH0cbI2oWesSXH+QiqgyAG1tsLQRapyHqV
 d9OxmTzj5UGNXDoqSyDueoswjODaexFlQ+O5oXSlUCVOKP8MGgSRF0yg6TS3RRUMNHFD
 lXpA==
X-Gm-Message-State: AOAM532zpOtRfSf+7YeyHsoo5Jc0SgNhjFStILnTJzQSA3xVxCzEB+fz
 Hf8KZfudgzRB3sj9R2+SLjnU4w==
X-Google-Smtp-Source: ABdhPJwArKSP1GbQ25tbhNDvzZCNcxogaP2mPI5IH6CBqZA2sACP5s1J2IGQKikEyZ/PadmXHII8iA==
X-Received: by 2002:a63:1266:: with SMTP id 38mr9960371pgs.219.1634316964288; 
 Fri, 15 Oct 2021 09:56:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id m12sm5254518pjv.29.2021.10.15.09.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 09:56:04 -0700 (PDT)
Date: Fri, 15 Oct 2021 09:56:03 -0700
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
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 21/30] pstore/blk: use bdev_nr_bytes instead of open
 coding it
Message-ID: <202110150955.495735B@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-22-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_095605_135741_7B2C68C2 
X-CRM114-Status: GOOD (  11.84  )
X-Mailman-Approved-At: Fri, 15 Oct 2021 10:01:29 -0700
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

On Fri, Oct 15, 2021 at 03:26:34PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the bdev_by_bytes() helper; this is more readable now. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

