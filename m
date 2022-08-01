Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47733C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W8rN2mblzq1ASEvlL21ayeCCG+Js+B4ZmZmZrGJYJsI=; b=FCHcAHl1nJiOg0s49WdR8SI58U
	P4CJLsQxNSeseSVjL94CzUTTAHgPl46bDUzQycG/LrfWCsKubpsB16Yz3S30Sgg+Q9reD5TNnJEHE
	WBYtTpUHaL2IrUrP2iEFC+zbYdMFxxINmrPddcAMWM0wJRNF6puynScK7UOax1AmIlMJEZjk0Oy5d
	6t646aPEyaxkru3j/G5B+YgbCEroQXmP8jDQZzimy0LQkiVMBgZcrtFQJj7TDwarNGwW+wXgby6S7
	5tjKT4YTWyEsYE2iEGiecJoIMrmFjWeFtOyXXLXQ8qI5i7W2SW4OOfIM5TQOBv3thsAbOAosefc4E
	/1WjlJxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIa5d-008tt3-E7; Mon, 01 Aug 2022 18:24:29 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIa5Y-008tm4-JT
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 18:24:27 +0000
Received: by mail-pl1-x633.google.com with SMTP id d16so3126905pll.11
        for <linux-nvme@lists.infradead.org>; Mon, 01 Aug 2022 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W8rN2mblzq1ASEvlL21ayeCCG+Js+B4ZmZmZrGJYJsI=;
        b=YA/c+ee9rJLOLvJiAt3iPm4a0PRLq+uilww6kiFaW/3IjrUV10QGDsiaLlp2wPfTR2
         CqDZmy7KBGmKvvZ8OB0Co344XLGCr+FT2H/2wPDAqioa7Kc73JW90+Zju45c0XOch/yD
         hpFMEOVQ0gvvu3eWdz+lOoB2HA4hroW+jxBPfeiSWI5LuU1XffxmglZ1jYexXxPJ2sqU
         LhYwiQpHA07jeoEvSWho+voqiHSTretlN3555K+EtaoauceitOFL+b+wryfj65WCoyWC
         cMDVNmDarYZKCsTIULtVQJSijNzmzsjQvpDHQsMK6Y5/VUBUk6pyebbn+8myMuUH82Mz
         ZQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W8rN2mblzq1ASEvlL21ayeCCG+Js+B4ZmZmZrGJYJsI=;
        b=7putssAEtZ/+ULQg/mhkTTJ6RuZVBO0z0TKUNk18c+Wl0G8UtkBq/Edh8IxEPaTjHa
         9Csw41liV/Db507EeSkdj0vIbsiZ4oqdrBlPPn3Y5d25B7iAkC1D9LhYY1InozcNfvXE
         AvEIT8QLDJcxxb6mHpObUw3HlE5KpgmywOFI4LHATBu73bTdR/4cksFWOG+x+yibjREj
         UTrLy2hiICZXbbkD18+0kmCL5O6ZNEO/IMApmLRfSguLgU2XXLpY99kkFWC2KAwXEjdY
         B7ftXrVCGF6ipYN6hf7LBL0K30b+osmnw1OlmnVcrg3NOt8A6sKdb0hbfsnrVVAAk/nq
         CoRA==
X-Gm-Message-State: ACgBeo1OumBV0mERgbD5whTDYoENXgvXFfMsWolCb58T7/8WMU7Mu5hV
	/9Fu7TGv7rz0GJdFZeSEzrCXgw==
X-Google-Smtp-Source: AA6agR7oQ+MahiBHH1gDEgJkPVRLBTheZdi1HG724XZGw5AL1HQkiqlEFM2H0krA+YtQLw+1JwE2Ww==
X-Received: by 2002:a17:90b:4f8d:b0:1f5:835:1b19 with SMTP id qe13-20020a17090b4f8d00b001f508351b19mr5035973pjb.63.1659378261711;
        Mon, 01 Aug 2022 11:24:21 -0700 (PDT)
Received: from google.com ([2620:15c:211:202:8c46:3487:778c:aadb])
        by smtp.gmail.com with ESMTPSA id z21-20020a630a55000000b00419ab8f8d2csm7729868pgk.20.2022.08.01.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:24:21 -0700 (PDT)
Date: Mon, 1 Aug 2022 11:24:14 -0700
From: Justin Stitt <justinstitt@google.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux@roeck-us.net, hare@suse.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvmet: fix a format specifier in
 nvmet_auth_ctrl_exponential
Message-ID: <YugaTrnLCRD9NIhk@google.com>
References: <20220718050356.227647-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718050356.227647-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_112426_091349_CEEDF926 
X-CRM114-Status: GOOD (  19.16  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 18, 2022 at 07:03:56AM +0200, Christoph Hellwig wrote:
> dh_keysize is a size_t, use the proper format specifier for printing it.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/target/auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index b41c7bbcc4366..cf690df347758 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -488,7 +488,7 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
>  		return -ENOKEY;
>  	}
>  	if (buf_size != ctrl->dh_keysize) {
> -		pr_warn("ctrl %d DH public key size mismatch, need %lu is %d\n",
> +		pr_warn("ctrl %d DH public key size mismatch, need %zu is %d\n",
>  			ctrl->cntlid, ctrl->dh_keysize, buf_size);
>  		ret = -EINVAL;
>  	} else {
> -- 
> 2.30.2
> 
> 
> 
Disregard my previous reply as this has already been picked up:
https://lore.kernel.org/all/YuFhR9OoPvM9VsdT@infradead.org/

