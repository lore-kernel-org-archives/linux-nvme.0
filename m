Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF068C021A0
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m2wFYX8dgaktOSAgfZPyadoLd/GGU3mSBDrqYC4o1Vc=; b=G9qjvIlFAHk7Ae2pvYK5q7o9lD
	PLlPOWF26v/x6ktvFkCF9Ty/7KnJsioJxt7jZXY7c0UgKGOA8lZv8YRmCh4hVegaR2V1LU3/GwtVj
	RSBjTHFmpXTmt9anNV7KaqNF+5FC+HcERY26sTnTZlUPmeTKk7rAUgvaXzmCpOwGeKrGMsXd8C55C
	ToTw6oqxqSIiiLr9MNZ4Ch1mwWUGDdUfQgpogyRZQgFyJCP4UhYZMo4Tqsv4Sgu8lApSMaevXQdGW
	MXlrlZAohf19ugE4oU3TarvjvOidl0loMgrvuYO/ETnO55WAqZWgWuY3tilfDs4PU3eAnGiwe3qOa
	tmQpEDQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjwAi-00000003hga-0B5d;
	Mon, 17 Feb 2025 08:08:08 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjwAf-00000003heW-0mQc
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 08:08:06 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a823036so42375685e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Feb 2025 00:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779683; x=1740384483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2wFYX8dgaktOSAgfZPyadoLd/GGU3mSBDrqYC4o1Vc=;
        b=G9/FjLdlca4XdNeQBycsGpytiGCSd/Uub2/lmHSrycURXu3HntvjkS0xPJOEUl7fXW
         ByY4PnO6qkfkiY4d2BuIrRLXukz0rOu1Er1d1SFFc1JsRp5bcjqWujnbDTgBVBgRm7Gc
         ehzIsPszoP7qAbG4RdQptJZ6dj3mKj2V3AJl/UA20t72g3zm4P03Honf6Oex1h5hzxzf
         bH7Bqa7eutbvKIJvUB/UT1g9R95MxDpM6ujNnPPqSpP5XwCbNLKGAJDzdt+plFmCTINM
         EuIu09Ehr3Nd7R0hzk0Xm4qTfslS6LRpZeYvBFc/7ws0cH7aGxSJs+1N9SymcWYUmxQH
         Sr0A==
X-Forwarded-Encrypted: i=1; AJvYcCU7v8ij1uyXj790l7GvQFIEjjgf/WtN3iOiGjuAA24OHFpIu/oUg/XxXfLM+HYdhKiBMUvhk8qafDVv@lists.infradead.org
X-Gm-Message-State: AOJu0YwDJtRXOPEJVOtddlw6F+GH/sACdu4v7HUdFCBNwNTJ8Ge8dMBS
	HnS1/ILnVZy7Egff9k9XeRDRXcW5uNIgGXY7piI4PeqQWqUm1ouccoKcRg==
X-Gm-Gg: ASbGncvaESB+0WqP7whUTy7BRuouYVEhSnZYIluZYa2tYbt5XavB6T8Kk3UUY3KyVKK
	TkPKrEZnnzNUBZFPg3U+NGppEKqbz4Epv4JJD/mlDHk0ZAYyqg9evu3lJRsVDQdONVuVq8l5xnV
	D6R1o/O9A0F3+fZlYmZEPoLg8Kj+A0UvPb2p/to+R8x0slo/6D8lV4hipbQ5DGeifzwZ8KI9O5O
	YdcPjHRFRSlwI/lEgh6Hen/uaXj04hAYjifnv98ZnzPEJZi1+ASjo4F6EBc53n77hZpUf4ZY+X6
	CYwbcI46jO3AQbqhXeBJnFeFf2LMiyMzZszl/QQp6m6Iemp8lOYIZB6dCA==
X-Google-Smtp-Source: AGHT+IFNcTDOkaZQlTyUplPUqQ21ZWQqF0+0Rp/O3wOz3kPHGdMVBsJAT9nt0R2HPDY5n8OxJZJKPQ==
X-Received: by 2002:adf:ed48:0:b0:38f:2a3e:870c with SMTP id ffacd0b85a97d-38f33f38891mr8801531f8f.16.1739779683530;
        Mon, 17 Feb 2025 00:08:03 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4314sm11408949f8f.9.2025.02.17.00.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 00:08:03 -0800 (PST)
Message-ID: <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
Date: Mon, 17 Feb 2025 10:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de
Cc: bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_000805_228397_ECEE2BF1 
X-CRM114-Status: GOOD (  23.25  )
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




On 13/02/2025 22:37, John Meneghini wrote:
> Keith, Christoph and Sagi,
>
> This patch has been fully tested and analyzed by Red Hat's QA group 
> and no
> unexpected side effects or regressions have been found. Both NVMe/FC 
> and NVMe/TCP
> have been tested. Our QE engineer has asked me to report this upstream.
>
> Tested-by: Marco Patalano <mpatalan@redhat.com>
>
> Fixes: 32acab3181c7 ("nvme: implement multipath access to nvme 
> subsystems")
>
> As discussed in previous email threads, the nvme.core_multipath 
> parameter was included
> by Christoph in the original implementation of nvme/host/multipath.c 
> back in 2017
> at the request of Red Hat. At that time Red Hat was only supporting 
> DMMP multipath
> with NVMe and we needed a way to disable core native nvme multipathing 
> without
> reconfiging the kernel.
>
> The nvme.core_multipath parameter has been used by Red Hat, together 
> with some additional
> out-of-tree changes to nvme/host/core.c, to support DMMP multipath 
> with NVMe since RHEL-8.
> However, the plan all along has been to deprecate and remove support 
> for DMMP multipath with NVMe
> in RHEL and to remove this parameter. This change has been advertised 
> and communicated to our
> customers and partners, beginning with RHEL-9, through release notes 
> and other communications.
>
> In RHEL-9 we changed the default setting of this parameter from "N" to 
> "Y" to match the upstream
> kernel and the move our customers to native nvme multipath. DMMP 
> multipath w/NVMe was deprecated
> in RHEL-9 but still supported. Customers were still able to optionally 
> enabled DMMP multipath
> with NVMe if they wanted, by changing this parameter, and many of them 
> do.
>
> In the (soon to be released) RHEL-10 release DMMP multipath is longer 
> supported with NVMe and
> the out-of-tree patches needed to support DMMP multipath with NVMe 
> have been removed.
>
> Red Hat is proposing this patch to remove nvme.core_multipath 
> parameter from the kernel as we believe
> leaving this non-supported parameter in the kernel for future releases 
> will only lead to confusion.
>
> We plan to ship this patch with RHEL-10. So it would be really good if 
> we could get this
> change accepted and merged upstream, perhaps into v6.15.

Hey John,

This looks fine to me, I'm assuming this was also tested with 
CONFIG_NVME_MULTIPATH=n ?

