Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE07BC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 02:49:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D14610FB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 02:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D14610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VmZUhu6ZYFaPPo/l6DkTeqMtv5tRbE8BcDfO+Ecbhlg=; b=d524+s1zE46ksZ2K62nyJYleo
	tio3RLIpoAIuW/zJqoxPuLa5gABekuOB3cZ45A5UyrmXbC4V5rCNwCLUGFNRgFfxcIcQOnaGt9i6J
	uVoJTAfsyiOkkF4hEe5y6P7h3Qe3sn3Qeu+BUcR/TjuPwrlZ8nDVCdqoOkti91jl5WcxaVPR1uMiW
	C48wAGqJqdJ51RfvIs9edal2q4u6NdPhbLoOrktSKKd8bPKOHbK4l93hlyuvSkbBAjhaNtlxT4DjH
	cdtziN8mSOwh1cbvPSz3dA0AXeaJXWCJSo2YG5QJXq251TkmlECElBR/G43+ZrNY8Y3wQRjR4Jlml
	ZhO61welQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXEXQ-000XZl-BG; Fri, 16 Apr 2021 02:48:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEXO-000XZW-1d
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 02:48:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=XwP9m3jizt7TJWxiag5hrBexZ6oYqOu9bxPNPCp40/8=; b=ikSchFz/SKtqsFVuVeUyVhkxRz
 PDvPFuSiy4cfh4TzFd1YwzWulmqypl07cMEKC6NL7IZvN1igKFpUohajW4INXFPGxsirV6TVpsZmW
 P5HaeaoAh1vw8MuVEvFy1D6EOV6pg2GaS6NAyGptf4GjUYcVHoQSNZpvRzQRc9+X9Hn7UA2qXp+vS
 VdA9JNBwAZ4kNVA06dZRB4t8NnhHGUfO9UJT40TyRIfr7NXZ1oAxvDnflgnDI3uEZzvvNS7FjWPHO
 2QKGUJTu1A85Q2oBjinNW+b/oswHF8wO8Q58Id8SSz4viepdto1mrVlFI4qBdsK+VBdcFUJ9HkH4I
 0nOe8Kkw==;
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEXL-0092P1-Ic
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 02:48:52 +0000
Received: by mail-pj1-x1029.google.com with SMTP id r13so9361202pjf.2
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XwP9m3jizt7TJWxiag5hrBexZ6oYqOu9bxPNPCp40/8=;
 b=buL38qLzMOLvmL9XGSbatrjI+9Q7q5id/VsSNpS7adsA61AYdf5nld64a3oDZAWRaE
 TxIEUN5eke6vTp66Y2PyhjjsBGEudNkdjUm/cRsMQc9KTfvALRm9gugOBXmR+8w9mdAw
 3DwqQmni3S6ZnPqThaMf3CxVlq6PkE6mXKRhCkwU4LgZXAq1VJyEEmqiH3xi6A9zX3+h
 /EvBIQckqQXmmBoRz46pOv+X+HkRC8k5Mz/3quaRXPkMp4tjBuJ6ejUpi0hIu4n7CZ2F
 YkR+Yf6rX1ORjdWMYsoNsf2AyRMTpjjpH+Br3Y15ZdDwypEmPKTpsqsPdNE9osY2poos
 362g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XwP9m3jizt7TJWxiag5hrBexZ6oYqOu9bxPNPCp40/8=;
 b=j6Pv4bABF+4hMy+BPzjdCxE5Po7HdQEYmMbq+fC2JbAHsy3LAEH6SqOu8H4Has58Yg
 QdAp803Las3sjGANRz20Ig2FaMq72Hixw/olixiY/8OBZ2PUyKnzvAOa06D/++VL/TcY
 4s0/qleZ3gWnSDgJ9I8gVcc4c8vFhypcCSAu5Ge45cpcPlvt+avqjDMxZVUzdIT9FfYw
 UztHytstAbs/aZCXI4UVbGHUUIHz/1Cs9n9gfhEXlf5w/kv05UD8qLzZRmfVxc2DkOKZ
 Axe95cVGM3Qwy/F+wX/8Z7g/ZMbnT/oqIRT8Ha2WliTvXuc0yrjDYd2qvZo7glrxlUSd
 0xBw==
