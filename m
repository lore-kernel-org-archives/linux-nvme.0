Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106E1C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:12:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37BD60524
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C37BD60524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EjL61VVMPXrCCs2TcOppWl7L2Ek9ijRG3SgOen7F6zs=; b=qeeiqB0QezoQu7
	4XWu3EfHsOXv+Fkh04nPS9bciYbHCVVf29rxF57YWxWrPijjv+x9PS7iI8amIgsHKl3QMusXZU6y2
	/6drIzhPiWZPL7eG0AlLboJxgnCvgLLDvdQyUyzs3CJBC+xxj/mSc24lTHVKkbD+HLYHHRNQahAF1
	r2AUDdG98mqoRirrP2GI1TR00GWZOXSkgHgEw0BqCXMi8dIZgDGs/AUXRCneZLg4FuAR5t5wg5z22
	FrAFqZC+4dBF0MmYgN+pc4dKd96Cr9OZbYmVkakWYsAakloWXSWLi29KA+lRTpSQAD4fnTSUa6I+r
	VVHADEQw9DtKQMC2QOwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maaJR-00Fj9J-UM; Wed, 13 Oct 2021 09:12:38 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maXZ5-00F7Kd-S2
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 06:16:37 +0000
Received: by mail-pl1-x62c.google.com with SMTP id f21so1102019plb.3
 for <linux-nvme@lists.infradead.org>; Tue, 12 Oct 2021 23:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yoKDGyU1IKw4WZcPglkL9qCJyXlf9awotx8P2PTzBWs=;
 b=CfsfnomPleYW4GBsBhk8H6G76FqS7CJ1hCWsqRQNWdP3gBxNE2zoVJGIUrEHECfVKa
 v2cK96TEo8Mw5Ik4Y/ADCAfA/3y7sebWHT8J/KK4oeu3vgk08FAOGIJ4+lA7q9hiMA29
 r2H7qpegYylGn4mcpKE0+qgwtq9QgI8dolIgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yoKDGyU1IKw4WZcPglkL9qCJyXlf9awotx8P2PTzBWs=;
 b=VDZx7KumabHTZ50p3y8oHSPC+OcSMYO6hI5GG9UA2Pmhs7ZaKrvt5Iqobcu25BmXBR
 LW9s7enErm0vX0QVFmy9F+0ZQzbnYEyAD90HE5gAHFus6GG2k8vjuFYjwFjKr+K0j2BF
 QOcJ/ufOpw169B9ynDPG6AfwSLvqMrC6oa1XJvkGcbuFmTxRmCAnCrWuI8H2FsArDh4X
 lnYVfgqvb2HGo4F0Cm0wxiqKVJL0K2oCBTGG4hQELrjNEdy6sY545Wbjb82Z4ejC0HNy
 XM7KrylOD+du1ml3KualSSjj9GM6sFH0rUGU8xnE8efW2OooyXws94AHCPIVxRDmJY4J
 XxeA==
X-Gm-Message-State: AOAM531eo+j+r6oKPEwBF6bnwPV2XXdXY5yn238flO3h1k/Mj89q+ZU0
 yDGZGJ+Cji36jSc7MpKYIT1l5w==
X-Google-Smtp-Source: ABdhPJxLGyOml5lqe+K0AfHsTHYJz8Z1ysoHhzc/2/LGB5MqaATX0lTpa7QxWtRvvD8zMko7cBuZVA==
X-Received: by 2002:a17:90b:3850:: with SMTP id
 nl16mr11065306pjb.127.1634105795098; 
 Tue, 12 Oct 2021 23:16:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id c11sm4509497pji.38.2021.10.12.23.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 23:16:34 -0700 (PDT)
Date: Tue, 12 Oct 2021 23:16:34 -0700
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
Subject: Re: [PATCH 13/29] fat: use bdev_nr_sectors instead of open coding it
Message-ID: <202110122316.8ED0742@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-14-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-14-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_231636_019788_37DB360A 
X-CRM114-Status: GOOD (  12.30  )
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

On Wed, Oct 13, 2021 at 07:10:26AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
