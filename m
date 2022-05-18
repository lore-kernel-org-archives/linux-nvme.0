Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E17DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 22:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TwGOpsZXmKjMebcqrmfjeutofyqjwqigUU8vU4Hxsjg=; b=tlCf+iXDFUCduk09vVOiq0bAxB
	lABN7LerabkQmI6GL+RG4APlc4mzQUDiKGxFnHHUrXLvXS/Ztvdnim2z6hkTJPSAFl389hRrhTI8J
	a14qgmCvg/nJtMt+3JeO8OucixoTK8VTpxKv/VRH4Q1l4UBLQxTmRsEaHQDW68baasN34vJipjZ25
	HSOJdsL+5gDmAtG2S55WOJkrnn4g1wuOmGj6PDkxGGXpkvHCfjRLcwh49l3/J3nor3PPWc7moEz2Q
	MqG6eMPjMFszqX9vmmRt3pzVXeHdU1lTtIE6YU55zoFnO/zr0NZN/GV2AxpWhw/bPCO6UmH6e0e3J
	vXhndZcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrSK3-0049Br-E1; Wed, 18 May 2022 22:39:15 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrSK0-0049AP-JB
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 22:39:13 +0000
Received: by mail-pf1-x436.google.com with SMTP id v11so3444133pff.6
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=TwGOpsZXmKjMebcqrmfjeutofyqjwqigUU8vU4Hxsjg=;
 b=ltO2bQWW4c9ju/2uK55hWAnRfjLi5f6mWGgzjz+VPPbGZ9A+Y4IqXH3hn1+sOU0dgX
 3kzudr1+8/ovu8n19SlVF4F8g6lWWCnvNZPtj3FENTwMhz8oV2+JX2J/wfE0MHsroYv1
 65ezdDzYMJ03lYT5W919MXR/+aWgKuaOxk7wQjYfWH1DNzxQMqo5WPFH5lF4J0Q1VkAB
 LWjqwoh+x5b10U22YJQQAzXg0sMYMTmi8g3MWKaaOa3ejSvZfPrziZmGewd6tMdd4XXG
 YTJRg1XzLyscAApvAZ5nzeisLEfndH+iMkGbPUIDOV+dJq8SJKLwZRllbeuf/Y5cS3vN
 ZYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=TwGOpsZXmKjMebcqrmfjeutofyqjwqigUU8vU4Hxsjg=;
 b=udkr1R7k8c19onDefBg0gAekjLK7cEIbQWkogUUeQor6vhHMbt8a//LH/YzJcqpQvX
 jDlLvGegP7sS6RZVDFEHzq7t+PU63YrJUIcOSZ5iLI9I1EUupgFrxj/oaDPqlOBYgocx
 yy941ChI4hlWS/RtRsmZhJJt2we5Cz2yzh9YUNA45g2b1FHU/tnO8WnBFZ/uweMBlAUL
 oxnM7ZoesaiAH7miRY6pG6hVfmY/GmZVHmWhXx0j2INde+zrrb2+NRA2Itlflyfa3U4X
 /8rlQOzHr/XUzdO6B92HsJyM9Jjz4HKFGWPKCXFEnislAtSnhbdFqyRu7Jd8h9rpgitk
 NCpw==
X-Gm-Message-State: AOAM530LzA2fzwcx4F05iINnwGitF2dCRhrK0lYbvvCTcqLFEWk5PxgI
 mzIrzejsc1PALoRCxnad7p67yQ==
X-Google-Smtp-Source: ABdhPJy7E1edQgt3ih3y4+NE5mAm66sIVfltCyXZCC1mkjHKtj6Ok+XbL/9nyPA5caK7Eaik3CwV4g==
X-Received: by 2002:a05:6a02:208:b0:3c6:9898:e656 with SMTP id
 bh8-20020a056a02020800b003c69898e656mr1406244pgb.560.1652913550177; 
 Wed, 18 May 2022 15:39:10 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a170903108100b0015f2b3bc97asm2147095pld.13.2022.05.18.15.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 May 2022 15:39:09 -0700 (PDT)
Message-ID: <c412b561-defe-dd86-1d4a-14dc10fc20fb@kernel.dk>
Date: Wed, 18 May 2022 16:39:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] blk-mq: remove __blk_execute_rq_nowait
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org
References: <20220517064901.3059255-1-hch@lst.de>
 <20220517064901.3059255-2-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220517064901.3059255-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_153912_678550_F58306D7 
X-CRM114-Status: GOOD (  11.54  )
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

On 5/17/22 12:48 AM, Christoph Hellwig wrote:
> +	} else {
> +		/*
> +		 * Prevent hang_check timer from firing at us during very long
> +		 * I/O
> +		 */
> +		unsigned long hang_check = 
> +			sysctl_hung_task_timeout_secs;

Trailing whitespace and odd formatting here, I fixed it up.

-- 
Jens Axboe


