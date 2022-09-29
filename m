Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9759BC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=474tjA3Gjf60Pz38dDMyAaRwLrDVcBWJSEsK7Yc5yII=; b=uLX2uHFkPFfyEi2Pg8PyfHA7S8
	vEYca8ddJu/zdT+vFOb2c/I6rvXkZwaj/0+n21sPR4aM2syP6xslHxLexausiSwJAUhyGhSh1fECF
	chVeM+ByI7WRvFz3b0eS/7AHGea+yIzoU2Eyrinu6h6LbjZzzMNjO+OGzPynyJIqqEMYHmABkQGu/
	GeThR0vhLYbuGfn7JfOzcvUI0eZblvWvR7/7xUKGEd5huR7084kA6Y2KY+WY9Q15U33VAZ5gHkYtG
	KZCaHEyeMNCRqbMFQt6Dxe3d9SSk1Rf3IpgmPEh6VMvQQkBJpDt5nyvjK8oDgtQE+ewJRfKWooZWw
	bryEyRLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odwMH-0049sV-Q1; Thu, 29 Sep 2022 16:25:57 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odwME-0049pA-5t
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 16:25:55 +0000
Received: by mail-wr1-f47.google.com with SMTP id x15so2510574wrv.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 09:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=474tjA3Gjf60Pz38dDMyAaRwLrDVcBWJSEsK7Yc5yII=;
        b=q1xcXb7FcvoIco0nuZZJ4uaQeb44mmFOfldnCvx1aXMVOG4VxDLu4Ro0aOmZ+0G+yg
         UEr8y0jbJuLGb7EDFQ+XFkaP6lI04usyM1UO69IpMDM2u1lmUBA5726Nl3LKjho2h1ml
         NyF8AtnLlv2uwICOtYkhihNA3VuFmEJkvjYG0l1ZBckpxO84SbUFsfaM42DIrJMXUbN8
         WKbreJ4nocXAIadtsSxkgRkY7R8NQs6hxhe3i2e2Vzxzj87I1ujjWYgnbBafjutDfg93
         YGrLaZu/Kv38CdTjm4Avl5tdyh41QwlmXjnBO9WaEgfnZVq/sSjyrLKPyNf9IeHPWJXh
         bOEQ==
X-Gm-Message-State: ACrzQf2tVtJjzu1JwAYxvQiipxQ2z3X1r6U55WJPzj1vE4ibpNKs6wOJ
	ccyIQipugEMjEmXI4e622hg=
X-Google-Smtp-Source: AMsMyM5ArMrAJHgtGVPKjq2yZzCVLOipwE7b7GNao9dudVYRpPyv4+HVhfSpxojNMkZYvmrzoH7nsA==
X-Received: by 2002:a05:6000:1c18:b0:22b:13e3:19d3 with SMTP id ba24-20020a0560001c1800b0022b13e319d3mr3106868wrb.699.1664468751518;
        Thu, 29 Sep 2022 09:25:51 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4743000000b00225307f43fbsm7155649wrs.44.2022.09.29.09.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 09:25:50 -0700 (PDT)
Message-ID: <91ebc84d-c0e3-b792-4f92-79612271eb91@grimberg.me>
Date: Thu, 29 Sep 2022 19:25:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
To: Jens Axboe <axboe@kernel.dk>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <04b39974-6b55-7aca-70de-4a567f2eac8f@kernel.dk>
Content-Language: en-US
In-Reply-To: <04b39974-6b55-7aca-70de-4a567f2eac8f@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_092554_268242_40FF9F3C 
X-CRM114-Status: GOOD (  14.53  )
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


>>> 3. Do you have some performance numbers (we're touching the fast path here) ?
>>
>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>> preemption disable. This is a very small price to pay for what we gain.
> 
> Is it? Enabling IO stats for normal devices has a very noticeable impact
> on performance at the higher end of the scale.

Interesting, I didn't think this would be that noticeable. How much
would you quantify the impact in terms of %?

I don't have any insight on this for blk-mq, probably because I've never
seen any user turn IO stats off (or at least don't remember).

My (very limited) testing did not show any noticeable differences for
nvme-loop. All I'm saying that we need to have IO stats for the mpath
device node. If there is a clever way to collect this from the hidden
devices just for nvme, great, but we need to expose these stats.

> So much so that I've contemplated how we can make this less expensive than it currently is.

Then nvme-mpath would benefit from that as well.

