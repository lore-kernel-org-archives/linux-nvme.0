Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836A4C3DA64
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jul 2024 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4fOkcJDRNToPHQZUBta3OCRjs/znt5HfYgsSbVlpWO8=; b=nucWzS1RxNL85SWgXOmXaRn/vN
	99jF54xW+4j21ADuQiuDRrgR74DzQTzZaKhrVIw+x94dm90eu5dCF8u4TyS+xHzlR66I9W5Ut9JS3
	/en4NceKF0d7eVgw0GvM8W2PQPbRD8hO5k5fB/LLyyKV0cHfD+hXMK6lQ7jsedorLNnYxBS20ZHUN
	oSNTb3Jas4T766xo1ZRGtWDSo+GJI7Z/C/kn+DHnPh9co/+dNcXC5TnjwvCdq0jcXNpa8qKJFel1f
	AendE13EL9boMcthJ2nEUflcCeQdOWKw8PDxiHWay1S12fyY4g4lD9vwg153kHvo+lzvWXy+LTD7Q
	a4w0xoWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYAqi-00000009C1V-3m6n;
	Sun, 28 Jul 2024 20:50:36 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYAqf-00000009C0r-2Lla
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jul 2024 20:50:34 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42803adb420so2241755e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 28 Jul 2024 13:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722199832; x=1722804632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fOkcJDRNToPHQZUBta3OCRjs/znt5HfYgsSbVlpWO8=;
        b=kMpsT3F9EnDxMXEZKZkfejtJRXkIeKJaGtdwYPdGwLp3bOaQcOPGK7pvG37geESPRQ
         bqC7msWMNA5IzYZgjdduTn+t2+7w/0eBC/gI9Ma5ZyflFYFevv1FviKt+6cq2E8yqlQr
         f9Fj1qcOp2jq1XvXsUnnEm2OCYhbcxZvKeHlXILdddZ95z77iU3di1k3aQ4keVmbVBE5
         kWCQ/ArPB8eWvHIK7heXGW/unWUxaVYlY8xSxPxo+NWT6eWdgNM5Rt5xXR1Y73T6jAF1
         ZK/hYObl3LGaj2lomVfrtcRSJv6TgX1RHBjLl5PPEFb+UCIpdXeTmaV/CXPLmRhdziy7
         RvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIxCCmGIco1kQm7SmoCcPmv76w7yqDzMYM2ErnwQnF0bJL0RlXOxfdtjw2eVnuhcCALdpS+a9TUlp1ABvhOkTPXKSNV/gfCWpFHQNnTpA=
X-Gm-Message-State: AOJu0Yy/x+aWq+w/5f0gahlm9mq0P6quGS7LiaewNAXugRdlb/bbs5X/
	/2/AvcGalYtKP/pDzMjncu63hP9FcY96Q7Tx+DNo9v9X4Jrrv76C
X-Google-Smtp-Source: AGHT+IED+zeyxzN9JB6HirBf/qXPP7qnC4qIb9Q+VbBMnALR5B/F2aAlppSNfbK6j8qoU8lig4OwhQ==
X-Received: by 2002:a05:600c:3ba8:b0:426:4920:2846 with SMTP id 5b1f17b1804b1-428054f12e2mr50866275e9.3.1722199831497;
        Sun, 28 Jul 2024 13:50:31 -0700 (PDT)
Received: from [10.100.102.74] (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42809eb192csm89916755e9.1.2024.07.28.13.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 13:50:31 -0700 (PDT)
Message-ID: <62235abd-a1bf-4892-8310-34bbf6c8982f@grimberg.me>
Date: Sun, 28 Jul 2024 23:50:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 0/9] nvme: fixes for secure concatenation
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240722120226.88737-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240722120226.88737-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240728_135033_632124_006FA5D7 
X-CRM114-Status: GOOD (  11.32  )
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




On 22/07/2024 15:02, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Hi all,
>
> here's a list of fixes split off from the secure concatenation patchset
> as they really are unrelated and just are assorted fixes to get things
> rolling.
> The most important here is the first patch, which implements TP8018 to
> support the 'version 1' format for TLS PSK identifiers. And it also
> updates the sysfs interface to allow us to re-construct the nvme-cli
> commandline from sysfs attributes.
>
> As usual, comments and reviews are welcome.

Keith, for clarification, I think that both Christoph and I are good 
with this being included.

