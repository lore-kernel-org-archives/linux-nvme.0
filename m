Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B21C27C5E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nkeWmt+Nx2AbtvOpSXf3xtCT93dTPkRd2wDT5Ci+nzc=; b=tnzQeZpz4AdnJ+cz/OcnDBFvJA
	f8H5oY5wiDar2fPC7LGc/RUdYY4kpVJ52ywseTzwNWd70EP6ZaVC+ozyrQd/D15VQYsOM9+8s7pJ7
	MSV24TZIwx8M0MaSNtlSguHEBzRTad/CW2+iCznQlrKS82bd71+80qWPrcncF37TBBSOQkiZMS+PH
	ui6Vu3cdO+lGQFS3sVvOgGqU0KIK+ugjbiofH2+69e5HYkQYZ+Xn5/wiF5LxvFwVSuCmma2KaV6MT
	xa38KAmr810la7XJZpjgaKWAQ+GK/SuEbg1lr74H80QsoJVpBKJFvIn1sIQ5omDMuQLUZSd7lr/cO
	yTe9A9KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGzG2-00000008YZ8-3ipf;
	Tue, 11 Jun 2024 11:01:42 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGzG0-00000008YWi-1CDQ
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 11:01:41 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52a559e4429so1057737e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jun 2024 04:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103695; x=1718708495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkeWmt+Nx2AbtvOpSXf3xtCT93dTPkRd2wDT5Ci+nzc=;
        b=ExySBIq3ZTR2RHtMkyihH92d+cUhUUPlur8VJKpaQuD2uvyPhX1eF8qMt5Sj7Stt/R
         BojHHBSoniJGn0ZfvqCCTqYehr2XpyLpVzMO+71zNHhjbaTrdVIlFnnj33yRl0tHNS8p
         cLwu91tSxSYhDDUtB/pf/64H1MrbjfGuFy7Ghqdlz/e6DeFxz4Ys7kkNV0z/OrZGyIdG
         MNaDB0iMIlPmDACm19Wg/R5TagtcpZHH2qL5f/FmDbjGf8XcW3pwzxKoR1+KXf+IhsHN
         Uo4dbFrUGi2E7qSOpOHk5v3KXOqyyo91kJfO/CUlOQyixODJCoBUa0H7xg5p23rd1aOo
         a2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXopYRQSn0nAVsUMFs5nt3tDpyRvRxWToizZqrZtOg0OAqxh2PaeVRZ4rtK0R2Vb55nYIKKceRjOYPAtpJ5LULjvOkASZZN/6xgZ6isSIw=
X-Gm-Message-State: AOJu0YyNkRzAgK5n54CEITmodUeaOe8CXCMTN0+05T247qdU38/nYzXc
	i/oRhZeuWV0IvEyjzqmxmQdbeyxQOITmiip983N0LlvJkTHuoeO4
X-Google-Smtp-Source: AGHT+IFFGKrZiYwDzEvS9vPvXOK2ImQGbAVJIS92wSdCM0deuyAXrB/gzLfnFmjwDtgXbv+nUtewTQ==
X-Received: by 2002:a2e:312:0:b0:2eb:de36:6775 with SMTP id 38308e7fff4ca-2ebde3668eamr39391041fa.4.1718103694508;
        Tue, 11 Jun 2024 04:01:34 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0d6d5ed3sm9915406f8f.19.2024.06.11.04.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 04:01:33 -0700 (PDT)
Message-ID: <6d53cf9e-a731-402c-8fc1-6dfe476bc35c@grimberg.me>
Date: Tue, 11 Jun 2024 14:01:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
To: Christoph Hellwig <hch@lst.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Aurelien Aptel <aaptel@nvidia.com>,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de>
 <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
 <20240610122939.GA21899@lst.de>
 <9a03d3bf-c48f-4758-9d7f-a5e7920ec68f@grimberg.me>
 <20240611064132.GA6727@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240611064132.GA6727@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_040140_361084_15501D09 
X-CRM114-Status: GOOD (  19.45  )
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



On 11/06/2024 9:41, Christoph Hellwig wrote:
> On Mon, Jun 10, 2024 at 05:30:34PM +0300, Sagi Grimberg wrote:
>>> efficient header splitting in the NIC, either hard coded or even
>>> better downloadable using something like eBPF.
>>  From what I understand, this is what this offload is trying to do. It uses
>> the nvme command_id similar to how the read_stag is used in iwarp,
>> it tracks the NVMe/TCP pdus to split pdus from data transfers, and maps
>> the command_id to an internal MR for dma purposes.
>>
>> What I think you don't like about this is the interface that the offload
>> exposes
>> to the TCP ulp driver (nvme-tcp in our case)?
> I don't see why a memory registration is needed at all.

I don't see how you can do it without memory registration.

>
> The by far biggest painpoint when doing storage protocols (including
> file systems) over IP based storage is the data copy on the receive
> path because the payload is not aligned to a page boundary.
>
> So we need to figure out a way that is as stateless as possible that
> allows aligning the actual data payload on a page boundary in an
> otherwise normal IP receive path.

But the device gets payload from the network, and needs a buffer
to dma to. In order to dma to the "correct" buffer it needs some
sort of pre-registration expressed with a tag, that the device can
infer by some sort of stream inspection. The socket recv call from
the ulp happens at a later stage.

I am not sure I understand the alignment assurance help the NIC
to dma payload from the network to the "correct" buffer
(i.e. userspace doing O_DIRECT read).

