Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C85CC07545
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 04:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=C2eQlkrHXsb01SkD0r5lPH6teOpnFeXQ1oyHS+DlKI4=; b=D5ZBhWWhTmenho
	WgA/zFaga1A/VIIvm9ZRiZseIknlzB3u1cstwi/HCSZ5RCP6YjBNFeuWCnwB6/mHGnkuOTGo8mJBo
	huO2M9UMgQ7ZU/eqtOdDOCTqt027H45wMJRQC2YA5RnH4x6aKjxbEHOwgZz5//puycvNfwtOafKcP
	802bfd4bUoIK1ZIcyDT1hS5lTyr/KL9oP28ZXJ9/Xm1u82MM+TYueW/WXSOq2K3cmwXNqsltCy7OK
	hvtU7b8YVVb6W4rGaNK2CXt9JMHaxSCHPWLM/gXJPpUA1RYb87DRZrbrgryEhcpoeYA5XoA8sJ6JA
	lt+3gDMFOJFBRze5z4og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvVlb-00BMDW-1r;
	Wed, 25 Oct 2023 04:45:15 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvVlX-00BMCa-2w
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 04:45:13 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso41121005e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Oct 2023 21:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698209109; x=1698813909; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2eQlkrHXsb01SkD0r5lPH6teOpnFeXQ1oyHS+DlKI4=;
        b=YV0SiEJLipl6tKIXjTPwY9+KMoPTjBfylk+8P8qsPggTe8/TSYhNTlOTtxBV97XtrX
         iOkxys0Rtwl/PKuJWbsBHXAp1e3ONW2nRa0LczQd8+k5aejkEwYk805wXyzpqpCf0rs7
         r58uf0VdZCh8qbStTG0YYUmDBS7HllG56+OBtASdD1A+aiRnC90VZBTYVPvvX0iGkh5n
         ujvnpqJmj4ja3qyKoht6ALbYcsGGEHzF7I18lC8qTKxRlg1PZ7rRnolCQexfDCMFm0NL
         +qpPAzuy6qbIKKkomnXAVUQdqqdgnvNMCg9cKEqDwDinjyP+QmGmP1vC2xX2XKQKwFqr
         FQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698209109; x=1698813909;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2eQlkrHXsb01SkD0r5lPH6teOpnFeXQ1oyHS+DlKI4=;
        b=JNvsV/Iz5bIl7SsS3GUju19im0AhS6SMcFTEsIlA6pTKrx2IPmu74A2eogrGY8xH8a
         5dzlmvATQneNqN3+feWCfTJWjtgJIV6sIUHyG0PWGhO9r5SoJyXwy97pHWUl/KWk0z58
         wHvP1yn8/vlBibfWx+wG0I7GZomsCQNIBogrT15WDBUan/EOob+M8YzmTPFfieBQuVmC
         MnE6ylugMin0TY4/ZxwsoZ4LMQgiHUH5/LRK5SPDf6FHDW9T1VusWYGfzKGcFGkARFQF
         J0OJrNTl2DAKZIELtjMYY2jyJzhpvYfj2qfg1uRqeQIa1zPScXE4RxLQmSioAt8fPwKW
         GUdQ==
X-Gm-Message-State: AOJu0Yy6P4sNx/gdsX00ZXalbIoY2WN3lnvabAR+nhnT+4uWjzyID/R7
	26hAlga053IdWyTEBePK/Lm1Uw==
X-Google-Smtp-Source: AGHT+IH5u+VrhTrLq4ZQUG00msn+IStTkp3E/NHGTSlHLwWSz3OReR5BpJ0FFZ2Ie1ciq6NwvNCJcA==
X-Received: by 2002:a05:600c:1ca6:b0:408:386b:1916 with SMTP id k38-20020a05600c1ca600b00408386b1916mr10835678wms.8.1698209109293;
        Tue, 24 Oct 2023 21:45:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x10-20020a05600c21ca00b003feea62440bsm13254454wmj.43.2023.10.24.21.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 21:45:08 -0700 (PDT)
Date: Wed, 25 Oct 2023 07:45:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Nitesh Shetty <nj.shetty@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com,
	gost.dev@samsung.com, mcgrof@kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v17 03/12] block: add copy offload support
Message-ID: <4c126ecc-ac29-46a5-8cd2-1149d37886c7@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019110147.31672-4-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_214512_012550_3DEA1FB0 
X-CRM114-Status: GOOD (  11.79  )
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

