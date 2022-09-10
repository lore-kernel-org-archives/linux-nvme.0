Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3B9ECAAD3
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r9dCl7QhjCZXvtpCmodoTGwKF+jhrQb09rsPLN1AZYY=; b=4it4gv+Y+d6b99ZLym6h0H7uBv
	wlEXkPuPX6VXnANhvrmzme8eTd6Eu5ubdmZesPFxa96DEu71krprsZdT20HKJpJ8tznLG8kK4osYG
	0nBIcwIhGqNQMa4KV8MuAWu1k19tgRR8epxTyF729VxAx7gz1WNv6T3soX3zFqG0mfDmiw1iqCZTJ
	F0GX7ZS3SV0BFsav1UUp6CSvGiXlsrEl1EqzEHmul83Q/8uM9ryp5QxtdZP13YvuYKG6l0X6HDPQ/
	AttM79bOoDaClvOb/xQZMSpgVCRoZRtePlpbEVY2dtPuzEWoFm1hxjzq5GqwUQLl0Psy/ocHWHBpm
	dCCwYlZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX1Y9-00AsW6-6Q; Sat, 10 Sep 2022 14:33:37 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX1Y6-00AsVL-LS
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 14:33:35 +0000
Received: by mail-pj1-x102c.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so4178524pjh.3
        for <linux-nvme@lists.infradead.org>; Sat, 10 Sep 2022 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=r9dCl7QhjCZXvtpCmodoTGwKF+jhrQb09rsPLN1AZYY=;
        b=daWbxKwCfJ9fWeKWKg07Zm8xLPXdxLUm626AwPcfeWMcljAT49UkJ2C2lN+G/WaWHB
         KTnBGT+1sVLuwtIS70HjbicpBr0DMv5acelE4db3yNHspPITt0kD+XABdrNEo8o45VDY
         CeuP+dqKcsdq1cHQATRZiAoLttsVQ0J79Ax91bKRIWnRTmua3fxd378a+v+GV36YOGUF
         gk/JT2r7ScBdEQMYkzdBDw9h2GJDAEzf+P4UlLlRCnvtqMuFalG+Gx50CIx6mQrlCZn9
         nx7sB0B6Hf/DVwcpg2s+YR/BSV/9a0obSR7gADiNo3VN7DBhdfF0tBITu737l8yK6iMG
         9a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=r9dCl7QhjCZXvtpCmodoTGwKF+jhrQb09rsPLN1AZYY=;
        b=Pfo21a7WGVtV05gzVpSUZ4SQaExFne8H2mfEP7LxWz21jLGCNoI27dkmo9SicDkGgz
         p89l/FJV1g4UUlwD28OqeLP7VflwIvCmMoagpQnv0bh0O0H0BhaVEqdTdR39W6Xb0faB
         hRWvZYph4S6EyxXXAI0xISwYA6CEybMNvQotrSsM5meOJZamSEsnsAUvPclYVgbH1d02
         c4qRe7RcAWtBd3amh7d+Vqc3qCpCjBDtppAqlU1kxjl5htpWvFMftImNAToRd4zcOzCW
         X31EzocRGCspYKOP2kjKzhD5acZi8hG2Rsa5O+fs+5P0u3+6FT+40GM/x5x2oD0QdJmB
         b8+g==
X-Gm-Message-State: ACgBeo34IDLEoOl53OrB202wIDxhmS9yzYvzo8TmAJI+nSnKeBesRjy+
	kbJoiNsldHtjRQA5eGMqrv4=
X-Google-Smtp-Source: AA6agR6jTqCa7me4rGP7gL1yUCl5YRTMNspblb2vT1sA0U6ZBNjNZjPx0jIS11Sn2TcCnGKa0KOq+Q==
X-Received: by 2002:a17:902:b106:b0:176:70e2:df21 with SMTP id q6-20020a170902b10600b0017670e2df21mr18841963plr.127.1662820412978;
        Sat, 10 Sep 2022 07:33:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y75-20020a62644e000000b005365aee486bsm1755899pfb.192.2022.09.10.07.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 07:33:32 -0700 (PDT)
Message-ID: <7ff5df5b-8816-4454-70d2-656f87d6b970@roeck-us.net>
Date: Sat, 10 Sep 2022 07:33:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
 Revanth Rajashekar <revanth.rajashekar@intel.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Serge Semin <fancer.lancer@gmail.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <20220910053045.GA23052@lst.de>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220910053045.GA23052@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220910_073334_732897_88704143 
X-CRM114-Status: GOOD (  11.55  )
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

On 9/9/22 22:30, Christoph Hellwig wrote:
> I think this will work, but unless we have to I'd generally prefer
> to just split dta that is DMAed into into a separate allocation.
> That is, do a separate kmalloc for the nvme_smart_log structure.
> 
> Guenter, is this ok with you?

Seems to be a bit overkill, but sure.

Guenter

