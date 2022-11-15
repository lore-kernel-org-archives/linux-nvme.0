Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61823C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 07:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vMnxsMJjPDuHr/H5zyJ4VFtezbEuKUHnFjeigyz6m3c=; b=CLBt6QUo4MnvipjthJ0ycx2eQZ
	L/CbCn4TgGDk9F30+sX96zQXqtd8tUg7pSQlW9IhnM0EnEcFDF1gPHGm/w7T/p6hmP1scBd0RtuGP
	JRFNoiusDkgZmaiiMCqpbQIHguWHeXAhw0gtD9O4uoH4wmaPLEhcnSm/9aQh4UXN+/n2GFackXyic
	VfKEU/FEcmop/cv7wHm1Q0CebtVkdhYpa2ozP4lbLYSWaWOV0a/bwEnLCDONqN8I6i/vkEO2sj26l
	L/ia7wIPzVkX840a+g2kErhxU4B2okX4Oggrn3u23flgGM/onxRlvZ3D1VOZ9389EYNVcembd7h9M
	xpNBzU4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouqej-008gUG-01; Tue, 15 Nov 2022 07:46:53 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouqeg-008gTX-Fr
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 07:46:52 +0000
Received: by mail-wr1-f53.google.com with SMTP id j15so22792705wrq.3
        for <linux-nvme@lists.infradead.org>; Mon, 14 Nov 2022 23:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMnxsMJjPDuHr/H5zyJ4VFtezbEuKUHnFjeigyz6m3c=;
        b=YaYrk+IsoY4q9MMyvRyePJB7bqE9qXpHHOHulrQTRaKbOSEnXT7j5d+5vfyP4JcAcA
         CwuTDUhG7stbjkJkzZ1h8ydC3K4F/oiNu86o/6Sk1FXSgxdPDkMXhgTvGO4CsS0hfBOg
         MuthY8z8IvKwF0DrCRSr3tMbJKqU1ljOwZ7ttNyFFcT8SvJOpBcfOsjOBKk46IztrF5Z
         kRS939mA09iumJNh+fl3QcMJbVsXBo0SgSXFRXeaUphHRsDq9KpH1KvxKgOOCjg0bRuW
         IY8YbVErFBRA2BKOXy5xaNOX9a8K0iix2HBjQe9cZQW4G7v8Aoa4fVBeat4/IcQ7NhJv
         Gzag==
X-Gm-Message-State: ANoB5pm/9ssQTWK7yb7G9NRCfcMWQFh5hzYkkIn3Eh7zjVlei1/o0sgo
	PnTvrs+wXAo5rsKX1JWWx+o=
X-Google-Smtp-Source: AA0mqf6VtK0DKhiLLvCitgrV6AASO9uFduc/UpGBW5ySTZuLeiK1ECmke4F/kPwP5vz0io9h/gJXOg==
X-Received: by 2002:a05:6000:11:b0:236:d611:4fcf with SMTP id h17-20020a056000001100b00236d6114fcfmr9656177wrx.192.1668498407854;
        Mon, 14 Nov 2022 23:46:47 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bh14-20020a05600c3d0e00b003c5571c27a1sm18224862wmb.32.2022.11.14.23.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 23:46:47 -0800 (PST)
Message-ID: <18e1c715-d31b-056e-bddd-189fd2948396@grimberg.me>
Date: Tue, 15 Nov 2022 09:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Resets during user commands leads to hung task and controller
 stuck in connecting
Content-Language: en-US
To: Jonathan Derrick <jonathan.derrick@linux.dev>, Keith Busch
 <kbusch@fb.com>, hch@lst.de, linux-nvme@lists.infradead.org
References: <d4a25dc1-fd2b-8f25-9ec1-04b28dfac386@linux.dev>
 <1ffea25b-6f67-a1e6-5b96-22bf3b4d89ec@grimberg.me>
 <65816415-303d-5579-4878-d8cba766f797@linux.dev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <65816415-303d-5579-4878-d8cba766f797@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_234650_545106_0AC06DA2 
X-CRM114-Status: GOOD (  12.17  )
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


>>> I'm (again) seeing a hung task when doing resets and formats simultaneously.
>>> Controller state is left in 'connecting'
>>>
>>> Using nvme.git/nvme-6.2 as of 'nvme: implement the DEAC bit for the Write Zeroes command',
>>> but I have also repro'd with Christoph's latest reset/probe-split set
>>>
>>>
>>> ctrl="nvme0"
>>> nsid=1
>>> pci="/sys/block/${ctrl}n${nsid}/device/"
>>> echo 30 > /proc/sys/kernel/hung_task_timeout_secs
>>> while true; do
>>>           nvme format -f /dev/${ctrl}n${nsid} &
>>
>> How long to it take the format to complete?
> Well it's pretty immediate but I'm under the impression that the
> nvme_dev_disable path leads to CC_EN disabling, interrupting any formats
> 
>>
>>>           echo 1 > $pci/reset_controller &
>>> done
>>
>> What happens if you set io_timeout to 20 instead of 30? (given
>> that you bound hung tasks at 30 seconds...
> It occurs with the standard 120s task timeout too
> Also there's no I/O occurring at the moment; just admin work
> 
> I added a blktests for this:
> http://lists.infradead.org/pipermail/linux-nvme/2022-November/036475.html

Keith?

Is this related to bc8fb906b0ff ("nvme: handle effects after freeing the 
request") ?

