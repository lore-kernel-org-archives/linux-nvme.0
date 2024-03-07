Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0535C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D3sWop1hOvwEpTkxwodpQiVXfbfobljVmJAH0ryi9mA=; b=bvgwmRFsvD427usfBTiWURPkEA
	AMilDDDqQb27Ny3A1IjWeBPFghE2mk/2URIEGwAAypKv9v3syNAN80cJVpDvOQCndgoVjWG5uIlDh
	54gGE8iVFgVZ4AKdoiLas3PCCUmVMXmDE1f2JAOnk7/55E6O9aJ1qzd4o8m0/9AqkXolrgVPg4S4T
	ktokQbwjdqvb45axNXo4OgJ2n2EIOfYq2h4ThLjZtv+Zr60T1V2fh6Crt8PqchuvL5mzl72nEwWQ3
	uqI3qfm2TMSo1wzt+b5RLMcCvvgpXHhAxrLu8Lo1eVYIH3QT6/snPH05ktOyUkSSvBv59bUG54n8Q
	QwFk7+Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAJM-00000003usH-1eVi;
	Thu, 07 Mar 2024 09:45:12 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAJJ-00000003uqR-1xoj
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 09:45:10 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412bcca7c56so250505e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 01:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804707; x=1710409507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3sWop1hOvwEpTkxwodpQiVXfbfobljVmJAH0ryi9mA=;
        b=RazF0v1vzQJj0zrdkJ9MQMACuaH6BQMSC8ADcF6qbbbvfd+eE3H9KToNZZ8Nss2Oor
         IHjq+YUqm3xCmSPYcfABv9pJFe8F94hzPwjL8XOvK+8fbwip41vdC0brJNcqh9vFpH5+
         xrzvESnsTRM5Kzgc1NQRnYYWzbGFXcRtU5kNCstroV0gpdw5ku5CAz/XMGCSusYCPw8B
         DqK0uoGV3jBNofIlShgd9M46DMPPVpXWWab29380I724saiAqx9NySnjNTiPo6cj/ehV
         29Smo4HDXjaorDd27jGNMiqd8dhgPA++GQYUwlbYth7T4Q6bxiRfhoHXKpl6pI7s6YnN
         J3qw==
X-Forwarded-Encrypted: i=1; AJvYcCVLWtX6E0l59iAvq3zp36gkWheqJpNFRfGDqwVQjivXzzu3w2laJYcxpPPZnnblIHgrZNdECCwm9uCoTDKwcy2XvNeT609brpaQgAhj1fo=
X-Gm-Message-State: AOJu0YwZTGQqFnoMHXM5YFwKtbeE+o+PQ28HcuwUdz/qr4qlZiIKD/M8
	Fd8jbxNVy1eAFO74BMprL5vC+Js34jhV1HSxbIlv5FC4+8bWrneQ
X-Google-Smtp-Source: AGHT+IEbz8eiTFn0EcXe2AWBFHQWSXRzzq8b12NdthORVan7Xa/Zpfa3MGMYU7U2Q/GYGwnZj5ylRQ==
X-Received: by 2002:a05:600c:1d0f:b0:412:f82b:9cb8 with SMTP id l15-20020a05600c1d0f00b00412f82b9cb8mr1043414wms.4.1709804707531;
        Thu, 07 Mar 2024 01:45:07 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c359400b0041308e57a28sm2096934wmq.23.2024.03.07.01.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:45:07 -0800 (PST)
Message-ID: <1aee2876-15dd-48dd-a6b1-76ac1ebfc682@grimberg.me>
Date: Thu, 7 Mar 2024 11:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add 'static' suffix for user-specified TLS keys
Content-Language: en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240226122449.46976-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240226122449.46976-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_014509_539242_BBC97F6A 
X-CRM114-Status: UNSURE (   9.84  )
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



On 26/02/2024 14:24, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> If the user specifies a specific TLS key via the '--tls_key'
> option to nvme-cli we should be adding a ';static' suffix
> to the 'tls_key' sysfs attribute to signal that this is a
> user-specific key, and not one auto-selected during TLS
> protocol negotiation.

Static is not the best wording. Doesn't the user already
know what it provided? How is this indication useful?

