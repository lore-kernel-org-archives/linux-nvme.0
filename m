Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6287C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3rDmItwcDlvsLqXIWBqGF9Nz8nCax5NlHicaC1ur7s0=; b=s1LsNmQH1SxuNDC+a4OC1VBiKC
	/JrMg2yzNpw5zvImwG0+EY4lRvkWmIBNA8aFVP8qtbhfossorzBH9fmWg1DyKjA690d/7mk3iV8N4
	oyeVcOsFFhID5pbyp+7C5kbBRv9gYx0fOIPAw+AWqafo/qzSQGM+mALlMPeEJbuF3ki5x3ceqLLOu
	FPExez8JeVIWCI9dyQQbsjp2Dgdb3FEeCkljjuYZekV812i6IiVjfjVzsKrtsAhjxyPPDsvpIdwTY
	dg7ep+COiUyWM+R3ZFtt9uvVywGpA6Z5/N1oa11OT3avCl/SCV/IbNuNs31LgNKfVzf/BXKQQCndT
	FIrydK9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndrSH-008Psm-D7; Mon, 11 Apr 2022 10:39:33 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndrHJ-008KSY-Iw
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 10:28:15 +0000
Received: by mail-wr1-f45.google.com with SMTP id r13so22277611wrr.9
 for <linux-nvme@lists.infradead.org>; Mon, 11 Apr 2022 03:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3rDmItwcDlvsLqXIWBqGF9Nz8nCax5NlHicaC1ur7s0=;
 b=DkRmfpnbp3isGn9OhQRFZEPBKK/Fz/+q7rJqW3kBdYeNoXb5i+6Au36XY3wJ039Vls
 C8lg2bwPN/svciQmv7US0oWHOcdy+ss1sbzh7eqo/asZns2ONp8TSDYjsLbo/MfRjWj2
 U1j3CbbeI+fAqdfmU7Z2PPAmwZxkSvfdhcigOEajut5RVKoakGdTAEE+SspvEG9nzBjE
 nqzPUIUfA4W9kmavpHt8erUlS9yIipBG6nR5EC1+0wjKck9B/i0cW0JEjoP0wzE7Nx4O
 ipPIA8NDyUKgIGfeq2W2q6W/ne40JJwLRzkfvxJiur/jhI6EQALJCVLrU/vGE/djUHOl
 Q5xw==
X-Gm-Message-State: AOAM533FMgpZPbFSm9ANy6NtRNQDk97p4RaPLRUikXnBRMP41Lf5+XxZ
 JxBAQdxBYrGPgQYFMbK4HKY=
X-Google-Smtp-Source: ABdhPJzXOf4YNZBer85ylZxTXrgLWoypbmSOH2wrTfZeaT87RvEFDTswQiHyZnZTdNLqkT0TCutR3A==
X-Received: by 2002:a5d:6487:0:b0:205:7c2b:b6ba with SMTP id
 o7-20020a5d6487000000b002057c2bb6bamr23661199wri.283.1649672890486; 
 Mon, 11 Apr 2022 03:28:10 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 i19-20020a05600c355300b0038e1d69af52sm17613349wmq.7.2022.04.11.03.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 03:28:10 -0700 (PDT)
Message-ID: <cffab35a-59b1-b5b5-a0fc-075268593235@grimberg.me>
Date: Mon, 11 Apr 2022 13:28:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220411031249.5158-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_032813_693382_27365AC0 
X-CRM114-Status: GOOD (  15.76  )
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


> Mark internal passthru requests quiet in the submission path with
> RQF_QUIET flag added in the __nvme_submit_sync_cmd(). In the completion
> path, if nvme request is resulted in the error and request is marked
> RQF_QUIET then don't log the error with nvme_error_log().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 449378a96a9f..12302be83a6c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -370,7 +370,7 @@ static inline void nvme_end_req(struct request *req)
>   {
>   	blk_status_t status = nvme_error_status(nvme_req(req)->status);
>   
> -	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
> +	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
>   		nvme_log_error(req);
>   	nvme_end_req_zoned(req);
>   	nvme_trace_bio_complete(req);
> @@ -1100,6 +1100,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>   			goto out;
>   	}
>   
> +	req->rq_flags |= RQF_QUIET;
>   	ret = nvme_execute_rq(req, at_head);
>   	if (result && ret >= 0)
>   		*result = nvme_req(req)->result;

Other than what Christoph pointed out, which can be
added incrementally.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

