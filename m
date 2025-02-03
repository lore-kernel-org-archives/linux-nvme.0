Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57266C02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Liydz60cmndYD4qns14/Qbs4OC2qocuyXIy5gGvyjyg=; b=QEH3tE3WYthslpEhk+HuCFg89y
	vJsbf5MpZrAE9hm6NDoBH2BuTYrL/xuGQ+uqTxn7fdE/8GhCXltguBS1TEyPh/S3OmMewxdUAHGDN
	FfFF6YFmmk1k+nCv3OHHjgtJjKlyV3m9xUJYmX4eJGRrTDA+PxXxDqh3OaQ7Vs5Mq01ABdf6IWxYh
	0hh5ktGQffeeX32WDWB9ZoeUgz78KdZZ8mBFLOx1Qm8RD/FQSs0+oDEcd2UWKgz3e3N8dvjkqJPtW
	agpQte3NYisk8GNV7Se5y4mEJGEwdYC3RobG0Tyh6A63YGndRf+3q+zpa7gRSN8Nt4xs/0LKZ9B2C
	ofvLz2Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tey5K-0000000Fok8-0Mne;
	Mon, 03 Feb 2025 15:10:02 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tey4Q-0000000FocO-1znA;
	Mon, 03 Feb 2025 15:09:07 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2166651f752so89327105ad.3;
        Mon, 03 Feb 2025 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738595345; x=1739200145; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Liydz60cmndYD4qns14/Qbs4OC2qocuyXIy5gGvyjyg=;
        b=RLIiSg+z9NAy7nXMTxcGP0eJ85it9e9Mktvd9zdHGvaIdZ4LIZh/9dM5EtQ6GUDF3B
         CaiISn/a4KnpesFKv2Oz5oEViccx/as3nvbdLMRHZRk2NGL+GGiey+n0P7N9tfH6qzKz
         AwnDLUC1sQ3aUH72AtE3m34jgvr2LHFX03Yj/sei69sSKAiSKl7LdUu9PEjk7IGIfpSs
         nhFuZeSswOzurq4g3nlyuZ8oKqoc4U0uWEfHP04jGNGcdXe+KXl9b+N4v+soFlHnuqG/
         t0na8JY7K9PITClqFOMB0ANQfS1h/An6DlEzRdl3d1H8WVLKSetW5XBd2DZdqyinWedr
         kPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595345; x=1739200145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Liydz60cmndYD4qns14/Qbs4OC2qocuyXIy5gGvyjyg=;
        b=ZXOYpdLORegxJSkWtFgO91zuxMUjRWtUNmB12fYuYhECEp8vKZLCq8QSChvsWxmmzG
         Tze/hX9uYgg1rAJBfVUDtWru0n8wabtNVpV53eRHrw/oSIRMtbwDtxW5yGM+BxaXNz6i
         2UoQaZNQvWGH1T7PALjXTCKkLc+l+AwZFUnaDr1pkbRqlVZT6cgOfuiITXS+E+O1l740
         bCoj7/HWcIapSDLTjteV8+OajSt0Wr1CRHw9b6ZY2z1gADgN3xOujsYMScmSJiBCh4ct
         MewCCN+UsU7AmgNTy8O4JBR9ByIqefW4nEuq9Ut+xVcYJJmHH5ozKoe5gHnc+yH47UUm
         FO1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7/c2h0NOv1YcRlanizHprzCpMeQiYfERacG4aUgTBSgSrMuFN2Q6VZST2qFlHCrWuayCZ+WGjozQ=@lists.infradead.org, AJvYcCVJrqPRaoW5ttCULf13DXDfivKLSw5fyRr337BtLLI3gFxDFN4T0xaKF3MKMeyUIjxn8DbJ6IVhkKeWAQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyNvp4UDiwkO43GPABeCbSghCHu+L49ASbSgZqfTgw+zD+0D+Bs
	bEqGVMmZUy/P8I0dpHEcHD1QyQT3ET82g6ohj0+3y20MeJOWrDvz
X-Gm-Gg: ASbGncurNCC7PJI5o5eHGwm+rw5OV4nwxI7zbTKy/peFhsHwXtLa9W0RkCy/jtvt/dl
	pb3fh8tPMOnQkT23m5yFx0n1OVD8lAjjH2OdRoKIG70ysG/2o9LLDWdnPF7mVb9NS0pFXTitSYc
	bg2BacR1bHMvU7I2cwVic1VMFGjk+H5eINMb+8A9DYhkRvflfzYN6rObiZbRLFr7zAQBR59Jpr+
	usCHz/fcHZ4QDUF70VJk7o7jj8VxxapbZb9gbHZ5Tu9rvPACREEHi9pVVKeDLLk1LpUn3rnS75M
	tUVaS7rtgjrAgrKDs8vdsh32drsL
