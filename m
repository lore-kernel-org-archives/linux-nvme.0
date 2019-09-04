Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA92C3A5A8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:51:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CD621670
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AqtHmmv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CD621670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9dR8zRlnhU5Z67ejw7TXiCmLlWtTK+IlEayzYpTD+rA=; b=AqtHmmv5sLfr3F
	zyIi+2+6nVSwgKD/50rbVUHnSntXWpW/+RxMaiT1G4ov2xHQsIWPtt435TFdKbt87ytbx5XUihYQy
	/FwziztF0SyX20T2TzzzMq6pb7VMpq7AB6nCylIeFgA+n0Ln1kFQ4m3DQSwW7gcADaGGFmQGxJo8C
	1XRmSPgdSBYN4xmX+jGm8YaPvDktTewBmvAO/BKAOOV2zz62Rho4aL0byh2ZC/ro4DjFsxzZmBgmJ
	nc/KqYtK/K09ZgHqtFRn84ZUjO7P6/1SRhKkcfBpC6iB3iLGsCfj+t9A8vKU5qdK5B2qRDK2RRsFf
	kkMiilHNYst81HqxlFKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5ZRk-0000r7-0g; Wed, 04 Sep 2019 17:51:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5ZRa-0000el-Hb
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 17:51:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 97B6C227A81; Wed,  4 Sep 2019 19:51:42 +0200 (CEST)
Date: Wed, 4 Sep 2019 19:51:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v2 1/1] block: centralize PI remapping logic to the
 block layer
Message-ID: <20190904175142.GA21990@lst.de>
References: <1567614452-26251-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1567614452-26251-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_105146_741497_34B7C767 
X-CRM114-Status: GOOD (  12.01  )
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
Cc: axboe@kernel.dk, keith.busch@intel.com, sagi@grimberg.me,
 martin.petersen@oracle.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 shlomin@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 07:27:32PM +0300, Max Gurtovoy wrote:
> @@ -1405,6 +1406,11 @@ bool blk_update_request(struct request *req, blk_status_t error,
>  	if (!req->bio)
>  		return false;
>  
> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> +	    error == BLK_STS_OK)
> +		t10_pi_complete(req,
> +			nr_bytes >> blk_integrity_interval_shift(req->q));

I think it would be nicer to just pass nr_bytes to t10_pi_complete and 
do the calculation internally.  That keeps the caller a littler cleaner.

> -void t10_pi_prepare(struct request *rq, u8 protection_type)
> +void t10_pi_prepare(struct request *rq)
>  {
> +	u8 protection_type = rq->rq_disk->protection_type;

The protection_type variable is only used once, so we might as well
remove it.

> +void t10_pi_complete(struct request *rq, unsigned int intervals)
>  {
> +	u8 protection_type = rq->rq_disk->protection_type;

Same here.

> +static void nvme_set_disk_prot_type(struct nvme_ns *ns, struct gendisk *disk)
> +{
> +	switch (ns->pi_type) {
> +	case NVME_NS_DPS_PI_TYPE1:
> +		disk->protection_type = T10_PI_TYPE1_PROTECTION;
> +		break;
> +	case NVME_NS_DPS_PI_TYPE2:
> +		disk->protection_type = T10_PI_TYPE2_PROTECTION;
> +		break;
> +	case NVME_NS_DPS_PI_TYPE3:
> +		disk->protection_type = T10_PI_TYPE3_PROTECTION;
> +		break;
> +	default:
> +		disk->protection_type = T10_PI_TYPE0_PROTECTION;
> +		break;
> +	}
> +}

We just passed the value in direttly before, so I think we can keep
it that way.  In fact it might make sense to just remove the
NVME_NS_DPS_PI_TYPE* values entirely (in a separate patch).

But I think we should remove the pi_type field in struct nvme_ns here,
just like in sd.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
