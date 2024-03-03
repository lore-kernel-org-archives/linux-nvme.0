Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C349C54E49
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Mar 2024 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ikfe6o+inj4dMrhzQCM91BE0ram1wt5jM+ElrBh+ocw=; b=egVjLk0x4VwwapXigPfgyhNjFD
	Zn6UrAuN6IWnobipd2uaLJEhoswg9j3lWAQRaOCpjRrvGj06jqs6FABT2EHCNyddvr6l2OFBbgUhw
	zgb4nu3+0hbqfEo463FLzpIeb2pFIrbBV7bazvClIg2/LOGCZsLZ8iYZfxvx+E5SrAP2nSTdOMhpw
	q+bTf6MTlVf9bGCONIIf1S/jA7VKawiA3F7UgVTQrU0AC+Nizh7kKJCKvACKIN+Fd2fQZg3A/D6Tp
	JuNXxvW+UZH8CX0DZixKTCHH1JGAqgoPntJmeyYRH9ThLpCpVjdZczu1hwhsRmlxEh68wfT9SguPA
	KvsRHOew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgowJ-00000006JEg-3Zzc;
	Sun, 03 Mar 2024 16:43:51 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgowD-00000006JDd-41sP
	for linux-nvme@lists.infradead.org;
	Sun, 03 Mar 2024 16:43:47 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-33e162b1b71so2710438f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 03 Mar 2024 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709484224; x=1710089024; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikfe6o+inj4dMrhzQCM91BE0ram1wt5jM+ElrBh+ocw=;
        b=lpcsDk+pihwdHugKp5uKXgGlL8qjXI9AbrED5NXriyaa5AP6eaBPVg6fd0jKodjvtl
         Zv/inzSvcQl+pgSF+PVw/1IdTgErb7+wJAwAZmxAnzVzhRQH0M1EyLamXuuHk+/hZVsR
         Jrh+ErqZBDkscrgMXJD3995m57lwdgWsFQNm4XNgYUiDsqjYQ4QRWfe7GK9czVY6nBZf
         jAXxSmPxNNbduTECkvkYF2t0kurnQ7gTb1kytPvKqlyEkyVxXP0TGj2SHi5oJ/X0KL7Y
         6q9VSCOkfQph4p1pvSYT433Rr1eTIsLs0kHo/PH4+CW315gvS6yK+Dj8LER7pxsOHSsq
         k96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709484224; x=1710089024;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikfe6o+inj4dMrhzQCM91BE0ram1wt5jM+ElrBh+ocw=;
        b=NNBlVhjVjbmMXAqQxffoui1VZNzQgcMiLERlLhJOm24VzZsmHYZYyqYA7r1/khbmBv
         ngXi5AWWrSQHwN8yvqhtE8zEXp6W3b1E4JTyb9pjmkii4L/HxxtpF/oQqF3SotK6YojG
         wyqcTMI3YIH5JV4t20xVER6zJ59wfLMUFXK73Qb+2WBeI2LvEBKTk/K8oDWSZ6rDtjwJ
         myhAu35pbxSzZL+3397ETZ0+GPmvEF/enHV5o0HMOISDM+73FpwYfWfD4rzoFPARE8uq
         QQpwNGfztJ5OmxyjzQd9HHElftVPIPROOwx7WC7wU0oRrs4jcaWXb2I0LgUXHiwcJ9G5
         9kuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKTqtHA21wsga65MkLxMvaF5gAHBG/jesJd3tAce1NaMpDtN91oxIbaFlv74HwIMBTw6lwZ0L9XObb8/4JhkKfCDt9YxDF6yPAVXs1cqs=
X-Gm-Message-State: AOJu0Yz+VJ4qFsPad36ejaPdGCuDgnS3ImbigQDneVb/ugiTCRPr8p5n
	jz7lnKaXngqx/I0k7JL0n6BP/13CIiE31w8zcdK/LSbdwCGdr0ep
X-Google-Smtp-Source: AGHT+IEan7Mnlup0Dsmz/hl+Nfxoss34Q+iDIhW40VewxV5OR6PZ3luhS7QypruxneaihlG33uJrxQ==
X-Received: by 2002:a05:6000:12c8:b0:33d:747a:1e94 with SMTP id l8-20020a05600012c800b0033d747a1e94mr4376321wrx.41.1709484223538;
        Sun, 03 Mar 2024 08:43:43 -0800 (PST)
Received: from [10.8.18.71] ([62.214.99.74])
        by smtp.gmail.com with ESMTPSA id cr14-20020a05600004ee00b0033dd06e628asm9995441wrb.27.2024.03.03.08.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 08:43:42 -0800 (PST)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <be75fe5b-9901-425c-8dbb-771dcb084e2e@linux.dev>
Date: Sun, 3 Mar 2024 17:43:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] : Two stage IOMMU DMA
 mapping operations
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <bvanassche@acm.org>, "kbusch@kernel.org"
 <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, Christoph Hellwig
 <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 "jack@suse.com" <jack@suse.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Chuck Lever <chuck.lever@oracle.com>
References: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
 <20240227113007.GD1842804@unreal>
In-Reply-To: <20240227113007.GD1842804@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240303_084346_058736_5E4B23A6 
X-CRM114-Status: GOOD (  12.42  )
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

On 27.02.24 12:30, Leon Romanovsky wrote:
> On Tue, Feb 27, 2024 at 08:17:27AM +0000, Chaitanya Kulkarni wrote:
>> Hi,
> 
> <...>
> 
>> In order to create a good platform for a concrete and meaningful
>> discussion at LSFMM 24, we plan to post an RFC within the next two weeks.
> 
> The code can be found here https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dma-split

Thanks a lot. I will delve into it. An interesting topic.

Zhu Yanjun

> 
> Thanks
> 
>>
>> Required Attendees list :-
>>
>> Christoph Hellwig
>> Jason Gunthorpe
>> Jens Axboe
>> Chuck Lever
>> David Howells
>> Keith Busch
>> Bart Van Assche
>> Damien Le Moal
>> Martin Petersen
>>
>> -ck
>>
>> [1]
>> https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net
>> [2] https://lore.kernel.org/linux-iommu/20200708065014.GA5694@lst.de/
>>
>>
>>


