Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4341EC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zRNiACsJhBNwJLyxdj4fXSeO8OY9w/BNHd9o7EsaQjs=; b=s2WNXmTqVbXXTf4qXV0BsHI4mR
	xhqY7YYFTt1x/aiJqgFkPHy5aI4NZY4lzOGPRupgbK+w9lHDXIwNQWNDxtWf/kfQTMsdxyoUh8vkL
	cEIYjWlH0HvDhpvkOFe6moT4z5JCyYxFkhThZ7k6KlYVZMZVv+VvbY7kqyqvkBnPcfrkUnRvGQYtV
	5uTmOl0sPV2AdI1UahfRJ5l/BxZ6S0gkSCwS6Gn4+1ow62H2g0ME/RB9FLzbLsvPKVDPPWO48hXX2
	jVUHArQQThiuMTp6zp/oi9dLODzaLSzXmF+XL4ysQuwMGaErm2Tze1DiPEfMlXOFePjekYYvN+B09
	zKw+RBIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odwBE-00455Q-Od; Thu, 29 Sep 2022 16:14:32 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odwBA-00451u-TP
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 16:14:31 +0000
Received: by mail-wr1-f51.google.com with SMTP id bk15so2932355wrb.13
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 09:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zRNiACsJhBNwJLyxdj4fXSeO8OY9w/BNHd9o7EsaQjs=;
        b=sEl6e1OzoqbphxGn0Ct3Ky8/I/C+SBJpyxBkHa64vlnTK9lmPZZd9FsZD831CwxUg7
         d/VgLqwNCkZRoZGSCEqwiVqRanJCyW+DRUyprpd2zcu8c0QthyS33hd2vVT9gGvomgCe
         m3kJOs4FwP19QXZZWvKB962W6x5ZayMQoHrPzf999yCTVeGzTKnC+TxHIKh7JvUCrmnK
         pmyHUoQfAtmveaVC5lBoKuPxxyYVR+EnEoFJ0Ym9j/i8pQGk7DIsKAioIVlQ7X5rcne4
         sXW1UkYqsRrqt1PvTgPGZXuB6qWLF7AapzAKcQWMlTQnUpQkT815klayIK1t8yuEtLK0
         rpQg==
X-Gm-Message-State: ACrzQf2ZsvH7y7tkkQmzhlBXHnhYESYL1BOzpsHOsAKl9a8u4/l3BfFv
	KXkTXyKQzcewbQQSNX2YIkI=
X-Google-Smtp-Source: AMsMyM7jLXjhnuLLrBNRhEDkP/c3459iKiT9VPPid2SuOetdwAh5j7XhdUFGfLTh523DISz98fDnXg==
X-Received: by 2002:a5d:6da7:0:b0:226:e081:941a with SMTP id u7-20020a5d6da7000000b00226e081941amr2981557wrs.642.1664468066059;
        Thu, 29 Sep 2022 09:14:26 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s3-20020adff803000000b00228aea99efcsm4009634wrp.14.2022.09.29.09.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 09:14:25 -0700 (PDT)
Message-ID: <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me>
Date: Thu, 29 Sep 2022 19:14:23 +0300
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_091429_013620_5E36629F 
X-CRM114-Status: GOOD (  13.32  )
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


>>> 3. Do you have some performance numbers (we're touching the fast path
>>> here) ?
>>
>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>> preemption disable. This is a very small price to pay for what we gain.
> 
> It does add up, though, and some environments disable stats to skip the
> overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
> assuming you need to account for stats.
> 
> Instead of duplicating the accounting, could you just have the stats file report
> the sum of its hidden devices?

Interesting...

How do you suggest we do that? .collect_stats() callout in fops?

