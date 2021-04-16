Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EDCC433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 20:53:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF22D613CE
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 20:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF22D613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8NSSu5wXoSUMDU9J8PAIjpQ6QQotTCPzqqkR8Y0YCCA=; b=HubEwtb9L8ohqIbLixIhQKRuk
	JiQYYdJmpqGBgD09TW/Vvq5pph1g6izHnL95LgYXUSvRdUdoXU/Z57KsNj3Vs1kaq3b00kNH3ebI5
	5prmhf7QGkXVF29Acv4XvI7zdDEOau+qyv5i62PJDXUCefYnWDGipq2f+Pw+1oJ0cUkH0Z4oUHIHl
	47zFkMVA4iJuo1zYT1Cp+0gjyPofigDxfKP0KwiYN5z47GIM6n+DtIc3byeATPHxJOyZxEfx0tCw2
	rBU143rWWAV8NjOEvxBpGkA0IZi53SDH+IQJ6XiwOZB+QRSGbyw7fa8ziDyNsY/dmPl5i/gfPJ6SX
	kWnvZqV4w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXVSb-003Oql-1c; Fri, 16 Apr 2021 20:53:05 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXVSY-003OqZ-MM
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 20:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=QIz+7zTMpg5KYL5d7MD5C8AtmRz+4MZutLOb6AL1uNY=; b=P+x6NXC+PLHxxpT9RvN93Sx5r+
 Z2OTqDDWgzvReijzUMQAUdbaDo0XbwaLnqHoUwd+M+bD8HqTLM1gBphGdgHTpgFKA36CyTPOv+vg1
 6qTQBQnpgXghpnYCf78NgUCjruGPfXNUiI6wIMqz7uXQW9QVAx4VA0ncujM+H4zW4H9O2mCVphGjy
 1TUzg3ckERRNKtkTZ9yMdbFfzwMP9nQnE7lAkN231DpMR1z4lRRavpxOZ2VJq/qDRGbFBNiIB5ZF7
 gnlzNOTbNbXoteNQikFbPXu69bL1R844o++MS00jxUwbu1ad956mVl+Zp1RIclidAtgB3p5ZX9mVe
 FU1rL2zQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXVSU-009h2U-LU
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 20:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618606375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIz+7zTMpg5KYL5d7MD5C8AtmRz+4MZutLOb6AL1uNY=;
 b=cwYhk47Rbn22JBjHSLw+YJXYcRDnLEEdNUaPibNzHeRb9DOYl+HAJwF+Lqf9sukMPlmh+2
 A9v7LDqZL8ABT8ygW2Ng5mHb45znUMOFq8G2ZX9jI3mOuIG2C8sKHlN7UjrYt7wsBRZpdK
 AJA4gLEU0asJSELKyTbMGZX0uQ7PiVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-O2gbqR5mOBWpjC-tSQtMGw-1; Fri, 16 Apr 2021 16:52:38 -0400
X-MC-Unique: O2gbqR5mOBWpjC-tSQtMGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FED018397A6;
 Fri, 16 Apr 2021 20:52:37 +0000 (UTC)
