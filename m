Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874A7C4321E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wU/91PBSh5tJSvo82xfCRdEad6nZOm6USh6XW3ETiHM=; b=Wf8dBIifYKghiFbE5INCbdQ1dk
	AYQZMHBtaCukLl9ziXxhPWU929CDFL2iekuokhRBjJvZ0qonWWdHHXitV3reBf063nPdDC+iO4Uei
	dC26uLReIFilNTcahV+rKFX/2clVo9qXHQiAoyxYRcrbTx+6aHRZzAk6D3EWFOxvApWIKyPBzdn9C
	kaH4pTPtSdbJK0NoIlSHP3eHcC7cZ8nfDHpx/l/e2H/rOC+B15KGaXYM0rnXE9pjMml973kUNbe+T
	W9xVtNnq6GbVxtR5dZWynWQOFyeSPsgxcJkbgIlHOZOT/cF28z2/1SSscOiMGQ2/CeKnbb3NdL+8s
	BcmaOR8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p18bm-00HMWR-Tb; Fri, 02 Dec 2022 16:09:50 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p18aD-00HLBR-43
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 16:08:25 +0000
Received: by mail-pj1-x102b.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso6563418pjb.1
        for <linux-nvme@lists.infradead.org>; Fri, 02 Dec 2022 08:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wU/91PBSh5tJSvo82xfCRdEad6nZOm6USh6XW3ETiHM=;
        b=BqYEdFpuicG2AHdxDQ6Niy+kPCE+VwBPODI4qec11rQ/ybBTa+kuZGvEx7EEC86jGj
         wf3DClyK8OlcS5Z6h0GbBGNma95dNY1n34rSSlJlETnqOSh7lqrzFxtA33gtwAi+gziD
         odOSiSYHRdh4bYNKoos+Nna9EY6soO5g/vTHb7oCKmQJp6Mp9LXNjrF2tQ+/9f6xSnpU
         edpYVmRAkzZZDXMeAxngK1Gy8scvXzjJ06b7eWnD5YBU9TRHowP/9aNfahFP/MlzEEdw
         SiiuvBoAJbxHnyHjxm75AlCQOnMhVb5n0U7UFCUAZU4pxQmkkU4dh7iblP3loYuxQGTt
         z4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wU/91PBSh5tJSvo82xfCRdEad6nZOm6USh6XW3ETiHM=;
        b=MvJtNpwpNgVVhij8+nXONnxHauwkEGoJkvoWRkb40SDOXwv0oYnaVsrqRIboPs5iQ5
         7sb0vzCMapfp4A7rvnTwR5syBr5wdHEYbcP0bM2MCaykvmCDjggWyMH0yUfB3zDnCNVU
         3b208B2iPzTUvhHCQJAQVRoUMVVr6tpjqn0OkVXedtL8y98a0TSvPgelZkphEPl5HybO
         Ns8hRccZVMkgcVRR270IhXNSdXRbp82DRg+G6mp+WwqN1ba2BqgKwB0C/E79pH4on33J
         OskwqYp0co6JtpCEEfGevIT/ua7eKI/vy2G5cFb2t9PSPfVLAwk/1x2xq24l69AnON+X
         EG0w==
X-Gm-Message-State: ANoB5pkM1cQ641V3gVZRjf3wuIJQCQ+m8rox4/sISQ/nvRl1mJh/Qr8n
	GCsRl/mTZbzlLATSDD2RvYg=
X-Google-Smtp-Source: AA0mqf7h/SK6m/lkcUI1KSVCrquOH6UNTxUUTto4Rco9OeRV0J/oS63bQUpWqM7eN3+OdcmOlNLIkA==
X-Received: by 2002:a17:90b:3c0a:b0:212:510b:5851 with SMTP id pb10-20020a17090b3c0a00b00212510b5851mr74634077pjb.57.1669997270586;
        Fri, 02 Dec 2022 08:07:50 -0800 (PST)
Received: from [192.168.50.208] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id l1-20020a655601000000b00460a5c6304dsm4211508pgs.67.2022.12.02.08.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:07:49 -0800 (PST)
Message-ID: <bff08204-0cc1-4da1-a520-339831228042@gmail.com>
Date: Fri, 2 Dec 2022 08:07:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] nvme-fc: avoid null pointer dereference
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20221130213341.9625-1-kch@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20221130213341.9625-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_080813_336942_5381FC49 
X-CRM114-Status: GOOD (  13.60  )
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

On 11/30/2022 1:33 PM, Chaitanya Kulkarni wrote:
> Before using dynamically allcoated variable lsop in the
> nvme_fc_rcv_ls_req(), add a check for NULL and error out early.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/fc.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 489f5e797204..06bae7150087 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1754,9 +1754,18 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
>   	}
>   
>   	lsop = kzalloc(sizeof(*lsop), GFP_KERNEL);
> +	if (!lsop) {
> +		dev_info(lport->dev,
> +			"RCV %s LS failed: No memory\n",
> +			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
> +				nvmefc_ls_names[w0->ls_cmd] : "");
> +		ret = -ENOMEM;
> +		goto out_put;
> +	}
> +
>   	lsop->rqstbuf = kzalloc(sizeof(*lsop->rqstbuf), GFP_KERNEL);
>   	lsop->rspbuf = kzalloc(sizeof(*lsop->rspbuf), GFP_KERNEL);
> -	if (!lsop || !lsop->rqstbuf || !lsop->rspbuf) {
> +	if (!lsop->rqstbuf || !lsop->rspbuf) {
>   		dev_info(lport->dev,
>   			"RCV %s LS failed: No memory\n",
>   			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?

Looks good

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


