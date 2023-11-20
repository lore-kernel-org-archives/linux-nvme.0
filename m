Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF8CC54E76
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 10:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/mpjNaJompao/Eu3273sR8jB7ryD7Xh0dcC+At10JAc=; b=bMOjOUzV5/C9CzhnlrfV24gBPd
	UJ8Ljf13O2BD45g0b4YsyL2PfGHIUfIt1WPczP63iI9bRWW0wBswnenrfdSNnjfGbaQHlfQZKEsFp
	rV2+Xv9yC1dlUE5xGFM0MmDW5sWmhj+f5gG8H/JDFIVgzKgFXoUlUcHiAvwIWWAaSF5rOyFGfs+hY
	Se6QHhDwbrdListFBhhy5WFIuhgh0NiMUBROn7dg6+vAyI7SnCZmXonkBO3iKTfSKnMAnkVOHDcX8
	wq0bXDosB3jchgIcvEM+TJU03c437Ya/e8QljkvSvSEYJPZaJlP+vfJ+kGT1hafYJ6duXHTWkUvi7
	cjFUmmCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r51Mv-00BkvR-2l;
	Mon, 20 Nov 2023 10:19:05 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r51Mp-00Bkun-1q
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 10:19:03 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9c6f0530929so103563266b.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 02:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700475536; x=1701080336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mpjNaJompao/Eu3273sR8jB7ryD7Xh0dcC+At10JAc=;
        b=v0r3TlT265QBhKahHE8Qx+rg6FM0+ks+fEhdoZkWJ+IWUuPhI4OucF0r/pymQPh9R7
         vdU2m5L6d2hLtMt5Cmia1ZtGekE/GDZ2NArbGW2zHi4UeE3sa9wmEsKeYZsSY2DBPtYY
         V4D1Mwomz2u/RykmjxaHkY7by31IKpKck5UaHwdtxXc3gSXt6qqT42JaLlv7xeJapmhW
         +KHVXKE8YCTwXZwN4TnPue6ohXUI22e+NYh1ISm91w5s6PSbzU6KwBlgVWSDCtLrum1l
         /aqd7VBS2yxWt+0aTlSauGDwJUPB/oYVRrFnlfOc7wRMCeOcW9lIELBzMaVNIaT8JTAB
         q2eg==
X-Gm-Message-State: AOJu0YyKAimRbO2VhK3RXWDyzlqjrohRmmwqtAoam04RcxBlWG4J47dd
	Xw8rWts5FqYdLoV/VyctC60=
X-Google-Smtp-Source: AGHT+IFmW7cO7hdhtkh7+AXPePkas883ITLj2r+7GLg2FlUoz7jfsfx2GUpkgIDxBqLV9DLvLvh4xg==
X-Received: by 2002:a17:906:10cf:b0:9cb:b737:e469 with SMTP id v15-20020a17090610cf00b009cbb737e469mr4829185ejv.4.1700475536100;
        Mon, 20 Nov 2023 02:18:56 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709062bc800b009dd8473559dsm3718134ejg.110.2023.11.20.02.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:18:55 -0800 (PST)
Message-ID: <2fc7ca93-3ad7-4127-b779-76c32f8d9124@grimberg.me>
Date: Mon, 20 Nov 2023 12:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Yuanyuan Zhong <yzhong@purestorage.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 randyj@purestorage.com, hcoutinho@purestorage.com
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
 <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
 <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
 <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
 <20231117132846.GB7867@lst.de>
 <ZVeW-8cNNVOvNdaR@kbusch-mbp.dhcp.thefacebook.com>
 <20231120082346.GA11622@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231120082346.GA11622@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_021859_612166_90BBA2B9 
X-CRM114-Status: GOOD (  16.60  )
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



On 11/20/23 10:23, Christoph Hellwig wrote:
> On Fri, Nov 17, 2023 at 09:38:19AM -0700, Keith Busch wrote:
>> The effects log is per-CSI so different command sets won't create
>> conflicts.
> 
> True.  But that wasn't the point anyway.  It is that different
> controllers might expose very different namespaes with different
> capabilities.  Maybe a controller with HDD namespaces vs flash might
> be a better example.
> 
>> Namespaces that are not shared don't really matter here because this
>> problem is unique to mulitpath.
> 
> Indeed.
> 
>> It doesn't make sense for effects logs to be different per-controller
>> for the same shared namespace. The spec doesn't seem to explicitly
>> prevent that, but hints that all hosts should be seeing the same thing
>> no matter which controller they're connected to:
> 
> Also agreed as already indicated in the past mail.

Having every ns get its own effects log cache is another 4k per nshead.
Even if we restrict it only to iocs its 1k per nshead.

Would it make sense to have nvme_free_cels fence passthru commands
with an rcu instead?

