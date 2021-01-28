Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B35AC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:17:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AB164DD6
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AB164DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G1RnpDyLXT65X+J+2elMRtWHt8SogXhd1AoY44mVw28=; b=p0Lal+VVb9RG52CTbf+w69QIY
	Z5dEBXgnmH76ScVlobiu07kli2HelcvGjlqXfboZ6d+CP/PqLQPg1W551EbkxOeFT56Sll0eQkkll
	iN4BC9SgL+YaGDfkRJOnp9zgaVHqAwOwun7rcp0EQh+Y536JtRMw7LeTfqTSkvAJCwYka29LNLC1g
	SrJ3ahX4GqqOMh15vv73KWKBCKHq4LBs7TVl3Vh6H4sN8fUoL4wN1Go4v20X9bxXObdVurJXFFdOy
	/AUa62zWEjAkv0S7hTNz2bOcyjE6y24lrNnJw8+2CpXjF4tRIZDfq/w2Q3MUdScy4Iu8d4TDDg9aL
	iBGmFlj9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l53Qj-0008V2-IN; Thu, 28 Jan 2021 09:17:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l53Qh-0008UR-Ci
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 09:17:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 480C468B02; Thu, 28 Jan 2021 10:17:27 +0100 (CET)
Date: Thu, 28 Jan 2021 10:17:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v4 3/8] nullb: use blk_queue_set_zoned() to setup zoned
 devices
Message-ID: <20210128091727.GB1959@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
 <20210128044733.503606-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210128044733.503606-4-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_041731_549315_5EE23D4F 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@wdc.com>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 01:47:28PM +0900, Damien Le Moal wrote:
> Use blk_queue_set_zoned() to set a nullb device zone model instead of
> directly assigning the device queue zoned limit. This initialization of
> the devicve zoned model as well as the setup of the queue flag
> QUEUE_FLAG_ZONE_RESETALL and of the device queue elevator feature are
> moved from null_init_zoned_dev() to null_register_zoned_dev() so that
> the initialization of the queue limits is done when the gendisk of the
> nullb device is available.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
