Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D49BC4320A
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 06:18:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2774261004
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 06:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2774261004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4CLzgfN9q92K5DjdGRP/SyMIwcBbfvICA4O4ZtsX/k=; b=aHW74BjhDy2FFeUxAA7E22XpBm
	7PSWrlitaI5eCrtPJ9nnPqf6+7oGHhgbMchPrsvyLJspo5Vpi5gTOs2ZOck91svHYsTdjnpTfbg2I
	w6w76lvXt1NdpCi+rHI3m4h27hZTdTslWh8/uMyR6vZgoGZimo0GgO6mSeTewlTtEC6n9Bcd9/LS9
	BhpH1wly1kvE2053/twz4zZ3wX0ndteu4qazheOaRemTqMUJHU1WlPWlq0T89aHah+mR42UZPzvHZ
	E8MlmaaPL43GvEVqrbIWtyswGK0msJhflrVEQbxiMVpJJng6n+VPsWelfaTEKRt11huptiKge3U/N
	664yisAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBWiB-008DId-OO; Thu, 05 Aug 2021 06:18:35 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBWhv-008DIB-5z
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 06:18:20 +0000
Received: by mail-pj1-x102f.google.com with SMTP id
 o44-20020a17090a0a2fb0290176ca3e5a2fso7130130pjo.1
 for <linux-nvme@lists.infradead.org>; Wed, 04 Aug 2021 23:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=FmqN0pxEdocd1AVjoIvh4yoH0IcVcW5iuMtffkipqc8=;
 b=p+7pVxN+WUx0sEhXitnJYnln/pDD4N3lkK1JrO2aGX6eUpP+XwgBCWaDEcw+oEclZn
 5szP/XsODh0zoaPEGs6qTgUmvHyjUvdhYbTPDBF/ieSts7H1o8oo6ShCzZUQan5Jz6Tx
 SohxXK1b/xEcB22e8LGspeakqGgH0TbXVZzBJ1gBF1TyseHWmj1E0Uxo7WngtnRKKkl0
 N0o8OT6VqcAU0hNwc+6F95WcvWzA2pIaYMHdvQHzVLwvaMuLM3XQEGtTFYKgSfqwPNLC
 j+LA5iEYWmrDAa3njBl3yiPP9UGNw2NwCErNjlGK+5DyBABNW3/fMmJiFyszlHMIzJFQ
 b+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FmqN0pxEdocd1AVjoIvh4yoH0IcVcW5iuMtffkipqc8=;
 b=cgaEhL/1FI8LLLa0zPT1zTbkN0b32jFQZQ4kzMBOpb1SiMU+yaYsKS1SkpmvIDCX23
 fWAN/izT6iRUSX8IAvOpTKUTgRzzjQ4XncUhH+bIDiHgVGDvih3bmJw2vv6qmqxnvN3m
 Jln+1huQozNqvKeJk2PIy7ZwEdoLq10WLD1CmSfDZcRd6NQiTsLPpmAdmw9+j0BWF58/
 L1ORL2266mwW3IGNjUOiL9Uos2QsTIjrJxA1uhEAQfvzBPK4X3tdSMArEvNfyg3BBYDL
 E0AaPAnftIQKBRE5m89qTFle226Om/0z/4WeGs/kH1tfn5FO7lQntDyjislWD20PV6bD
 HiPQ==
X-Gm-Message-State: AOAM531wS8CXuz5x+JBtuu8N0/bfRcUVlhXVHjc7W/5i5/Tj243ECHCy
 sPIam65zZiF26KSNPpWRhY2fSbQDJJcREw==
X-Google-Smtp-Source: ABdhPJw6HIUPx1Dqbujmk3+0UUeQ5fmEqDASNnM/NjtTmPX+jYu+lQjMU1zYrTJmbKQqaRypDwH5GQ==
X-Received: by 2002:a17:902:e804:b029:12c:af3b:b172 with SMTP id
 u4-20020a170902e804b029012caf3bb172mr2664181plg.2.1628144297377; 
 Wed, 04 Aug 2021 23:18:17 -0700 (PDT)
Received: from [192.168.50.71] (ip70-175-137-120.oc.oc.cox.net.
 [70.175.137.120])
 by smtp.gmail.com with ESMTPSA id 5sm5277343pfp.154.2021.08.04.23.18.16
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 23:18:17 -0700 (PDT)
Subject: Re: [PATCH 15/15] nvme: use bvec_virt
To: linux-nvme@lists.infradead.org
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-16-hch@lst.de>
 <20210804143312.GA2296276@dhcp-10-100-145-180.wdc.com>
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Message-ID: <abf40425-946f-afe2-57a1-339c0c334ea3@gmail.com>
Date: Wed, 4 Aug 2021 23:18:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804143312.GA2296276@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_231819_279548_B0BB37FD 
X-CRM114-Status: GOOD (  10.58  )
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



On 8/4/2021 7:33 AM, Keith Busch wrote:
> On Wed, Aug 04, 2021 at 11:56:34AM +0200, Christoph Hellwig wrote:
>> Use bvec_virt instead of open coding it.
>>
>> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@kernel.org>

-- 
-ck

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
