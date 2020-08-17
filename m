Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E1CC433E4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 19:29:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBABD204EC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 19:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y2Xgyd6w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbRXKrAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBABD204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BwaVEy5UCGjyVf1BNVp7tp2QMeC+bFcOxTXvpxutq24=; b=Y2Xgyd6w6tJoI8hTIqrvF2AWG
	gcISyd2tujESq3Xd6rlN3xcmaE4TIqTmsqqMPtl90k9UUVpmmmH0HHXBr9o0TkL1GtlqWikvnZe9p
	1gqBearBhgBZx1GJpdHYAo66ksQgFbTcvxPdX1Rlr25EmMb2OErYqlDo9khvtCYUezxGoP7rznwjY
	1SjK5ex6AvV9FmF/AawUmyuGK7EY5SAN/pR8AlCv73TuX9njS94amkBXqjVasU2QzYviTbzgPTXG3
	VtsarNT/7x1KmalNK3P1K6dUMNQYivGFHPDonbjK9QYlqJKzlXZP/iciXH7I188VOI2mkgrtAP8ZD
	MPlMIsHgQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7kog-0007Gs-96; Mon, 17 Aug 2020 19:29:10 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7kod-0007GG-D3
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 19:29:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597692546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/xv7y+seXOmSwF/sZm+kNzyU/jPRY9VlLWrQ825XAI=;
 b=QbRXKrAoNmVkkP+NgSe/gXHDJvIUFF1bHmZ1Q3xAuJwRUKYuBbaHXY+U7ivuI9tWj08NCA
 jwdjzgLef9Cs2iZLhBTAWV9yk48eUQEbvUG8l/5TzF+t73OhAamKmEX3QC5Wo9Kv+iSc3Z
 NilGgPO4W1QuGzXkdn+SAw4RrRA1gX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-nmpz_GHiNOK8mUZBD3RfEw-1; Mon, 17 Aug 2020 15:29:01 -0400
X-MC-Unique: nmpz_GHiNOK8mUZBD3RfEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E9C7801ADB;
 Mon, 17 Aug 2020 19:29:00 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1977E60BF3;
 Mon, 17 Aug 2020 19:29:00 +0000 (UTC)
Date: Mon, 17 Aug 2020 15:28:59 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] nvme: refactor command completion
Message-ID: <20200817192859.GA31161@redhat.com>
References: <20200817081544.837699-1-hch@lst.de>
 <20200817081544.837699-3-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20200817081544.837699-3-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_152907_486401_A615C333 
X-CRM114-Status: GOOD (  23.53  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17 2020 at  4:15am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Lift all the code to decide the dispostition of a completed command
> from nvme_complete_rq and nvme_failover_req into a new helper, which
> returns an emum of the potential actions.  nvme_complete_rq then
> just switches on those and calls the proper helper for the action.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c      | 76 ++++++++++++++++++++++-------------
>  drivers/nvme/host/multipath.c | 47 ++++++----------------
>  drivers/nvme/host/nvme.h      | 31 ++++++++++++--
>  3 files changed, 90 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 88cff309d8e4f0..8d474adad721fb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -241,17 +241,6 @@ static blk_status_t nvme_error_status(u16 status)
>  	}
>  }
>  
> -static inline bool nvme_req_needs_retry(struct request *req)
> -{
> -	if (blk_noretry_request(req))
> -		return false;
> -	if (nvme_req(req)->status & NVME_SC_DNR)
> -		return false;
> -	if (nvme_req(req)->retries >= nvme_max_retries)
> -		return false;
> -	return true;
> -}
> -
>  static void nvme_retry_req(struct request *req)
>  {
>  	struct nvme_ns *ns = req->q->queuedata;
> @@ -268,34 +257,67 @@ static void nvme_retry_req(struct request *req)
>  	blk_mq_delay_kick_requeue_list(req->q, delay);
>  }
>  
> -void nvme_complete_rq(struct request *req)
> +enum nvme_disposition {
> +	COMPLETE,
> +	RETRY,
> +	FAILOVER,
> +};
> +
> +static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>  {
> -	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> +	u16 status = nvme_req(req)->status & 0x7ff;
>  
> -	trace_nvme_complete_rq(req);
> +	if (likely(status == 0))
> +		return COMPLETE;
>  
> -	nvme_cleanup_cmd(req);
> +	if (blk_noretry_request(req) || (status & NVME_SC_DNR) ||
> +	    nvme_req(req)->retries >= nvme_max_retries)
> +		return COMPLETE;

Looking just a bit closer, the above DNR test seems wrong because of the
0x7ff mask applied.  That mask drops access to NVME_SC_DNR right?

Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
