Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F00C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 01:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QIsP3rIT20WkjzGLGzVyHnhUMjCoAAIVWQlR2AtO0K4=; b=QDO+m8tuApy5HBg+QXTcntLP/L
	LDOB0hgiUuo3+Ga6SWGIYQkfeHAfNYFcP/Hp0MA2n8d2VfxTDr/VGutI9VspkDe+QbmHv8d072ksK
	fqf/lQLxr/7DIo7o4FXC+DWSB6qOXCtBCoei2d8Zo6uUKk8PyT4iFek9ahlKAid1bUTS5NiY19OKh
	SyYtKPHKoXOGIIdXK0GMjIqC3w8toMO7bd2G9u4ysJ/IV+b4ZxJv+4Qr4KvwjrkH3tG5RKCfs7z8W
	St1a9FP6SZsNke59BppZPRAyr3rDGsfMZXKhsiUkkjpUplUhe/HFmKmX1VDb3WU96xOg4sCdvZFjL
	a2xAmdeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUFBG-00000007Grh-2uoW;
	Wed, 25 Jun 2025 01:44:06 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUFBD-00000007Gr0-35AT
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 01:44:05 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2350b1b9129so45213625ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Jun 2025 18:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750815842; x=1751420642; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QIsP3rIT20WkjzGLGzVyHnhUMjCoAAIVWQlR2AtO0K4=;
        b=heYyex/7/sC5B1c30o1clFQwttSdFkFzB7dNDAj+vJ4yVvh3cwqUhBXJWHERMKq67m
         Y5ouxC994k184dvrmDVlwoeI2Itt+xJTqzTOC1xGGTLUFkw5cBpqjhYXE8/L5s2Gj7Ez
         kFf9OK5jZZicz08slw1s3Pmt93wtrqdq/1yHYqohWuQ3ZfiRQAeLs2F+xP9if3p3XdY0
         zR+VsbidA5nxdXi8LjFtz+GJ2d/gCmxracFBIYCG8z+TMSirE7+uq6nF5lAhRvkucACY
         Sig91priwl3zfjxDlOHG+9cTLFMaXdk2aq89mkbmgGUh+bNfZ6z1hvx+Z0r7nnQFIa6J
         jVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750815842; x=1751420642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIsP3rIT20WkjzGLGzVyHnhUMjCoAAIVWQlR2AtO0K4=;
        b=QuvI5YWkti6pdx1GPZYihkvvy4BtI8m8Zn64EOXUsK0dCWqB2mtNl/fKHtDf7DsCCf
         mODBF3En9PTtwLNwt122DwsxcmuNHG4dBln8/a0e94dRCSAAwi2qSAZLOp5DGLVlrU3w
         rjalLEkdqV5ixiRveQbHzD5GfuVDUt9ppJdOmIFwN2VPw5W2nVZgSF6lrdlhbX8stLtm
         l8h+37KJYH59YCbO94xKrSv2+sKG0N/Htd4FYEcBxQPBbM4uCm/DK13MJEMyJQxCXZpp
         jJP4n5lzbLHIfrNacg7fqw9CmCPVUNzSvvLCLBX7T6fq9EfI45NbYhYpbQcMsbFPC0D2
         h9qA==
X-Forwarded-Encrypted: i=1; AJvYcCXkm4bIaQuvSrAvbEyZ6p4SmjdRR4PJ+wf2BAfUcrdmJLdJrN5qa/8gJDcpHfO1goM8lvmZquhrm3Y7@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1UFYuPH2/8jpIjJ+MycWFTWGCrgmsB/Mao8qKuC5CFiSR42DL
	+5QI1OKy3rUcXUJbdLptz3SeafTMpmkvsc4k1ypH1hoyDu4xiUINgbt2rwZbT9NiTbE=
X-Gm-Gg: ASbGncuvt3vVpDlQoFFnzB50kwKC7sRRSPSW7ge5BxI1UuFRdpn5ujF2HtMUapSFhku
	4lPayy8wXeJlWmG32GJClYK+QCJ5I8SS6mbckFUPS8FIhXwX0bOPb9HMoGUt1FQxTIPlNUNnKap
	kzK2+J7IQIxgcQlwZ46IhVO7xgNPPrNUiiWA7xoSxzZbKuXrg6Dm3hAXwfXbuc3kbP4BboEBFSS
	0pTNPZMnd8ddOdfvbI8RMILWWbXtT0hl/RMZeIkATKKSfphfiZpkif+X97Xch3LYE9TrqJRDm8K
	5GyZ33d6PQ3KPG3HBDdvwDMQXFDqvvVItGctmxt5tys7COErOVkSvSn1TkG8hBrJCzixAWoPDN7
	AI7xViERZx18f+ilRbwduNGLaw4q+EwiH9oxZRImYKQ==
