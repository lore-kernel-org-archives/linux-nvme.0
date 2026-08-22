Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306A1C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 23:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GToWNBYdWtqZihyp7bYRxbSGzt40gaMzEtJBxEsD0ec=; b=DH9ZFTTFv8VZgTI4+QnyvDVE1i
	MKYXSfzr9+kfO0sPpOM4zrcrIo4m051CxF0h9S6Mx9U03BudumEXkPhN6kkDvJlaXU4W4xC55hhta
	iFrr+YzOsxiZZWJR2Ui58Lcdyi7+80VdoGL+3N8PlgiF/OzC0LgMMP2dcmooc0h0quIUoCKxW8WWW
	1f3yL0Y6C8QOuALq3CIwyA7NNl3DNngP2f+XM4OW8ne874J328uQUSAW/MmhqAl35ULpgJhJMhZiK
	66KtjUwh0w8IxtqMkJVMZYYMNOZJJn6vlOyA7MZTK7G7mZ2T4OmphiBQuveJJY//LSsov70moRmYd
	HkrAfhEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxujV-0000000Eseu-2HbI;
	Sat, 22 Aug 2026 23:02:37 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxujS-0000000Eseb-3vJH
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 23:02:35 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2022323c37so349334366b.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 16:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787439752; x=1788044552;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GToWNBYdWtqZihyp7bYRxbSGzt40gaMzEtJBxEsD0ec=;
        b=DvE7RFNGederREPs6g07tPy+7ddPPnqLihOEPUwW47R4qwhacoJgTS2LB30w6y6Lyh
         zKZN6q5/MQoFuW/bJdpV0eD7HmApTLelComQKPYJzVI0o4wNRgqRDBxpBs9N0KsqQlVo
         BI4Ziu7iE/21hM2P6pdHjZsh7heHLjYgXg40HO8JmbgDl4X43O24L34uFkRtVE6DEtd+
         +FPkjTVCVPv/fuNpresJ6/TShd1fdOcwfp/olUxUo0zDnTW5K0B+5RgiXEAqAHG9vrt5
         3ZGkNSkF7AI0qvJqFEDEr7Lcpm8+LD4I44hl3UP2v1AwM6+/F75WHHGlkfSoJx7q9upj
         sOmg==
X-Forwarded-Encrypted: i=1; AHgh+Rou9BgxBlj8TCziQaM+dH3nFEvpmeTGSHGpvISlcMCWySXs2prJ0hJoLIUYQWaTAvV1/GjG3ppypEZV@lists.infradead.org
X-Gm-Message-State: AFuF++lFY6IbSmRjiXNp386CDlLkvPa8KGFkeTsJ00odJwP/FFm/7TYV
	e+sWexlM/YWDClf5zDvcmYXrO6kJJ42IX0MresQQtKJXzB0WT+9Z39Hv
X-Gm-Gg: AR+sD10/cXs+igElaV6tXoBkdjxAHvjo5ccAsy5j0+wndzxPGuVuIBscr40PmV2QIc0
	Z6EVQOG/B2KkXbiysfFfIFCcDVD4gk0/euo7KTlyYmbzLffk0ygzSQculbwFxrQtUYsQIGXshEk
	ecMTvY5eXGnFaZ2VMHwhGlAwhhP5HUfKlF9F0eqda8OZYo0zEHi+A9TQeYjhHxLWzk/KU0SmlJw
	z0m+86LIpPtJZKu7OpthQYsid9tPeOKk/SKwmY0ivzbGSdooVvkrxmzR/gOLEcZ0mXN51Tkaj7U
	ofngAWWgBLQ9GDvb0zOlNygpyGN/BYskCivDRIRivnbP2GRL4RlEqU43uczM/iIxr+d4XcVG/Az
	Ztfw2XTF6KFU9UyEWma8PMW82AUVxtcPflHpU6C5PlLN8clwNYmsbsEni20oUaSPivygDBpJMEp
	lAeqK+HEGrjRQkE6aURwayHaoxnKDFloYQywd7Yhx9BNhGrIqCjqsrWy+BLB4n8jOv5bnb7tpXx
	tBzcWMIMcMaEVO7yrntW+IPDy9RE2UpiQ==
X-Received: by 2002:a17:907:97d5:b0:c20:21be:ea75 with SMTP id a640c23a62f3a-c246a33ea8bmr1656712766b.8.1787439752499;
        Sat, 22 Aug 2026 16:02:32 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f6adfsm483205866b.31.2026.08.22.16.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 16:02:32 -0700 (PDT)
Message-ID: <cb6890a5-81d3-49a1-9179-08a453f5bd4d@grimberg.me>
Date: Sun, 23 Aug 2026 02:02:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_blktests_nvme/062_lockdep_=E2=80=94_defer_TLS_inlin?=
 =?UTF-8?Q?e_send_to_io=5Fwork=3F?=
To: Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Xixin Liu <liuxixin@kylinos.cn>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
References: <ajtk1CaN1pBreS4O@shinmob>
 <cover.1782436781.git.liuxixin@kylinos.cn>
 <8803a2bf-3f8e-4ee9-b6d7-5467bfc1b1ce@suse.de>
 <reply-hannes.062lockdep.20260629.liuxixin@kylinos.cn>
 <reply-hannes.062lockdep.20260701.liuxixin@kylinos.cn>
 <aoPuIUSQvZxujmv7@shinhome> <ee0225fa-6a0b-4933-9a4d-5c77792eb94b@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ee0225fa-6a0b-4933-9a4d-5c77792eb94b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_160234_986629_93EEF31B 
X-CRM114-Status: UNSURE (   6.11  )
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

>
> I actually thought we could do away with this 'if' condition completely.
> But that I guess requires more analysis. So for now:
>
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
>
> Can you send a formal patch?

Yes please, and feel free to add my:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

[its possible that this came out already and I haven't got to it yet...]

