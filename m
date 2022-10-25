Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8E5C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0fsX7yeTxe0eS/CHtm1mqvfMaztxd0YeRoUzAz0/1Fk=; b=ZzZlZdWS1dVzDGlPJ3ra1fkogl
	iaS0e9NXWqrdLg1/OJZGSBWpML6qTYjeszWXdHKR7jFc2k/JTIIQVt/5gWVDG9Yb+jSM5eBC+yfPA
	4wEZu147tGkDARFSDiC7uCErpLKtXPRL7IHPaZYOeGPqaWlaK6IqzpVDnHK6pGKlTCEWiAjSaOIb9
	VaUfEWJcyh1YMrdrMOsdG9bynDdgPEv8EVqSTBjiNZ/eYlz1C9FxAwAHXCNcs4R9qD+BEmXEPIrla
	nR39aozu5aBvRXoR/B0x5ptulcp9oldavXLimiX5li6F4yKk4mkqoRtSvTjSJwCTB7nGt7C9Clix8
	tAl0LZMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMJy-006CYJ-06; Tue, 25 Oct 2022 15:58:30 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMJv-006CXA-1N
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:58:28 +0000
Received: by mail-wr1-f51.google.com with SMTP id bu30so21878103wrb.8
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 08:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fsX7yeTxe0eS/CHtm1mqvfMaztxd0YeRoUzAz0/1Fk=;
        b=hz0KNSTLsViUJnzH1EZzKYZV0m22Ax0QY4Zx2Kpc9RdrDWcyXv+nkOkXPqzH16fFGR
         0qu0915gSHrqlf4dPgZKoVFkcvv+CAp3NV+Hi4sXvRlp9cGBbAs6wo19cmckm47KxMVk
         Jsww0YC2vCACRWZ+5tIwz+dIlsvtchxFleiugsmbA4UGSPyAKJIPkXiv0slayD5F3Kjg
         MWurCWv1VQL9u7wgK8zWTrtNwlK+g6NyaR58KU6sQGDM4ox/4baygAWzO4Kfheq+GFUt
         X/iTlrF5lhbTK51r7I9lU+BvAk5EWb0b3VdMrSw7PtDNtJi53LfUKK4bnCvpgUdE86EE
         XdSQ==
X-Gm-Message-State: ACrzQf0FNwuW2xpE9RqwsYTJUF4Tyu2lYkmeLg2M1jcGGrPYojcBddSQ
	bTwZwLi0I3RV/Gv2+bXG/E0=
X-Google-Smtp-Source: AMsMyM7h/2f9UtfzUPGAIoF08HGRI2i6G6TS3dsNSYWjix/jEmKoUIPLwg1SsZBvhyWiUp1Fcvz20Q==
X-Received: by 2002:a05:6000:61c:b0:22e:5e08:43e7 with SMTP id bn28-20020a056000061c00b0022e5e0843e7mr26348915wrb.176.1666713502380;
        Tue, 25 Oct 2022 08:58:22 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id e12-20020adfdbcc000000b002258235bda3sm2981299wrj.61.2022.10.25.08.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 08:58:21 -0700 (PDT)
Message-ID: <f214dff7-9562-5f32-38b3-51bfc1216e98@grimberg.me>
Date: Tue, 25 Oct 2022 18:58:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
 <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me>
 <YzcJdeR82tHbFGAh@kbusch-mbp.dhcp.thefacebook.com>
 <414f04b6-aeac-5492-c175-9624b91d21c9@grimberg.me>
 <20221025153017.GA24137@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025153017.GA24137@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_085827_112921_E41089A1 
X-CRM114-Status: GOOD (  19.17  )
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


>>> make up the multipath device. Only the low-level driver can do that right now,
>>> so perhaps either call into the driver to get all the block_device parts, or
>>> the gendisk needs to maintain a list of those parts itself.
>>
>> I definitely don't think we want to propagate the device relationship to
>> blk-mq. But a callback to the driver also seems very niche to nvme
>> multipath and is also kinda messy to combine calculations like
>> iops/bw/latency accurately which depends on the submission distribution
>> to the bottom devices which we would need to track now.
>>
>> I'm leaning towards just moving forward with this, take the relatively
>> small hit, and if people absolutely care about the extra latency, then
>> they can disable it altogether (upper and/or bottom devices).
> 
> So looking at the patches I'm really not a big fan of the extra
> accounting calls, and especially the start_time field in the
> nvme_request

Don't love it either.

> and even more so the special start/end calls in all
> the transport drivers.

The end is centralized and the start part has not sprinkled to
the drivers. I don't think its bad.

> the stats sysfs attributes already have the entirely separate
> blk-mq vs bio based code pathes.  So I think having a block_device
> operation that replaces part_stat_read_all which allows nvme to
> iterate over all pathes and collect the numbers would seem
> a lot nicer.  There might be some caveats like having to stash
> away the numbers for disappearing paths, though.

You think this is better? really? I don't agree with you, I think its
better to pay a small cost than doing this very specialized thing that
will only ever be used for nvme-mpath.

