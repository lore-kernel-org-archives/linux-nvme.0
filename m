Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8F7C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 15:46:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF30D6105A
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 15:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF30D6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFM5WavD2dlHj0k2cmbjEUH7DswNvraUTvaUeecsFLI=; b=aiRtLVcdvvO/5f3m9gKgjyopGP
	wM2FGlUEn4C+JPIfYtZFylqRrbY4nmTNy7NeOC6k2w5MXjR3BkhGY+dQRoqw8r6I4hwdPKBNDB23b
	hFeBAHee1gxuxZ+Bpso8q0wwiaaQknHvA45UQBbAqA7I2axKHKEvOZ17eq/lfCavacmY1IlATxDgg
	dYDfBgqR5zUJjf3AdsborqQz+eexuivO3OP2FdFHe8s88erCXLxy/9DcOHvaBilTr1wwNqgffDpvf
	pKwt1JH4vbC+UYjhEcAQTuZzq6Dqh/FRrO/1Jq/K+rxk6MHmDVqPp4Hkk2/5FAv58ZPj21FJUZcCJ
	T6N9LGlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbPQ9-007wva-J5; Fri, 15 Oct 2021 15:46:57 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbPP7-007wox-DY
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 15:45:54 +0000
Received: by mail-pl1-x635.google.com with SMTP id c4so6639784pls.6
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XFM5WavD2dlHj0k2cmbjEUH7DswNvraUTvaUeecsFLI=;
 b=kI3cmovLUq4/7b3XdGijH4QV2pLukclN+qtvDChdq76oCBSEjB/PxJ/LWqXaiWG3Ff
 e4ufh94HB0JHTcED5LMZgB7kXmiVxJYf75rZOCTtrAggeGm0/wa2OqJYCFCBhzazIF7l
 udxg7lVjqVFbJpk0sBDk4exc+CKZoXIIyRuqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XFM5WavD2dlHj0k2cmbjEUH7DswNvraUTvaUeecsFLI=;
 b=iEALPSArWG2bieG5iu8WNB2yE8EVPuUH0l9hHFs7Y2aMb8+GrqV3A/T82HhDJlmrAj
 dXIbjceO/MjgWI9+kKUxUQ9I7yN9tdmc0nLYMgiHRfe8QrmStBfKNppqm259v99/zKfo
 0DsIOKPsJipi86hywG/4K36NUhP5jzmTHeoBeu3lnku9NqgJno1Tc6HIpqukikUMtwPa
 E5hmmYKg/viDAz4WfuGnAx/OimMqx3e7F4JNzaWIEbdC8zAJEncKZpevxmrGNzFevuW4
 rZmDeJlctkDLrOwhfBVsXJO4zje+bq1O5A6ljbrfScz7pCVHs88udnvg7UmoZde5JeYc
 peKA==
X-Gm-Message-State: AOAM531ADYG3utTxJTmpXtr5kS02qzKUkwPUyL7kG8WC/34VZ6ljVw8g
 UdGG4zGa4c9jfA8Q/TUvmsCxzA==
X-Google-Smtp-Source: ABdhPJwzQs+V6r1hPLOTwtZOgiRq0ZYBjWTuzen8H9dNT74QaE01sJDiES/7Q1kbrrYk+yq2JOau2g==
X-Received: by 2002:a17:90a:86:: with SMTP id
 a6mr28243106pja.190.1634312751709; 
 Fri, 15 Oct 2021 08:45:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id g17sm5328859pfu.22.2021.10.15.08.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 08:45:51 -0700 (PDT)
Date: Fri, 15 Oct 2021 08:45:50 -0700
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
Subject: Re: [PATCH 01/30] block: move the SECTOR_SIZE related definitions to
 blk_types.h
Message-ID: <202110150845.29BA04E647@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_084553_501365_E80853C6 
X-CRM114-Status: GOOD (  11.34  )
X-Mailman-Approved-At: Fri, 15 Oct 2021 08:46:36 -0700
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

On Fri, Oct 15, 2021 at 03:26:14PM +0200, Christoph Hellwig wrote:
> Ensure these are always available for inlines in the various block layer
> headers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Awesome, yes. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

