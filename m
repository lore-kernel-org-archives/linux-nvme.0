Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD9DC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 03:43:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5397D224B1
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 03:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5397D224B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kjk1Jmy/CfjlgVWE1AieNRlem65oPsD2Zhv0C65Kzdk=; b=QXWbsdv9ixWIB7IrC0Zeboy6O
	79txbyOFEwcF4ydlLjiMg23AV837kaIEusI/eKqUqA/fANQ/ao9DfEoNRpMZ0z2BNMVHKtH8Fdn2s
	Pkcmu1rTpe81vhB2GZ1I3m38L35iA7YDvvPYsbRbb1DdpIMyso4IhoBXcbyVBiRgSHdR37SsblIVY
	I3yn0kagaa1UYcOEnZo1VgBZzMYZAR+FJl77siDfOh1AOhe3nOzgrIzJLj7EQ0nTHOK84y+P3rbKD
	eNeQx7tb8sIzr6DZsYS87Bwh/d8glDYnyu8eH1bGjlc0hvr9u9n2q4AOgtASepp6GcdhMPezKqYvs
	W0SU3PXDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1hvm-0000zs-2j; Tue, 19 Jan 2021 03:43:46 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1hvj-0000zZ-QX
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 03:43:44 +0000
Received: by mail-pj1-x1035.google.com with SMTP id u4so11236118pjn.4
 for <linux-nvme@lists.infradead.org>; Mon, 18 Jan 2021 19:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IHzxyDySMZvv/RJWQym/54UBbdibbKAwACAo+sNNNGY=;
 b=f/7A0iBkWrITiMoDDVqWcPDDQuBiRlMMqykDST+mU6KJr4mjtz8LMN+GjcJaU+wLXn
 SuAZJFgmqZQlR+HyWaZ8ksRuwuGXSxLFSnmaxGA0F7KEhaHLIjwLCWa7PFvaETX6+fhi
 U94ESKPFl6Bi+TcqKJfhhk3verGvXfsqnEFnwmtaWIREcoGWX1/RdL9QVrlEBCiOaCRk
 tuDWvfAXcpdwNlkyNQa6UP2ijzoyaPDwMZEUT+xpGtAOr018vBaymKVWSCseWQDSeC5D
 NHfR65tj0043kihRA/HTePkpArbGbVM2CJTayEuheuVR/8nYw6Mq54e33pSB2vcEikJ5
 8aRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IHzxyDySMZvv/RJWQym/54UBbdibbKAwACAo+sNNNGY=;
 b=o+JlrmaAsIJ8B8qbK9iVPlfojzgUCYoY+EYnEV/W1pofp8svNwYu7Af6scY/oAB6tL
 owRYr1HPx9D42vNvhauSx7AtJ/oQdb3mD/Bl9ELnALgBRGH2Z8Z5XgA8E1URlicd+qbP
 EselOjruxhnpfggZoCkdR2rOis1nIb634mQ5RZKb4NkD3wn6693kHiw4MAuaZoUoJYcG
 yDwSpO6R1mRysgzOyDwmf/cBVD9T1tJGOsfrlms7sEaBY75NxhuG54WwEyPBxWRW3uT3
 o5Xe64XbYUTVUrpkrCuMx1Z7cRSHD90aBJrMUaSOuIKdCCe6DN+VIRDd6WZs+7q4cRVc
 YCgA==
X-Gm-Message-State: AOAM530VRMiN1A7O2cc1G3J0sxH41E4+N7N1OBo3O0p8qQFl/GAzs8lL
 auFu6K/im3MzEVQV35kbg8Qg9v0CTQT/Mg==
X-Google-Smtp-Source: ABdhPJytIHqc09oT4WKs1nvoczr44Tdy8Xbpy6pvzcxkdZCkbYSdrG5bAEcTw1iq1L4g2EGEG/JdgA==
X-Received: by 2002:a17:90a:14e2:: with SMTP id
 k89mr2806587pja.168.1611027821498; 
 Mon, 18 Jan 2021 19:43:41 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id t4sm17110439pfe.212.2021.01.18.19.43.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Jan 2021 19:43:40 -0800 (PST)
Date: Tue, 19 Jan 2021 12:43:38 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: Re: [PATCH V3 1/3] nvme: check all retry delay times in Identify
 Controller
Message-ID: <20210119034338.GF5939@localhost.localdomain>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
 <20210114133110.20779-2-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210114133110.20779-2-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_224344_146091_70256479 
X-CRM114-Status: GOOD (  21.57  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-01-14 22:31:08, Minwoo Im wrote:
> If none of Command Retry Delay Time(CRDT)s are set, then we can simply
> skip to configure Advanced Command Retry Enable(ACRE).
> 
> CRDT selection will be made in Completion Queue Entry that controller
> has responsibility to decide.
> 
> This patch checks all CRDT[0, 1, and 2] in Identify Controller data
> structrure instead of checking the first one: CRDT[0] for cases that:
> 
> 	- CRDT[0] == 0, but CRDT[1 or 2] != 0
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fff49e544fdf..a8cee380b3c0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2499,7 +2499,7 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
>  	int ret;
>  
>  	/* Don't bother enabling the feature if retry delay is not reported */
> -	if (!ctrl->crdt[0])
> +	if (!ctrl->crdt[0] && !ctrl->crdt[1] && !ctrl->crdt[2])
>  		return 0;
>  
>  	host = kzalloc(sizeof(*host), GFP_KERNEL);
> -- 
> 2.17.1
> 

Hello Christoph, and Keith,

May I get your feedback on this?  Is there any background reason not to
configure ACRE without checking CRDT2[1] and CRDT3[2] ?

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
