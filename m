Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054CEC00A89
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 07:31:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAE7206A4
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 07:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M7UItl9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAE7206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C0VAUudHEXKGfDJ6QZ3bpboBJ1d+9iWxCPnWYmcLN0I=; b=M7UItl9BTuk/J9LNZ5GA8IoQp
	17BzqGy4JZQdSM3tjakkFHjP28Nj9ldDlehlP1DKqtpv7nQ5TjI9d+F3aRIkZncYaFct3LygueAQ0
	lGMjSGXWrOk6udwtjV8VG3p6EIVecQAWyrQb4j/Io29rJv44k3D6wlF+qQjBhfdwXcc3M1y526I5h
	MYjTkTV76e4BqHIz6sQzDfVKDwiUmraslHyMrVM96zub4rmtyOoWZaivfmIw2n5UH0uxaRHnVLuMV
	4Ai8kCJz0jV7pzLLnVvBDAtFdiND/eUxjWOr0EvpVdM6L632LhCJvH/e2FUEg59hEIOl5DGh2cH/t
	N/Fg402HQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaZjq-0003d5-L9; Thu, 05 Nov 2020 07:31:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaZjo-0003cM-Hn
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 07:31:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2606F68B05; Thu,  5 Nov 2020 08:31:14 +0100 (CET)
Date: Thu, 5 Nov 2020 08:31:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V6 1/5] nvme: centralize setting req timeout
Message-ID: <20201105073113.GB4540@lst.de>
References: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
 <20201104203736.62745-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201104203736.62745-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_023116_756978_E2D7BBFA 
X-CRM114-Status: GOOD (  14.54  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 04, 2020 at 12:37:32PM -0800, Chaitanya Kulkarni wrote:
>  
> +static inline void nvme_req_set_default_timeout(struct request *req)
> +{
> +	if (req->q->queuedata)
> +		req->timeout = NVME_IO_TIMEOUT;
> +	else /* no queuedata implies admin queue */
> +		req->timeout = ADMIN_TIMEOUT;
> +}

This just has a single caller now, so I think we can open code it.

> +
>  struct request *nvme_alloc_request(struct request_queue *q,
> -		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
> +		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid,
> +		unsigned int timeout)
>  {
>  	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
>  	struct request *req;
> @@ -533,6 +542,11 @@ struct request *nvme_alloc_request(struct request_queue *q,
>  	if (IS_ERR(req))
>  		return req;
>  
> +	if (timeout)
> +		req->timeout = timeout;
> +	else
> +		nvme_req_set_default_timeout(req);

No need to pass the timeout argument here.  The callers that care
can set it in the caller instead of adding another parameter.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
