Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C0CC7EE24
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1c3AsJNXErJz7xw89fJuP9RcBP71fTx8ZOUD1z/igTQ=; b=KnYuPAYe5UypxyhgsVOEuOGzqB
	NbW0yQO5kAsGRzvmdlMMb0vBFJrraJvwC9HioXjX40bQ1pI5LFxzmnyaMxUU4+RjhifN/cewImSz6
	9yHACY4zl6W4A76lMe2Cown3eGhpvcFP1V1CjyhciTvrRVj38YAxRSZ0rNes7wwOk2FXbmUYSuyx4
	80Lvk+jGCMJCWAPx6xJYcCDQv1OvpxIVPaWxANnCQUqUdkw5a36Q6nezEC8vJ1G6fL87nk9H51Q4O
	U/vngiQmgBlK9ppr8viWjwobC/DdFaLO58rvpdUEalmv8c2WaqcyJJQl//gZcRF7Rv5gb91E/4d6u
	EDqjuMBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzZm3-00CRD1-2X;
	Thu, 18 May 2023 09:18:15 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzZm1-00CRBb-1L
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 09:18:14 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f475364065so3666185e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 02:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684401490; x=1686993490;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1c3AsJNXErJz7xw89fJuP9RcBP71fTx8ZOUD1z/igTQ=;
        b=LzfT30tDbl86Mj21Rtbol6jeNVh0jzn252BFWfHsVMtZa2Kjw0blYX126yXlt3VEVz
         WMgztsDL4vyQoMBFziSMOPEVcB/0P9A3YlzcmEl471hnPuRwhVrgvGN2OexA/9NtlkY/
         t5vNyKJo5cwv6vwyMsVzvqPi/dZnEkXJqUEOJzgf2XeC/34nOcYUtI/5VfMZ1Hx6ic4p
         kZmZlrrARf2KSKtjzBgckSO2JH5Zy8KVms7wmRz0ZlYJG9VNQ3pHoDP5na/636/yS2wu
         nS5KVTMjeoMZAUq5bDl+wj2RkDMisBYScg9MUSg8rXZXY9SPLvjgFe25yWsAXM1pe5hc
         Z2ZQ==
X-Gm-Message-State: AC+VfDx8v2h/hOCU2P0bzmOR2DS/oeGg+EDUQZWPTy9FmJXvxXCoEaPM
	9sEygwta5bwjcJSkvfaosAc=
X-Google-Smtp-Source: ACHHUZ5JuC8vTQGjN15o2q60vgw8PXkOuUvqFMfLXoeRAoIr5ivoCuH4Egt9DvliM/qKQ+yEk142kw==
X-Received: by 2002:a05:600c:3486:b0:3f4:e86b:798 with SMTP id a6-20020a05600c348600b003f4e86b0798mr4826056wmq.1.1684401490319;
        Thu, 18 May 2023 02:18:10 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c22c200b003f4e8530696sm1352311wmg.46.2023.05.18.02.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 02:18:09 -0700 (PDT)
Message-ID: <9c867339-2c79-ab45-4ff8-cfdfe4af2abc@grimberg.me>
Date: Thu, 18 May 2023 12:18:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: nvme host complete request tracing
Content-Language: en-US
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CO1PR19MB488584F51B17C06C58E8E84FEE7E9@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CO1PR19MB488584F51B17C06C58E8E84FEE7E9@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_021813_452178_62F76F37 
X-CRM114-Status: GOOD (  12.98  )
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


> Hello,
> 
> nvme/host/core.c trace_nvme_complete_rq() is being called immediately when entering nvme_complete_rq()
> As I understand it, the idea behind this trace is to trace every single nvme request that is being completed.
> but this is actually not accurate since there are several options for a request as part of this function:
> COMPLETE, RETRY, FAILOVER

Well, it is completing this particular request.

> In order to better understand the status per nvme request I think it’s better to have a separate trace per each case, something like:
> trace_nvme_end_rq(req), trace_nvme_retry_rq(req), trace_nvme_failover_rq(req) etc.

Maybe we can add the disposition to the trace?

Something like:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b374e6007553..eaf03ff61224 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -393,14 +393,17 @@ static inline void nvme_end_req(struct request *req)
  void nvme_complete_rq(struct request *req)
  {
         struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+       enum nvme_disposition disposition;

-       trace_nvme_complete_rq(req);
         nvme_cleanup_cmd(req);

         if (ctrl->kas)
                 ctrl->comp_seen = true;

-       switch (nvme_decide_disposition(req)) {
+       disposition = nvme_decide_disposition(req);
+       trace_nvme_complete_rq(req, disposition);
+
+       switch (disposition) {
         case COMPLETE:
                 nvme_end_req(req);
                 return;
--

