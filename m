Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF75C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 02:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j6m+l1oUecnNNLOok0/YBcj8+iHstx9eNeTw7wBI+vA=; b=ukt4wUyLSo1DNaWfVpka+TRIDN
	QzzJqOyZs0HHtmM93AqmzkjTk7U+2HeAUuFo/Dw9lzJpZUGe/nql5MpqJA5E0npPHTYCAY9Ohz7RR
	AxkPKKYGjNKLh+PSeygtu4yfz6g6ZBEykb6M9KhvDW42QsRHIK28/3mmwwkOoktduHFl3cBuPCwqC
	ViSVIWQAwsbGjR52SYlhZLCx/qlqnKFRyLZu4HKnSXI5TQDh265A8+P6M9C2SpCSXlSK+4aVCsN/2
	+pcqERiTrzfaomui9XS4r8Mk3QV1/YxbPpEe65Gt7BMnG6UOaD1hIiPyT8XafY1Mjfe17Uwau+55G
	+LOAtvaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKWuA-008mYG-Pu; Thu, 17 Feb 2022 02:52:26 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKWu7-008mXc-K1
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 02:52:24 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 75so3784243pgb.4
 for <linux-nvme@lists.infradead.org>; Wed, 16 Feb 2022 18:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=j6m+l1oUecnNNLOok0/YBcj8+iHstx9eNeTw7wBI+vA=;
 b=1NIhBqfb2bt9IE2LPyzVew1RAtL5yrCM88EQpdmg6GEr8qnOkpIWCQ89qbETK3wn41
 405LfItUQrIwoslP8n9/+YWIZ8h07NA8EsHoSRppWXR20HRyv5w/21fyTrXSvRVAN8Y7
 OA5NYmoCc5xvn/zNbOGlCKoNQn+lLaqk/EM8oTUGT8tt6yVjkqfhZh3B0yxDqNF7fpW8
 +qDsvS3dKCxFJqyolz+geks4B1IuZCkWgZcOjtXovaSco6y/Zk6tprtJRVnq4prlsggc
 wsi4mUiJ+iiDJfN6TG9wrURJIjEV1r0soDnfP80XcpxiCpCfD0I77qRSeiutRLYLim/7
 g/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=j6m+l1oUecnNNLOok0/YBcj8+iHstx9eNeTw7wBI+vA=;
 b=IjcQRpicXIFrcM7lfCUQXV/ltsppVAeTC8VEkRMwhb6JUepcSE21XUTd5cougr7TJH
 hz+54Ox9v41uW/a3YdefqjiqKmRIt5fpr3LPs7P3q+VqdoWDfthYJtRCmfDVVyBTDopi
 zrIVFXxCrsWcwdxzS92Sdl7s/XLJR/wlsIbrAsCF+VLc0UBgWkZ/Wqh9vx0GjXtOjxe4
 /M2INRb+XXecA53EfwVxcJep37UH/kQzH7STHVdkjy3uRXf0enQJF0LjHp131i9ax9sy
 0e3Xi6FoHaTNgNXrOwG2C6X1VpWNt+ALcmK1lQkRH3lKhW05HxYHZlW8TouVKePVQgbk
 CiWg==
X-Gm-Message-State: AOAM532aQNojI7HqoZdDR33BjKG/AQRD4ntFMjMZbXBdIW3JeXtsJGgG
 oL3Nr2gnc17vm9jIIybuHRL2Yg==
X-Google-Smtp-Source: ABdhPJw5EWuYRb71wLCJIIGBT4noHs4G6tbIHUSogiGVkMhwAu8zdLPxq3GuTH+vZb/3vCh0Kw73mQ==
X-Received: by 2002:a62:63c2:0:b0:4e1:604:f07 with SMTP id
 x185-20020a6263c2000000b004e106040f07mr851283pfb.56.1645066342700; 
 Wed, 16 Feb 2022 18:52:22 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id b8sm1263990pfv.74.2022.02.16.18.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Feb 2022 18:52:22 -0800 (PST)
Message-ID: <384cd4ed-6727-d7d0-b267-6a19f58df7eb@kernel.dk>
Date: Wed, 16 Feb 2022 19:52:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC 03/13] io_uring: mark iopoll not supported for uring-cmd
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
 javier@javigon.com, anuj20.g@samsung.com, joshiiitr@gmail.com,
 pankydev8@gmail.com
References: <20211220141734.12206-1-joshi.k@samsung.com>
 <CGME20211220142233epcas5p3b54aa591fb7b81bfb58bc33b5f92a2d3@epcas5p3.samsung.com>
 <20211220141734.12206-4-joshi.k@samsung.com>
 <Yg2wA2xxrDthoCDi@bombadil.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yg2wA2xxrDthoCDi@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_185223_691410_737C046D 
X-CRM114-Status: GOOD (  10.98  )
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

On 2/16/22 7:16 PM, Luis Chamberlain wrote:
> On Mon, Dec 20, 2021 at 07:47:24PM +0530, Kanchan Joshi wrote:
>> From: Anuj Gupta <anuj20.g@samsung.com>
>>
>> Currently uring-passthrough doesn't support iopoll. Bail out to avoid
>> the panic.
>>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> 
> Jens, can you fold this in to your series?

Yes, we really need to spin a new series with the bits combined. I've
got some ideas for that...

-- 
Jens Axboe


