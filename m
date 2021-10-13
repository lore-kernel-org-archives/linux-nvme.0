Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B27BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:08:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECDA60462
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2ECDA60462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IjAKtqGDDa3uhliDar91jFObpb2m+JyeilGzBU+fizM=; b=yj8+jikWHzVnis
	eAFirTB+t3TKCw/esVfL3a4u9FkYWNqj8JQ86cWVOpNzTtIIqnzRorl886h78sEZ3mdPny4WI5F1i
	rA/jDmCYiqD/DRPf2vavSUZNxi9g0OwR8PcbQNuKy/ZfIboshOck67e8Wc9SvUv6yKsm6lWhyirfq
	4mgBc5lvwD81E1VxFiyT4qxwjzi7svJojtGTxHW8S8G57NIQ71DRKNGz3NWM+cjoX5Xdc8Sky3+qU
	o7ZuTxck2inSqWDC8nvUdv9Srw00YifIGxP2nHTFGbYfDlOQI19h3W906zOdCj6zGEPTDhHRbwgFb
	TfRynvuiJOZwe+GlG66Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maaEe-00FiFd-BU; Wed, 13 Oct 2021 09:07:40 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maXWq-00F6oX-7a
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 06:14:18 +0000
Received: by mail-pg1-x532.google.com with SMTP id a73so1347255pge.0
 for <linux-nvme@lists.infradead.org>; Tue, 12 Oct 2021 23:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ohUOQyC8vv5S9fFmDSqrC2HGxb4XvUeywx+2/I7KWZo=;
 b=frRmuaPa3nXR7lxMr1CNNPYB3c6MDWaV+IHcoR+XuNXpKLmcDJudjmJiNd/vJuYFPn
 yeOjEGluCsqDt4qWvY1oHVWaypcD/6hEY+cvzA7LDBwWjS32G63Wnxe8e0GGmx9dGa0p
 xQzhoygleJQrWshzo5X8hdFcW2UVxu2kZRAXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ohUOQyC8vv5S9fFmDSqrC2HGxb4XvUeywx+2/I7KWZo=;
 b=Trf6T/Ii/6bCoVbzOFMYHu5B6qbxYZXjG/AISEhMpddbbYnuScI2KxKpzM6rleG91b
 BYUqc9Cu/6IijlpDwR1aXxnW+fIaiFLdvJB/k0gkdR6YC0EDbV4j+U+gR4xtL8hHXYXW
 iaqGBi0nT23ldezTDBKglheNTGGCZdwNnKhJKPps8TlMaJhvL7fP/8TzaRGQ35etHQ17
 cb9VE6iSouRrnehIl/iY0pTm/0Ogk1NdtNVFt1aAX8CmHGLrSD/SeVI5rLDmUYHzcL2E
 uahlOsDd9TplBs2SZwU3EuZGM1yVAdiRKyZ03vUR9BOSmnuo0RG+MFg+fYrb/vjaTRZf
 x1GA==
X-Gm-Message-State: AOAM533ozzxavTTHz73mwYbdNUTm/ImczDYv4l8urMZsNpYQyn293upz
 6eCV7d+bq6ZUMS9fR/9saTwhWQ==
X-Google-Smtp-Source: ABdhPJwNMNbppcyyaPyGGktYQSHeAypT2bIkLVBhhieDA7TSPn60W6m8F7nQfgJZ/E5a6hMyK4Ynow==
X-Received: by 2002:a63:e00b:: with SMTP id e11mr26380948pgh.190.1634105655240; 
 Tue, 12 Oct 2021 23:14:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id t8sm10813622pgk.66.2021.10.12.23.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 23:14:15 -0700 (PDT)
Date: Tue, 12 Oct 2021 23:14:14 -0700
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
Subject: Re: [PATCH 09/29] fs: simplify init_page_buffers
Message-ID: <202110122314.664187AA@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-10-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-10-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_231416_300993_59201E82 
X-CRM114-Status: GOOD (  11.24  )
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

On Wed, Oct 13, 2021 at 07:10:22AM +0200, Christoph Hellwig wrote:
> No need to convert from bdev to inode and back.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
