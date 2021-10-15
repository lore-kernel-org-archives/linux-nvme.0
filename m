Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B903C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 08:57:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA7260C4B
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 08:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFA7260C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LpGoqEWei5FXrKy5qTqsLJCtKd2jpbBDiauT/XgCqN4=; b=KEtaE48IJZNsZRQnrQXEn+X4qx
	w2+4zxNbx5azUOlzTgKg3a1BnchthdzGYl2cM7+oz8EiWu2rdy1kesgibksaqMg2fYqZW3P9ZF24t
	HlFUxlnM3s6HbccR5D/F7UAgNV4eVfsUECyaPeujeLa4M0qEjDXposJiVr25Dc7vD9pbt4Po/asaU
	UyhTxUbDR1XjraIuG7QS56rFpV6T6Th6n3DAnLLYouqWt5XRWd+Viq4b9pK7c6CVJ4WYlfQOVJJGg
	ZpbNu5amS5BFS5dyP3UKsv4UQ/itP3poO+e8wcZDYgc8V73MZIHUY/wS/U43VPCq89AaavUhDwUfW
	feurQqoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbJ2F-0067kj-MW; Fri, 15 Oct 2021 08:57:51 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbIbm-0060AD-3U
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 08:30:32 +0000
Received: by mail-lf1-x132.google.com with SMTP id x27so38781943lfu.5
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LpGoqEWei5FXrKy5qTqsLJCtKd2jpbBDiauT/XgCqN4=;
 b=H72WQZEscxVJsu+eWElnCHCUXOukvxf46e1VnF83K6j9v7nsP3+19wEpz7B4f1RH7D
 7CDRwUD6+N8ffcFTc90gVU5pND2FXfQAczcVAyc+7cURXriueOD/4YDedzYVABpNoroD
 CYbL7Ap6c6L+IZ0oFn6Pp5fXTPK0x0xQ/yv6IXBB+YOnmisCKrOhBEB9/p0/K6f4hgNc
 4Tugx6JtZJ0lXyGs+rBo7PkhfDGk9dg/c22xac9tr0RwGtyshlFFRFrcoSvnpaHcqizc
 lv6y93SrtuS8i213itZv+77Ns3DncA1EpLruBOAv5Tasi/5JHb8KOa8ck10lCQclIq9H
 yYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LpGoqEWei5FXrKy5qTqsLJCtKd2jpbBDiauT/XgCqN4=;
 b=xG1FSd4l/w+2FjPRInsDCtWFN9v/fYmk4MkAiQ4KevSOGBC3a9FshaLz5X/Pv8gCq9
 19ZCPBjr4Mkslegvb+qK7YZ2XHAMMTnBwzIlhHe/N61DQFVXHz8b7F50obZm4JRr4Ces
 XOPVeG1jItxxV8eNt/agkdtjJlPoFHYM6G3oq6hReypXsRCOq4IniYKvf1BIX2gACygV
 KM7dOy0fav2XDGaXQ40L4uzw3Xv5zow2eiEVrKlrVK7DXT2Sbk3+smo2Z+lPMJhJuQro
 GX4dgpgQ046+6CevYAmRUThvJUwWByA1WLQM6q4TfKJy3LzhMm+kx1Aj6j2dtyM+WY5n
 756w==
X-Gm-Message-State: AOAM531VhVlSnEvsfqpsOSuGq1y8WNYoKW6Hbhm3yPECenvKIvfgeWEv
 fgLcjnElC46AwIthXFI4NQU=
X-Google-Smtp-Source: ABdhPJyjX7GxxUZgQH2jAvzQ0Vlt+MCNSvpXHNNMMUEhpz//xRQC+cI+Z0eCH4vbBVyhrGxxsefqfg==
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr11452577ljj.357.1634286627882; 
 Fri, 15 Oct 2021 01:30:27 -0700 (PDT)
Received: from localhost (80-62-117-201-mobile.dk.customer.tdc.net.
 [80.62.117.201])
 by smtp.gmail.com with ESMTPSA id s12sm438870lfc.256.2021.10.15.01.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 01:30:27 -0700 (PDT)
Date: Fri, 15 Oct 2021 10:30:26 +0200
From: Pankaj Raghav <pankydev8@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Ming Lei <ming.lei@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
Message-ID: <20211015083026.3geaix6r6kcnncu7@quentin>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012111226.760968-15-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_013030_186488_4C96A0DA 
X-CRM114-Status: GOOD (  14.34  )
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

On Tue, Oct 12, 2021 at 01:12:24PM +0200, Christoph Hellwig wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2b80c98fc373e..2a8689e949b4c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -25,6 +25,7 @@ struct request;
>  struct sg_io_hdr;
>  struct blkcg_gq;
>  struct blk_flush_queue;
> +struct kiocb;
>  struct pr_ops;
>  struct rq_qos;
>  struct blk_queue_stats;
> @@ -550,7 +551,7 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
>  
>  extern int blk_register_queue(struct gendisk *disk);
>  extern void blk_unregister_queue(struct gendisk *disk);
> -blk_qc_t submit_bio_noacct(struct bio *bio);
> +void submit_bio_noacct(struct bio *bio);
>  
>  extern int blk_lld_busy(struct request_queue *q);
>  extern void blk_queue_split(struct bio **);
> @@ -568,7 +569,8 @@ blk_status_t errno_to_blk_status(int errno);
>  #define BLK_POLL_ONESHOT		(1 << 0)
>  /* do not sleep to wait for the expected completion time */
>  #define BLK_POLL_NOSLEEP		(1 << 1)
Minor comment: Could we also have a flag #define BLK_POLL_SPIN 0?
It can improve the readability from the caller side instead of having
just a 0 to indicate spinning.

Regards, 
Pankaj Raghav

