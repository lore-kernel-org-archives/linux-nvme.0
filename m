Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41F2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 12:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9u+nIpxqOSfGTgVtgZ+Rj20LtTm5iPwX2cJ0QwjgMq4=; b=O7xurwtEZbLmiMYv0qFdEDgziE
	WUzE+Gc/Hc5r1Ag8wuKWponmz7FVrIr0X35RRb16Ct5g7M2ECjMu9rYXoTx70ahCP80hfwjgUIaZu
	LG2m+AFBL1l2IWZniVJ5+1Q55zzuZC1Yg4lI09MMCu5YFvnyJxRlNedw0QrJxI66dqVe1ohmkP3gE
	dtuyQ5Z/T1DOj1eiccUDSj49tYjdHaAyYQeWv9gkmDy49XbK2K6kOdlMo77Q8K6WF00Tnp3Ii5qZ/
	rgaxqURs4ZNcPCxFEE3Zt0WZGcvo/8W0z9Sv5sZbBt8dSSLKniCiPgr+FhwlP/7u8kpCQpRcjuvVp
	BCcnqhFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntU7J-0082ab-Uf; Tue, 24 May 2022 12:58:29 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntU7H-0082ZX-7w
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 12:58:28 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 c190-20020a1c35c7000000b0038e37907b5bso1391612wma.0
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 05:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9u+nIpxqOSfGTgVtgZ+Rj20LtTm5iPwX2cJ0QwjgMq4=;
 b=6t3at2BwiBWIUdCFvGWcRT2riReN9CvAR1BO82DmninEuuwtlHeXIBeGK1tKtiEyuN
 iDxiychiV1Y512q6pGDYrwjIFnoE/RAJW6z1C+qm34MiCgClAZfOMwP8UR1D1GGsiD3g
 ODNRc/8ubgXuTUlp1uU5gUnujZzwTPEsr+0w+BkpF1BTuBzTXFYQGoiNPKoTiOT/2E2/
 1uAaKPeFMT5/TD/Uf6sAQ0XIpRiVPuxR0Wz0CrfQGN0ZEOi9cJrX4UIV6rxHjnG6iBwQ
 bhB4StDV3Bejpo/8oUEc3rY+Vh9zaUJXc1PprAxcYHMMVdeEUCpLDkmMhMTUSKTl5D2k
 BNnQ==
X-Gm-Message-State: AOAM532CARmabYoHvdXv4PeRL4J5OnRGFJq3awwRi/Fu2bP+ttt40MoP
 L2EA2kPPy6VxE6uV9h/RC+w=
X-Google-Smtp-Source: ABdhPJyNzCDrD8hpm6NVXTF1dUZoGtLjsxUoAoemEbhVXofRYqZUCcGZ1B03XIrze+POhZwu5TVYYA==
X-Received: by 2002:a1c:f40a:0:b0:397:306b:caec with SMTP id
 z10-20020a1cf40a000000b00397306bcaecmr3704259wma.22.1653397104497; 
 Tue, 24 May 2022 05:58:24 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 2-20020a056000154200b0020ff3a2a925sm1881514wry.63.2022.05.24.05.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 May 2022 05:58:24 -0700 (PDT)
Message-ID: <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
Date: Tue, 24 May 2022 15:58:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: nvme: split bios issued in reverse order
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>, linux-nvme@lists.infradead.org
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_055827_330027_C91DE1D3 
X-CRM114-Status: GOOD (  18.01  )
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


> There seems to be an inconsistency in the order of writes that are
> issued after splitting a bio. Ordering depends on how the application
> write is submitted and the number of I/O queues configured.
> 
> In our testing nvme/tcp,

Is this specific to nvme-tcp?

> a 128K write issued with fio/pvsync

is this specific to the io engine?

> is split
> into four 32K I/Os (the target maximum data transfer size is set to
> 32K, and max_sectors_kb is therefore 32K). As expected, the four write
> I/Os are issued to the target in sequential order. However, if the
> 128K write is issued using fio/libaio, the four 32K writes are issued
> in reverse order:
> 
> fio-8098 [001] ..... 254009.711080: nvme_setup_cmd: nvme1:
> disk=nvme1c1n1, qid=2, cmdid=16468, nsid=1, flags=0x0, meta=0x0,
> cmd=(nvme_cmd_write slba=192, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
> 
> fio-8098 [001] ..... 254009.711083: nvme_setup_cmd: nvme1:
> disk=nvme1c1n1, qid=2, cmdid=16467, nsid=1, flags=0x0, meta=0x0,
> cmd=(nvme_cmd_write slba=128, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
> 
> fio-8098 [001] ..... 254009.711084: nvme_setup_cmd: nvme1:
> disk=nvme1c1n1, qid=2, cmdid=16466, nsid=1, flags=0x0, meta=0x0,
> cmd=(nvme_cmd_write slba=64, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
> 
> fio-8098 [001] ..... 254009.711085: nvme_setup_cmd: nvme1:
> disk=nvme1c1n1, qid=2, cmdid=16465, nsid=1, flags=0x0, meta=0x0,
> cmd=(nvme_cmd_write slba=0, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
> 
> Further investigation found that if the number of I/Os queues is
> limited to 1 at connect time,

Is this specific to a single I/O queue?

> the issue order is sequential for both
> pwritev and libaio.

I'm assuming that this is 100% repeatable?

> 
> I've spent some time tracing through the bio/blk_mq code and
> can't seem to find what might be causing the difference in
> behavior. Can anyone confirm that this is expected or desired
> behavior?

What is the controller mdts? does the 32k go in-capsule? or does
the controller send r2t?


Also, if we assume that this is indeed the case, is this a fundamental
issue?

