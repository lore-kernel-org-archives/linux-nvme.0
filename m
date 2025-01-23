Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291E9C02182
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2025 22:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ls4BbGB923YqnVDO8N2ChNuYoAeRhKjTuymx3RawGWw=; b=ZJdJM3+n7swq3ws/iwMPR8q4NK
	5sJiPiZTz0kExdXGv/pUmw4KvgbqVQPjxluG2Ksd0VopcRLCB225c3ztKrJnHWjxMJGLq8h7DaBuh
	S2/ac/g24tasi/CnjI63kp3PEAhcBDRsaIDcR42aXSzRXh5J/ReAt1+MvxDXr2LG5isNVvxuFWuH1
	VZ5PixNow1OJ1n7VKj8lrAz6wbODXXcea520SPlIjrtqIJTVElowwadjWEHRGXzGtFxTSdjA+Hjrn
	jCbmQarV9Vzc7pUo0nvcxd/L23+18TEckQ2Dic/YhUpNSPsl4EbNrmBWrsg3IJWIBe61vsAJ2dPjs
	XzOvF90g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5SB-0000000DO2B-1VgH;
	Thu, 23 Jan 2025 22:13:35 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5Rm-0000000DO0Y-3omS
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jan 2025 22:13:12 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso10537175e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jan 2025 14:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737670389; x=1738275189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls4BbGB923YqnVDO8N2ChNuYoAeRhKjTuymx3RawGWw=;
        b=aa0NV0tZUS6E0OKGoql8EmNa7jNuNk/KzXP/iClS6s/oEK31kZkpwvNdmbrIs5Xezs
         TdNQ8g/YTbkVdjgRG/shlmJxr3RlVNBteRuJD10bgCLPZ65OWAs8uJjiDjY31UXlAu8t
         hXssx5J6zW5kKRTdBmRr8d3SzNbeylljsHehwydbc6GZtShydf4Q07pyRSIt/RPkiEQr
         pBpTjKGib9conTdfljZ905Ok6Zypj+630RxKRn4c0pJX7ohanaB/gzNXdKQLN11YeKh3
         oVKcbMsmEcv/bi06sQEuw9ZnDoEcDKeoHYllr8GMT1rdpPeHudZXowH5UF3/qaE6VDdb
         2Jhw==
X-Forwarded-Encrypted: i=1; AJvYcCWjg2BMIQou9U47pt1uqhC16WVqTLaoQD1FecIEPjGA+6VLlw+0PJ89B1LeExAk3lRR0/HAq4ZiYx5L@lists.infradead.org
X-Gm-Message-State: AOJu0YwSV3gEjodVoBFLsyt/880HDJvxSBwn5hxIk6F5AGP5JrGEOTWJ
	csYsSWCHiWvUnQtP4dFtwX7xoTy7cPm4arZj1JwEUfElamtZth6c
X-Gm-Gg: ASbGncu3hmGRry6Du4ODhvSVpv/6Oa48vYoXsr8cUIU+VKzS9KcK7QMqra6fJ2txo6X
	CaLUDlqnrxB0SGXuoOfhpQCXMRGIM7vpXPCPY+evtuAlzEV3IDdjrZHrNDOEzR5pxxapovNl5K1
	f61/rra++dxluY8sRC8ObKJWgR+ezqgVLEnRqXqQtSb1Z4Ro2B4F9whaExjjQPzRjdkKhTTQIZD
	D/TlwUFsQjH/yyBorWDjUh9q4Gc6v7D2IYmY+91Z7n8RqIud1Sntqw2YI1wt2y50kV8mugwZldI
	akNkm2E2fAOAIXlpPoFGykBMIFXs4nU+7LxjdlN8ph2W68+pa4s=
X-Google-Smtp-Source: AGHT+IFAardb/YezwH5XJSEyOUiMKdSo87zmwdBbvfkgWOdwiNDUl6U21UtZAFBPZDB1wk12f1g4WA==
X-Received: by 2002:a05:600c:4ed4:b0:434:fdbc:5cf7 with SMTP id 5b1f17b1804b1-438914373e4mr250713595e9.27.1737670388801;
        Thu, 23 Jan 2025 14:13:08 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd50184dsm4839475e9.10.2025.01.23.14.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 14:13:08 -0800 (PST)
Message-ID: <f10b3efc-4341-41dc-ac76-92826df440f6@grimberg.me>
Date: Fri, 24 Jan 2025 00:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv14 00/10] nvme: implement secure concatenation
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250122165829.11603-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250122165829.11603-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_141310_959396_C7ABE7AE 
X-CRM114-Status: GOOD (  17.64  )
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




On 22/01/2025 18:58, Hannes Reinecke wrote:
> Hi all,
>
> here's my attempt to implement secure concatenation for NVMe-of TCP
> as outlined in TP8018.
> The original (v5) patchset had been split in two, the first part of
> which has already been merged with nvme-6.11, and this is the second part
> which actually implements secure concatenation.
>
> Secure concatenation means that a TLS PSK is generated from the key
> material negotiated by the DH-HMAC-CHAP protocol, and the TLS PSK
> is then used for a subsequent TLS connection.
> The difference between the original definition of secure concatenation
> and the method outlined in TP8018 is that with TP8018 the connection
> is reset after DH-HMAC-CHAP negotiation, and a new connection is setup
> with the generated TLS PSK.
>
> To implement that Sagi came up with the idea to directly reset the
> admin queue once the DH-CHAP negotiation has completed; that way
> it will be transparent to the upper layers and we don't have to
> worry about exposing queues which should not be used.
>
> A blktest submission is in
> https://github.com/osandov/blktests/pull/158
> in case anyone want to run their own tests.
>
> As usual, comments and reviews are welcome.

Looks good. already reviewed.

