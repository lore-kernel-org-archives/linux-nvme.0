Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD8FC0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MR0VzigLbJOFJrGwRbChZm7muwkkiSuV8Hk/gpvlAcE=; b=brM4cyf8qoT9TxlTvr5L6zr1z7
	mjtAlObb1awmXNqVWlWR2QYtOoA2pgk9cace6u6MrD97u/TLHce1u3rEBZkOBFsfwo6uYPYpPucQh
	OB4HSt1tKDnLcWcBBMI0nLZ5mk6HX0+mbs+3NFFgsNPAK9v2lPOtrvR5+5yLvaeocdkxnL2T0ajPV
	FZaxAAqYFVLRNO5mpjzQFvRbh+xsWMqUl01qJ4EsJc9A5bn7cna1PLS5piN4I4EBrjEq5NxI1TbxP
	g6p824mMxF1nDywyAOJl4jmEPzreitmvb3AvkaMw2wSY3vL6KChcpehEpqjh0YHfPrzjmQQwmPXLc
	2tCT9SvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdptC-0000000AaPd-41GY;
	Fri, 31 Jan 2025 12:12:50 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdptA-0000000AaPG-485d
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 12:12:50 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43634b570c1so13807515e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 04:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738325567; x=1738930367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MR0VzigLbJOFJrGwRbChZm7muwkkiSuV8Hk/gpvlAcE=;
        b=rVwJly+HL77RDzDxWwGAJRhZd+elp4iW3PuzLh0u5wfOqgDaTuKDt5VWOZhjAaS2jt
         7GWaEBabK8rFYwqbXITQ6ojPonStpba/Fv3fpd3K0UdLW7dWkMWtowNzhoZbm7N3XlOW
         F+NEhG0zBcVneSS5j64LF4ytwl5KOzH+JEd4x+cC5MheLKXHXMxRQDCnPYvs7UmBR8zu
         Xxi74JQyRru9T+gG2cuu0pIyx4Cl+SnZk+DU3UOSuDzaLDZETwLMiqTblA50XJlJo8GJ
         Xj/kgLEi0R4If9Y9yAlU4+bhqzR6WK6O+6G6d0uFnd4It2J098ga5Mw5ZPYoAGKl4fbp
         09nA==
X-Gm-Message-State: AOJu0Yzlab38VHj0oBy6lmFirUODYYjltoTrKFVNJ/3T1qkyxBsAt7Kb
	VbhWMHHeYaCllRpHimL9modpVhMOEIeWIYqZNfBtUWnI9MqMo4+V
X-Gm-Gg: ASbGncs/oqfj2XB8xH6jcDOOSPaCSxJMO0K7yk0yHWgyXAXmZuOUr1V0JnlsN50vGJe
	AV7GP6iuQtJFnejvE61giPFUEc38MoWNuMSqiX2B2wHhNnrNhXyFENkXkFFmAKtEGHbuLKrP1lW
	sfdTa3YRK/GRXcVDdoVpb0APOmBgJOpWuj80Yt5+4OoYSGcp6HEZkkGhioYnzxvEVv/7qa+WGYD
	2+WogGxTjboel7hSFAbYXquupDxdXUQari8urc3uio+eR0LDE5zSw3B7XouFO+9XUJnkFv180bg
	Xw/ao4y9KmOgV87AvcgLKG/136mrbhMwmjH0PJndvXoWYnL7bso=
X-Google-Smtp-Source: AGHT+IFgY9VTcn63S1gYZwXP5GrrHuHOHUkFqGAi+daHFgJBaaGKH7crsiUksb3/4cFK/Oxp5RjUzg==
X-Received: by 2002:a05:600c:1554:b0:436:faf1:9da with SMTP id 5b1f17b1804b1-438dc3a3f9emr104597885e9.2.1738325566996;
        Fri, 31 Jan 2025 04:12:46 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc12f28sm88297035e9.7.2025.01.31.04.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 04:12:46 -0800 (PST)
Message-ID: <862506fc-7a4c-44f7-b9f3-3372b3f468e8@grimberg.me>
Date: Fri, 31 Jan 2025 14:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvmet-tcp: get rid of a high-order allocation
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20250131120509.796198-1-sagi@grimberg.me>
 <20250131120937.GA22109@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250131120937.GA22109@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_041249_028758_C1E7022A 
X-CRM114-Status: GOOD (  10.61  )
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




On 31/01/2025 14:09, Christoph Hellwig wrote:
> On Fri, Jan 31, 2025 at 02:05:09PM +0200, Sagi Grimberg wrote:
>> Allocating the queue commands array leads to a high order
>> allocation.
>>
>> The current size of nvmet_tcp_cmd is 704 bytes. Allocating
>> 128 of those (default queue depth) means that we are allocating
>> an array of 90K bytes. There is no reason why this will be
>> a single contiguous allocation. Change the allocation to be
>> kvcalloc instead.
> Should we still aim for non-vmalloc allocation if easily possibe,
> i.e. use kvcalloc?
>

We can do that yes...

