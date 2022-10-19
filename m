Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCD6C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KC1hP/1XoS5x2+2XJsUa0Pm0hUGuRM0gtVqGq8fuPjk=; b=T8zvWhI3O5/wsZ9Ka1U/n/i9A1
	SszKWU9aI60WfjwAoB+G73/v450XitGMB7y7n6uIzDXiz+qRgu1Njdr0xrG40VaSJ3fwU/78q+7km
	UdItPEaSHFWcXAMyNnMo+I9/pUdC0Jz4euZdUmvfvWv2dG6bBVJPAMNswzgttIsXFiKa4BdLKAinP
	mEZUpgUQ8ZRfPEjudJzB9aqJul9Z9GhB9f7Ax9bZr2JJ2rBhuSQW9w5spiUanOwwfdbjKQL/jzNgS
	REbQrIatutxvfMCH3oEs1PukvCmOnldRu6VORaeK6hPvn/rpCSma62rPkGjHONJfgh+KsGUIqR8D+
	e3TenYBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olD6f-004b3F-0D; Wed, 19 Oct 2022 17:43:53 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olD6a-004b2C-Qz
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 17:43:52 +0000
Received: by mail-wr1-f45.google.com with SMTP id bp11so30337040wrb.9
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 10:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KC1hP/1XoS5x2+2XJsUa0Pm0hUGuRM0gtVqGq8fuPjk=;
        b=KHX9lUgHBlXe76vR3vyAV3vLdmX2TiO8h+WnZ7eAcO3+QMOj+nWXTR4s7g9+CS5iv7
         v/CMu/jzp8TwV8z0ANtOfUzAMfXIvbof6Ry1igXpMGijIbjbjSAv2OJh8zvgfmE5ox1J
         wFpcvZwLFuUjlMie6QTgXHqKiycwxg4xcNN6B2pUmzyB/2uKLot3l6Bv1cAEZuwJgkxO
         EQthG0A/c/1Y57AzdOjLS2muuEzz8Ipx8UY1wqv/If9btDSNo3xiq5SH0HdjWKP52oex
         mXTDg1b3iicuojm9bZ/Ak6uwubXCpsfNeMiXydrbB35Rp5YfSlKeAdJLuiJkn4o+T+U5
         Qr/Q==
X-Gm-Message-State: ACrzQf0S5MfiVNQr3aTl+EvUBCZZ/8xetJoVmziIJEqkIdsDDF4UMhpx
	Xa/0URPXvPf0dxq8h8QNixDczjSJevU=
X-Google-Smtp-Source: AMsMyM4f+tPQwhLlZKDHlWzoP5XCE3cLKVrpgUtno2/N8hxkDIzd+2q4+NMeMAdEH10KyBGxLJhfuA==
X-Received: by 2002:a5d:6c63:0:b0:230:8257:be9e with SMTP id r3-20020a5d6c63000000b002308257be9emr5630475wrz.606.1666201426540;
        Wed, 19 Oct 2022 10:43:46 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id f18-20020adff452000000b0022584c82c80sm14101456wrp.19.2022.10.19.10.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 10:43:46 -0700 (PDT)
Message-ID: <8c564393-f5e6-57e7-c2a2-8ddd58187a0b@grimberg.me>
Date: Wed, 19 Oct 2022 20:43:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20221019075138.ff2sfahovionh72v@carbon.lan>
 <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
 <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
 <20221019113517.wv27jqp7lyskfbqb@carbon.lan>
 <96978c5e-369b-a010-f9b5-6b4675836e47@grimberg.me>
 <20221019160147.ij3nc44n5ppmzifp@carbon.suse.asia>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221019160147.ij3nc44n5ppmzifp@carbon.suse.asia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_104348_902327_6849FB2C 
X-CRM114-Status: GOOD (  11.09  )
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


>>> Still able to trigger though I figured out how I am able to
>>> reproduce it:
>>>
>>>    VM 4M memory, 8 vCPUs
>>
>> thats small...
> 
> Just a test VM. But I think this is actually the key to reproduce the
> lockdep splat. The fio command is eating up a lot of ram (I guess any
> other memory hog would do the job as well) and forces the mm subsystem
> to use the swap.

Is that 4MB of memory? or 4GB?

> 
>> What is vm.min_free_kbytes (via sysctl)?
> 
> vm.min_free_kbytes = 67584

