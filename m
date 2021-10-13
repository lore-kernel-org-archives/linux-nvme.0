Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9FCC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:00:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254E0610CF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 254E0610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wSFhioP2rd093cY5VQdZkzwkfRoXOrd+EQYCBY5SWSQ=; b=uvvAo4RVWVl201
	x77zTclSPVLj8o7+uiHTVriaxhX7IGfffl5dAXv/flsQK7IjziuSplTDiUx3cli9aCORrMSmU5PUZ
	hc2y1GSUhv4Gqp4ZOLvzPDk96gvERUHXumZ9UFBHc6k/Z4BJE24RmHsdSb5kQcnjW+9/MThbZvzCq
	mc2vpKUo3eGmEfqO5AJ6mVshejH34Yy4LiMUAiRxONXFu2pYcrwSss+YIhOmQhmUGqayHGfS57GUB
	3bRGoljZ3Grf3rNB0o9me1+K/4UGfh5p4AckwHYYSaFZD51CYF3l50WiQKA9yw5SAEM9Lpt9kXKri
	ue5fmum54AyN2UIi7KJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maa7l-00FgoK-VD; Wed, 13 Oct 2021 09:00:34 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maXS4-00F5hC-Ud
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 06:09:22 +0000
Received: by mail-pg1-x52c.google.com with SMTP id s11so1281362pgr.11
 for <linux-nvme@lists.infradead.org>; Tue, 12 Oct 2021 23:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Qqwh23O6V/63P0yRnTO77bOtLRcytQL2fAyeRI5kB34=;
 b=CXM9rJHHK73rEQgm0mgdKmXS/wAofOl4OFPnwKac/DX3XFO3SZF+VUOO6mlfTZkIDy
 UTW+b9/6/6WoMA5ZI2y3esBG93Aw5k00FZrNw4PEm0iPy6yRGylzqCSKEzZCYiYZiEa0
 Gvi4MQ98yBAEGpxPU0vceWRTRPKnOulu8VFrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qqwh23O6V/63P0yRnTO77bOtLRcytQL2fAyeRI5kB34=;
 b=LZUMav3HerHCBjoXwPdNdLFPL7M1Xd/6xlNaid1GSjZK9w13fpVeJJD+KuJTcuZkQm
 iymMlJioO9Tpq2U0vRvcXoiUUJ+nxGb+Qslwrh46T2YSTpDw0OR1N8EMu6jsrTxqIeOA
 xAdC27oUrcyzcbD2BW6MSHqHrm3DekaVqx8J5PEDs3QfoCmZPliUiprLRYu7yuOzlwIN
 tFcEaexwYRzJJrGt8+QMYf0fhpZ8xwQzt/P1P7Q6sBU09FYQOyYRqb/YTNpzPdI91ZkK
 PM1flo+7Xchd5r5JcZh6HnrOLhlsmVT0cvB7YkJMwgO/bhDqm/+6oHZnyt2M9LQWJbv1
 zKHg==
X-Gm-Message-State: AOAM533eIeJ/SHu4Xr+Y08sPl5uTq/d2fT5HTPARmuyooURof3qPwTsX
 RzOo898fQkPeP3baiGv+t4VPYQ==
X-Google-Smtp-Source: ABdhPJzPVB6suksbrVxsW8arxDgbrt+zmZKpBhbvkmkjyXI+mBKX9gJNh2h2afCA7c0GFA7FKUgXzA==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr26426089pgh.7.1634105359458; 
 Tue, 12 Oct 2021 23:09:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id e6sm12787858pfm.212.2021.10.12.23.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 23:09:18 -0700 (PDT)
Date: Tue, 12 Oct 2021 23:09:17 -0700
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
Subject: Re: [PATCH 01/29] bcache: remove bdev_sectors
Message-ID: <202110122309.010F81F49A@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_230921_052864_ED53606C 
X-CRM114-Status: GOOD (  11.07  )
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

On Wed, Oct 13, 2021 at 07:10:14AM +0200, Christoph Hellwig wrote:
> Use the equivalent block layer helper instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
