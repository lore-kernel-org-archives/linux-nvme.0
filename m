Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E50CD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 20:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z59eKGisbG/GVwZ41NOAkympydkJlAvl6JclA5ptAW4=; b=UUekg1F8oy4I7IrSiYtHBQ1S7e
	Z+d6/pm86bqgkPfxhLC1PHIo+q9tooREP9Qr1og3ouHYhA3+0Nd2KCYQ8HsQNuqiNWcgk26L8K1bR
	vilcAczUlDPgO4uHFlYktDzuMJYB+E5P1HIKUceR2jtd05lsvdk45QEusACKy7cmhA2OjWqUhk2q0
	3SrjjDNzXKmpG6a3jWLaVpy1X4loSicETLSa02ehW0iwhlot+X5P52AN4etTtRospbsAacby5flKr
	LJrFItfNQc9EHMTig1eEr2mxuSjI6AFfSrahkEPtnhSkWtteynr4Ygng6lCJsAaRWaWKhAV3iOfiN
	Qmxqhhqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtYoY-0000000DQnC-46eI;
	Sun, 07 Apr 2024 20:08:30 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtYoW-0000000DQmi-1RBR
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 20:08:29 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-416463e82fbso666025e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 13:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712520505; x=1713125305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z59eKGisbG/GVwZ41NOAkympydkJlAvl6JclA5ptAW4=;
        b=piFvM2a03DaaMMk7aKm+HkFoOiAasYG/qfAz9FWxyIIVibx1ZtZ2tmEat3U9v3wl0/
         7lICvQnIWbvA++n8Xmtbi7NefK4pTPXnzu7pabgja4ARlsn+IksTYMmMPdToldRdS7UK
         h8D8nqogZoiCgjOOw8UIUnCKes/stjsgCB962gq3zh7Iq73tdXPn7Hm3RsW9UUigYhGo
         VBqcJUkh8jnp0b9doHvwS3hWLFb02leyy7ql0TLPYrRC+YoVk6doPp40aRujX4zTeBid
         X0E0PSF4Cr1SURz0I9lSrtTYCIbPFMJVpHjggr7bCB5kG3L+qM+6TxLnXeD0IQ/gbHWV
         zB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaXReyRNIByTO9LJ2krezB/0BxXBI8YtCST80y5t/Aruoi25C93SNxQ4noSPylcAlEAR384410Uhwq61Olr4CNIYSt9LljNCdDiuCvpV8=
X-Gm-Message-State: AOJu0Yyl8N89Xxi5W6dftITqrgdpIgrZj4wPmo/7T0YxwK7VkBZeGeV4
	s5Sfy6XwBLpzWjOmUULg+H/G078xKaP2IfP1h3PW4dRihcDaHTJY
X-Google-Smtp-Source: AGHT+IFbPIOq5EP4wvRPLUOjCwF64ufM0/+5/bxWBDsG82CRtuWR0RyEFHCnmSXszVXn3J9JBlOD7Q==
X-Received: by 2002:a05:600c:3b26:b0:416:3de5:1367 with SMTP id m38-20020a05600c3b2600b004163de51367mr3432106wms.3.1712520505315;
        Sun, 07 Apr 2024 13:08:25 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b004162a9f03a6sm14000449wmb.7.2024.04.07.13.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 13:08:25 -0700 (PDT)
Message-ID: <f5d57e3b-8168-41af-8e36-c7a21ef3a475@grimberg.me>
Date: Sun, 7 Apr 2024 23:08:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
 <6d3af8dd-30c3-48d4-9083-7f00ea21ff8c@nvidia.com>
 <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_130828_483991_D26A8E5B 
X-CRM114-Status: UNSURE (   9.28  )
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



On 03/04/2024 2:50, Kamaljit Singh wrote:
> Sagi, Chaitanya,
>   
> Sorry for the delay, found your replies in the junk folder :(
>   
>>   Was the test you were running read-heavy?
> No, most of the failing fio tests were doing heavy writes. All were with 8 Controllers and 32 NS each. io-specs are below.
>
> [1] bs=16k, iodepth=16, rwmixread=0, numjobs=16
> Failed in ~1 min
>
> Some others were:
> [2] bs=8k, iodepth=16, rwmixread=5, numjobs=16
> [3] bs=8k, iodepth=16, rwmixread=50, numjobs=16

Interesting, that is the opposite of what I would suspect (I thought that
the workload would be read-only or read-mostly).

Does this happen with a 90-%100% read workload?

If we look at nvme_tcp_io_work() it is essentially looping
doing send() and recv() and every iteration checks if a 1ms
deadline elapsed. The fact that it happens on a 100% write
workload leads me to conclude that the only way this can
happen if sending a single 16K request to a controller on its
own takes more than 10ms, which is unexpected...

Question, are you working with a Linux controller? what
is the ctrl ioccsz?

