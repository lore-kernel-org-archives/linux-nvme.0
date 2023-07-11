Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AB9EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BrZ8yh4nFHBxX4BgGqt9YuV6OVfsRrdwyKxh5AGLUOY=; b=eiyFsETtUWXi+uazmpEuMbT2n0
	3/bNsXL8PqsmJ69kTC2P/OtaendkDbU0hDjeBBAViUX9QRMk97cOO5gbTsSxJMov2L3Dx3pGQ0YFi
	XVGNWS7O4jDXXQ5zJ0e2Nmb8KSUaqwqY0Z0u/UUbr/DjygtaIRx8XXgVtolykihauTvAKdwMwUKEv
	KB43ApBj0yoxWBOYuseA8+0n86CjWEH3qjdCXsOVQ85+9ZYRMvzUZ59VSvWj4MIdx9JrBIpcJ07al
	WdwIIhlFXfZT46jYcEGoaFXMj2LT5zGpwPNNFhfn+fZcjJ+GjJsirY56Bee9tV72LeUOSWwYYAUT+
	uiSnfP5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJCGm-00EqUn-0U;
	Tue, 11 Jul 2023 12:15:04 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJCGj-00EqTB-2G
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 12:15:02 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso11968445e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 05:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077697; x=1689682497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrZ8yh4nFHBxX4BgGqt9YuV6OVfsRrdwyKxh5AGLUOY=;
        b=E//SGMKlhZqROiNHYcfk4dNhO2yxqHJw3v3SV1ZZphC8LCi0aYcB3M6GRzZDUwf8wi
         D+N54EswqobqMlocTFlP0xUQO8iLQcW/m2EseyGDFRSDt8wuJ+Ox5FQ8WZY5GwWqOLHZ
         4Dy/agK+ep3IL7GI65OVnATdJyP4pwO5H34YsG8GZEjySlZ4/6/tnI+aX8FFehX/8ygD
         bTts953w21QHXQRdJxLgaGqSONxqueD8nyNsExk7YZaToXetTgdaSElFdwV/dp+v0TlD
         TLMqBoZj5R1TjuZGtsRpdwPX29o/LYO7yeXP3Tq8ax1pP1UMNyU60OZRuE/MGZiB1Bgw
         bIfA==
X-Gm-Message-State: ABy/qLbJUUlC9iPIUOykawo8LJWe2i2qDJq9Mip6Wfx+kiKKZPLvGRyi
	kNnFlCwzEWhBk24f4swaO0E=
X-Google-Smtp-Source: APBJJlFTz6sRrKHYL8i9OSKnEs6VzdhcuUcl03pmVYw312kGUe2L1rfBbXc0ltDJz2GHqbM8BxUQag==
X-Received: by 2002:a05:600c:4709:b0:3f6:8a3:8e59 with SMTP id v9-20020a05600c470900b003f608a38e59mr16114725wmo.1.1689077696814;
        Tue, 11 Jul 2023 05:14:56 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d684e000000b003145559a691sm2115991wrw.41.2023.07.11.05.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 05:14:56 -0700 (PDT)
Message-ID: <23017407-83eb-8fb0-5d91-2c7c4ae02544@grimberg.me>
Date: Tue, 11 Jul 2023 15:14:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 "Clemens S." <cspringsguth@gmail.com>,
 Martin Belanger <martin.belanger@dell.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, John Meneghini <jmeneghi@redhat.com>,
 Hannes Reinecke <hare@suse.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Kanchan Joshi <joshi.k@samsung.com>,
 Javier Gonzalez <javier.gonz@samsung.com>, =?UTF-8?B?67CV7KeE7ZmY?=
 <jh.i.park@samsung.com>, Linus Torvalds <torvalds@linux-foundation.org>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
 <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
 <20230711120609.GB27050@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230711120609.GB27050@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_051501_745950_CD183485 
X-CRM114-Status: GOOD (  17.26  )
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


>> Well, that "They keep pumping out more and more devices with the same
>> breakage" and the "new device" comment from Pankaj below bear the
>> question: should we stop trying to play "whack a mole" with all those
>> quirk entries and handle devices with duplicate ids just like Windows does?
> 
> As far as I can tell Windows completely ignores the IDs.  Which, looking
> back, I'd love to be able to do as well, but they are already used
> by udev for the /dev/disk/by-id/ links.   Those are usually not used
> on desktop systems, as they use the file system labels and UUIDs, but
> that doesn't work for non-file system uses.
> 
> And all this has been working really well with the good old enterprise
> SSDs, it's just that the cheap consumer devices keep fucking it up.
> 
> If we'd take it away now we'd break existing users, which puts us between
> a rock and a hard place.

Maybe the compromise would be to add a modparam that tells the driver
to ignore it altogether (like allow_bogus_identifiers) that would
default to false. Then people can just workaround the problem instead
of having the back-and-fourth with the vendor?