Hi Nitesh,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-and-sysfs-for-copy-offload-support/20231019-200658
base:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
patch link:    https://lore.kernel.org/r/20231019110147.31672-4-nj.shetty%40samsung.com
patch subject: [PATCH v17 03/12] block: add copy offload support
config: i386-randconfig-141-20231022 (https://download.01.org/0day-ci/archive/20231025/202310251059.GiTmwLYx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231025/202310251059.GiTmwLYx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310251059.GiTmwLYx-lkp@intel.com/

New smatch warnings:
block/blk-lib.c:248 blkdev_copy_offload() warn: use 'gfp' here instead of GFP_KERNEL?

Old smatch warnings:
block/blk-lib.c:264 blkdev_copy_offload() warn: use 'gfp' here instead of GFP_KERNEL?

vim +/gfp +248 block/blk-lib.c

391929a15e2c18 Nitesh Shetty 2023-10-19  228  ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
391929a15e2c18 Nitesh Shetty 2023-10-19  229  			    loff_t pos_out, size_t len,
391929a15e2c18 Nitesh Shetty 2023-10-19  230  			    void (*endio)(void *, int, ssize_t),
391929a15e2c18 Nitesh Shetty 2023-10-19  231  			    void *private, gfp_t gfp)
391929a15e2c18 Nitesh Shetty 2023-10-19  232  {
391929a15e2c18 Nitesh Shetty 2023-10-19  233  	struct blkdev_copy_io *cio;
391929a15e2c18 Nitesh Shetty 2023-10-19  234  	struct blkdev_copy_offload_io *offload_io;
391929a15e2c18 Nitesh Shetty 2023-10-19  235  	struct bio *src_bio, *dst_bio;
391929a15e2c18 Nitesh Shetty 2023-10-19  236  	size_t rem, chunk;
391929a15e2c18 Nitesh Shetty 2023-10-19  237  	size_t max_copy_bytes = bdev_max_copy_sectors(bdev) << SECTOR_SHIFT;
391929a15e2c18 Nitesh Shetty 2023-10-19  238  	ssize_t ret;
391929a15e2c18 Nitesh Shetty 2023-10-19  239  	struct blk_plug plug;
391929a15e2c18 Nitesh Shetty 2023-10-19  240  
391929a15e2c18 Nitesh Shetty 2023-10-19  241  	if (!max_copy_bytes)
391929a15e2c18 Nitesh Shetty 2023-10-19  242  		return -EOPNOTSUPP;
391929a15e2c18 Nitesh Shetty 2023-10-19  243  
391929a15e2c18 Nitesh Shetty 2023-10-19  244  	ret = blkdev_copy_sanity_check(bdev, pos_in, bdev, pos_out, len);
391929a15e2c18 Nitesh Shetty 2023-10-19  245  	if (ret)
391929a15e2c18 Nitesh Shetty 2023-10-19  246  		return ret;
391929a15e2c18 Nitesh Shetty 2023-10-19  247  
391929a15e2c18 Nitesh Shetty 2023-10-19 @248  	cio = kzalloc(sizeof(*cio), GFP_KERNEL);

Should this be: cio = kzalloc(sizeof(*cio), gfp);?  It's not totally
clear from the context honestly.  (I haven't looked at the code outside
what is in this automated email).

391929a15e2c18 Nitesh Shetty 2023-10-19  249  	if (!cio)
391929a15e2c18 Nitesh Shetty 2023-10-19  250  		return -ENOMEM;
391929a15e2c18 Nitesh Shetty 2023-10-19  251  	atomic_set(&cio->refcount, 1);
391929a15e2c18 Nitesh Shetty 2023-10-19  252  	cio->waiter = current;
391929a15e2c18 Nitesh Shetty 2023-10-19  253  	cio->endio = endio;
391929a15e2c18 Nitesh Shetty 2023-10-19  254  	cio->private = private;
391929a15e2c18 Nitesh Shetty 2023-10-19  255  
391929a15e2c18 Nitesh Shetty 2023-10-19  256  	/*
391929a15e2c18 Nitesh Shetty 2023-10-19  257  	 * If there is a error, copied will be set to least successfully
391929a15e2c18 Nitesh Shetty 2023-10-19  258  	 * completed copied length
391929a15e2c18 Nitesh Shetty 2023-10-19  259  	 */
391929a15e2c18 Nitesh Shetty 2023-10-19  260  	cio->copied = len;
391929a15e2c18 Nitesh Shetty 2023-10-19  261  	for (rem = len; rem > 0; rem -= chunk) {
391929a15e2c18 Nitesh Shetty 2023-10-19  262  		chunk = min(rem, max_copy_bytes);
391929a15e2c18 Nitesh Shetty 2023-10-19  263  
391929a15e2c18 Nitesh Shetty 2023-10-19  264  		offload_io = kzalloc(sizeof(*offload_io), GFP_KERNEL);
391929a15e2c18 Nitesh Shetty 2023-10-19  265  		if (!offload_io)
391929a15e2c18 Nitesh Shetty 2023-10-19  266  			goto err_free_cio;
391929a15e2c18 Nitesh Shetty 2023-10-19  267  		offload_io->cio = cio;
391929a15e2c18 Nitesh Shetty 2023-10-19  268  		/*
391929a15e2c18 Nitesh Shetty 2023-10-19  269  		 * For partial completion, we use offload_io->offset to truncate
391929a15e2c18 Nitesh Shetty 2023-10-19  270  		 * successful copy length
391929a15e2c18 Nitesh Shetty 2023-10-19  271  		 */
391929a15e2c18 Nitesh Shetty 2023-10-19  272  		offload_io->offset = len - rem;
391929a15e2c18 Nitesh Shetty 2023-10-19  273  
391929a15e2c18 Nitesh Shetty 2023-10-19  274  		src_bio = bio_alloc(bdev, 0, REQ_OP_COPY_SRC, gfp);
391929a15e2c18 Nitesh Shetty 2023-10-19  275  		if (!src_bio)
391929a15e2c18 Nitesh Shetty 2023-10-19  276  			goto err_free_offload_io;
391929a15e2c18 Nitesh Shetty 2023-10-19  277  		src_bio->bi_iter.bi_size = chunk;
391929a15e2c18 Nitesh Shetty 2023-10-19  278  		src_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
391929a15e2c18 Nitesh Shetty 2023-10-19  279  
391929a15e2c18 Nitesh Shetty 2023-10-19  280  		blk_start_plug(&plug);
391929a15e2c18 Nitesh Shetty 2023-10-19  281  		dst_bio = blk_next_bio(src_bio, bdev, 0, REQ_OP_COPY_DST, gfp);
391929a15e2c18 Nitesh Shetty 2023-10-19  282  		if (!dst_bio)
391929a15e2c18 Nitesh Shetty 2023-10-19  283  			goto err_free_src_bio;
391929a15e2c18 Nitesh Shetty 2023-10-19  284  		dst_bio->bi_iter.bi_size = chunk;
391929a15e2c18 Nitesh Shetty 2023-10-19  285  		dst_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
391929a15e2c18 Nitesh Shetty 2023-10-19  286  		dst_bio->bi_end_io = blkdev_copy_offload_dst_endio;
391929a15e2c18 Nitesh Shetty 2023-10-19  287  		dst_bio->bi_private = offload_io;
391929a15e2c18 Nitesh Shetty 2023-10-19  288  
391929a15e2c18 Nitesh Shetty 2023-10-19  289  		atomic_inc(&cio->refcount);
391929a15e2c18 Nitesh Shetty 2023-10-19  290  		submit_bio(dst_bio);
391929a15e2c18 Nitesh Shetty 2023-10-19  291  		blk_finish_plug(&plug);
391929a15e2c18 Nitesh Shetty 2023-10-19  292  		pos_in += chunk;
391929a15e2c18 Nitesh Shetty 2023-10-19  293  		pos_out += chunk;
391929a15e2c18 Nitesh Shetty 2023-10-19  294  	}
391929a15e2c18 Nitesh Shetty 2023-10-19  295  
391929a15e2c18 Nitesh Shetty 2023-10-19  296  	if (atomic_dec_and_test(&cio->refcount))
391929a15e2c18 Nitesh Shetty 2023-10-19  297  		blkdev_copy_endio(cio);
391929a15e2c18 Nitesh Shetty 2023-10-19  298  	if (endio)
391929a15e2c18 Nitesh Shetty 2023-10-19  299  		return -EIOCBQUEUED;
391929a15e2c18 Nitesh Shetty 2023-10-19  300  
391929a15e2c18 Nitesh Shetty 2023-10-19  301  	return blkdev_copy_wait_for_completion_io(cio);
391929a15e2c18 Nitesh Shetty 2023-10-19  302  
391929a15e2c18 Nitesh Shetty 2023-10-19  303  err_free_src_bio:
391929a15e2c18 Nitesh Shetty 2023-10-19  304  	bio_put(src_bio);
391929a15e2c18 Nitesh Shetty 2023-10-19  305  err_free_offload_io:
391929a15e2c18 Nitesh Shetty 2023-10-19  306  	kfree(offload_io);
391929a15e2c18 Nitesh Shetty 2023-10-19  307  err_free_cio:
391929a15e2c18 Nitesh Shetty 2023-10-19  308  	cio->copied = min_t(ssize_t, cio->copied, (len - rem));
391929a15e2c18 Nitesh Shetty 2023-10-19  309  	cio->status = -ENOMEM;
391929a15e2c18 Nitesh Shetty 2023-10-19  310  	if (rem == len) {
391929a15e2c18 Nitesh Shetty 2023-10-19  311  		ret = cio->status;
391929a15e2c18 Nitesh Shetty 2023-10-19  312  		kfree(cio);
391929a15e2c18 Nitesh Shetty 2023-10-19  313  		return ret;
391929a15e2c18 Nitesh Shetty 2023-10-19  314  	}
391929a15e2c18 Nitesh Shetty 2023-10-19  315  	if (cio->endio)
391929a15e2c18 Nitesh Shetty 2023-10-19  316  		return cio->status;
391929a15e2c18 Nitesh Shetty 2023-10-19  317  
391929a15e2c18 Nitesh Shetty 2023-10-19  318  	return blkdev_copy_wait_for_completion_io(cio);
391929a15e2c18 Nitesh Shetty 2023-10-19  319  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


