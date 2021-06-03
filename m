Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9455DC47096
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 07:30:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6DE613D7
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 07:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6DE613D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7/tcVbSkqwbMiRHDJwuF9qaOKOdmyeuDxQWXRGyxCvw=; b=fhCPwiATccQPrl
	KgU/0/Duhd/3cDjNhpBvix/Q1YmrZVdobzE/bQRUHW4uzNQLsEnC7c4/Xdf/kE4ochWqT4ObOd7PY
	Asoo1nB0LZZpehvlCfCuTcWeJj+Dr5w9k72q1W1ke/39SXTxlGXSashK3B16f3taAn1KPlJ7dn7Sy
	K+JiNAoM5naNt+v2fgcNlpWmyb/OL4pGPjNfhcKEFfrvwcXdWouU7ZopL01G8UIaEDTKAcUKRgWD2
	qqSkWxXWClV15A4bw/HW/NUd8LMd2tATQsgcGiHLon82x/A0A/kUYyJASp6A1KvbTHKwH7i3BAP1p
	OaXZyNRXrO9PqA1RjSiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lohnk-007WMa-UG; Thu, 03 Jun 2021 07:30:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lohjY-007UX6-BQ
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 07:25:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9E9B96736F; Thu,  3 Jun 2021 09:25:37 +0200 (CEST)
Date: Thu, 3 Jun 2021 09:25:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: reset disk to the mpath node also when requeuing
Message-ID: <20210603072537.GA4718@lst.de>
References: <20210602130039.122879-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210602130039.122879-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_002540_595827_C39235A8 
X-CRM114-Status: GOOD (  16.31  )
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

On Wed, Jun 02, 2021 at 03:00:39PM +0200, Daniel Wagner wrote:
> +	struct bio *b;
>  	blk_qc_t ret = BLK_QC_T_NONE;
>  	int srcu_idx;
>  
> @@ -324,6 +325,8 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>  		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
>  
>  		spin_lock_irq(&head->requeue_lock);
> +		for (b = bio; b; b = b->bi_next)
> +			bio_set_dev(b, head->disk->part0);
>  		bio_list_add(&head->requeue_list, bio);
>  		spin_unlock_irq(&head->requeue_lock);
>  	} else {

I can't see why we'd need this hunk.  bio->bi_bdev should have never been
changed to start with in this path.

> @@ -435,11 +438,6 @@ static void nvme_requeue_work(struct work_struct *work)
>  		next = bio->bi_next;
>  		bio->bi_next = NULL;
>  
> -		/*
> -		 * Reset disk to the mpath node and resubmit to select a new
> -		 * path.
> -		 */
> -		bio_set_dev(bio, head->disk->part0);
>  		submit_bio_noacct(bio);
>  	}

This hunk looks fine.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