X-Google-Smtp-Source: AGHT+IFUAkyxrkJaDrPwYodDQvzxDDTUk4r3atYHiHtcVu1uJFXauC2E5w6/RR2ly7RfMe7ktQE7aA==
X-Received: by 2002:a17:903:188:b0:21d:dfae:300c with SMTP id d9443c01a7336-21ddfae34camr280680665ad.3.1738595344940;
        Mon, 03 Feb 2025 07:09:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de4a91af6sm76095175ad.17.2025.02.03.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 07:09:04 -0800 (PST)
Date: Mon, 3 Feb 2025 07:09:02 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	ceph-devel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH] block: force noio scope in blk_mq_freeze_queue
Message-ID: <2273ad20-ed56-429c-a6ef-ffdb3196782b@roeck-us.net>
References: <20250131120352.1315351-1-hch@lst.de>
 <20250131120352.1315351-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131120352.1315351-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_070906_513072_3B2AB6B8 
X-CRM114-Status: GOOD (  16.97  )
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

On Fri, Jan 31, 2025 at 01:03:47PM +0100, Christoph Hellwig wrote:
> When block drivers or the core block code perform allocations with a
> frozen queue, this could try to recurse into the block device to
> reclaim memory and deadlock.  Thus all allocations done by a process
> that froze a queue need to be done without __GFP_IO and __GFP_FS.
> Instead of tying to track all of them down, force a noio scope as
> part of freezing the queue.
> 
> Note that nvme is a bit of a mess here due to the non-owner freezes,
> and they will be addressed separately.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

All sparc64 builds fail with this patch in the tree.

drivers/block/sunvdc.c: In function 'vdc_queue_drain':
drivers/block/sunvdc.c:1130:9: error: too many arguments to function 'blk_mq_unquiesce_queue'
 1130 |         blk_mq_unquiesce_queue(q, memflags);
      |         ^~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/block/sunvdc.c:10:
include/linux/blk-mq.h:895:6: note: declared here
  895 | void blk_mq_unquiesce_queue(struct request_queue *q);
      |      ^~~~~~~~~~~~~~~~~~~~~~
drivers/block/sunvdc.c:1131:9: error: too few arguments to function 'blk_mq_unfreeze_queue'
 1131 |         blk_mq_unfreeze_queue(q);
      |         ^~~~~~~~~~~~~~~~~~~~~
include/linux/blk-mq.h:914:1: note: declared here
  914 | blk_mq_unfreeze_queue(struct request_queue *q, unsigned int memflags)

Bisect log attached for reference.

Guenter

---
# bad: [8d0efe18f567040a251aef1e00ea39bd3776f5e1] Merge branch 'fixes-v6.14' into testing
# good: [69e858e0b8b2ea07759e995aa383e8780d9d140c] Merge tag 'uml-for-linus-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux
git bisect start 'HEAD' '69e858e0b8b2'
# bad: [1b5f3c51fbb8042efb314484b47b2092cdd40bf6] Merge tag 'riscv-for-linus-6.14-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
git bisect bad 1b5f3c51fbb8042efb314484b47b2092cdd40bf6
# bad: [9755ffd989aa04c298d265c27625806595875895] Merge tag 'block-6.14-20250131' of git://git.kernel.dk/linux
git bisect bad 9755ffd989aa04c298d265c27625806595875895
# good: [626d1a1e99583f846e44d6eefdc9d1c8b82c372d] Merge tag 'ceph-for-6.14-rc1' of https://github.com/ceph/ceph-client
git bisect good 626d1a1e99583f846e44d6eefdc9d1c8b82c372d
# good: [8c8492ca64e79c6e0f433e8c9d2bcbd039ef83d0] io_uring/net: don't retry connect operation on EPOLLERR
git bisect good 8c8492ca64e79c6e0f433e8c9d2bcbd039ef83d0
# good: [95d7e8226106e3445b0d877015f4192c47d23637] Merge tag 'ata-6.14-rc1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
git bisect good 95d7e8226106e3445b0d877015f4192c47d23637
# good: [5aa21b0495df1fac6d39f45011c1572bb431c44c] loop: don't clear LO_FLAGS_PARTSCAN on LOOP_SET_STATUS{,64}
git bisect good 5aa21b0495df1fac6d39f45011c1572bb431c44c
# good: [14ef49657ff3b7156952b2eadcf2e5bafd735795] block: fix nr_hw_queue update racing with disk addition/removal
git bisect good 14ef49657ff3b7156952b2eadcf2e5bafd735795
# bad: [1e1a9cecfab3f22ebef0a976f849c87be8d03c1c] block: force noio scope in blk_mq_freeze_queue
git bisect bad 1e1a9cecfab3f22ebef0a976f849c87be8d03c1c
# first bad commit: [1e1a9cecfab3f22ebef0a976f849c87be8d03c1c] block: force noio scope in blk_mq_freeze_queue


