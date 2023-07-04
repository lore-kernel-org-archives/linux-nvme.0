Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF27AEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jul 2023 12:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JV2SCOEdB9t0w6tigDexjJMYhGF54ZwsLlYmJ1gE7wU=; b=Vg9pp4RbZnQRbRvVZAU/h9TW2o
	IYlvThdZARhuUklabuFgTjida4LZj7/017WEkznw2Z5/kX/JhAeHv7IF8QaeGiT+1K9YMENrJogh6
	eRdPluqmHDT2U4TSscXfacgO0lBvguNRM+LpbBVvH596ltDHr/I6RJWLiEY8mxcSk71xSJV6UHajm
	T3E0xhhw3vkY0Hko+Z6yKuO0ctAkA3LxpBbdakpHlA2mH3H6ZJ9bXyVyKrdLb4TmfAkrjGvZl0N5+
	udwUCah0kycNN9nTTCTeZpQa88KtsuK+yGjabcDDG+PBT4DeYxCL2WgY+m53I/QJ7e37cgmDjMyXa
	mAEyX7XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qH1G1-00Fnz1-0K;
	Wed, 05 Jul 2023 12:05:17 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGgfo-00DTLg-1L;
	Tue, 04 Jul 2023 14:06:33 +0000
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b7f2239bfdso44612395ad.1;
        Tue, 04 Jul 2023 07:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479590; x=1691071590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JV2SCOEdB9t0w6tigDexjJMYhGF54ZwsLlYmJ1gE7wU=;
        b=IVCEDDUHXHZWopFJZ953y2gRG75CZW4Qvex38u6h8/yC3EcXtZfJtluY8nABSYZrz1
         N546IEIO0VuS+SjzGL8sWKIEJFjiqJCcjELFflyQG9SgTlxbxwN5Pr7f6uU87lBwY63n
         /m/32nnPFFgtIJjXxd0V8Pkx6fQgZpxfNJQx107VO1wixUNAXfeBja8D1EOFrJyxpxye
         XdI2I49u3lWaN/5Xd91lMBITOJ/SsbGxD0Zjt27kMmVtUdWn+esjquKJHOyO7kDiFSfg
         FwoRzF6ZgXG7MgV7Ygr73nvDu1tYCHzsieafsaEYll3AZar7MaJxrsliUaVVuVM2sVgp
         YJ+A==
X-Gm-Message-State: ABy/qLZImSluOhE33/8pl3/nVB4rzAJ9HRNygyBroryHj8HaLfhupmMG
	xroRW0d982288a6rIg8Rp1E=
X-Google-Smtp-Source: APBJJlEESj5502hCCjnCrW5aNdhMviGxH5NXIz8SFwBF+614aVB6e0+1hJtWMTw8TJzZNuQy8olTNg==
X-Received: by 2002:a17:903:447:b0:1b8:a31b:ac85 with SMTP id iw7-20020a170903044700b001b8a31bac85mr2719760plb.41.1688479589749;
        Tue, 04 Jul 2023 07:06:29 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id jk4-20020a170903330400b001b672af624esm13083569plb.164.2023.07.04.07.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:06:29 -0700 (PDT)
Message-ID: <bb91e76b-0bd8-a949-f8b9-868f919ebcb9@acm.org>
Date: Tue, 4 Jul 2023 07:06:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>, Alasdair Kergon <agk@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Anna Schumaker <anna@kernel.org>,
 Chao Yu <chao@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Dave Kleikamp <shaggy@kernel.org>, David Sterba <dsterba@suse.com>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, Gao Xiang
 <xiang@kernel.org>, Jack Wang <jinpu.wang@ionos.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, jfs-discussion@lists.sourceforge.net,
 Joern Engel <joern@lazybastard.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Kent Overstreet <kent.overstreet@gmail.com>,
 linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Mike Snitzer <snitzer@kernel.org>, Minchan Kim <minchan@kernel.org>,
 ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Song Liu <song@kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>, target-devel@vger.kernel.org,
 Ted Tso <tytso@mit.edu>, Trond Myklebust <trond.myklebust@hammerspace.com>,
 xen-devel@lists.xenproject.org
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-1-jack@suse.cz>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230704122224.16257-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_070632_470150_775E7528 
X-CRM114-Status: GOOD (  11.48  )
X-Mailman-Approved-At: Wed, 05 Jul 2023 05:05:12 -0700
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

On 7/4/23 05:21, Jan Kara wrote:
> +struct bdev_handle {
> +	struct block_device *bdev;
> +	void *holder;
> +};

Please explain in the patch description why a holder pointer is 
introduced in struct bdev_handle and how it relates to the bd_holder 
pointer in struct block_device. Is one of the purposes of this patch 
series perhaps to add support for multiple holders per block device?

Thanks,

Bart.


