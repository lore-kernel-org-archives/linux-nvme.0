Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF86C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 06:23:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B9B60FDA
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 06:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80B9B60FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jpc/vfEuS75jSv0qgv+aLAsUnNlmhdNkptUPYGIO6vo=; b=0BPrTHO2vu9Sda
	nlCyuXciHi6/c+UqSShlbPN0czJ0itgECHFANin8Dev5YLomxLHLltl4Ff2Rd+YQ88RuUH3uFPmD2
	3ZD06U+hq2qdIfoKQU644y6GawVK8kAYiWQC7QoXoid+rwzup5tpODUyjREQLt43eo34FYYN4Uj6R
	dcfMjuTH+u8GKdB9r/xCUQSVv+FSn9+Rb3GtuP/xHKhl3WvHvUtvmbJCWZvGLTKbPLEr5idZnbqyz
	3hSyVbMN0XWAHkKIHC9M+Yx0pLNqxtoQFewrT1UHJ2KOQFdyjPERHQjYCb3LngtB5OpAIKDqkKRLn
	TaIy7I6AviTqHcj2NPfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIPpn-001psZ-7p; Tue, 24 Aug 2021 06:22:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIPpl-001prt-NT
 for linux-nvme@bombadil.infradead.org; Tue, 24 Aug 2021 06:22:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NKFJoeYTqWpvwgOnvXGlWBRk4r7Ma5K7sZ2OJmDpXzU=; b=U7bi6QnCeU8LmhajLwuLPmnZlS
 LjSyGkqk3km9uYYmJ7D5A9FFyl8qVqyLW2dfuD8Ey8BE2oTJ7QhvGHnt6NVlXtwcw0N/4OKry2xhN
 ba3337soV7oOg168NKc9dJPzJA1GboxJ1Qg8fj/tc7TI9Qcy7teO73MZ+eDQn7lsnB2FMUEps7QP0
 KaNE4SkdKl+SeKbKHrIYiizI5JxTpPKmjNEV88s8nzhoGAiwvVk2/fA1iL0kMowDCe/U8zlI41FuG
 QyC+3ZjOnn4G15hGXUmlVCQ6nZQOKtHTa5N3QvBQ3yFlhFGWpoMdoW17uzS4YCcvcRY36HbpEwDJc
 85FfU+PQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mIPoQ-00AeEP-DQ; Tue, 24 Aug 2021 06:21:46 +0000
Date: Tue, 24 Aug 2021 07:21:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
 bvanassche@acm.org, ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] dm: add add_disk() error handling
Message-ID: <YSSP6ujNQttGN2sZ@infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-9-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210823202930.137278-9-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Mon, Aug 23, 2021 at 01:29:28PM -0700, Luis Chamberlain wrote:
> -	add_disk(md->disk);
> +	r = add_disk(md->disk);
> +	if (r)
> +		goto out_cleanup_disk;
>  
>  	r = dm_sysfs_init(md);
> -	if (r) {
> -		del_gendisk(md->disk);
> -		return r;
> -	}
> +	if (r)
> +		goto out_del_gendisk;
>  	md->type = type;
>  	return 0;
> +
> +out_cleanup_disk:
> +	blk_cleanup_disk(md->disk);
> +out_del_gendisk:
> +	del_gendisk(md->disk);
> +	return r;

I think the add_disk should just return r.  If you look at the
callers they eventualy end up in dm_table_destroy, which does
this cleanup.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
