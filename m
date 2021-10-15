Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9685CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 16:56:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6992361181
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 16:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6992361181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SGOpzYQsZVxiJYbDiHH5De0/7WPNstxhmFZjyDhxXSM=; b=X6H18oyTLYAkAFfhxf9rjYm1w9
	/Bjo7bkL/pDkTP1QcQmarL86dfQBpwIqXNvB9YZw6Um7vjwWuQfYRV5r+pp9atMM3ogS/PutmYbFK
	CSdEvRGgvwg7cHCwpYhB79kxDZo44mqZN8AS7cP3u8bSXlRrw9OqyQL0kmA1d1ObNJt1zbg6ykGUN
	Ehy66k70oPNRUAu4tiFKZ+O6C1ZlFRo3tBimMELIv7R0s4Dnqj3rrW9w8DfVR5GKryr/h15QTIS1o
	AB+qDSyIUV11gyqU70+1pgd/1J+Ng/HTcP0Fpdx2ioD8yJX4PVKgI7hlW0E3W0dPKUXPMig2HhmVJ
	KPtGq3yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbQVs-008BUG-UA; Fri, 15 Oct 2021 16:56:57 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbQTx-008AuB-9g
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 16:54:58 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 66so9103625pgc.9
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SGOpzYQsZVxiJYbDiHH5De0/7WPNstxhmFZjyDhxXSM=;
 b=fs2nTqRo7F1ZHnAQpHrc4ABoCfv10ucgSRl5XyF5Dl0EU+kq5CLj40RrhqmGKfYBdE
 srWd8WSfQrAgtx4IytED1edJOCHp8619TxpM3AEsBF+FDwK3nXgnkT7wtVpp+hLrbcJ8
 Rg3NqIIsXlTg4ynBFyVvaBOq2w7XptVlu38kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SGOpzYQsZVxiJYbDiHH5De0/7WPNstxhmFZjyDhxXSM=;
 b=QxUOAiedCT/UBFV+wHtpk1e+LXHC9koOSYV9hjqVRJZ9xeqJfg8Fzyp7k5fz4ZEGgW
 AdG89KbIhumA07L+a834cC6dFfKVOyRh/k2Pwk1RYyE385CA7mskrpb/pRBKbg4t8CO8
 Oon2nfm5FIMQsRymcikT8YUYpqXh+ek1R+hPVS2XA5rCYawj9a9ykYlKfwBS12xC/sEE
 +T/jA6RNvnLfOtKAcfOP3+HBqI6JRf4wVU2rCsWCLbsO6ibEzsSs8E84LJVMdaW1JI2H
 fxHfvc9Kg/rDUjQuVpGql9Gu5Shl3GNsmSiFgLsFwE1iBLbcuPeLsVmgCB7T+4hQ79r1
 ZCZA==
X-Gm-Message-State: AOAM533idtz/b+fu4krFdrluD1m8aQwJynJZQBTt4XUCIaUdvkC58ra8
 5Vw6H6uIGeJeaVetn9jfAb+0NQ==
X-Google-Smtp-Source: ABdhPJyWeQQaxN3OVR9dpjDI7bcixMoFds0uTAEJpzN0+vwQj4qrWqnY4m/W/UbgYRyhJ3miirXMyQ==
X-Received: by 2002:a62:1596:0:b0:44c:f7b3:df74 with SMTP id
 144-20020a621596000000b0044cf7b3df74mr12889236pfv.60.1634316896184; 
 Fri, 15 Oct 2021 09:54:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id h3sm6042497pfv.166.2021.10.15.09.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 09:54:55 -0700 (PDT)
Date: Fri, 15 Oct 2021 09:54:55 -0700
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
Subject: Re: [PATCH 20/30] ntfs3: use bdev_nr_bytes instead of open coding it
Message-ID: <202110150954.FE37F8CF00@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-21-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-21-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_095457_360291_9ADAD261 
X-CRM114-Status: GOOD (  11.61  )
X-Mailman-Approved-At: Fri, 15 Oct 2021 09:55:57 -0700
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

