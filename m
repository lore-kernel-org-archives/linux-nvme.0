Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9519BC47DDF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 20:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AtZBEe426KIf/mBUMlvvoaF7jyFEZ9/COBSE2/txMLU=; b=BlIvc/rDFsFNvQLv4j7V2ToUdy
	YodRM79mFKfecp5ynHzu8DA02J+kP6JAcgjAqLEQwpxhOBeQDzWmFP4K42pNr/6VSgopgEnIp3U5e
	6xv0HzScEEjkBqBPZverBBxLac9cop4Q66BEW9lViq9nxDZRtcMxdeDi5fQW/LgJIBNGmPgRuIKNk
	AWT0FJhNDd3krFRCOhs4yrhyZt0YXBzaNNs918Rq3VWC/rybwnCm+i4blBXwnBo27fbpEBvLqBXC/
	yYJCLPKbYSMoabfyiLeLNcbRaT0HL3b/XEJBhCKzVdlZaaxMkofFomaL2k+bDemxjpCCY3kQ4A+Q8
	ofijfGiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUv3E-00000000Y3u-0oF8;
	Tue, 30 Jan 2024 20:49:48 +0000
Received: from mail-qv1-f42.google.com ([209.85.219.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUv2r-00000000Xz0-1nbl
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 20:49:27 +0000
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68c3ac1fdb9so26349216d6.2
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 12:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706647763; x=1707252563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtZBEe426KIf/mBUMlvvoaF7jyFEZ9/COBSE2/txMLU=;
        b=vbKkqaHmR4Q6k0DuWnF8wJfV8wT74MmTICY3B3LPkKZ9H9Ka+HKpGidHPGEdGzrZRf
         stz4dXei44L6ozVylFYLtJ1Y4SRoU8EI3V4x6EP/ltBOZtPj0P6f0VOAgCAnOwEdLGnT
         LOsFAiOYD8oosPMXJIv/DI0C4gkmfvY6U/xkTT8aIVWyv0rHeoeYVduN3YeuXf8MPHlo
         2+D41Cp4bm6xj+P1JOmu7f0S6DXhrjwjrEO6vrxf1i6MRbJRb753WnGwGUZ6w+6vsObK
         8PrFM5OAVX3PjaRwpmICR6JYvS8UJgo7rkUxPdQ9qL0PLcNiShYisn0KGK8jsX/ZkQFJ
         t8kA==
X-Gm-Message-State: AOJu0Yz7GrZ3ru5HrrjOMNtXdaxW9zHymk/2gdDf2Xb7oGg+qDO96y5g
	lMlU7/EHyN7aYse3aDOCZsFsyb0sTwiGPxswCyROFUprzrzObPHNcHkzHrliig==
X-Google-Smtp-Source: AGHT+IExCJjqhy5J/HQbLwc6HEIv1PKoKFV6opMfTc/hdwP/PWAAPv9RfvTcXLRcTuNHUUdlDE2mNw==
X-Received: by 2002:a05:6214:f2c:b0:681:7d81:705b with SMTP id iw12-20020a0562140f2c00b006817d81705bmr615439qvb.4.1706647763522;
        Tue, 30 Jan 2024 12:49:23 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id of10-20020a056214434a00b0068c560eaf8fsm1688182qvb.134.2024.01.30.12.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:49:23 -0800 (PST)
Date: Tue, 30 Jan 2024 15:49:22 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 5/5] block: remove gfp_flags from blkdev_zone_mgmt
Message-ID: <Zblg0qE25wPt-SRv@redhat.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-5-ae3b7c8def61@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128-zonefs_nofs-v3-5-ae3b7c8def61@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_124925_492245_39E268BE 
X-CRM114-Status: GOOD (  10.87  )
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

On Mon, Jan 29 2024 at  2:52P -0500,
Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:

> Now that all callers pass in GFP_KERNEL to blkdev_zone_mgmt() and use
> memalloc_no{io,fs}_{save,restore}() to define the allocation scope, we can
> drop the gfp_mask parameter from blkdev_zone_mgmt() as well as
> blkdev_zone_reset_all() and blkdev_zone_reset_all_emulated().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

