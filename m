Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3518D743FE
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D05HFEfzVtIRd0z7PsMq2blSxI/si9IfLN79k43B55Q=; b=pD+yi46jYTaxaizVGhr/Gu6bA+
	bnTZ+vCcAvuQ9c+YnO7VZDY3fteejmfsB6p49ToEucDC90fyDjTvvCV93EPft3KLt/tpgaj+8Sh9W
	lE2bhfPVyPvJzVYK4AuZYr2sFd6NuHsaEFSRTOvJgTKthaGPPJsrDWdtdh1lGWZW5A4/fLrrfDEHR
	+6PMrvXXTiD5W/bjfHGiylGdGUXrm3NYwg65g1R4ov3Ojb5CMFoOGHIH/eg+CEo9V5lAB5xgPoCrH
	TPhvrPnHTfv5i6JkEqC4JkyRbEf74BOLkE5eTcwoT0NhSli4QiaNwVbsUgkqel2953c3IGS1NGMZa
	sZ7as86A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEBSV-00000000bYL-2NPD;
	Thu, 21 Nov 2024 17:59:15 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEBSS-00000000bWR-2IZj
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 17:59:14 +0000
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-718078c7f53so572445a34.1
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 09:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732211951; x=1732816751; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D05HFEfzVtIRd0z7PsMq2blSxI/si9IfLN79k43B55Q=;
        b=e45SBXIyubdm0+mVrsh+5lq0KSKVC575HtdgbewUVNIs/8TDf5MbKipiGzQ0hIISpz
         BDXXD34qNoGW+vLJozI44CJpTV2KORB9IZxo+OLvy+1nArW9k8jU2yiY0fEE61XNif8/
         XY6b/UFf0bLhb6NnZ/1NZmbDR7r/HyJADVXt06OV8F8CBimgDA7iAqCkMjoweLsifoF5
         R4iALNU9LzKb28HMVgOOf9qRgqcue9p4CBMWpxGpLyDzn+UNw1qXAANab5Cq+dienbzi
         Qiclrot/01++yNAVor0J2FCy3XS5AnzReSGdEsjAaDTEcgrFxpVG4ZBS758wtihyQU9I
         5WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732211951; x=1732816751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D05HFEfzVtIRd0z7PsMq2blSxI/si9IfLN79k43B55Q=;
        b=GCzRr8C+fjZJv/5P98Ch+LCfRCph0fcFrFfXNrFRFXF/PB8hPYkL0kNwQTP/qxBgAW
         y9Ihv1e/uHhuvcnshyF/usN8/bIsA04SaT8kc4uFDxndWODUMk5IKLawrjg8U+ZM5j8m
         PU9HFRldIXtFde139sNCgo6FyFPox8zGbP4z8ssueSfTWuZdhbLp+X9NFjBReecQkJdT
         hqBoMY5JEGb2aTNe0VJ68dDmehBr3z7PZyxnWf0Vv2rjcqjVtIkXZoJlk6sfjlgyx7Bf
         zv1KvMK2RTouPUgYc9M/yN9c7+FV2C/iWFryKTsPCWPzG38iimdMFh9Z/1+50HFOyU7v
         OW8w==
X-Forwarded-Encrypted: i=1; AJvYcCUlDHZ3y9Mq4tSTzSTZ82Urgw9BJtLa6lV1HpqBmoIcaOJyizTsm3qYdq3oPAHhtkRGo3wEpv2JVSBD@lists.infradead.org
X-Gm-Message-State: AOJu0Yww8jopnd22WFtaXEIyWJysbhZQfZvXZ3sLyvGQQM9ZwhUzVHJy
	L+xV5GdzGjhIfdg0G/FIytxLWEC75FM1ATtp1BRkbEKGAdF/nhrkLxOQudzETxQ=
X-Gm-Gg: ASbGncvUKthOYkzcg1WQKJ3t+BCcIuFYo+z1p4LHg5mis5wz8vjEYG+8d1RGGGW/DNl
	IubB+rIan6Yd45tHQe9Xe+0F3u3seypn7PjiKYEZRQ3pp2ME4AyJSD460klywrztN2Bjmq9zISI
	XraKsMMxaqGOIuFZGgAEZNu4EQ/an5tQMUbqsZEz3YIvyRN8f68ezAB2ZCKTXKiXdLHapVrQHVV
	v3l1OpMiBRBwOWuW/FWVc79PtaVNsFwvzHeJdI12/s1Mg==
X-Google-Smtp-Source: AGHT+IFb+Ehby8+iMwGhfUnzmf3Q7UN2Ucx1UiUPKX/UL01Irc/kNP+mL4TLUh07rjYBNY/58101bw==
X-Received: by 2002:a05:6830:6405:b0:713:d159:ec with SMTP id 46e09a7af769-71c03c50e6fmr91567a34.10.1732211951396;
        Thu, 21 Nov 2024 09:59:11 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0379b241sm35637a34.42.2024.11.21.09.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 09:59:10 -0800 (PST)
Message-ID: <0a834a84-4f63-419c-887f-8479b79781ed@kernel.dk>
Date: Thu, 21 Nov 2024 10:59:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.13
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Zz9zvAF0yqzVbzoq@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zz9zvAF0yqzVbzoq@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_095912_803993_504DC954 
X-CRM114-Status: GOOD (  10.04  )
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

On 11/21/24 10:54 AM, Keith Busch wrote:
> The following changes since commit a3f143c461444c0b56360bbf468615fa814a8372:
> 
>   rust: block: simplify Result<()> in validate_block_size return (2024-11-18 09:10:33 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.13-2024-11-21
> 
> for you to fetch changes up to 029cc98dec2eadb5d0978b5fea9ae6c427f2a020:
> 
>   nvme: tuning pr code by using defined structs and macros (2024-11-21 08:57:42 -0800)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.13
> 
>  - Use correct srcu list traversal (Breno)
>  - Scatter-gather support for metadata (Keith)
>  - Fabrics shutdown race condition fix (Nilay)
>  - Persistent reservations updates (Guixin)

Pulled, thanks.

-- 
Jens Axboe


