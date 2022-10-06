Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54624C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 18:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z2pht9RoqtyP284j+C1cC7Lqj7p0xiPE6PS482Bfdnw=; b=ZW1btbyumEumAb0zm1pnM7CYFf
	N1Y3dzv6gy7EesmjzqCIJeb7FUTO7nednq8DuTGPaw0K0/q+R12gIURYjfheWn9DPPqft9PT1qLsU
	vEVt9lMNu+E5rX1b6nH7V2te0OxfAq6wD/PV8IcGmslFcYzZ1dx252fc0p/LSIksDRLOcr17FnuC8
	aWzkuEuxrY1p+Jp6xmpvaawtXYn291owcZXfEjO8HXGRx6z1M2XUf2UhLQbQh3u8e9Ph9L0Vza4XW
	8MhOcbkE3XTWUwpbBaxoG8H2UldtlwL29JnHN/mg+0KKmSCCrFgNpwBXY/ujXEJ1CI/a/Qj60zBLy
	JhJOEtQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogVnS-004W0W-BU; Thu, 06 Oct 2022 18:40:38 +0000
Received: from mail-pg1-f176.google.com ([209.85.215.176])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogVnP-004Vzc-Uq
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 18:40:37 +0000
Received: by mail-pg1-f176.google.com with SMTP id 195so2630110pga.1
        for <linux-nvme@lists.infradead.org>; Thu, 06 Oct 2022 11:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2pht9RoqtyP284j+C1cC7Lqj7p0xiPE6PS482Bfdnw=;
        b=compdukOCxC0EU4qhSPkyEpmTKPUUkuAvYSIRfSrCLWIphp9IqKQH1ppOiFH3KnukI
         nVQumDNJMSt8eSSw53kSymspETLPwu5Sn9DxigbYVBpvp8ca07B5mZwuT6IUTSTxdm02
         Ikq0aCzcM9HLb3lunTn3fQWmqLVt5jOl01afY/v+xFNcjOIxW0rqARwGyh2ReTxpyldw
         Wu3RLVj68T5OM1hHYyW2iuW/1D9xiHuLA7bA3Wr/fWlPTcqVfOmBkRYfjHDoqSU0Ifxp
         xHy5yqdYOrA6ieoZtoKT/JhsI3vY/XXkKzWfsudR3ewlVjAIvLZyER2OCn70o8kUZLmG
         E5OA==
X-Gm-Message-State: ACrzQf2mpe2jqsAGX9clX5oIu/I1dSJnPP0kJXtxuN1GsxcHXoNGb+wN
	QFWp6udlnIEpfyBKR67iyAc=
X-Google-Smtp-Source: AMsMyM7O6ZwP1XgoQZ4RryLenvCTr4zIfNbhwRmXnxmeC6wuX+8NTfy6f3FcAAjd7qKs80T2PObciA==
X-Received: by 2002:a62:ee17:0:b0:55b:b0d:bc9f with SMTP id e23-20020a62ee17000000b0055b0b0dbc9fmr1228763pfi.39.1665081632917;
        Thu, 06 Oct 2022 11:40:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1d3c:9be0:da66:6729? ([2620:15c:211:201:1d3c:9be0:da66:6729])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0017a0668befasm12537245pln.124.2022.10.06.11.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 11:40:32 -0700 (PDT)
Message-ID: <51f62009-777f-8958-8d28-b29e64bbff09@acm.org>
Date: Thu, 6 Oct 2022 11:40:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20221005032257.80681-1-kch@nvidia.com>
 <20221005032257.80681-2-kch@nvidia.com>
 <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
 <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
 <e0ea0b0a-5077-de37-046f-62902aca93b6@acm.org>
 <a7e4fe12-64f2-3164-d675-26310ac07c9e@nvidia.com>
 <7e9ce6b2-70c8-cf85-95ab-de09090db64d@nvidia.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7e9ce6b2-70c8-cf85-95ab-de09090db64d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_114036_024365_500AB77E 
X-CRM114-Status: GOOD (  13.98  )
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

On 10/6/22 11:13, Chaitanya Kulkarni wrote:
> I will trim down the argument list with the most common arguments
> and keep it to max 4-5 mandatory arguments identical to what we
> have done this for blk_next_bio() and bio_alloc_bioset() [1]
> where mandatory arguments are part of the initialization API
> than repeating the code all the in the tree, that creates
> maintenance work of treewide patches.
> 
> Also, instead of doing tree wide change in series I'll start small
> and gradually add more patches over time.
> 
> This definitely adds a more value to the code where code is not
> repeated for mandatory arguments, which are way less than 9.

Hmm ... I'm not convinced that the approach outlined above will result
in a valuable patch series. I think my objections also apply to the
approach outlined above.

Bart.

