Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1984C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNyhKX+44etDaPeXvf805XOJQOz+KJlCk+saU/ThMG8=; b=hHwdJAGBzq8xfPFSi1bPv34zFv
	T1NONKxp6XT+Xe1gTB8vYiB7BRq6/v9w4eKTXNvHdmxDJ788KzY/MmbR6bvxrbJx7u67bAuW2hTig
	3xRZfDZaPG3uBSnH/32pbEKqMpKhMhInyuCC81a5JGDhVCMueIAMvsDknxhEDUm2UF5iV+tlkKcB0
	NntIMj8gwAowVxpoasghbpO2dQhCofcIuW72Oh1FFSsNqAeH7CwftWX9o5jay42kyx6MO85xPGINw
	WAYNG7QBsRtXFHiTUdvJcD1TwKosFbmRxiA9SUzHQzT5BshyBylyj/+GiF3vwQvuy08TbTnPbE4jU
	ZsAnguaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricVn-00000009zv4-0Uap;
	Fri, 08 Mar 2024 15:51:55 +0000
Received: from mail-lf1-f54.google.com ([209.85.167.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ribSN-00000009dki-1paF
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 14:44:20 +0000
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513830f18d9so251198e87.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 06:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709909057; x=1710513857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNyhKX+44etDaPeXvf805XOJQOz+KJlCk+saU/ThMG8=;
        b=D6d6o5qLyI5DGdYE4VAy6I4Rfj56zghTvDy78Tpo/Vv+sNVR0Mm8hqD3GKYcKSuU+e
         3T9mVrhI2KCh8UCQyf9seiCFst+wuPToTbegv7j5rNJyKpXItT88Ol7A3mLOXS4FlZG6
         QStETz545heMmLZXq+Scb8sdg66GGaGImmUMiNWFKFSDD4ZvDklsyZWE6z6S38yQ71Zr
         cZt/Czg0uCd8+vXSf3WUHGk5Yxin7+DU0fHCWqZb5vQk2AdPrmpSVIWEy0Dpj2LaJKW3
         dYxWcNehLx0/k0lpnMireTgvRQM6z4NAjL6swaFpmiwCRnw8iW8XYjBP07bjCdfJymue
         jrtw==
X-Forwarded-Encrypted: i=1; AJvYcCX83mOIzGFKRqeA5DdJGQZcibRjaNHZIA6EtC4orGDN0dfAF6UTqLaA0WkYTPZ8/ZOcVChbYxFA+618WLA15HceXJ6t1/HSO+DNvINV1Os=
X-Gm-Message-State: AOJu0YwX0m9+dLF3LxxxtZsTQ0D+kSptk643f10HX561ivMJNwPDm1lJ
	e3rxCLABSk9KQDyXt3vmuxzRX8x93UhhBp9AOAnJnhSQ2KXZ9q8g
X-Google-Smtp-Source: AGHT+IHldJgJc2ijuaJnS0hYUOmRB065SGk6SQ22acfoGc6EFB7sbKNUttdDPGioyr9l3pSSKrtFXQ==
X-Received: by 2002:a05:6512:206:b0:513:4b49:e1e5 with SMTP id a6-20020a056512020600b005134b49e1e5mr1402433lfo.1.1709909056630;
        Fri, 08 Mar 2024 06:44:16 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b0041316e696besm2740963wmq.13.2024.03.08.06.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:44:16 -0800 (PST)
Message-ID: <c895887c-7b5d-4254-9a91-76fb31e661f1@grimberg.me>
Date: Fri, 8 Mar 2024 16:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag
 allocation
Content-Language: he-IL, en-US
To: Christoph Hellwig <hch@lst.de>, "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240308015435.100968-1-brookxu.cn@gmail.com>
 <20240308144208.GA9194@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240308144208.GA9194@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_064419_521363_5D029BB4 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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



On 08/03/2024 16:42, Christoph Hellwig wrote:
> The fix looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> But given that's we consolidate to a single place each for setting
> up the tagsets for admin and I/O queues, what about just killing
> the symbolic name and moving the assignments and comments directly
> into the only users?
>

That works too

