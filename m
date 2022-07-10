Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4C4C43334
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jul 2022 09:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xEuiyabvsQDb6WJ6qFrmFNq916brfyyk43k/L2CuaG0=; b=XTM7S2tsxnbfGSOMptuGmaL7Qr
	ImjaIYTY+3Ql8/szAkdDKhfM6iXpR7eX3vnaubmhviiXn4iESTE/xEQOrr5RH2PU8JzIoaxTo4rZ3
	uFSqZkpqG2rISYLe8TGheX+2tHaWucVIzViP3td8Il6p34WszEGx/bq5RpZeUd38Up5hj2pdEa6RK
	uSy4oEIXDHtUEOT3W1ZwBOY8YBLfIPfhrZ3Ku8LRsooezt6cQZHKEmddwMyajk5FLWS4hIOyaCVHF
	41bKMdFjItJ9J0JAuzYmGcbkuEk54tt76IHyUdjKiZdC/vwo2LaBDqTonJHlEwDb4NvJAUK5p/iTV
	Jy/OKFmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oATRd-00BHf2-N8; Sun, 10 Jul 2022 09:41:41 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oATRb-00BHeJ-DJ
	for linux-nvme@lists.infradead.org; Sun, 10 Jul 2022 09:41:41 +0000
Received: by mail-wr1-f51.google.com with SMTP id v16so3527511wrd.13
        for <linux-nvme@lists.infradead.org>; Sun, 10 Jul 2022 02:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xEuiyabvsQDb6WJ6qFrmFNq916brfyyk43k/L2CuaG0=;
        b=wr0Sehpt41uWTGkXoOyza7rNlu42KiSo179wuxTWZIQbHIrruhCh+4PQOo9B8pKIGz
         LgYcvfTb3JK22y8Cw67MKgiYT9UDY/TtMWLnGcfV8w2emev8mMF3PUT3APlig09nZfgC
         R4/HUnTgbZyKVH3ug+985Fe+x6hQtEoZoryAY6oiomC537+MJLOyNkn7OZbqJO4mRKpH
         giKnIwEoj40zNHo087pz26mouGmD4Wdsy+eCiFQ5243aarRJjiCGOQQQVaN3N0X3vpuQ
         NIy1inlvrbIjDmLv8p0t3M3kINfzqpvVSlkuXe0YqenggTG3ut+q3e+uY/VqmSLrJa+9
         C4iQ==
X-Gm-Message-State: AJIora9qEsWhHqkVbtwbnbmUq1li0tvElSQazwZFp0eoxIy2UYNn6vXC
	D9HVerK/AU9XXSwD5zvBRkg=
X-Google-Smtp-Source: AGRyM1tnYHU2kuKbNjQiVLMiKob0GgudW3LLlovKxZOzecsGCXewdaZdgCiaGIy0Ixz+wQEbAeoUhQ==
X-Received: by 2002:adf:c64c:0:b0:21a:7a3:54a4 with SMTP id u12-20020adfc64c000000b0021a07a354a4mr11641836wrg.163.1657446095973;
        Sun, 10 Jul 2022 02:41:35 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6792000000b0021d4155cd6fsm3235238wru.53.2022.07.10.02.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 02:41:35 -0700 (PDT)
Message-ID: <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
Date: Sun, 10 Jul 2022 12:41:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220710_024139_496467_E463A8C4 
X-CRM114-Status: UNSURE (   7.01  )
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


> Hello
> 
> I reproduced this issue on the linux-block/for-next, pls help check
> it, feel free to let me know if you need info/test, thanks.


These reports are making me tired... Should we just remove
MEM_RECLAIM from all nvme/nvmet workqueues are be done with
it?

The only downside is that nvme reset/error-recovery will
also be susceptible for low-memory situation...

Christoph, Keith, what are your thoughts?

