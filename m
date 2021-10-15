Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA4FC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 16:05:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA7361181
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 16:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBA7361181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DZnDLe/hPV82nGDaQ9SybgeRvq4v8194pDCOmq4WnGI=; b=sCjXrvk9yf3VXwl1Eny10Ea3D1
	MNF7DNBmzRZJC3Zfugfh0EUebvGoyJjA5g7vrPQoVGCt2AvlvJDsQyax6SFPFjQ2jFxmPttDyxwED
	199mUrkvbdeVn64SvAb0iqukwaA2c9WepehVhAUld58wzGZsCR1UFR0f2ik4bypYzwswhjueLDBnt
	rW7damQyVR8uv+Z+ysepWNByhxS6442FssvcqQq8D1wQqrVc4m9Sdy0ipEd50mmCUt8JEvv+ZjHoS
	+lAf+8HLEGBzDd4C1TB08KwpBG8pWb5M9OxlIAUnzgT3ncajBrsSzCP7NjTt7XqfPSmau8K5Pe3Sk
	7f9+Yo/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbPhw-007zYj-MD; Fri, 15 Oct 2021 16:05:20 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbPUM-007xg8-CC
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 15:51:19 +0000
Received: by mail-pj1-x1033.google.com with SMTP id oa4so7488820pjb.2
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DZnDLe/hPV82nGDaQ9SybgeRvq4v8194pDCOmq4WnGI=;
 b=MrTzmpi6tPkZEscjT0HSiUnzPC0e0Zm+HdRKo1GnmGF9YjiSBut+2I9RhysvFrlXle
 xZfF/EyK1YxGO+4XkAzcR5rkYfkBT8c0FO8fgSH63rqxjWSjB317HZNHZiI7+NPsyO40
 1HghhomhvrKYKMicBAPPc0DZU1RkPhHGeNsOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DZnDLe/hPV82nGDaQ9SybgeRvq4v8194pDCOmq4WnGI=;
 b=jfjJ8X81uPFR/GGKfhNLz0Q6URKXfGDl1zI4/mGlzSvMXQWIiY1gIaL290fmeDNcOK
 Ws8dJwJvXEtCIhaWZxxd92lvqMGLfwfoYp1x6kGRUe4f1z/Veufj08Cj0/P/nM5VBaaf
 IAy+vC09OhYOKnNUl6swkecNoLB8xyvRN4/4QeAqsyG/DIjlX/1tRmHZEQVAFronO9+J
 np3Ow6XltqiDEVg4eSLxL0gvdbrpSldcCeYgVQikYv6vGOBr88ZdNrUYC52uH1757jKC
 hsS87njobJRKwjXiguWg194SQmklD+Ly28CupcjoIuaAD58LFBOblyrpsQgcUGNIEeTp
 gOAw==
X-Gm-Message-State: AOAM5332Ps6pDKFGTFPUDOSqDxHbciIWV17Hs3jWMsxz8qYwLBpFQTgK
 wg02odJd0iJB/gkBiO39ky6GpQ==
X-Google-Smtp-Source: ABdhPJxDmKDta0sIDCKxrBjrXvbcujsYquDk3gV7yUWEsTdaAg5jq62C+ng3dE34jL0hht2zFj2KNw==
X-Received: by 2002:a17:90b:224e:: with SMTP id
 hk14mr14307733pjb.224.1634313076478; 
 Fri, 15 Oct 2021 08:51:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id k17sm5446139pfk.16.2021.10.15.08.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 08:51:16 -0700 (PDT)
Date: Fri, 15 Oct 2021 08:51:15 -0700
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
 reiserfs-devel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 07/30] nvmet: use bdev_nr_bytes instead of open coding it
Message-ID: <202110150851.0021855B14@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_085118_451187_994C9653 
X-CRM114-Status: GOOD (  11.58  )
X-Mailman-Approved-At: Fri, 15 Oct 2021 09:05:09 -0700
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

On Fri, Oct 15, 2021 at 03:26:20PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

