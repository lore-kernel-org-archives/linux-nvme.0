Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A545C3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jul 2024 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GMrcvl4SKuZA/ORUeJhfOQOkhDAp5kkw1k64MaNIGwU=; b=bcarKgFY3dPvR1WwUk9l88UbLo
	ZPrSDfQPGHEFra7CblmtVa1ueEpusQHR6QOa7kWAffVjP9OgZ8iqQDWC93heXVbx9K4Ox6bAPSS+r
	H9vvK3iBFdnavle9lnnK8HB+DmJ2zeGc7C5AgMO+Eq2f07mryR7712xIPPkq+n2nPwLEJg9a2uOL0
	3kGETibvlg3ULlRUC72uBpyDFIY8vsPvKBlXqRlgQlEiblMwJWYYKqMGEzDAE3UChACJS2x/xS/K/
	MINDz1m+xx2XsKuIncFT8RiwNtMsInV5p16VvR3fYTyjtTZZoZeDFTQ0imU7uzkOePr0TmEvLQ1QL
	WdVLBMdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRVvn-0000000AQMI-2S8Y;
	Wed, 10 Jul 2024 11:56:19 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRVvk-0000000AQLi-25h8
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jul 2024 11:56:17 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42671c659e4so1261495e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jul 2024 04:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720612574; x=1721217374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMrcvl4SKuZA/ORUeJhfOQOkhDAp5kkw1k64MaNIGwU=;
        b=uiKC2gElBNrDjK3+BYRE3nFvmbyCqq2SFb6fKWIUjdpe5T8dErU5ALYaBUbaL2RAur
         vjn6NOB1OhFpIFBClC9MXY6T+4VEiISZ8wESxbsGUxsCRh6bBW1DhC+zgLFOg/r3ZOf8
         lfGDRhFgtpMNT+d2JRYvR3nVyPGXcGx/UGAD6xbhVa8bEtzpvoONofUN4X+UdSfSohbq
         wUm/X6+YiEpXVtxn/13FLzz1EZnSlRXxtRkxU0EI3jlmcTRbAI9Zw0RKOFupiY20SHba
         JoKqxz6ZwbxWIFyIXuA6SMu/Rrf/4QSaE81elkR1PugA1TXBHtKG8SvO+fdL+kpoLOv3
         F9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXwLebHKBsRXnYJRcqQYR6CiYwmjq8R2RNRUf3jduaihlbKWuVVKSeeMuXVlCXCqKmoRn30f4nhTQN4za2SInzgsjf7CZJ3r0FKMG430wg=
X-Gm-Message-State: AOJu0Yy3VoevEKADiSAeoGn8FxziDcyiVb7TjmJ0oHJipVIhqRxdBOY9
	KgBs9wWyZciSNL+l5rgulzQ5yRoNSdOO8sSaaaJmHvZI2U2ykwq+
X-Google-Smtp-Source: AGHT+IF5y59VvHpD10ktAF9fWEwHMWj99/Em3FV5cwZBKdJBjh65eHeHEXSjZfaREP+Zmq7HqNwFRQ==
X-Received: by 2002:a05:600c:1c81:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-426707f9cb0mr33732495e9.2.1720612574056;
        Wed, 10 Jul 2024 04:56:14 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427272c4371sm43453015e9.22.2024.07.10.04.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 04:56:13 -0700 (PDT)
Message-ID: <33f72b7d-d1da-4c5d-8aa1-1df2559b9588@grimberg.me>
Date: Wed, 10 Jul 2024 14:56:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/3] nvme-tcp: improve scalability
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240708071013.69984-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_045616_571124_8A14D126 
X-CRM114-Status: GOOD (  11.09  )
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



On 08/07/2024 10:10, Hannes Reinecke wrote:
> Hi all,
>
> for workloads with a lot of controllers we run into workqueue contention,
> where the single workqueue is not able to service requests fast enough,
> leading to spurious I/O errors and connect resets during high load.
> This patchset improves the situation by improve the fairness between
> rx and tx scheduling, introducing per-controller workqueues,
> and distribute the load accoring to the blk-mq cpu mapping.
> With this we reduce the spurious I/O errors and improve the overall
> performance for highly contended workloads.
>
> All performance number are derived from the 'tiobench-example.fio'

Did you keep the fio file unmodified? I'd suggest to run it for longer
say 60 seconds each workload. 512 MB is a very short benchmark...

