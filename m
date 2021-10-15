Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FBBC43219
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 16:56:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B22F61181
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 16:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B22F61181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/gIfzDIY8BHp2GAnTGqbUaWifgLmmgJaZHOEikCPNE=; b=WuaZqS6hXWz2eGzHj3Q5amLw1J
	RC9BjRa8RDw5T1xe7nhnpFmaNWEXr7fousUsHFbaCFGhWEtlAKgNkM6FbtZ42nEM1+BH5C3EshOq7
	pGAZ4K0rWpwURsC7hQpsBL24FSRXUo5MCb+zpwqNEUmhxMz/6Xs6wwmdwTIM4FI+n1NMoev+kR+3i
	/xAYkeUD8HgbBMF4CS+cO3zmgWkwt1VrwtDkKrhMS0aPFsfNosA+ipp7OW+kNT5TSoOJd6Lh1ih0m
	qiMHYa6xi7NCERPcldaFigGTyTVOSSBnL9GV3DE4AAnnevOb+Zy944NYdLzifmAgjHNiunMVjeGUe
	yD9vQmsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbQV8-008BC3-Mv; Fri, 15 Oct 2021 16:56:10 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbQSx-008ATT-5T
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 16:53:56 +0000
Received: by mail-pj1-x102b.google.com with SMTP id
 nn3-20020a17090b38c300b001a03bb6c4ebso7720295pjb.1
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=i/gIfzDIY8BHp2GAnTGqbUaWifgLmmgJaZHOEikCPNE=;
 b=ijCBeqwjSX44JYJYQXxoOlzCMaUqE2c/FshvcWt5AOJ7Pdw2meC8GD81XASC91VnuZ
 nItwuK+FFfu4fuFDPeSQcXw9Uz1W4h2xhJCY/Ev6pPXPQ0ELlFXiago1MNdfKztmZVkX
 OUFTCDErJi6w26qIfF+omjAVxqFsWClXKietM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i/gIfzDIY8BHp2GAnTGqbUaWifgLmmgJaZHOEikCPNE=;
 b=Cm/z39t4AwwcCSWqcufb8tsFJs7q6duKRQaqoUNthCaQhzkwkBSd6BsCSSoARwwSmV
 7OOUxz+RrEI1aF/3r88jN3B5MzrwzuPwYcojxOumW7XyYwvEvv/dA14dmPsYqbafwrue
 I7R/xkTR87BzlvjHWkshKHQpqjqj0o4BYVCXAI3hdkFTIQtsqzBht44M2gHAOJGayQlS
 kSS0KK2/w2gqPAGjsS2IgDYwYMvYvfweO80r17byN/LbvUR0eIPBZ1AbiG2J8kKiRPe2
 DAJXIAz1zbepuq4HeN+W3tgGpz6/5RXX9YZFgBSPXT9Ny9/S6X6togi6WZrf2C5yENNz
 rEGw==
X-Gm-Message-State: AOAM5308oyGfff41mUwEIo9R8CNNSOZ7SBV8tc2TvmTJ8tGnbcKQjIvv
 ywxyMcUvvC8G/zm19qHoB6R+fQ==
X-Google-Smtp-Source: ABdhPJwk57gXwSH1fuk9uQJ3MKRp8IS5de92E1niz0LUeVepi4gZ7xD6FT4x0ovJQOMjXdqoZrATMw==
X-Received: by 2002:a17:902:eccf:b0:13e:b002:d8bd with SMTP id
 a15-20020a170902eccf00b0013eb002d8bdmr11944496plh.48.1634316833234; 
 Fri, 15 Oct 2021 09:53:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id j7sm5286487pfh.168.2021.10.15.09.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 09:53:52 -0700 (PDT)
Date: Fri, 15 Oct 2021 09:53:52 -0700
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
 reiserfs-devel@vger.kernel.org, Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH 17/30] jfs: use bdev_nr_bytes instead of open coding it
Message-ID: <202110150953.4C55C8948@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-18-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_095355_229199_A791F616 
X-CRM114-Status: GOOD (  11.68  )
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

On Fri, Oct 15, 2021 at 03:26:30PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

