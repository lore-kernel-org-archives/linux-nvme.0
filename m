Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC35C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y2fvs7eM8OaHaxhSMO6sO31oZMM4z0ixYpjmyYfBMsw=; b=hpf+KrMcSTd5J6wwat0lrGfqxy
	7gu/gfpDdFipViiDHk4mfcl4A/6o13pkA4tVP1BZPp5y2lVhu6PiEMEuWYacCwQ7m/ecctrtLAinX
	wUbqvXbu1G+huiDvrhca2c3lwBl6344c+rFaekIsFDr6EgG81gZtwImw6Mahc4U+CCVV5uc6MEbrE
	L4e102JQx6Tfvj09jyIQchUo2nI8Mm/Se/fsLqG81g+vgrjl1dc9DEYQKxkvvjCoKBydvWJ3fMypn
	MABBeKsFHtG4kY/E+T7G1L4FFcnPgdCUVxUNeHvGyXXCs6HBAMY5dWaXbfAD+nDlGLLJ8/arszP+U
	BIN5xAAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU7XW-009IhO-IZ; Tue, 15 Mar 2022 13:48:42 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU7XT-009Ig9-Lg
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 13:48:40 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 r131-20020a1c4489000000b0038c2c33d8f3so72097wma.4
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 06:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=y2fvs7eM8OaHaxhSMO6sO31oZMM4z0ixYpjmyYfBMsw=;
 b=Zec8yc6w16O54HwUBqVM5gJELalgSBfqC0VIk4sD2xQHiXJkffjG0gw3mPK78yIi8w
 T4/By8P9YnSVWAC0JBgkbBUK9e9ZiiWbmp5UN/oSFIkJsVosCwT9WriE4I7E5g19fy7G
 hRqamP7/Na10//sY8WSwS9iWLLP4ObzDRduvjnV3SL/Am/as2BaiebsPojFJPNPrfb8x
 XbFMZvUARzIA6QUXwnPJCEQnKD1Ik6p7/Cywe9ntJb4vjW1x3l9c0T/p8JkOkxoVfcqR
 NHdEO3sG/vRHG7zKxcM1C6ktANovQKqEuj5TtFLM38xZvbWufTuj3RAw718KoijRUyxN
 g/Pw==
X-Gm-Message-State: AOAM5310elBsE1wqukG2WobVkjt4NJy27HNNe16YRTzi+zZmyBkZS5Xd
 vAtHFdy716VPbJ1JIxFAtMw=
X-Google-Smtp-Source: ABdhPJxEceduonR56v8iYVAgpReJATOL0h1TxRvmVwSR4MasQEp5K/pUrCF8+CGzPmgnZVdQnS92cA==
X-Received: by 2002:a1c:2544:0:b0:381:18a:a46d with SMTP id
 l65-20020a1c2544000000b00381018aa46dmr3475293wml.26.1647352117690; 
 Tue, 15 Mar 2022 06:48:37 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 r17-20020a05600c35d100b00389f368cf1esm2512916wmq.40.2022.03.15.06.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 06:48:37 -0700 (PDT)
Message-ID: <d6a26b94-b18e-5e42-adb6-4cc95a6ab0a2@grimberg.me>
Date: Tue, 15 Mar 2022 15:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
 <b2942a7f-0d23-46e3-5ab1-31cad3ee8011@suse.de>
 <dae0fa76-2b78-16f9-a7fa-f28c1412c317@grimberg.me>
 <79067416-401e-7ee1-2de8-f67187aaecdb@suse.de>
 <b0334223-367b-690b-3a41-55ccae21b47a@grimberg.me>
 <c44e33fb-b1b8-da7e-bc70-87a39a2b5bd8@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c44e33fb-b1b8-da7e-bc70-87a39a2b5bd8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_064839_752657_CCEF5424 
X-CRM114-Status: GOOD (  16.75  )
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


>>> When you want to retrieve the discovery log manually _and_ have 
>>> existing persistent discovery controllers you'll need to know which 
>>> device to pick.
>>
>> Please describe the use-case because I still don't understand.
>> nvme-cli offers 'discover' that gives you the log page and 'connect-all'
>> that connects to the subsystems it found in the log page.
>>
>> Do you have foreign udev rules in addition to the ones supplied in
>> nvme-cli? I am missing the problem statement that you are alluding to.
>>
> 
> No, not foreign rules; it's the manual call to 'nvme discover' which I 
> try to simplify.
> 
> But you are right; unique discovery controllers are only important for 
> authentication. Everything else is just to make the system 'nicer'.

OK, thanks.

> So leave it for now and I'll come back with a different set of patches, 
> as I _still_ see a benefit in being able to configure the discovery 
> response.

Sure

