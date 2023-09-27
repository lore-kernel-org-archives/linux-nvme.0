Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813BDE728C1
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Sep 2023 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wwk46okUDVQfnnelgDDAXJI2PyNHcNwKe3ka13udWbU=; b=O9iQT400xV1x0+uNJNDKFmxb4y
	vLINJceNl4bvhxzYTM+rUQuS6IHtPzYKMjvJepzOSZILMh/cAU/c9Bc8QydWI+HEqzzQP8rloJntr
	XkgQ/iAQrMgbKirpxL80yr6s/hpS3j+CUGz9U/u51HhF3X+8/x1xKlIX6rB17te39seggHrdcLT3g
	0IB3vq+ITcij9cvTMBLTwwanUmzhoFNWUSQJM7D8RWuYW0Pbg8p0KDcGrtkkf4OUNKeC1kmlergJW
	YoUHkX+cz2Sp4Orb9Gc6dqx9dGyxsnmCt+WOZxTxde/wHw2gmbMmGTWc6P2LZF/GbnGNB+vTTjQkI
	hb3gH1VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmFhc-008EJ7-24;
	Fri, 29 Sep 2023 15:46:52 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlVOA-0017WS-37
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 14:19:44 +0000
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bfe9447645so40486351fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695824379; x=1696429179; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wwk46okUDVQfnnelgDDAXJI2PyNHcNwKe3ka13udWbU=;
        b=oNj82EpmRdLE+QjKVOLuZR3vpuxzBH+4CbUwaz/yEBDapZXM4kEYJnCdA5686CfDFq
         N6jfNemW0ASOwPTE26lHpU5LjorohE1shQI8ARmKJmhFfT67qJ1U4AHnD/YS1SmjzRiq
         q8A23w2qv8+uTnH50qgQe9hqgp5zNYmMd1SDM2mJTE4VjCA7i5bvC8OANjzX40/aC2SD
         zxBFkGjWWvmYDCnVpzFipv55jHcL17jFfNj6YF37OhIoyjWyn7J82GLwuQJwgQz9D/WH
         f9mhGofND9ZDtefUwhwfyYX8YWjS3P/E9cWuTUY8JASIKXzr0yI0YMfC+K1sIYpxWMHe
         jhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824379; x=1696429179;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwk46okUDVQfnnelgDDAXJI2PyNHcNwKe3ka13udWbU=;
        b=c6DzWcJf3PLFVkEF8KE7qn6Li6pSVs2HEAMGkTyWcbhcnxldlvJnXtVOTyxm1SDQy0
         KSyN081PQ6JuE9ymisfXQ/+t7jUZB+Cj1sO/ONiD7j5qGPmHXjy/GEya15M80MYEzz83
         PWwVE3gYRntYNeX13Xp+UMfC741Hf1UXhy0d5WpMltHy5XGFuzNxZy97IQWTkoGlTRcO
         mljt7DMvHDARn1LW9fuyGuidvlmWAMa4eSTkadTFYRReGQNpK05MFj++QI4JJItkL27Y
         i4AQzb4kOuNLaVZwa5hYIzVdrl08zhLYbeTpyAIj1kz6cQ2o7dps9yPehwBTPNco5r9p
         I1ag==
X-Gm-Message-State: AOJu0Yw2mTD0/oA01oqj4YgqSxuZGutn3U5/EvwynI3jXASEyF3Cql5y
	k5oZ4PSrxHDFDkANn2/f3NO4Ag==
X-Google-Smtp-Source: AGHT+IExVCqrFIxKzo43T8FMa/9T5rz6/xdccYRyI4cqxFk27k3RqgKqbk6x0v1Y5TMyg8NtKFdEkg==
X-Received: by 2002:a05:651c:3cf:b0:2b6:cd7f:5ea8 with SMTP id f15-20020a05651c03cf00b002b6cd7f5ea8mr1801740ljp.1.1695824378667;
        Wed, 27 Sep 2023 07:19:38 -0700 (PDT)
Received: from [172.20.13.88] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b00992b2c55c67sm9370253ejb.156.2023.09.27.07.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 07:19:37 -0700 (PDT)
Message-ID: <9cc59d88-4b77-4e56-ae54-737baca1d435@kernel.dk>
Date: Wed, 27 Sep 2023 08:19:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/29] block: Make blkdev_get_by_*() return handle
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>,
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
References: <20230818123232.2269-1-jack@suse.cz>
Content-Language: en-US
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_071943_008810_9CD1E0A2 
X-CRM114-Status: GOOD (  18.15  )
X-Mailman-Approved-At: Fri, 29 Sep 2023 08:46:50 -0700
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

On Wed, Sep 27, 2023 at 3:34?AM Jan Kara <jack@suse.cz> wrote:
>
> Hello,
>
> this is a v3 of the patch series which implements the idea of blkdev_get_by_*()

v4?

> calls returning bdev_handle which is then passed to blkdev_put() [1]. This
> makes the get and put calls for bdevs more obviously matching and allows us to
> propagate context from get to put without having to modify all the users
> (again!). In particular I need to propagate used open flags to blkdev_put() to
> be able count writeable opens and add support for blocking writes to mounted
> block devices. I'll send that series separately.
>
> The series is based on Btrfs tree's for-next branch [2] as of today as the
> series depends on Christoph's changes to btrfs device handling.  Patches have
> passed some reasonable testing - I've tested block changes, md, dm, bcache,
> xfs, btrfs, ext4, swap. More testing or review is always welcome. Thanks! I've
> pushed out the full branch to:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdev_handle
>
> to ease review / testing. Christian, can you pull the patches to your tree
> to get some exposure in linux-next as well? Thanks!

For the block bits:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


