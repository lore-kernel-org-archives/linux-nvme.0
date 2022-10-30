Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434E3ECAAA1
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DlUsVXBEKnWSmUCDw//iMFATDePe/mdqp+ek5UTPNEE=; b=Hlqdr+wRK1QXxiCaIQ9kIUwFiK
	1lzX0X2/gjwQ+PBOGLJ0Bum7Hqx7WF39aK3HVJQxpQ7kG9u9+4kw28AeSrn3PPicfqWTQEmvAG2pK
	dEaoA1ClatRlBF28fSq3OTOPvSVczD+Py7l1b71oZmKdehoojH1ovOio5XaA7t7/k/7w5sVRyyQFe
	jpJbgOh+ebxS6dDPi5mMyRa8TC6O6JJgvWDfh4cpOAXsME6MVifNfoF386G/w7aiUqcutum5gc6e8
	9GdoqvA7UchtnbEfGX6CmWfPlCPqrkiaj5iUXDgC7p7aSVNfkSnthuxld4ApUshWed701WcVRZ0FA
	nyVOMbGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op9G6-00GrlP-PS; Sun, 30 Oct 2022 14:25:54 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op9G2-00GrjU-1J
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 14:25:51 +0000
Received: by mail-pl1-f172.google.com with SMTP id f23so8718855plr.6
        for <linux-nvme@lists.infradead.org>; Sun, 30 Oct 2022 07:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlUsVXBEKnWSmUCDw//iMFATDePe/mdqp+ek5UTPNEE=;
        b=ImxoV0UudQbh1lxZXv5empblGZJUmiw7DH8l0QwXoHr6MNyuHargHKu46zJnlYimzv
         iUmL7NhEr4g6dzIHa+n2lcCGRR054UhIMe4lb1uhf6QWJT9Bh0hgJxCZz34TVP3eGHBX
         bU58CDz+eQd6It64du6RLuHfjsSLHhTTJNNsCAmHfeem3Abvu3EUTVJsV/qbHN5X3Y1f
         Dy+sXOBov2lWkhcL/wlNZ+VhF0iUrGqwp5kDoHLVvvf/fVDG5NyVx551bofBulv1A5e4
         C8cqs8C/NGvHPSQ0LAVM8L4qAeWimcRprEIBniMgJx3hcsUMiuH629SgJ8d8c/Qr9ODS
         jtgw==
X-Gm-Message-State: ACrzQf2sIoRcPPZojcaTA1nw1hcs1LyCOvRBQApghWfL2dApmffJSLgj
	qovJySdpTaTzweKAujuYnaM=
X-Google-Smtp-Source: AMsMyM6kbsZX1AjQpVrp9L1PHMcJdfj4whBoZlmlCsbKzzpmVhCS34FDVE6CLk69TeseCfE6bfZMzw==
X-Received: by 2002:a17:90a:6d22:b0:213:7e1e:9be0 with SMTP id z31-20020a17090a6d2200b002137e1e9be0mr9805926pjj.17.1667139948115;
        Sun, 30 Oct 2022 07:25:48 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id s4-20020a170903214400b00177e5d83d3esm2789734ple.88.2022.10.30.07.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 07:25:47 -0700 (PDT)
Message-ID: <9a758d91-42c5-d6b3-ddde-9c2b89d741a6@acm.org>
Date: Sun, 30 Oct 2022 07:25:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
Content-Language: en-US
To: Jinlong Chen <nickyc975@zju.edu.cn>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
 <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
 <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
 <42681e4e.15223d.18426b71124.Coremail.nickyc975@zju.edu.cn>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <42681e4e.15223d.18426b71124.Coremail.nickyc975@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_072550_109682_7466F05D 
X-CRM114-Status: GOOD (  14.78  )
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

On 10/29/22 19:27, Jinlong Chen wrote:
>> I think this patch introduces a hang for every caller of
>> blk_mq_destroy_queue() other than blk_queue_start_drain().
 >> I don't see why the patch introduces a hang. The calling relationship in
> blk_mq_destroy_queue is as follows: [ ... ]

Agreed - what I wrote is wrong.

> So I think there is a redundant call to blk_freeze_queue_start(), we
> just need to call blk_mq_freeze_queue_wait() after calling
> blk_queue_start_drain().

I think it is on purpose that blk_queue_start_drain() freezes the 
request queue and never unfreezes it. So if you want to change this 
behavior it's up to you to motivate why you want to change this behavior 
and also why it is safe to make that change. See also commit 
d3cfb2a0ac0b ("block: block new I/O just after queue is set as dying").

Bart.