Received: from ovpn-112-203.phx2.redhat.com (ovpn-112-203.phx2.redhat.com
 [10.3.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6963F5D9C6;
 Fri, 16 Apr 2021 20:52:31 +0000 (UTC)
Message-ID: <d679b46e86ee719deb87bd151f01563b2af223d3.camel@redhat.com>
Subject: Re: [PATCH v2 3/4] nvme: introduce FAILUP handling for
 REQ_FAILFAST_TRANSPORT
From: "Ewan D. Milne" <emilne@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>, Jens
 Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org
Date: Fri, 16 Apr 2021 16:52:31 -0400
In-Reply-To: <20210415231530.95464-4-snitzer@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-4-snitzer@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_135258_805859_FD11DAD0 
X-CRM114-Status: GOOD (  26.22  )
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

On Thu, 2021-04-15 at 19:15 -0400, Mike Snitzer wrote:
> If REQ_FAILFAST_TRANSPORT is set it means the driver should not retry
> IO that completed with transport errors. REQ_FAILFAST_TRANSPORT is
> set by multipathing software (e.g. dm-multipath) before it issues IO.
> 
> Update NVMe to allow failover of requests marked with either
> REQ_NVME_MPATH or REQ_FAILFAST_TRANSPORT. This allows such requests
> to be given a disposition of either FAILOVER or FAILUP respectively.
> FAILUP handling ensures a retryable error is returned up from NVMe.
> 
> Introduce nvme_failup_req() for use in nvme_complete_rq() if
> nvme_decide_disposition() returns FAILUP. nvme_failup_req() ensures
> the request is completed with a retryable IO error when appropriate.
> __nvme_end_req() was factored out for use by both nvme_end_req() and
> nvme_failup_req().
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4134cf3c7e48..10375197dd53 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -299,6 +299,7 @@ enum nvme_disposition {
>  	COMPLETE,
>  	RETRY,
>  	FAILOVER,
> +	FAILUP,
>  };
>  
>  static inline enum nvme_disposition nvme_decide_disposition(struct
> request *req)
> @@ -318,10 +319,11 @@ static inline enum nvme_disposition
> nvme_decide_disposition(struct request *req)
>  	    nvme_req(req)->retries >= nvme_max_retries)
>  		return COMPLETE;
>  
> -	if (req->cmd_flags & REQ_NVME_MPATH) {
> +	if (req->cmd_flags & (REQ_NVME_MPATH | REQ_FAILFAST_TRANSPORT))
> {
>  		if (nvme_is_path_error(nvme_req(req)->status) ||
>  		    blk_queue_dying(req->q))
> -			return FAILOVER;
> +			return (req->cmd_flags & REQ_NVME_MPATH) ?
> +				FAILOVER : FAILUP;
>  	} else {
>  		if (blk_queue_dying(req->q))
>  			return COMPLETE;
> @@ -330,10 +332,8 @@ static inline enum nvme_disposition
> nvme_decide_disposition(struct request *req)
>  	return RETRY;
>  }
>  
> -static inline void nvme_end_req(struct request *req)
> +static inline void __nvme_end_req(struct request *req, blk_status_t
> status)
>  {
> -	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> -
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>  	    req_op(req) == REQ_OP_ZONE_APPEND)
>  		req->__sector = nvme_lba_to_sect(req->q->queuedata,
> @@ -343,6 +343,24 @@ static inline void nvme_end_req(struct request
> *req)
>  	blk_mq_end_request(req, status);
>  }
>  
> +static inline void nvme_end_req(struct request *req)
> +{
> +	__nvme_end_req(req, nvme_error_status(nvme_req(req)->status));
> +}
> +
> +static void nvme_failup_req(struct request *req)
> +{
> +	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> +
> +	if (WARN_ON_ONCE(!blk_path_error(status))) {
> +		pr_debug("Request meant for failover but blk_status_t
> (errno=%d) was not retryable.\n",
> +			 blk_status_to_errno(status));
> +		status = BLK_STS_IOERR;
> +	}
> +
> +	__nvme_end_req(req, status);

It seems like adding __nvme_end_req() was unnecessary, since
nvme_end_req() just calls it and does nothing else?

-Ewan

> +}
> +
>  void nvme_complete_rq(struct request *req)
>  {
>  	trace_nvme_complete_rq(req);
> @@ -361,6 +379,9 @@ void nvme_complete_rq(struct request *req)
>  	case FAILOVER:
>  		nvme_failover_req(req);
>  		return;
> +	case FAILUP:
> +		nvme_failup_req(req);
> +		return;
>  	}
>  }
>  EXPORT_SYMBOL_GPL(nvme_complete_rq);


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
