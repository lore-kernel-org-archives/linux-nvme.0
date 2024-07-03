Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4C7C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVIVwir5gr7cEjhZ9cm27Wq3floLd1gNG0Ip6yWv6R0=; b=kcPvrSEujJ1MIuYGujPBVDbdxU
	U5KgFbnfWisdWw9EdjoK0hCtB5oFHMplWdy5uTDlj+olehrz8P+S5MnDHSWAXO2JcTVXmoZ4RiCvs
	WnBAQCy4f1VnZzf2pwKXkQeQNRyNlAbwUIsBtCalvC1nyrronlNpWNpNXDyFtBhkPffAy6votqPHy
	38fvRhj6/jEkpSdPyV8USdjRyDUtXF/J3ktb9+zjWhEaNBcP/NqV4ZN0qfZ0E/MqYHZDuAOgsOp7T
	7MYvjfQZryaKNjXmV8yDx8Gg+rfblLw3fSWmf7VexQtgiTNskcC2QGDAi/4Zdr94Si9CD/zUiqPAC
	n4mcT/8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1cB-0000000Aceq-27qC;
	Wed, 03 Jul 2024 15:09:47 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1c8-0000000Ace1-4BaW
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 15:09:46 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-364068c0ec5so278990f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 08:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019383; x=1720624183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVIVwir5gr7cEjhZ9cm27Wq3floLd1gNG0Ip6yWv6R0=;
        b=T9c169HBzswDdbJnf4XTT+tADen+EmjhC9anfsjvxOcZFm9df88j7nd3LVYv4gF6fl
         aMU1IRGN02OonQeRdw+79ryVQ60ofKY6/FB++rkP+HAf5xAiV2gUyJAlbqkMzyyr/6Kc
         aMzgAwYQQsvkpBmipca7cfWg5UWIOB09WVJrW3STdUguAnqjp9ICijQNlOuPXV38FfLw
         U3xOoFrg7fnrgwNLpZo+P4Fx3uNqCKbT4fMjt4yzba56xR7C9iKnOwPNnZiUGvpHYVwK
         2SJUQK7+vbYH78Lq3rZondNynPoiKexKqljTkEiqxPCXGGHQFPEd0GqUMIeSYzKXWUdQ
         wrig==
X-Forwarded-Encrypted: i=1; AJvYcCVKJlozI3DFAsC9A5h/TnAycQCAme/CLP7lHvQ4YPn54GrnAcEJR7KpmXgz3r7H9d4PrVcYnt6iV04psHi5T72QrKwoDejiSCpBzQsmJJw=
X-Gm-Message-State: AOJu0Yw4AB7xcTdu7K6MgNiMwoEgWnKHqQX8cZVWUzBcqXZr+NEozugE
	zMnCCUlDpWh0WZkTPVqQuSQUSTNpa2fmXB1UrRNfFpps3RmWB6vp
X-Google-Smtp-Source: AGHT+IHCMzz49NxyvAxVzjQVa99KOAvkB9NsrWcXAMLH7JmEij+JQ7IzLZP7t+1lKpYTR4VjJDObFA==
X-Received: by 2002:a05:6000:1f86:b0:365:da7f:6c17 with SMTP id ffacd0b85a97d-36775733d2emr8920590f8f.7.1720019382671;
        Wed, 03 Jul 2024 08:09:42 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a043a16sm16351569f8f.0.2024.07.03.08.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 08:09:42 -0700 (PDT)
Message-ID: <2b0dbd25-bfa5-4a0c-842b-50c27b0843a7@grimberg.me>
Date: Wed, 3 Jul 2024 18:09:41 +0300
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
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <792eeb90-90ba-4750-ab22-622023967eeb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_080945_073024_BFC4D356 
X-CRM114-Status: GOOD (  22.15  )
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



On 03/07/2024 18:01, Hannes Reinecke wrote:
> On 7/3/24 16:22, Sagi Grimberg wrote:
>>
>>
>> On 03/07/2024 16:50, Hannes Reinecke wrote:
>>> We should switch to the 'cpu' affinity scope when using the 
>>> 'wq_unbound'
>>> parameter as this allows us to keep I/O locality and improve 
>>> performance.
>>
>> Can you please describe more why this is better? locality between what?
>>
> Well; the default unbound scope is 'cache', which groups the cpu 
> according to the cache hierarchy. I want the cpu locality of the 
> workqueue items to be preserved as much as possible, so I switched
> to 'cpu' here.
>
> I'll get some performance numbers.
>
>> While you mention in your cover letter "comments and reviews are 
>> welcome"
>> The change logs in your patches are not designed to assist your 
>> reviewer.
>
> I spent the last few weeks trying to come up with a solution based on my
> original submission, but in the end I gave up as I hadn't been able to
> fix the original issue.

Well, the last submission was a discombobulated set of mostly unrelated 
patches...
What was it that did not work?

> This here is a different approach by massaging the 'wq_unbound' 
> mechanism, which is not only easier but also has the big advantage that
> it actually works :-)
> So I did not include a changlog to the previous patchset as this is a 
> pretty different approach.
> Sorry if this is confusing.

It's just difficult to try and understand what each patch contributes, 
and most of the time the patches
are under-documented. I want to see the improvements added, but I also 
want them to be properly reviewed.

