Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A374C388F7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 01:41:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAF2216C4
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 01:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EKX9+cho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAF2216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=okYN7JMd9Ckz0JS0WjiR4hMkFlMMatS3j0b+jhwrldw=; b=EKX9+choFZc2g8uuxcqnln8QW
	9El2mt1EUU4k2i6INK+DCNfw9ny2O3bZ+FfrQP2iQ7KgyAlVzjOalZ2VCBHlu6IwYFjqhXmh+isM3
	uOX5CYibH4aOzctbfWXusKTJKBYy20GQBrqgxJLqlMR7R+C/jcTvx0H/I0JX/Jy9AETRmN6VgFkpg
	pFBhR7y+zRHF1NdeV5Bf8feDuFrOqRhTNVsxUU2atBn0DAmXHk+dVsY+FE0ZCXecMJY00dAuyLCy9
	pBIqmo4i9Rh60CC3dKi1MpkqMw5O149uG4+F0s0qXz90abFNzua1TdIB61Fpm+JZKr9AiSDdbsMoe
	2ZnmBMHjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcf8W-0001rg-51; Wed, 11 Nov 2020 01:41:24 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcf8T-0001r6-6v
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 01:41:22 +0000
Received: by mail-pg1-f195.google.com with SMTP id 62so320337pgg.12
 for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2020 17:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xlHvNWa4yPPWg+JCLfaBgBaYnaHb/EDR8S1yfsdthVI=;
 b=sib5mqZNQaoHlA8HJ8rUFf8kJMtMyuaLQIWq2zNxdA7v9NLcc2UGlvPF0N5jZZ7u3H
 qVnnvqE3dVxgaja6Kzs6UZ4YqIr30olrczI5Ee3+ufLlmvUyxteQIIDSAk7f9n7xctZi
 DaEs5+z8oiPDo420CXrOAWAbnbGfUzsLxfujiRk4dQUtlCbmljBe5H3EwCPtthb24KEJ
 Zsl/lBs6BttvvJDw02+JRXKHeHWEeiufF01bN/IB/vSzpkXyTJPSysWHOeK+LdHcC2V9
 uhj1p59GWnDHw3Pdnbthhr3bR/PqZacW4/wzYxZCrI5BCiicwK8XW2dkyKrW1nNmTj02
 A8bQ==
X-Gm-Message-State: AOAM532VL5ToraiDgMWFnu2qwNo+gzZ4SwhPpGGFnwjgP5ZHZu3MNuHL
 t+PASXf3kIfnLwI8+97aK3Oz74QhngM=
X-Google-Smtp-Source: ABdhPJzysruYkddhFxxLZHPQAlV3Si3fxM8NYhaHMKeV6NohtwI9UgFNvguQCuWfLfyOUoeKJR+A9g==
X-Received: by 2002:a05:6a00:134d:b029:18b:2cde:d747 with SMTP id
 k13-20020a056a00134db029018b2cded747mr19956640pfu.60.1605058878583; 
 Tue, 10 Nov 2020 17:41:18 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:47ee:2018:3e3c:f9be?
 ([2601:647:4802:9070:47ee:2018:3e3c:f9be])
 by smtp.gmail.com with ESMTPSA id s5sm358489pfh.164.2020.11.10.17.41.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2020 17:41:17 -0800 (PST)
Subject: Re: [PATCH V3] nvme: enable ro namespace for ZNS without append
To: Keith Busch <kbusch@kernel.org>, javier@javigon.com
References: <20201110210708.5912-1-javier@samsung.com>
 <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <87931ded-b17b-90b2-c5b2-a1a465d109cc@grimberg.me>
Date: Tue, 10 Nov 2020 17:41:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_204121_270282_12C77FB4 
X-CRM114-Status: GOOD (  11.98  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, joshi.k@samsung.com,
 k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> -	if (id->nsattr & NVME_NS_ATTR_RO)
>> +	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
>>   		set_disk_ro(disk, true);
> 
> If the FORCE_RO flag is set, the disk is set to read-only. If that flag
> is later cleared, nothing clears the disk's read-only setting.

Yea, that is true also for the non-force case, but before it broke
BLKROSET so I reverted that. We can use this FORCE_RO for BLKROSET as
well I think...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
