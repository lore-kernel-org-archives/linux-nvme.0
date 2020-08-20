Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CACC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 20:54:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F1B20885
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 20:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EjdAB6M8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LjH34OXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F1B20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3itUja5COZTHEHnKDAw4Pc7sTsPFhT4RO3t2Y7Za/sw=; b=EjdAB6M8BvDrF0L9vRpCwqSPE
	nScMLiZHpyM+zA5bVO7PL669IozYLGrcbdqkU1dJHZiFet1jOvj6jgi1sX9yfb+iTTPF7F29b5UXH
	nsplFfDTYqv+jUNZJh6+xv1IrZjEBLQeQ1hvF3L3yHeMtaDQXzFvXMp4jrtlBPTCgAqmJqPRJJ0jz
	z/fUS2FlkidVxioy4pZ7GnB/5yM9H0gGyjYwJlc4q8lhXtIgbspgOfBqMuxdKO6K8gdxlT6PknwFE
	9I3OxxsXoZHbZ8aNqwAtQex+yaiBzx1wbfyaSq04uETs8fKYp9FHqWGX5H+YkiHB2ladkwaUIml6M
	/aVJXMOFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8rZs-0002UL-52; Thu, 20 Aug 2020 20:54:28 +0000
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8rZo-0002Tp-UC
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 20:54:25 +0000
Received: by mail-pj1-x1042.google.com with SMTP id ep8so1509819pjb.3
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 13:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=R0ISkUTa9OL5HT09V3AavNqSHjmLC+kaaccYWBVCoXE=;
 b=LjH34OXDm3SYoGtkR8CcWvqy/DicdUpujU1O+CT//l1gRKnTmjiPAXhewVfeNlW21+
 0wM5pnbYlGqw5iL7PVhQFb0De2+1iuM+6cK+HRlHiqlt9VThJLeGx45e5zEyvcthOSa4
 ULLbOgKx4Vf2wPaHOoXhqRfwF2JzSuS4LwAnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=R0ISkUTa9OL5HT09V3AavNqSHjmLC+kaaccYWBVCoXE=;
 b=On4aBIXdleqHsfLmcM02buFUmQB8SedXlReIFLnmxnSX5oZpNL7MfffN13YPp9lE3E
 flMuFxhd2PGv5pUJpC/uo25rlOPv9ifMa2R8DZB9AL2UV+hzWBQbFZk7q/Z4xU3yUbk3
 eVBQ8w+hXMcF2VgRKhTwuK4u79OTiPnCG8t/bF1ETsC6H6KLNCtUpzew/3dNkX2+A+zE
 xSlZUio6VNza+Qo/DSRXpCEVmNsQuiZNemHy8QYDxly/W1/RwMJwfcfYcrreysT1FE+8
 /+dydWM8odgO68k8ZILuisa75ODfsF8aWIG6BzJpLx+YB84YVRExhRuLurn4bv9HXX9i
 oxNw==
X-Gm-Message-State: AOAM533J2NQANo0EJeU+JxJfWkHpkYsQitvUVn2uO5T97dcwFKlmc/Dm
 Uq0uEE+WVrA3cH5WUY5E5hwleg==
X-Google-Smtp-Source: ABdhPJyhOXTW86aI2PqZadha1TkvCEel1mf+y+hvS2PLB1CL9i4aBVam4T4fYZ6Igj7x785A17ITvw==
X-Received: by 2002:a17:902:7689:: with SMTP id
 m9mr153058pll.240.1597956862882; 
 Thu, 20 Aug 2020 13:54:22 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id t2sm3634173pfb.123.2020.08.20.13.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 13:54:22 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <87703361-0f35-024a-ce28-94ed3f0a06d5@broadcom.com>
Date: Thu, 20 Aug 2020 13:54:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200820053651.197057-3-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_165425_076475_DD43A793 
X-CRM114-Status: GOOD (  26.48  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/19/2020 10:36 PM, Sagi Grimberg wrote:
> Right now we are failing requests based on the controller state (which
> is checked inline in nvmf_check_ready) however we should definitely
> accept requests if the queue is live.
>
> When entering controller reset, we transition the controller into
> NVME_CTRL_RESETTING, and then return BLK_STS_RESOURCE for non-mpath
> requests (have blk_noretry_request set).
>
> This is also the case for NVME_REQ_USER for the wrong reason. There
> shouldn't be any reason for us to reject this I/O in a controller reset.
> We do want to prevent passthru commands on the admin queue because we
> need the controller to fully initialize first before we let user passthru
> admin commands to be issued.
>
> In a non-mpath setup, this means that the requests will simply be
> requeued over and over forever not allowing the q_usage_counter to drop
> its final reference, causing controller reset to hang if running
> concurrently with heavy I/O.
>
> Fixes: 35897b920c8a ("nvme-fabrics: fix and refine state checks in __nvmf_check_ready")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 32f61fc5f4c5..8575724734e0 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -565,10 +565,14 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   	struct nvme_request *req = nvme_req(rq);
>   
>   	/*
> -	 * If we are in some state of setup or teardown only allow
> -	 * internally generated commands.
> +	 * currently we have a problem sending passthru commands
> +	 * on the admin_q if the controller is not LIVE because we can't
> +	 * make sure that they are going out after the admin connect,
> +	 * controller enable and/or other commands in the initialization
> +	 * sequence. until the controller will be LIVE, fail with
> +	 * BLK_STS_RESOURCE so that they will be rescheduled.
>   	 */
> -	if (!blk_rq_is_passthrough(rq) || (req->flags & NVME_REQ_USERCMD))
> +	if (rq->q == ctrl->admin_q && (req->flags & NVME_REQ_USERCMD))
>   		return false;
>   
>   	/*
> @@ -577,7 +581,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   	 */
>   	switch (ctrl->state) {
>   	case NVME_CTRL_CONNECTING:
> -		if (nvme_is_fabrics(req->cmd) &&
> +		if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
>   		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
>   			return true;
>   		break;

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
