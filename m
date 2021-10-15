Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E55C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 17:05:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85C460F25
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 17:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C85C460F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KeY5Iupdn4Pa1b1ywzkz23CB7y+Fa3Cfufu6RZZIPYI=; b=f56vNPwLX02meB11diZ1dXx3hh
	v3lVHifcJ5X3lKXVw+3ykVgRvvux4S6ZoC3GY9cZFmrXCvy0nU9Ybsv4Dg3g8Odj5Uog5+hPGD9zl
	eQcQxmmwZZ2ZqtNAk4Mzs3Rx2wcNvujbH4lGA79dnzp8wJyKob0k0k++kXbQPSrRU11I29N31N29Y
	ztqjySUM1DeC0xNQmwyS8++RK91Jg1iS/ezi7ZxygWKwsKbRvVVvtKuXOsgEUCETqEunqRcgu95SQ
	C30aLbPSPLnSgh/hilUYJEW5XTLr6gTtf8rFyBtHorxfFxndTxEZcNGidR/z4RuR4x+t5e5TZegVE
	SZPAV0CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbQe2-008EbV-NC; Fri, 15 Oct 2021 17:05:22 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbQYT-008CUM-TX
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 16:59:39 +0000
Received: by mail-pg1-x52e.google.com with SMTP id f5so9101825pgc.12
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KeY5Iupdn4Pa1b1ywzkz23CB7y+Fa3Cfufu6RZZIPYI=;
 b=VfHpzO3tYcRdDu0YlVkKzx/ciItoc9jkR356sB11SejVmPNb6TbARwblxJNv77Pw+N
 f8l5X6Xk6dZ16M5aIo4oyfynzDADoHwHbbl+nEWOg/Hpm3DtdjVVH1S12Q1eI7nmyOz6
 dWXhnsHrWbhYXafHG9GJqGCTKk1oPJdLtiQOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KeY5Iupdn4Pa1b1ywzkz23CB7y+Fa3Cfufu6RZZIPYI=;
 b=5Z+L7qb5Q1fS4R4VAMk66cFT65pDqUc35MxpSLedQKnzgm6UQa9vz2rqETvn68doux
 gzoPU8vRZiHB5U14uvIWbmC9+ccQjoFqzuePJM3pgRP0SAzFbE2xIXBbP8H7vu9pw4kU
 DowcgEpzpCgDKs+puLI/qcOu/6LtzNdAlstEeC2TW4MWSyzCDBiz7cDlu+6MnpIIa1lE
 B0YJT3WilTMCmthzflV8nDjRO5efGUU4hjhPclZU5C88xf23bEFXQLYZQKUrlDEwxPUJ
 /weOAHWIfACRKNJ2YwI++dkv+uQmRrFENvvRlI+fvJ7q9L84820W5z8qdOrUg2u4+FO+
 DcdA==
X-Gm-Message-State: AOAM530KAlXsyVJoVkvpnly81Mc84v2Um47jnDjtqGhi8bHghDm0R3LC
 GlqyZyA+5WOFCY0etyjo0YIkRw==
X-Google-Smtp-Source: ABdhPJyZcIPxqI061aZSIz4/wOG8MIjCzx1/IGr1O74KMeY0yclhOMeVn1PfQJDWXy+egSNKM0RvAw==
X-Received: by 2002:a62:1bd2:0:b0:44c:db2e:5a88 with SMTP id
 b201-20020a621bd2000000b0044cdb2e5a88mr13192615pfb.29.1634317177017; 
 Fri, 15 Oct 2021 09:59:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id t38sm1001799pfg.102.2021.10.15.09.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 09:59:35 -0700 (PDT)
Date: Fri, 15 Oct 2021 09:59:35 -0700
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
 reiserfs-devel@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 12/30] btrfs: use bdev_nr_bytes instead of open coding it
Message-ID: <202110150959.D3A3EBD2DD@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-13-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_095937_976366_7C86ACD2 
X-CRM114-Status: GOOD (  11.68  )
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

On Fri, Oct 15, 2021 at 03:26:25PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

