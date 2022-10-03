Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C44AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 08:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Cvz2njipUpf4SwCxzEiTXwyFELDSIGJ9mQRaHlNabY=; b=B8PlDf0Mw1jTdDLIEUXYoSSBNq
	BXYz5Gp8RG/3/uyyt1ocqvyGz1NsU7wQzI+nlnLHZwGlr8ZW7EET45Age0C9ACZB27rtHCzWXO52R
	HIO07e6JuvV9YCHj01QK+Tu8JL/Q5R4yq5AprlzuLFUkKKAhQRO6yF5mUzvY2niz8ExYPAx9E+B4n
	whMg7OeKj32qw7yYqpKWqCgU265/Qnfh39AMHaYTfcFVMT+cgrG5jgAM1ds2BcaKcLPvjAOTNsHJ3
	o0Aw8Juml08To4HlXtbKfpmWoQVmoKfkZityUreVek3u8twwMkcfNC+WBnzDvqKfmOXS/OZUZ95Ww
	b4PgCnmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofGVr-004bee-5K; Mon, 03 Oct 2022 08:09:19 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofGVj-004bbf-3f
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 08:09:12 +0000
Received: by mail-wr1-f54.google.com with SMTP id a3so3220157wrt.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Oct 2022 01:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7Cvz2njipUpf4SwCxzEiTXwyFELDSIGJ9mQRaHlNabY=;
        b=YyOgUQAAIMh/pvdCQqqg27NmM9UOWshiuYWfXI+LfIPqhih/4Uyrqmv4XY23m7TsfD
         tAP7hB8XCSt4TUveR2Dr6gg6ds3uPolC9pwFd9Kznj+ozfWDxvOzj/CZwgr8keYHUIfz
         eiQgbn6LSfVe+DC1gV6XVRXeDAOtMQDht/Oo0m/NXxMP3bVNFg9Ss8zypf+wn6/FmSlP
         bf3xGaYfIpgRaHOt+isUZE1ejBESGci49IIqnLIz5ObRCT0gQuhrtFhZaDepPZ+/Y+Cj
         gUL05rbTFt+YdRm9h6NtLwyM2BsiSSXgB2vK8iBc0SCTBmqG2JpVPjy/0/yYieYXV4ff
         s5qw==
X-Gm-Message-State: ACrzQf0G0MJ7b007XX9qARstPZZ92GOokdNasrmT2BTUJcugrhrPp4Vk
	ihvUfltfSl/BVynbJi3qjT4=
X-Google-Smtp-Source: AMsMyM4U2NhJ7SELnRkgkKzV+KrRSi9pXCSLIjhUuXOdhQoSrWCyBSBPl98HOe7T1ScpI8ClZvVgtg==
X-Received: by 2002:a05:6000:1f1d:b0:22a:feb9:18a7 with SMTP id bv29-20020a0560001f1d00b0022afeb918a7mr11478321wrb.152.1664784548417;
        Mon, 03 Oct 2022 01:09:08 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n186-20020a1ca4c3000000b003a8434530bbsm15449244wme.13.2022.10.03.01.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 01:09:07 -0700 (PDT)
Message-ID: <414f04b6-aeac-5492-c175-9624b91d21c9@grimberg.me>
Date: Mon, 3 Oct 2022 11:09:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>,
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YzcJdeR82tHbFGAh@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_010911_182067_97698DE7 
X-CRM114-Status: GOOD (  16.27  )
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


>>>>> 3. Do you have some performance numbers (we're touching the fast path
>>>>> here) ?
>>>>
>>>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>>>> preemption disable. This is a very small price to pay for what we gain.
>>>
>>> It does add up, though, and some environments disable stats to skip the
>>> overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
>>> assuming you need to account for stats.
>>>
>>> Instead of duplicating the accounting, could you just have the stats file report
>>> the sum of its hidden devices?
>>
>> Interesting...
>>
>> How do you suggest we do that? .collect_stats() callout in fops?
> 
> Maybe, yeah. I think we'd need something to enumerate the HIDDEN disks that
> make up the multipath device. Only the low-level driver can do that right now,
> so perhaps either call into the driver to get all the block_device parts, or
> the gendisk needs to maintain a list of those parts itself.

I definitely don't think we want to propagate the device relationship to
blk-mq. But a callback to the driver also seems very niche to nvme 
multipath and is also kinda messy to combine calculations like
iops/bw/latency accurately which depends on the submission distribution
to the bottom devices which we would need to track now.

I'm leaning towards just moving forward with this, take the relatively
small hit, and if people absolutely care about the extra latency, then
they can disable it altogether (upper and/or bottom devices).

