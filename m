Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC4FC30658
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5aTyO+fkrfsiB0KEGtZHRqNAU8uvM1qqKyObB4mf7jw=; b=NxEsf3vOH4l3MidUpMIHou3rmo
	yAMzfXiQbVGjKhselVpovohpP+16u6bwEVFf9h/IYhwc2L6f8LQxPikjfPknd6LiKG+UQv56Opwwm
	mjjinFiFQjkBxM51065HENfzz5QmBDnxtGsf34W8Z7b1nSKIfDoDsXJZFI/OTovInSdKDTz5ex/Vf
	Iq06/z0vXhY7T7guADYTdtUoi2YPCmOxkgLEaXC7LLZ4g9piHyqAu4c7W2OZfbf4JMKtE6B8uQXoe
	nS+fHf1IPO12HJMiy45aYSaO+sp6P9Wfv69bYJnD4VU4y4SNSLNR1KU3Q1zMa+s7w2IAWfwm/chVB
	/dACMvtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPhR6-0000000Fpql-0Xi2;
	Fri, 05 Jul 2024 11:49:08 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPhQz-0000000FpqK-3ZUu
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jul 2024 11:49:03 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3679911df2aso154232f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 05 Jul 2024 04:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720180140; x=1720784940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aTyO+fkrfsiB0KEGtZHRqNAU8uvM1qqKyObB4mf7jw=;
        b=a7ROoMhjS59UqEZOidPk2PhM3gPQzYycapShVs+qh/UDS7/KXqN3eJehB5hdEuF7y1
         IiPqGXIa62kpOKQyAq8aoK43dFeSUQQ0ewiJRJKBqYI6POy5lXa5INZC0427SvOk2S2t
         Vyy9IvRu6YZQoW0jtgeLgOGj+GtjExd3IzfKxiym6yQQpzD5nCZzdmNftdCPbbi2WQRR
         upAPA9eaC6VIFRY/J3yBVV24FB1gJEmi1hD1s9PGW9v4GPMwzJ8TPV7FOjmpY2c3Ss0Z
         X0BomvglyOhjtnL/FGDtHPqs9G3WEIr+RnNlSrm52zFoJJcIUYf3mJ+85c3J2RRHUR/t
         CXjg==
X-Forwarded-Encrypted: i=1; AJvYcCVVus3Tp4nfFdAXWao6EDEVMfWHOkzfP7eafwQOchsU1ISbv6O2JnQ0GWlDD4m/vRK/oTnzwwMnOud8TqiuAgVukssDIBNb/fkrhqjSxN4=
X-Gm-Message-State: AOJu0YyA1DSwsieF3cVQX6t8ZYZto4v8StPlyawyMoR4PRvnP5+zy96i
	C91VTwFbUkP4T0KC11HfLOqcqp9v5t0BUt+ngnVtX6EbTNaRpKoo/RpD6LXr
X-Google-Smtp-Source: AGHT+IGrI5SV4ccpw7UGj2NSRUUTRk6N/W1bAQHqWyKfxlewT/IXHlK0EeOSaoimvRc8GUzTOwC3Ow==
X-Received: by 2002:a05:600c:510d:b0:426:4920:2842 with SMTP id 5b1f17b1804b1-4264a45f67amr30397085e9.4.1720180139879;
        Fri, 05 Jul 2024 04:48:59 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f22acsm58765615e9.24.2024.07.05.04.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 04:48:59 -0700 (PDT)
Message-ID: <b74f1411-8a48-496d-992f-91cd897e991f@grimberg.me>
Date: Fri, 5 Jul 2024 14:48:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme-tcp: switch to 'cpu' affinity scope for unbound
 workqueues
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-5-hare@kernel.org>
 <1259766c-234e-4958-a16f-9de753a4a0b5@grimberg.me>
 <792eeb90-90ba-4750-ab22-622023967eeb@suse.de>
 <2b0dbd25-bfa5-4a0c-842b-50c27b0843a7@grimberg.me>
 <56ebc95e-8c9c-43cb-a849-a1bbdd4a98e6@suse.de>
 <ed21cca6-4d79-4edc-935b-20e342a4d352@grimberg.me>
 <b6c7fe9e-d15d-45be-912b-d9ef35c15c49@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b6c7fe9e-d15d-45be-912b-d9ef35c15c49@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_044901_927245_D321CDA4 
X-CRM114-Status: GOOD (  16.52  )
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


>> I tend to think that the io timeouts are caused by a bug, not by "non 
>> optimized" code. io timeouts are eternity for this test, which makes me
>> think we have a different issue here.
>
> I did some latency measurements for the send and receive loop, and 
> found that we are in fact starved by the receive side. The sending 
> side is pretty well limited by the 'deadline' setting, but the 
> receiving side has no such precaution, and I have seen per-queue 
> receive latencies of over 5 milliseconds.
> The worrying thing here was that only individual queues have been 
> affected; most queues had the expected latency of around 50usecs, but
> some really went over the top with 1000s of usecs. And these were the
> queues which were generating I/O timeouts.
>
> I have now modified the deadline method to cover both receive and 
> sending side, and the results were pretty good; timeouts are gone and
> even the overall performance for the 4 subsystem case has gone up.
>
> Will be posting an updated patchset shortly.

That is good to get some confirmation. I'll wait to see your patch 
(assuming that you added
count limit to the desc passed to read_sock?)

btw, the count doesn't need to be byte granular, it can also store 
jiffies and check time.
However, I'd prefer to keep it to byte count such that we can leverage 
it to do one call
directly in nvme_tcp_data_ready().

