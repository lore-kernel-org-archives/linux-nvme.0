Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9F6C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 08:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gkZTkbZnkokRK0M1d5m0Kxks/rddfMlEtI55Hvmyh70=; b=uWGYIb4IUNM1EiZYT448dNs+of
	qNchYSZgtTXQ5A/Z1CsfXddIniuBT3NpXtkKmPWx6VJttBiOMUJBCghVkIWaOgWU9dOs+Hr8dnV/e
	9eBfthHQhgW2Ydo6mUisM0G4ct2kixVfArLdJuiz7PsGPcTaR/gnZbwi+lr6e19d8UQqbAwRbt2ai
	fIvkKymKZLRP+J+MRl3s8O5VPAdBEhDHJZYQEvt4hCvplnTbp2MRCH3UvyO9Hsj0GOqFt6JD3o6rl
	8NhbkjpGz+9mWpOTyAxqalcND06iV9Eyu+9eZ/R6ckK4dcnzGUJxU3SKODir83h/rRytGhcDU0MiP
	BsBgaYAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkIpg-00000007ExJ-39rH;
	Tue, 18 Feb 2025 08:19:56 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkIpe-00000007Ev5-2HZg
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 08:19:55 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43964e79314so47130365e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 18 Feb 2025 00:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866792; x=1740471592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkZTkbZnkokRK0M1d5m0Kxks/rddfMlEtI55Hvmyh70=;
        b=Ergi/lwZBk7OVwnZqeoRtQK5qz+q1CiF5z8OYxD56h678CUxu10eePViIAjsynu0bY
         ovWiqT8Q+aW53fHH6QK/ikNnybK5le75wNAZzPBPWLBpPT7CQA0UbrmAj9FmyujW4PXq
         f7NreoIq7Jp6f9TV1SH4smA07vVdpbbR1ZK9OYIIZ9KrQsDb7zSw8uSMY0acCMHlCsJ1
         V/GDWulbw2QUILsA8HnW5jtX5LM/lYEPUcCDXc7onGCMRnMxJZIG9nZDeWy5N8RxSMAC
         HBM4hA9H3uUyRhyvdc1cMxpIilr+1m+ofSRDY3Ne/+wesdOypbi1zdlHgdBeTheZVNQs
         RI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjl8DiqvwgoLMNnkB9DVuENrhjLX5CHT7rHyVSqOwSjbXm1qTGPCPRAE88R6b+3jx8oIpKn0+qnECP@lists.infradead.org
X-Gm-Message-State: AOJu0YxWSTDgf9JxAa0ILNtkCULqOLzF7H4eVNBUBZcwswjVT7fpSIXh
	HhDkoCf9kc7x3pnlQ623JULjYW5N2rSQ5WBhT0+QmTJCQm3UcoNs
X-Gm-Gg: ASbGncvfANPEF3vQfwO7nCMGWp64vuL8E0eykEb7h+AkRlO2GyHJlqBYB+AOS/TohqC
	m0WkOXw7FFGJbuDY16fGxuA5QUnvUMeEMh4lghWV9zi8xKpq4PFjpcEQkPGix2qLxwjcGT35B3p
	nU4XrKAlc5s420QOrRioYnM336h37jdJoitE5hFN6gvT0Z5LXQvxBxaztXVANUm4dKPXZbCmn6U
	RE6ThJpEk2OikCwbko0fborr2Ez3RIOoPb10VlcP5qnrU9C9EiQjhg1XWWaXCSYhvNKrXsgmb8w
	zs1bDfYE9sBIfIGPEx7FPwmEtcgMbKpuA37793nDAfKoSvIpMmkUnLsrJw==
X-Google-Smtp-Source: AGHT+IGpzKroGCXPMYzXV24w2xGqnCA8wj2NxLDnN+GaP245oMnjUtCkdXhtzKeeylr9e6dtP3b4yQ==
X-Received: by 2002:a05:600c:1e11:b0:439:86fb:7326 with SMTP id 5b1f17b1804b1-43986fb7498mr46336425e9.22.1739866792138;
        Tue, 18 Feb 2025 00:19:52 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7f3sm177488915e9.29.2025.02.18.00.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:19:51 -0800 (PST)
Message-ID: <ccc171d1-8de3-4632-9483-71fd5ea63d46@grimberg.me>
Date: Tue, 18 Feb 2025 10:19:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de
Cc: bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
 <ea9537d5-721a-4b37-84d1-df797646fce2@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ea9537d5-721a-4b37-84d1-df797646fce2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_001954_579354_784AACD7 
X-CRM114-Status: GOOD (  16.54  )
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




On 17/02/2025 18:14, John Meneghini wrote:
>
> On 2/17/25 3:08 AM, Sagi Grimberg wrote:
>>>
>>> We plan to ship this patch with RHEL-10. So it would be really good 
>>> if we could get this
>>> change accepted and merged upstream, perhaps into v6.15.
>>
>> Hey John,
>>
>> This looks fine to me, I'm assuming this was also tested with 
>> CONFIG_NVME_MULTIPATH=n ?
>
> Yes, everything has been tested with CONFIG_NVME_MULTIPATH both 
> enabled (Y) and disabled (N).
>
> As we discussed in the previous email thread[1] there is an anomaly 
> seen when you build a kernel with CONFIG_NVME_MULTIPATH=n.
> and the host discovers a multipath capable nvme device (CMIC/NMIC=1). 
> You will see exactly the same thing that you do with
> CONFIG_NVME_MULTIPATH=y when the nvme_core.multipath parameter is N. 
> You see a separate /dev/nvmeNN entry for
> every namespace/controller path.
>
> We can send send a separate patch to address that problem, but this 
> patch, which simply removes the nvme_core.multipath parameter
> has beeen fully tested and is ready to go.

I think that we want to print a warning in this case though. Can you 
resubmit with logging a warning in this case?

