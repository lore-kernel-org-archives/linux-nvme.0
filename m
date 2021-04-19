Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9569BC43460
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7F9611CE
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7F9611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EfixJXQl1cjuQXHvj0RyPQ532jvBnFQ7X2bBxusV4oA=; b=OM3tj0AJiiJe4/Ep3hsQZ7kmE
	z0xsxKwHby/FE/6R/H2oFJ8sUxqvCk7GiTvKq6HUdgemHBaY2yQUD8cU5KEmnaPo4kR2NnRLzb3eY
	pdhApOTFvetkVtuHU+rv1fNQgUI8LLYmMgLwv5QymDexrjuuPuyZv11DmMr+VfIJdwYhok8bXvSot
	qf29mRY7xjhPJsgPUeVD97wQAOiWKc3xSXCvKRVU1zyS3TE8ICY5swvUGlDd3pyI3QEtEtCms/Ir4
	dDmZXpnXGGAEyn2jRhrHB6FcWiKf+74JKs9YccJP1McaDFbn3LMHv4tqdWyl7bJMHCbFqdfhclHBn
	uCCmccodQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYVdL-00AAgI-0t; Mon, 19 Apr 2021 15:16:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYVdH-00AAfp-Gh
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 15:16:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=45GPU1la+v3UxuDEwFXSk9++ywt+nKtWOgIU5KOM4LA=; b=Rdl2ITb1Hdij85musSUd3FdtFs
 unjpFA7cjeC+JZevSaYeEAdrH1rfoDbid3ImDwXfXnkAZ4+zfVzQtJ+wwkQZ/YCJB2s1B+WCWSvye
 PmkhFW+J01HPg05ZkXwbCMYE+CncXsHZUyv3yQd0qNlqLFRjYLV9/Az4oSTmiL78vOdHYwjptZR+b
 9Ik+9fma2jYvrkLDA7PrWbMXM0s4YqYMbSJF6WG1nNEx5MQaUNS2j2/Ko0ytWYMmHTsb7lqq8yVFl
 EgyZYLYxZbxJ2pjelquv9nOhrafZ5UJKOAc3SM1SHIS+78+S6kduttScZ+DiB29eaoAcdgoHdOiuR
 xOPvtr1Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYVdE-00BTqn-TO
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 15:16:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F00936113C;
 Mon, 19 Apr 2021 15:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618845372;
 bh=GGjLvKWlST70ow/V6OAjUhmYlOAJo2gdwxMCBz6NUVM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SLlo1cPQ929agaebchZaQhLJjBC85j5N4oo6VMs9WVJjX2vqgnr51EAU/RxyPjhZ8
 tIYK7RFLOyUxeOg+T5nrpG/CuM04/Ub8qTeuuYjTlgoF8MXslHReYze3f7NSrX0NeU
 h32GChRQ9IBP8UvoeOGhvHDBDzT+GJWLn8wtqlBvAKnGwG3mpyIYJVskaiUUYY7Ofj
 fhUuIx5xfDWqTHWIGDC9sUw3e7wyDJoo9HEdTRuiDUgdQCoMTsBxmyPbog27q3GSf+
 EI1xAX5jNJXMlaZ6aZ8CJ1X0PtcH4t0sW0SjjP1guvqcTwYmZTmppegBTFa8AYB+rA
 45UoTdICUgejQ==
Date: Tue, 20 Apr 2021 00:16:09 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Peng Liu <liupeng17@lenovo.com>
Subject: Re: [PATCH] nvme: do not try to reconfigure APST when the controller
 is not live
Message-ID: <20210419151609.GA13015@redsun51.ssa.fujisawa.hgst.com>
References: <20210409094905.1920747-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210409094905.1920747-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_081612_993182_AB4355FF 
X-CRM114-Status: GOOD (  19.40  )
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

On Fri, Apr 09, 2021 at 11:49:05AM +0200, Christoph Hellwig wrote:
> Do not call nvme_configure_apst when the controller is not live, given
> that nvme_configure_apst will fail due the lack of an admin queue when
> the controller is being torn down and nvme_set_latency_tolerance is
> called from dev_pm_qos_hide_latency_tolerance.
> 
> Fixes: 510a405d945b("nvme: fix memory leak for power latency tolerance")
> Reported-by: Peng Liu <liupeng17@lenovo.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> ---
>  drivers/nvme/host/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 63a1e6cc27acab..f3c7b1cb2c7c8c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2740,7 +2740,8 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
>  
>  	if (ctrl->ps_max_latency_us != latency) {
>  		ctrl->ps_max_latency_us = latency;
> -		nvme_configure_apst(ctrl);
> +		if (ctrl->state == NVME_CTRL_LIVE)
> +			nvme_configure_apst(ctrl);
>  	}
>  }
>  
> -- 
> 2.30.1
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
