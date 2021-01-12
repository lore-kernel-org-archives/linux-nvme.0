Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5309AC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 07:34:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D7122CA2
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 07:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D7122CA2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S35X1YFnfDn3BXAQcHOmwc/+hOHL1sEDiGSRq+q7k2s=; b=sy4nsYPTpRFuRzcccVhyxWKg6
	5rcoxGXnT8WqfWt8x23m5AQ1485VNUoQyUTMW/ckOfGlL2eGvbTKPbZgDpVK8BuiB0CR8qzyRFvn6
	lxlbqYB37g6lSF0Dd7vmRvkUmY9Wnj5BTazDo3URyEWicKrBRFLrQUu/nozv9cYFKxibnNe0Hf7Kp
	WNzwdsvm6u1oUPNraduO9DzqkZu8hTBM0HYWHzw+cgALKjAdf7Idqb6yOItS4C5Mvhu1+TfTnBSoL
	vxEn7SzLJsG7nUfHVaMX6QWMTD1JlLRbESDjHrdDKKKNvPDbNSAf+HnkV0BtYjyY9bJeCYTnfcRsd
	Q/paVyvBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzEBm-00029M-RL; Tue, 12 Jan 2021 07:34:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzEBk-00028B-63
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 07:34:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A891767373; Tue, 12 Jan 2021 08:33:58 +0100 (CET)
Date: Tue, 12 Jan 2021 08:33:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Message-ID: <20210112073358.GB24288@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_023400_351684_5577D395 
X-CRM114-Status: UNSURE (   7.63  )
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
Cc: linux-block@vger.kernel.org, damien.lemoal@wdc.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +static inline void nvmet_bio_init(struct bio *bio, struct block_device *bdev,
> +				  unsigned int op, sector_t sect, void *private,
> +				  bio_end_io_t *bi_end_io)
> +{
> +	bio_set_dev(bio, bdev);
> +	bio->bi_opf = op;
> +	bio->bi_iter.bi_sector = sect;
> +	bio->bi_private = private;
> +	bio->bi_end_io = bi_end_io;
> +}

Nothing NVMe specific about this.  The helper also doesn't relaly contain
any logic either.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
