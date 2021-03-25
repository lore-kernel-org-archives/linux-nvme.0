Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CB9C433E3
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 15:20:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA1461A16
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 15:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA1461A16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nFgti6jcT3kMR8EXqY/vxZLDQEk+x2hZg+4EVfUKonE=; b=S8t9m9Q3Etod1fA0IEhA+oA3X
	uNcJ81cxFUEZa4CbU46/f/5L0fZAneOfy7E+PCdaUgF9pCvPcMcKOMmt6xIfZ1FB09OeHemBeQXbS
	YKEy8ikLSXj8ZWrvlYCCt0cJWFjYdz8evW68xzXb1vWMc5n3b8uudvhf3Z3OhcvLXDFgw2m/pB8+P
	n4kNklV5pGNmvEOmMpEOAP+pn7H8PfzdPUW+BQ7mK2B9dVuTu8oCyQ37bLqB+F/RLGyqBvdZ5M9Ok
	dkTQIKVr76U8Zu3UNrzwkqo9tc07xp+Ufn8sL4O4dMlNH1dxY0Xr7V6HjcE8ziWF0jOwyC+phkEL+
	iQ9EmSgfA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPRm3-001hwm-M7; Thu, 25 Mar 2021 15:19:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPRly-001hwD-RR
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 15:19:49 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7290161A16;
 Thu, 25 Mar 2021 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616685585;
 bh=C89LYBVzHXj0ropGKfj0qYFMFjm9LdWvKvOD6cMztAo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PKc5586jOuNATzAX/9ftFJB06Wmo5bJO0mE+i6SfIf8g99Pf+shEs/DOs8Xselyto
 Wzmo3APVwIq+YBG6oT9bI7N58xT30r8JppKhQjXA5S5gh6DCv9/HBD7tdQpBix9Sns
 EFEkNeiHvKurvB87qf9U5kYDt5UcZysIkqeFMjr7AS5TmULk+wN51dGPOn3Qh/tu1p
 IWqjX5cAFK1H2hRHGXSMD6mvHLlSY3VSsKWgLt/sLrJqhS9mPPLmNrkuU53cKmHfQw
 FlNXXLCfBNb76soJAqCaK7cTpotTatPwTXFyP/WTtU7gsR+P5EfwF5XCjl9S2Anbwz
 ngYA34C050dIQ==
Date: Fri, 26 Mar 2021 00:19:42 +0900
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: disallow passthru cmd from targeting a nsid !=
 nsid of the block dev
Message-ID: <20210325151942.GB31394@redsun51.ssa.fujisawa.hgst.com>
References: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_151947_614574_A3A682A2 
X-CRM114-Status: GOOD (  25.05  )
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

On Thu, Mar 25, 2021 at 09:48:37AM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> When a passthru command targets a specific namespace, the ns parameter to
> nvme_user_cmd()/nvme_user_cmd64() is set. However, there is currently no
> validation that the nsid specified in the passthru command targets the
> namespace/nsid represented by the block device that the ioctl was
> performed on.
> 
> Add a check that validates that the nsid in the passthru command matches
> that of the supplied namespace.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Currently, if doing NVME_IOCTL_IO_CMD on the controller char device,
> if and only if there is a single namespace in the ctrl->namespaces list,
> nvme_dev_user_cmd() will call nvme_user_cmd() with ns parameter set.
> While it might be good that we validate the nsid even in this case,
> perhaps we want to allow a nsid value in the passthru command to be
> 0x0 and/or the NSID broadcast value? (Only when NVME_IOCTL_IO_CMD was
> done on the controller char device though.)

There are no IO commands accepting a 0 NSID, so rejecting those from the
driver should be okay.

FLUSH is the only IO command that takes a broadcast NSID. I suspect at
least some entities were unfortunately sending broadcast flush through
this interface, so it's possible we'll hear of breakage, but I'd agree
your patch is still the right thing to do.

>  drivers/nvme/host/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40215a0246e4..e4591a4c68a8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1632,6 +1632,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  		return -EFAULT;
>  	if (cmd.flags)
>  		return -EINVAL;
> +	if (ns && cmd.nsid != ns->head->ns_id)
> +		return -EINVAL;
>  
>  	memset(&c, 0, sizeof(c));
>  	c.common.opcode = cmd.opcode;
> @@ -1676,6 +1678,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  		return -EFAULT;
>  	if (cmd.flags)
>  		return -EINVAL;
> +	if (ns && cmd.nsid != ns->head->ns_id)
> +		return -EINVAL;
>  
>  	memset(&c, 0, sizeof(c));
>  	c.common.opcode = cmd.opcode;
> -- 
> 2.30.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
