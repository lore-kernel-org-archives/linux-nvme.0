Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBDECD13DF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 18:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NXLg+nrr3M9M+FT0+QCr6ZD6pc/R7QelMFoBuHbRWoU=; b=sgCkOXlRQ7wv9IAJDQAH9L0FMd
	x9ssOKswmW1kQylbRgr+dG3HGpUteIr4ZZ3KnmXH5yfgNLL0d18kI/Js9iVTBcclb8twJKOewKrCK
	TpzNaetZtTafpYykBwYIQx5vdmoiL+gB6KczU9cOOlGUATdHTtgTeH/p1jJGIAe+RSLDAB+IKXVxu
	hHTuwzJZwCpBJI6bEaQrzvXxSd/6vW6yODYFRW/Hp6VSxrQF6vwRdWDEzZiMiNxQ2EpVx1oMy5czo
	1Ra3O+r6D0TIse2NY/42+Wwyj8+qPQe2PUUV9lqpgFt2ignL/0sTHaxKV6ImeDOQORFa8MUxxkpj3
	mjuXGRIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIWD2-00000005pfT-01KP;
	Thu, 30 Apr 2026 18:34:00 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIWCz-00000005pf3-0p5z
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 18:33:58 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-43d77f6092eso821001f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777574035; x=1778178835; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXLg+nrr3M9M+FT0+QCr6ZD6pc/R7QelMFoBuHbRWoU=;
        b=evDMpqVwnQudOa6QJdKr749BdSnsFGhAqxFOXOMJM4dmQtPAOoqrl78E9V2ZCIdeE0
         r5QOJPg6E5+C1OvvdCyL66mmadj+rTn2NeP9IaIOKoRyjvI6XDVQs5Hlst+PeJv7/zS2
         u0UsBfLekBDzRal4wA85hh6hv3HKJ/pdPf4VEbjp2TOyqMEHXQndGSOheCf6hDfoN2mD
         VxcbMuLksjAf+opyB5gFJaDOirvXghHvzT0C6m0I0hTwgaWxSD8vVuoSVqnMufDBXqM9
         IlT8oE/OFcXlkDxRenqCU8kNTaLFbKy7otqVDidTnRz9Dz+OOyXlEoueq+bVPfvVLLYb
         jA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574035; x=1778178835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXLg+nrr3M9M+FT0+QCr6ZD6pc/R7QelMFoBuHbRWoU=;
        b=SjIy5t4Qgiy0ZSeDIwENpEwOh6PqAtt22BrpAekBIx4WYEZ7PN3uZ7aGHX9LPNXEo/
         lnMniVEndUZG8bzAMiN98BGNQT9K6y1ml/wDt2SnPLgRTLBJXg/yiu6s0bmn1ePN/2+6
         Pt2U2qsk6Zw6Umr4s0Nm2RqjAgfdJnky4T9dr12Nfqp0PjIO2B7B2aRwUb1K4yCD48Wv
         yppEq21HrIRrtxzLj3GbPYsSRTkqbbvWgHxg3eK3Lu4hSBD434YN5IuZkUJCLrHh+IVi
         xL9DhcfGsx/1L3fOZFSJolSQFj0VRjz0pUSRYpXcJfijMFMhQzC3S7sdYP2VW8PiuiRB
         hNRg==
X-Forwarded-Encrypted: i=1; AFNElJ/8XvBk0Lkr7O3R0glTomL/bsOCMLgn6vJNiMkYUIntPnD3YpI5Ttg7zv8G0hycdt24XdjkSTp1Esf8@lists.infradead.org
X-Gm-Message-State: AOJu0YxDXLotdr7OXfbpued0iriOdclORt3W3a+tw6q8FxYNLN1DC1Bd
	VK9hFut+v21w0INzfcgJeqw6yCTtHfmt6hGnqLv18AKsAlSXStC/jwlM
X-Gm-Gg: AeBDieu64AYehwvZuQaND55mMlY6paq+o7HTXrvn/HmicQKyWSTEWircy/MHOTYZtEV
	M4uXRQ2GrhHAl6ThYOZJ7qtYsLFTDA5X4lNFOEzn+MRzPlKllv2HeUWBt0EPJg47hwB8+DfDx48
	rSpM/lD5GGTfDqvb841JcpPOtv0h/0u9H1EF8iXtQ2HZMSDODv+AWP1EPQHvTTAu2W47EjRMjOC
	8MDmmcx4vmm868GTTTfhonivA2U5gPmVIPmTY2A6cNGSWKMy1z0e60rYNk8baXMgQjIRSI96Tvl
	fVIBciEY51NyV1jUT3CA25gfV0W0SDmjRe5RxAmjkZAF62Mx85QgwHNqaO0esoObct7NDglRL01
	F13LsOpKlCBMqsNrKiDXT9tDs7oN2nxFcWjI8oWQWrp6tYNuZsDjcw7j6ZyTIIalzUcu1oqI99C
	dwdvp28ixY/kofFJLXnl8trdw0WG3D94HdA5FwcsLo4uf6GWD8PROMwoAp5xSeT58jZMHc1GJCT
	tsFVz4gJthU5fvfqwksnYyGJvyJSVaHzquNP313F80KioEn8uFVjIajdnVVyMdSvYYlCQCvN6R6
	FA==
X-Received: by 2002:a05:6000:1a8a:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-4493fa01beamr7079438f8f.32.1777574035154;
        Thu, 30 Apr 2026 11:33:55 -0700 (PDT)
Received: from [10.109.92.8] (net-2-37-141-89.cust.vodafonedsl.it. [2.37.141.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216eecsm13579672f8f.9.2026.04.30.11.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 11:33:54 -0700 (PDT)
Message-ID: <6cce2f4d-7400-4618-82ce-cbd5004c92a4@gmail.com>
Date: Thu, 30 Apr 2026 19:33:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] file: add callback for creating long-term dmabuf
 maps
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <ae941457cf6cacb9d4c16b6ec904da9ef7fed97f.1777475843.git.asml.silence@gmail.com>
 <f0dd8f89-835e-4331-b593-4405ec59f4fe@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <f0dd8f89-835e-4331-b593-4405ec59f4fe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_113357_255145_9C0C26D4 
X-CRM114-Status: GOOD (  13.54  )
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

On 4/30/26 07:03, Christian König wrote:
> On 4/29/26 17:25, Pavel Begunkov wrote:
>> Introduce a new file callback that allows creating long-term dma
>> mapping. All necessary information together with a dmabuf will be passed
>> in the second argument of type struct io_dmabuf_token, which will be
>> defined in following patches.
> 
> Well first of all the naming is probably not the best. Maybe rather call that dma-buf attachment or context or mappping.

"Mapping" or "attachment" would be confusing as maps are created lazily
together with struct io_dmabuf_map. I can name it create_dmabuf_ctx(),
but I decided to use "token" not to collide with dmabuf terminology.
e.g. I wouldn't be surprised to see some dmabuf ctx in the dmabuf
implementation code. Maybe "*io_ctx" would be better.

> Then the patch should probably define the full interface and not just add the callback here and then the structure in a follow up patch.

I strongly prefer splitting patches so that they touch one tree at
a time whenever possible. tbh, I don't see much of a problem it being
not defined as it's just forwarded in first patches, but I can shuffle
it around in the series so that definitions come first.

-- 
Pavel Begunkov


