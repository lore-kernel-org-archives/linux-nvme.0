Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D21C46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+qc8hzSGcovaBTW+nQhwMOo5ax2E0IJVjobKa/5UmFE=; b=VEGmZXObXIlywJfvxzqmGavg9G
	2UHpczFiWX1f8OajYGYyE4tdEkNVMLMTO5Z6IHYZAtfXKZM/IUGiJEF1ap/kLCgXfC8va7rmdGUqV
	j+bXwCH1tTBG8OD6/Tft/NgaN8U5BclNFZ7x0SO1uAuajkrokWQ/0lZZhuFp+JlOIS+ySL1X1YSKQ
	mN0JmcHkw2upAHXFOt/vKxedmETMajrgTQt7cP5weagQNcK7Fa/elAdx7PMW392mArbXVZaYkvCDA
	+IuGQhSO2xqgsFGARXqBOyW8IyFXIosi05S34I3SR+e/PwgPN41mzNlSuJx/YF7U0gC4Ohv/Jb2dn
	c81fCezQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFasj-00EK31-2d;
	Tue, 19 Dec 2023 14:15:37 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFasg-00EK1m-31
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 14:15:36 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3367659c42aso10273f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 06:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995332; x=1703600132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qc8hzSGcovaBTW+nQhwMOo5ax2E0IJVjobKa/5UmFE=;
        b=vRX65/El/uzODouS09iuWPDnwpThCMOK60Rd4shTHkbAVSyTpqjKJTDwU1xER3B2+q
         btJl1odzCfC9/8VkhgUR/MqEDG3m0l/b8SvK94vHU7ktPRNyEo60Al2ewnkTSbblTnAe
         /MagKfZdbpohq2MeFiCN6OYbuh4fAPig2qj55qzIUB9eBCWO+Ry3jmbo4Kt0jiCoP1M4
         8Y5+KOsnRfbKjGB3Ag29ZFsL4wk2IDXsPM72CP9hlGL/l0LMammE2DKbeq1BG+gouGWK
         KO1iQU7nJsJPpG8Oq//utTiVXkuV/LWWaBRJ63wQ+zUU36sr1MNRVPu64LSyivFgsuRo
         uJxA==
X-Gm-Message-State: AOJu0Yy/C8o48cgEGI5HpDxcD8+9bntbPygpo9R76w3eRK8WkU0LasE/
	QLy8pn/2hfySCMG492j6DhQ=
X-Google-Smtp-Source: AGHT+IGIlCSFAlWNFJ75OhzJUjvSUoMwan4Q1kltcpqAjfulwETinSOVemblGSu3+N2MI83dySVUPA==
X-Received: by 2002:a5d:498a:0:b0:336:6da5:96ad with SMTP id r10-20020a5d498a000000b003366da596admr3052181wrq.2.1702995331673;
        Tue, 19 Dec 2023 06:15:31 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600000d200b0033671314440sm2046380wrx.3.2023.12.19.06.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 06:15:30 -0800 (PST)
Message-ID: <b0bb838e-761c-4857-9647-515f50d7ebf0@grimberg.me>
Date: Tue, 19 Dec 2023 16:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-pci: enhance timeout kernel log
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, chaitanyak@nvidia.com,
 Keith Busch <kbusch@kernel.org>
References: <20231218224633.2963811-1-kbusch@meta.com>
 <20231219050108.GA31771@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231219050108.GA31771@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_061534_970736_247BFC15 
X-CRM114-Status: UNSURE (   7.82  )
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


>> -			 "I/O %d QID %d timeout, completion polled\n",
>> +			 "I/O tag %d QID %d timeout, completion polled\n",
> 
> Q: should we use the Linux term tag or the NVMe term command ID
> (or command_id) ?  I don't really care, just thinking out loud.

I was fine with neither tbh, but tag is better than command_id I
think.