X-Google-Smtp-Source: AGHT+IHoDqUOYTCnE2gceYTiiXbnq2K/SlA10HDt9RUO5WPvnN8jozjol3hPLkjrrrxWz9hN/gbLRA==
X-Received: by 2002:a17:903:f90:b0:234:e3b7:5d0f with SMTP id d9443c01a7336-23823d5682bmr23697475ad.0.1750815842318;
        Tue, 24 Jun 2025 18:44:02 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8393893sm119389915ad.25.2025.06.24.18.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 18:44:01 -0700 (PDT)
Date: Tue, 24 Jun 2025 18:43:59 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Breno Leitao <leitao@debian.org>, Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aFtUXy-lct0WxY2w@mozart.vkv.me>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
 <aFTfQpsUiD1Hw3zU@mozart.vkv.me>
 <f320c94e-3a94-d645-8f7b-80f958c50fbe@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f320c94e-3a94-d645-8f7b-80f958c50fbe@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_184403_776869_634337A5 
X-CRM114-Status: GOOD (  22.69  )
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

On Friday 06/20 at 14:47 +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/06/20 12:10, Calvin Owens 写道:
> > I dumped all the similar WARNs I've seen here (blk-warn-%d.txt):
> > 
> >      https://github.com/jcalvinowens/lkml-debug-616/tree/master
> 
> These reports also contain both request-based and bio-based disk, I
> think perhaps following concurrent scenario is possible:
> 
> While bdev_count_inflight is interating all cpu, some IOs are issued
> from traversed cpu and then completed from the cpu that is not traversed
> yet.
> 
> cpu0
> 		cpu1
> 		bdev_count_inflight
> 		 //for_each_possible_cpu
> 		 // cpu0 is 0
> 		 infliht += 0
> // issue a io
> blk_account_io_start
> // cpu0 inflight ++
> 
> 				cpu2
> 				// the io is done
> 				blk_account_io_done
> 				// cpu2 inflight --
> 		 // cpu 1 is 0
> 		 inflight += 0
> 		 // cpu2 is -1
> 		 inflight += -1
> 		 ...
> 
> In this case, the total inflight will be -1.
> 
> Yi and Calvin,
> 
> Can you please help testing the following patch, it add a WARN_ON_ONCE()
> using atomic operations, if the new warning is not reporduced while
> the old warning is reporduced, I think it can be confirmed the above
> analyze is correct, and I will send a revert for the WARN_ON_ONCE()
> change in bdev_count_inflight().

Hi Kuai,

I can confirm it's what you expected, I've reproduced the original
warning with your patch while not seeing any of the new ones.

If you like, for the revert:

Tested-By: Calvin Owens <calvin@wbinvd.org>

Thanks,
Calvin

> Thanks,
> Kuai
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b862c66018f2..2b033caa74e8 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1035,6 +1035,8 @@ unsigned long bdev_start_io_acct(struct block_device
> *bdev, enum req_op op,
>         part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
>         part_stat_unlock();
> 
> +       atomic_inc(&bdev->inflight[op_is_write(op)]);
> +
>         return start_time;
>  }
>  EXPORT_SYMBOL(bdev_start_io_acct);
> @@ -1065,6 +1067,8 @@ void bdev_end_io_acct(struct block_device *bdev, enum
> req_op op,
>         part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
>         part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
>         part_stat_unlock();
> +
> +       WARN_ON_ONCE(atomic_dec_return(&bdev->inflight[op_is_write(op)]) <
> 0);
>  }
>  EXPORT_SYMBOL(bdev_end_io_acct);
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be5..ff15276d277f 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -658,6 +658,8 @@ static void blk_account_io_merge_request(struct request
> *req)
>                 part_stat_local_dec(req->part,
>                                     in_flight[op_is_write(req_op(req))]);
>                 part_stat_unlock();
> +
> + WARN_ON_ONCE(atomic_dec_return(&req->part->inflight[op_is_write(req_op(req))])
> < 0);
>         }
>  }
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4806b867e37d..94e728ff8bb6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1056,6 +1056,8 @@ static inline void blk_account_io_done(struct request
> *req, u64 now)
>                 part_stat_local_dec(req->part,
>                                     in_flight[op_is_write(req_op(req))]);
>                 part_stat_unlock();
> +
> + WARN_ON_ONCE(atomic_dec_return(&req->part->inflight[op_is_write(req_op(req))])
> < 0);
>         }
>  }
> 
> @@ -1116,6 +1118,8 @@ static inline void blk_account_io_start(struct request
> *req)
>         update_io_ticks(req->part, jiffies, false);
>         part_stat_local_inc(req->part, in_flight[op_is_write(req_op(req))]);
>         part_stat_unlock();
> +
> +       atomic_inc(&req->part->inflight[op_is_write(req_op(req))]);
>  }
> 
>  static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 3d1577f07c1c..a81110c07426 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -43,6 +43,7 @@ struct block_device {
>         sector_t                bd_nr_sectors;
>         struct gendisk *        bd_disk;
>         struct request_queue *  bd_queue;
> +       atomic_t                inflight[2];
>         struct disk_stats __percpu *bd_stats;
>         unsigned long           bd_stamp;
>         atomic_t                __bd_flags;     // partition number + flags
> 

