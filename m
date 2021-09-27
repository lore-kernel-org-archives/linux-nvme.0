Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2A9C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 15:40:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE7860EBB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 15:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FE7860EBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=X0zVNDJPLqdsOoy/voHKOehyOADV/Q8vvw0f/sFv7kQ=; b=kgBSnA+ScI0CLO1t4wMknpD+Pc
	zJ7NvJUBcLxjcPvnOezuSVLEPX0tVx6/rtFCG5hmmhTr0Sr3OiAMSJvJg3p9WAqfveE+gsQzo1AdQ
	gJHhr0+JdwldqcS6avhmsJ44GXviqQerh1plszH2le+9joTQ2pMul8udIMuknqBjvujGS90eqaBZJ
	GVAyidfhjWwKXylslIGJldlygkkfQ8CyDfvQwh05gLtYIpSOQ2lFeX8mI+/omoh+C2xjBaGJgx3mA
	U92EjQH5B236Jsn3xMHQbnYDAUI1Q0TehsVksZ08OuczHtoIxiOGcZsDVjVZuT9FZ6J9YeLcYLS99
	s0/CRGPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUsjA-003CX2-6V; Mon, 27 Sep 2021 15:39:36 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUsj7-003CW1-3B
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 15:39:34 +0000
Received: by mail-il1-x136.google.com with SMTP id q6so5782850ilm.3
 for <linux-nvme@lists.infradead.org>; Mon, 27 Sep 2021 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WAHfMK/wO4fMYiKU9LDZg4Jep2aIYsjvtqPdpQXlzlA=;
 b=cPjtNTXQ7jG9UfkpYtR2bmP66u78khVHJvzbhsxQQJgZ5a2+sm920mccP1Ajw4BEE/
 M00myu3fFRyGNfuBUt3x2u/mkvY1anT1oPvlyuEfjwf0+fie/IkPhdd3ykc7rRw/CaU4
 18i4iVanMkGeETLGRVKfZHYC9TyqAOFvrDWcTMMebpTtdW21bAhc7LZcFke5GFwzLUtp
 lIfyRxrBAhQSPoAMrYHnJk6xqdZ1y3/7J5F3M8dK9rtSm15v4loZQMBxganzf1toiTla
 MEhlOLvt0bE5BVvQeea2yjbR5hyffDQQ5EuqvTjHv6wjg1Ye0yrBa8LL4fVKgx7T8ifs
 w4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WAHfMK/wO4fMYiKU9LDZg4Jep2aIYsjvtqPdpQXlzlA=;
 b=LxcZEskKUrM357BVTJzhEpctMHtskvApSDzbzIQJrr9mc7xXkrmTQpMSqzS1sAmEPi
 OsrXS61/o/I83xkmlI21dpY3MzOMHfn/Y6G8BBSmqbExpilcR++jJ8gWTRCKE5l+FeWa
 Jfrk/Rdiy2peu7hc2iMoQ/kW2HL21fRJOP+3R4GHTlR1jwMFnvxj8MWgwuDqVo456oHQ
 B/LUf1QJMu4+/ZqqCEfvmpWsg9WF631QuucIHSh9DAmwK28UjDDuu0wK+F/EEpIe76O9
 rNnjByMJUD6UQqb2PmZMthhKerkZIX1sY5mQCCb+1MPtsdzO4PmjRt9ybIixMNpv/PUN
 /6Kw==
X-Gm-Message-State: AOAM530Ad+qnXotWQhIj337B3IMef0w0JQ5ntK1kABH2fIn8fq2d0jY6
 SSLv0M9LNg33vgKTj225KnxXLg==
X-Google-Smtp-Source: ABdhPJx2TtlVVewQaJWgDWOOqZP1A+fXDpcp9XoWi3kMMOS2ORttrMKa3Ms241TMQrRrEKHGmWSD8Q==
X-Received: by 2002:a05:6e02:664:: with SMTP id
 l4mr508080ilt.153.1632757171044; 
 Mon, 27 Sep 2021 08:39:31 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id z20sm9377591ill.2.2021.09.27.08.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Sep 2021 08:39:30 -0700 (PDT)
Subject: Re: [PATCH] nvme: add command id quirk for apple controllers
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de
Cc: linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
 Orlando Chamberlain <redecorating@protonmail.com>,
 Aditya Garg <gargaditya08@live.com>
References: <20210927153539.372986-1-kbusch@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <aea8dabd-4c5f-3183-89a3-b2019d004ded@kernel.dk>
Date: Mon, 27 Sep 2021 09:39:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927153539.372986-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_083933_235557_BCEF829A 
X-CRM114-Status: GOOD (  11.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/27/21 9:35 AM, Keith Busch wrote:
> @@ -1026,7 +1027,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>  		return BLK_STS_IOERR;
>  	}
>  
> -	nvme_req(req)->genctr++;
> +	if (!ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN)
> +		nvme_req(req)->genctr++;

This doesn't look right, as it'll never be true...

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
