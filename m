Return-Path: <SRS0=YEyo=W5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD2C3A59E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 15:14:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D4B217D7
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 15:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lBCdlhNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D4B217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+7DYilZc6LUbzDkHBvUgbM+OHo6qifuQLlygh88KcL8=; b=lBCdlhNW+ZKHP/
	+o9kMbhXvPMVb7YjH7M8XuZY2mc9nRzDBLtssYmuF7UH1/JQzpA9ukPtCQcDlKJP9WYkJDaANjIxD
	W/scTGU2rjCccnII4u9iLVSdyHkD7i2Gc8jEWWTvoCEHFvu9EIDv1FcWQDiuV2fN4Wp6BrGP/JTIF
	W5rofVf7CNvzGpjrVQddrWl9OV+PZ1hzLBUYS1fovALFyEYy9FLvlBJk2Unlq3KTNIiOxdqGDy09r
	f5EetlMWkUTd4MOSXX8Hh4LSaTMdPB69jows3Bv6VnuPvoPm4TLLVPn3XXHZezMMXtQEeh/j8/TKP
	NQ9Vb+lU025l8sy/I6PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4o2M-0000s3-9t; Mon, 02 Sep 2019 15:14:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4o2K-0000re-2T
 for linux-nvme@lists.infradead.org; Mon, 02 Sep 2019 15:14:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3833E68AFE; Mon,  2 Sep 2019 17:14:29 +0200 (CEST)
Date: Mon, 2 Sep 2019 17:14:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 2/3] nvmet-loop: use nvme_finish_cmd during complete
 callback
Message-ID: <20190902151429.GB5034@lst.de>
References: <1567436462-23218-1-git-send-email-maxg@mellanox.com>
 <1567436462-23218-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1567436462-23218-2-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190902_081432_258556_8E3A90FC 
X-CRM114-Status: UNSURE (   8.06  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, israelr@mellanox.com, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> @@ -157,8 +157,10 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		iod->sg_table.sgl = iod->first_sgl;
>  		if (sg_alloc_table_chained(&iod->sg_table,
>  				blk_rq_nr_phys_segments(req),
> -				iod->sg_table.sgl, SG_CHUNK_SIZE))
> +				iod->sg_table.sgl, SG_CHUNK_SIZE)) {
> +			nvme_cleanup_cmd(req);
>  			return BLK_STS_RESOURCE;
> +		}

Please submit this as a standalone backportable fix.

The other hunk should go into your v1 if we stick to the separate
functions.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
