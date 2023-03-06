Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D82C678D4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EM+EMbtEYZBrsL73cxURZ0xg43wfs2FNZyFsMDpd3b8=; b=kNsppD83oBzFJX8QX/7VEXCsVd
	Nu0bqtEDPyIvR1Pk7X8suz9v0oUXVMqPHEbO1YBcQhokRkWggDrojsWydADWIOMcfkTv6HBKHWCqn
	knCWZt8NbhcCnIO/K1atP5DonAn53QBTFzYY0hEEtUedpZjs+Bya6hEdCGN5G1tnLBSCmPZZzViiT
	I7cBYJz8YToJbrIYTFZGv3G5wjt00JGYA3cdKUNNXlTkmPvsVogdWbZwwxnlDU40Eo36lh+e+AXn7
	o4Dy2ycO8JhVJZ+UBc0XETl513PXzTIDDaBy0naLKiF9w5zhcp+pG0NuHD5I0jziv0Sbz452Q9vAh
	ItzuaREg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZBOd-00D2IU-9Z; Mon, 06 Mar 2023 14:00:59 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZBOa-00D2HQ-AU
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 14:00:57 +0000
Received: by mail-wr1-f46.google.com with SMTP id g3so8915126wri.6
        for <linux-nvme@lists.infradead.org>; Mon, 06 Mar 2023 06:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111254;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EM+EMbtEYZBrsL73cxURZ0xg43wfs2FNZyFsMDpd3b8=;
        b=HiY+oZrGZ8o2NdIWmJ9+MJHU0JbTRx5OQBA3kIqpirfwmzwP0g4bQNr1UEkpWtqkHs
         Wqh8zMSst+qBew7ZW/MmMlO62uq7FMQU2mVYkxKPif4mh5QgB5FpxAzWjkVYDHD15r16
         dUhMuzObIH3UvoyLbO6TKnAvS4M2MQA9BCRQlgD/bBxBbWWb4zpWwb7wWEtFLvOaxmqf
         Xb/XgLHN2osIudschBHoe45NGf1FO7/rJdCioS7jDsvhmD3Y0QZq+iDjcowygnGCA9f3
         6ZTtNwQ2KQlwEknV3KyvweU/p1bmKKnUwyH+hAxx8BQU/GEVrKBBDfRUcnK3uj43qKQO
         VO6A==
X-Gm-Message-State: AO0yUKUdHs+U4i9kWwXK7JGxbaftlbQ/y9MTPuc3UBARaMSZR8MBhcgB
	rUiAxWPOSXkppB2GY9Iis5MYzO5qucA=
X-Google-Smtp-Source: AK7set/ynnC7UJYBiufFNR8zBlLu8ErKa89B6vxnBCd+O/WZMWyfscki8lb51poDu9OGGiYYNEgB3w==
X-Received: by 2002:adf:eb42:0:b0:2c7:1b46:7b33 with SMTP id u2-20020adfeb42000000b002c71b467b33mr6230392wrn.4.1678111254481;
        Mon, 06 Mar 2023 06:00:54 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b002c70851bfcasm10014385wru.28.2023.03.06.06.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:00:54 -0800 (PST)
Message-ID: <855aeacf-03e3-8553-f27f-42748dfd2641@grimberg.me>
Date: Mon, 6 Mar 2023 16:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] nvmet: Avoid potential UAF in nvmet_req_complete()
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20230306011313.99870-1-damien.lemoal@opensource.wdc.com>
 <b0af3112-6f6e-809f-bac6-2a6e245b9245@grimberg.me>
 <afb050c7-0029-ed87-7b77-720b559af798@opensource.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <afb050c7-0029-ed87-7b77-720b559af798@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_060056_394174_DD492042 
X-CRM114-Status: GOOD (  10.99  )
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


>> Hey Damien,
>>
>>> An nvme target ->queue_response() operation implementation may free the
>>> request passed as argument. Such implementation potentially could result
>>> in a use after free of the request pointer when percpu_ref_put() is
>>> called in nvmet_req_complete().
>>
>> Can you point me to which transport frees the request?
> 
> My prototype PCIe endpoint nvme function driver, not upstream yet.
> 
> The endpoint board keeps randomly crashing without this patch and not freeing
> the request (embedded in a struct) in the ->queue_response() operation would
> require *a lot* more code.

Got it,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

