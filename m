Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B491C001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UuWS2k+JCf/SgvTmKSTe79OiavDylfF6Nt3w3ojyWpk=; b=ovH605x6GtZs3cCFo+QfS00AMG
	T7WHguldwLcc8ykdVqG5TiZwOWVytb1X3TpkuJ72kpbk+v5KO1FMccLIVFxWZqQaMvEmp//3phUoh
	AyUXmI6x/7It0PaKA3kjGEi3M5Cz3eMe8KUBHfBt0A4CnsnCkGswUyN9sb4PJvE4KsppARAK77lpK
	z/dqf2zapi1iikNq9G2x05f7PB9wyXRo0vKjAhWkFbtkY+FZhO0f6ERYLg+9GPW7DLxTJ83LSIj6Q
	CjZsyXYchlQvKh9/s71pmq+mi2WgiFxy2GAMr1FPQCymYMvKbIqRmKPwYPNpPVqLtNGaTRO79c53i
	S+7P2nUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOfuK-00AiFR-0g;
	Wed, 26 Jul 2023 14:54:32 +0000
Received: from mail-pf1-f171.google.com ([209.85.210.171])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOfuH-00AiEi-0r
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 14:54:30 +0000
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6686ef86110so3985559b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jul 2023 07:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383268; x=1690988068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuWS2k+JCf/SgvTmKSTe79OiavDylfF6Nt3w3ojyWpk=;
        b=UfUHd5MKgTklUNWD9sJjfYCmcW9Pdy3JIFt7tHcP/M0sMxj4gs1X0JlxlSZ/OuY24Y
         dkXdXTyBoijBrKbynOZ8NWWzA5Gn3gCug3+C7Or9Y6hLiCPEru1/m4RjR3nsp8rM4OEI
         28qbrRrad+/B3jAZiTS8AH24oqsA0DmS9kci1DiEsus09QTXA/zUnHwnbsGJ8uKbHoCA
         0P5pVq6pyDXI5e9s7YKnFlNOrj5Q8Y0NMhlqb43bMCd7dlGabnxXKdpXuwVCJzdoQ4kS
         mPW7u4S4wrc1A5jrbNYMRif6fhPPkkhgWIXfTmsilo7lwVIHDCzFr2yObWwjo+KsD0AT
         wQYg==
X-Gm-Message-State: ABy/qLagUfNlVCIrR+iFUPkxUnGYYDVdavAgpCG0sn1fqKEWjipO7jzE
	ErJEpiY9iNEaxNuN9EqHICI=
X-Google-Smtp-Source: APBJJlEOjtuRs+yoPYTIYSKyIRh5TosXj3onTsKaVnOJp3v0HP4gI8BK5fv4FbwBZFrJ8xlLo2ziuA==
X-Received: by 2002:a05:6a20:3ca3:b0:132:1e76:6f02 with SMTP id b35-20020a056a203ca300b001321e766f02mr2350185pzj.34.1690383267614;
        Wed, 26 Jul 2023 07:54:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:7ecb:b0e6:dc38:b05f? ([2620:15c:211:201:7ecb:b0e6:dc38:b05f])
        by smtp.gmail.com with ESMTPSA id k11-20020aa792cb000000b0067aea93af40sm11587369pfa.2.2023.07.26.07.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 07:54:27 -0700 (PDT)
Message-ID: <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
Date: Wed, 26 Jul 2023 07:54:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-2-dwagner@suse.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230726124644.12619-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_075429_298746_ABF1709A 
X-CRM114-Status: GOOD (  10.71  )
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

On 7/26/23 05:46, Daniel Wagner wrote:
> Group all variable declarations together at the beginning of the
> function.

An explanation of why this change has been proposed is missing from the 
patch description.

I think the current style, with variable declarations occurring just 
before the first use of a variable, is on purpose. I like that style.

Bart.


