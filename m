Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13BDC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 08:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bmO39YEWije4rH+HKh/s0rFob5lUA/WlZwpEHZX6kGY=; b=MSWNRNoEUrybLdP0oerS5Kt/+F
	an1qDtDVxfsnFo5Y5XloatbjyFkeQHWkQnbi8GoyFiNylVHampUQvmDcXDgU/PIFZC6fnKSYhjhQ5
	O0NxmCgxXPpWOKUFqEBai3BFoHYyvyq6ikRIm2lFYdHBKqTmh97XfMfm9JU7dwT2hEbwUaCsCYVc9
	btFboUZz5sCzSqoybDYPn+vdDvss/heVCvZmzR7WYX2gSChZ9uZvvMsg9vGiDB8ncJlqOspsslXWq
	ZiJ5kuSgs1LjBubAeBMcSdQVFem3V2ydJHN5ZVHILVaRzl1RfPs7lhbtbdiIOUGDZsu6Qj7/kCthX
	jdzUlYRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oav4n-009x3h-J0; Wed, 21 Sep 2022 08:27:25 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oauyL-009tqO-Kt
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 08:20:46 +0000
Received: by mail-wm1-f51.google.com with SMTP id o5so3891176wms.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 01:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bmO39YEWije4rH+HKh/s0rFob5lUA/WlZwpEHZX6kGY=;
        b=O23lqbmACyokxTFh4roLW30FU/W9zQ9mcaPogeKBa9BUzN5QL/jmV1b5BR1CIBcJr7
         iH4p5O6zp/AdrHszcBRTLsNagmOu9FtruVUDTjKcwM6liUps+WwICIx4eFJuLVi49V1v
         8RGKH4sCrLYh0Q27MWrQjqcRpNVPnmskj0ykcDR7rTfU5tiOASoLypIGsjqUMWpklljt
         hlVsK4xm/fRKvfAjzXd0w6G0YTVnLTxB153C0WSfm/28BevKbT4OLX9QbuTR5RwQqjuq
         tlc8LmazrW5Z2RdFNwRKDXt2kb782RShb0d2aa/G53IgPl4k+K4NtWwKigmFhFkqIUDg
         5Tfw==
X-Gm-Message-State: ACrzQf0CERoEKTQrOQWhOQ0c3OYB1WSGqlp05Ktvqtj2GjQo5WEyYGka
	6eBTc4m7MqJ8gkXExnGE3yA=
X-Google-Smtp-Source: AMsMyM7RC9ua0j8zujZr4oMDXeypixegOnSpSmKUFrJ24NaFUdoUfN1znalBM/v71PLUrrMbArKYow==
X-Received: by 2002:a05:600c:19cf:b0:3b4:c8b6:15c6 with SMTP id u15-20020a05600c19cf00b003b4c8b615c6mr5079311wmq.85.1663748442287;
        Wed, 21 Sep 2022 01:20:42 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm1710430wms.1.2022.09.21.01.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:20:41 -0700 (PDT)
Message-ID: <cc1729fb-0a4e-b9f7-caf2-26716629aa2d@grimberg.me>
Date: Wed, 21 Sep 2022 11:20:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND for nvme-6.1] nvmet-tcp: Fix NULL pointer dereference
 during release
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220920131617.63540-1-pizhenwei@bytedance.com>
 <325841d0-16a5-a8dd-fb06-332e7b37721e@grimberg.me>
 <ecdacc31-0e9f-2dc8-297a-477d24e4f581@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ecdacc31-0e9f-2dc8-297a-477d24e4f581@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_012045_735036_369091F1 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
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


> Hi, Sagi
> 
> What about letting this patch fix the kernel panic only, and I'll send a 
> followup patch to remove nvmet_tcp_finish_cmd after this patch applies?

That is fine with me.

> 
>> Other than that,
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

