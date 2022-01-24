Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583F5C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K0yqD06w/bpkDHJyyEQxu9jiwjKCuiuMzWiPe+dLKlc=; b=EIjfoyjHz7lQvCGBDQ1LEW8NSj
	OrRoh6LyFJDNjIC/Q9BzVL+4YMHrblaw/WznDRNI0Fs0dHRW8bmhiCWB9BwpVLGglNfpx1rQ1lklg
	vM63VG5f+mAdJhZeQo8CqyDH1xTxlOzkiTY0kEoY2Kbm69fmFbI4oYNAfzzWmSere4IpAmYHQ4Ml1
	q/+FtcHSgITgzBJjs1T+us8KtgPpo9kGjePjwmii+2uUy7BeIvWP737f0p3/nN3ZU/GFmfekw9PLj
	qImYxElETumxKSVVoHRA9zeXF/jkhlCL8kz2p+FzukKh8YOe5OvCGYBadI/QQhy9h1vq2hyJGAm1G
	fkEqfOmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nByzm-003Mf7-1d; Mon, 24 Jan 2022 13:02:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nByzj-003Mdh-6a
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 13:02:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2EF3868C4E; Mon, 24 Jan 2022 14:02:48 +0100 (CET)
Date: Mon, 24 Jan 2022 14:02:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 03/13] block: move blkcg initialization/destroy into
 disk allocation/release handler
Message-ID: <20220124130248.GC27269@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_050251_421566_22679CCD 
X-CRM114-Status: GOOD (  13.87  )
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

> @@ -1308,6 +1316,10 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
>  		goto out_destroy_part_tbl;
>  
> +	/* todo: move blkcg into gendisk */
> +	if (blkcg_init_queue(q))
> +		goto out_erase_part0;
> +

I don't think having this todo comment here is helpful (even if I agree
with the move and actually half old preliminary patches for that).

With this comment dropped:

Reviewed-by: Christoph Hellwig <hch@lst.de>