X-Gm-Message-State: AOAM533kR78Qkr/QdXn4y/qaRF9IAVRJSSyqWGcYYQzS1nxEUJ8sGMu5
 PMP0B4Hqh9e2r1hOXAHUPuXctCITeAI=
X-Google-Smtp-Source: ABdhPJxS5a75tLd3G+QzniYMLUbjuZS1rdksgpi/BWEPfFIlW9YFm9RZHpLDNLLbATg7VyMnXnj8Tg==
X-Received: by 2002:a17:902:6949:b029:e8:c22d:17ae with SMTP id
 k9-20020a1709026949b02900e8c22d17aemr7010635plt.57.1618541329563; 
 Thu, 15 Apr 2021 19:48:49 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id c128sm3244195pfb.81.2021.04.15.19.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Apr 2021 19:48:49 -0700 (PDT)
Subject: Re: [PATCH] nvmet: avoid queuing keep-alive timer if it is disabled
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210415090530.2353-1-houpu.main@gmail.com>
 <BYAPR04MB49659A9C02A2344BB68BB7B6864D9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Hou Pu <houpu.main@gmail.com>
Message-ID: <5ef49cb5-7784-5ec5-b225-e181556fa908@gmail.com>
Date: Fri, 16 Apr 2021 10:48:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49659A9C02A2344BB68BB7B6864D9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_194851_652480_6987CB10 
X-CRM114-Status: GOOD (  20.65  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2021/4/16 4:17 AM, Chaitanya Kulkarni wrote:
> Hou,
>
> On 4/15/21 02:07, Hou Pu wrote:
>> ---
>>   drivers/nvme/target/admin-cmd.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>> index f4cc32674edd..b8a33d1506ba 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -926,8 +926,12 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
>>   	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
>>   		ctrl->cntlid, ctrl->kato);
>>   
>> -	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
>> -	nvmet_req_complete(req, 0);
>> +	if (ctrl->kato) {
>> +		mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
>> +		nvmet_req_complete(req, 0);
>> +		return;
>> +	}
>> +	nvmet_req_complete(req, NVME_SC_KA_TIMEOUT_INVALID);
>>   }
>>   
>>   u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>> -- 2.28.0
> I've validated that this behaviour does exists and this patch
> fixes that.Please add my :-
>
> Tested-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Thanks.

>
> Also, please consider following on the top of this patch :-

Thanks. Changed in v2.

>
> diff --git a/drivers/nvme/target/admin-cmd.c
> b/drivers/nvme/target/admin-cmd.c
> index a892cd246783..3422d35b25a1 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -1010,19 +1010,21 @@ void nvmet_execute_async_event(struct nvmet_req
> *req)
>   void nvmet_execute_keep_alive(struct nvmet_req *req)
>   {
>          struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +       u16 status = 0;
>   
>          if (!nvmet_check_transfer_len(req, 0))
>                  return;
>   
> +       if (!ctrl->kato) {
> +               status = NVME_SC_KA_TIMEOUT_INVALID;
> +               goto out;
> +       }
> +
>          pr_debug("ctrl %d update keep-alive timer for %d secs\n",
>                  ctrl->cntlid, ctrl->kato);
> -
> -       if (ctrl->kato) {
> -               mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato *
> HZ);
> -               nvmet_req_complete(req, 0);
> -               return;
> -       }
> -       nvmet_req_complete(req, NVME_SC_KA_TIMEOUT_INVALID);
> +       mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
> +out:
> +       nvmet_req_complete(req, status);
>   }
>   
>   u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>   
>
Thanks,

Hou



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
