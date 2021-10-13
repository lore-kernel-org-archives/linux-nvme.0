Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FCBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:09:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E133560462
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E133560462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gtAnOOgr/6KDV92ujzoWjx/nkf0gXHgdy10kB59ijoQ=; b=oyA2vBbwbWczSy
	8VhSJIxb6bvstxzrERZK2ovLx2eUK1obLyI7xWBgIKicf0KW5A1K6+FRClxNoOud7YWVoRPLQCMTf
	PAYp8qeuLoI51mWX7DoJTAFW0bmgwoHmGeQj4+abIudbdjlQhRGF0R1GzJeQ8W2/d0D5rrCY+DrSh
	RTiGioHL+qcd3LYzqucm8U9DtRuxaE8P2KK2ORlwYEeE+ErWb4COTMP6peidlfKn51UVDpLlZGiWv
	Dp/4VGHb5xcJMwOr9kMkdjJbu+Lt0mTdc4Xq+qjMHY2JIZu+HpjG6fucpICfpzC2wYKbW4lUiPAcD
	CmaFThitZSG0NC/jeATA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maaGI-00FiYo-Vp; Wed, 13 Oct 2021 09:09:23 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maXWz-00F6rV-Br
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 06:14:26 +0000
Received: by mail-pl1-x635.google.com with SMTP id t11so1073412plq.11
 for <linux-nvme@lists.infradead.org>; Tue, 12 Oct 2021 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cU/dcevRRiOMyYUwUWALBmXmlvE8es1M77S7S7Vy3hg=;
 b=V/PklmmvmwB6oF28+X9W5oSqUy3MEBQUnBb4J2bRKEg/eIXO/xXpeqqwQGZrKIWhNv
 T8ctXe4hPipGRmAP9ugd0bC7MXlyH2K83qjMXuuXIhufHwq0vvnSHMGq1LP/1SN2Yv7x
 bKng84M/wOhI7OL1CmIwsfNERqhd12BkP84hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cU/dcevRRiOMyYUwUWALBmXmlvE8es1M77S7S7Vy3hg=;
 b=G0Xd8FSAGYHG/hnCtuAyTlp7zPGRq/f6FdQi7LSjpl7yHHO3ESnWCR+u7PrIvB38tW
 T4SWKj5sn79iyxCSUvF6TJasQ6QIAcLnXYhMX8mj76v1d3cIXVdVP4g7iZjKYz7PUTy8
 9mVdkMfh2lU3W6VpTAAX78d22NUszlB8rK0kfhGDm9mlF+zcYyC4W5d77qgrkpUCOR3w
 vJzXdhHU5X9Xup5IBWKPnkFugeCd0lIjPYbPBlXnizjTOJf5097Fn1642o8i3Yudflcl
 YxzNCfgxPZqTrQldl/+jyXhruAXfugdC+SA1vXYq1vUCDWCS/WEpNiJ07I7LYzHB61ct
 Wa/g==
X-Gm-Message-State: AOAM533AedjeVK8iuTDpS63G3vfnfSufGxFQGBFoRhMO9cmYqyWod7bx
 bW5+XxWZcs9sFEiqnmxvIwmxgw==
X-Google-Smtp-Source: ABdhPJzB9T5WPRLBzlHsv86tToIXEU4uRcFKAiECkCtvwz0iUp/WDY5ZssCw0V4lwGrfF5Bgew0Phw==
X-Received: by 2002:a17:90a:8912:: with SMTP id
 u18mr10958091pjn.69.1634105664752; 
 Tue, 12 Oct 2021 23:14:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id o6sm12981960pfp.79.2021.10.12.23.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 23:14:24 -0700 (PDT)
Date: Tue, 12 Oct 2021 23:14:23 -0700
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
Subject: Re: [PATCH 10/29] affs: use bdev_nr_sectors instead of open coding it
Message-ID: <202110122314.6BE3F05AA3@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-11-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-11-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_231425_479412_8D032D8E 
X-CRM114-Status: GOOD (  12.19  )
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

On Wed, Oct 13, 2021 at 07:10:23AM +0200, Christoph Hellwig wrote:
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
