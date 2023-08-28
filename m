Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1104FC83F11
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k4/eVPaw3IBTjAjPz+bqGvgtrzgk0IYeEEuriGEdCkg=; b=atF92EopFS3c66Yj4ZBGSsdPaS
	/1vCspEhxKhAdJ7slax6VmedXX3KXNd0m+aF1IR/iagA9eoajTi+4dpdkpdAlMSY6NgneD8V0WpqM
	BMVpgyyGYvGlkniTMbCh26S+PajPPk2tId946c1EW3oipqxAYkZQbR1vUeM0Ve3mGl5FWXWENVD9/
	P2wWgey+98QHmfT5DsE1jue4wZavvKDG3hGKCiXiROCTGTH2En7svQYMquiHKjgNwGAU4zzc5lnL2
	NCJ0pdG7hjGPwHg4zeVmiCjrGnQlrUFblRqk/snwUv+SLxdejQR92+3lg0ptNznVGjXsK5Sp31lAb
	fgkgqRew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qadwr-009mA8-0m;
	Mon, 28 Aug 2023 15:14:37 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qadwp-009m9N-04
	for linux-nvme@lists.infradead.org;
	Mon, 28 Aug 2023 15:14:36 +0000
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-68a410316a2so2372353b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 28 Aug 2023 08:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235673; x=1693840473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4/eVPaw3IBTjAjPz+bqGvgtrzgk0IYeEEuriGEdCkg=;
        b=iswuKV9PEJsHGkSn9hsVeWqli31qikbMLgUmcQE3oqzGa3GTTlDuHW0zdcJK8OnrCF
         KAIqYM0/jFb49wiJ+RxYjkY0yA5CPWueY8LXQnQirJi2gIrZFOHhtV4LyI/jsO6maIlI
         ZVUCIT8E6vIsZs6jpHgJbfDQr4LTPucFR+Q50D8OZTe/RdpqB37Lg/Hcbge/m/JwpeyJ
         65dPDqJsx9hItfe9OWitDgpbZpGIqCzKEScS3d1UwUUHtFTnjFdn3n44rNjCrVtYyD7t
         l/Y8DqhWqmLW7TMm470xRnlPWgdaGaB6vW39trfKHwi7JezHmxb9VkVhW0+xnEJqCVfM
         1TKw==
X-Gm-Message-State: AOJu0Yx5le151f4DGe/l+SFmJvZ/t7IHxsLkQe2cWTQuVbddIcR7Ei98
	UChCxWoFukAMzcAQyPhr8yc=
X-Google-Smtp-Source: AGHT+IH+PPAxCeqwS0rQxAFK2k4hiRnRDctlRk35+6aaJ1RvNhCGrMLpEhUj+rAntmblcZ/VFz85jg==
X-Received: by 2002:a05:6a21:6da6:b0:126:9081:2156 with SMTP id wl38-20020a056a216da600b0012690812156mr25192585pzb.4.1693235672771;
        Mon, 28 Aug 2023 08:14:32 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79250000000b0068bff979c33sm6708230pfp.188.2023.08.28.08.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:14:32 -0700 (PDT)
Message-ID: <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
Date: Mon, 28 Aug 2023 08:14:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
 <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_081435_058408_92F3CA0D 
X-CRM114-Status: GOOD (  11.27  )
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

On 8/27/23 21:13, Shinichiro Kawasaki wrote:
> For me, your original suggestion to add "ignored_agument" looks better
> than "$@". (or in short, "noarg" or something)

It is not clear to me what the intention is of the _nvmet_target_setup
calls without arguments. Is the intention to pass all arguments that have
been passed to the caller or is the intention not to pass any arguments?
In the latter case I think it would be wrong to suppress SC2119 because
there really is a problem in this case. How about passing -- as argument
if the intention is not to pass any arguments? It is a well established
convention for shell commands and shell functions to ignore the double
hyphen if it is encountered in the argument list.

Thanks,

Bart.

