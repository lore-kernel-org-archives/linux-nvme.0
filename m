Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9556EC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 22:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5e3A7BQROq8pHrTQbOVSNDcP5W6YtGzTqCHh/+znOJo=; b=X/VBVbQj3bP5Ib9AhdqpROXW6h
	+t0umG3bF0Wm39o5B4jyi8bOFh7MCC9epZu6FOXzgZlZ+yCGkUDB2ajbvY/DBWd6PUadt2qgYT0QX
	d49LxM5G8WrE2fNrXc735GLqZLK4CcJQTffBcLcZI/nf8bdtHLZ3EiF4muKnKc6yPgLeN0csqQ/YD
	+FmaPilpaHp2Al+3/3WUdpPk+IDcD+2/A9j9bctDWhTSBX8EmHnV56mXd47/QD25qsJPBLzUTHwCI
	BlLIxvDkP9pm8Oy4BH/HLPMY/SHufx4hMAveqIVlCV9BVTWrLC2lt7AcJ2sOCKtdtFPyHmSzwyYG+
	8schForg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeRU-00CjLu-6i; Thu, 21 Jul 2022 22:14:48 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeRR-00CjJT-KG
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 22:14:46 +0000
Received: by mail-wr1-f50.google.com with SMTP id l15so108827wro.11
        for <linux-nvme@lists.infradead.org>; Thu, 21 Jul 2022 15:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5e3A7BQROq8pHrTQbOVSNDcP5W6YtGzTqCHh/+znOJo=;
        b=ai9FN9E8Q009jwIUL65rWNwyg3wK7eEfg6maOc7B1cEocieYfQyFtcZHeiGQKtY24e
         9596zpHYRBbMeDBsVhzNaoYSuQNROR0lu8AOH+SMAc03vVhNg+S4F+8vUZeuUkaeKe36
         b1Vt33eH0X8sYDknJmU0lphpoKcxOnRtNGcoXdR+LA3eeISDBjmR57UPX2vnAIoxSNDC
         2VOC+NTCRV42BUWafXEvwWgmTckhH8+4QSQcbFnhQLX/ynVx558hvQJfpYFuLtgw+LqC
         gTlWIte4Pw0UN6KO4WzQHiWOnCwtA9N31nOI5qcsUWjQTcvVnkPXVFnVGq3PcmYfReSh
         Wcog==
X-Gm-Message-State: AJIora9+0Dam0EUr/iAQvjaRaWL17E5yv6/cdzTAPq1t+uJykiCxCzG6
	aSMcV8iVCharzbwVYfXYhVdMRTHPYTQ=
X-Google-Smtp-Source: AGRyM1sruZX2ol9lBWur5Vutkuz0jmh7YyCa0yIf+qJ5U6WiXarFa1C+ldDGzYMPXHTPV2OSRQVHog==
X-Received: by 2002:a5d:55cd:0:b0:21e:5463:e2f0 with SMTP id i13-20020a5d55cd000000b0021e5463e2f0mr346107wrw.9.1658441682898;
        Thu, 21 Jul 2022 15:14:42 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003a17ab4e7c8sm8723497wmp.39.2022.07.21.15.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:14:42 -0700 (PDT)
Message-ID: <200d0cbc-3599-3418-361a-494b5fc625ca@grimberg.me>
Date: Fri, 22 Jul 2022 01:14:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: enable generic interface (/dev/ngX) for unknown command sets v2
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Joel Granados <j.granados@samsung.com>,
 kbusch@kernel.org
Cc: joshi.k@samsung.com, linux-nvme@lists.infradead.org,
 gost.dev@samsung.com, k.jensen@samsung.com
References: <20220718052503.235270-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220718052503.235270-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_151445_691594_FB8EA748 
X-CRM114-Status: UNSURE (   9.79  )
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


> Hi all,
> 
> this is a version of the patch from Joel rebased on a bunch of cleanups
> from me that I think make the layering a lot cleaner.  Let me know what
> everyone things.
> 
> Changes since v1:
>   - log consistent messages when only passthrough is supported for
>     namespaces

Looks good Christoph,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

