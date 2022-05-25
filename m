Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E304C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cYFvf5S74zrkxiUcx9efmkq8IReMie2+kmRtGzK9T9A=; b=QUfjoRuKq1EOWwQgDXgHVBLlh4
	/eKx5D2XrwiRhXZkpnFm0YFckY9MYkj7hRR1ypJkRxDASmK4bt/7KmlYknIP0TFzYu3LsJQGXEG9x
	RmaqjlWY/ZBTNHBsnIF3/+HqZEV4rNe7xUWZ6i+SSvAXwhzXK+xrGU3P7hmmoK9RC524b0PTes+uh
	PHIixnSfUKj7L7p+b1MdDwFrA9WtBV3pV9qm1ESxDPaT18FCZNk5MQYdCIq2+ptcOHrzoLmPTJQJl
	ND3S7THH6c8ljrTe7IzAfHYOF+CSEqagddTfnTgadcNvb4wXL8j8zA5tH8p0eJ8B1NTblYR7aX0Mf
	RKzp/HmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntoTX-00AkUA-Pd; Wed, 25 May 2022 10:42:47 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntoTU-00AkSz-Ad
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 10:42:45 +0000
Received: by mail-wr1-f49.google.com with SMTP id p10so10901962wrg.12
        for <linux-nvme@lists.infradead.org>; Wed, 25 May 2022 03:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cYFvf5S74zrkxiUcx9efmkq8IReMie2+kmRtGzK9T9A=;
        b=pDhZeSiAR7OVPgkm5TF/JewHi4GyMPFH26UUfwUiy0stmVSVX7PvByWjFvNq0hJrZG
         xDYFK7JpvlnOhBP8Tao1fEdozxd6WMjVZIZ9WegtYOUQAkFqyF4Eb9dh8N86+QKsT03x
         5fpUYmN9fgpHhKo9GlbIessn+BkZPR7tTT2mAinVE3tYCIfFMTHKyjxl7d0YZcP13kva
         oh7ygUDu3kKNW4fosqhFptqKZogMViJey8hKsPcHztP5Gt6uIE+VJRn4XmJ5Aw+PkjaL
         PTAlAyYGuoV3Te+YIRxIy4aMSW83etYCHb6F0IbYtdqlu4GEmkiIryj1EdnMxDQ2YkCV
         4mBw==
X-Gm-Message-State: AOAM532bMOplgSpdqh4HpiB2S4QOfev0rbMFBhSsXDREVAt7quDjUels
	J75a21/wTbabKpoSrbzYa5w=
X-Google-Smtp-Source: ABdhPJwVvlVhvwu055D6La1n8dBFZz/FVJlSa2HTQmGMFjI+M0cb6I0EvT6Q0weDGII3foC6XGglwg==
X-Received: by 2002:a5d:6782:0:b0:20f:dd3a:3edf with SMTP id v2-20020a5d6782000000b0020fdd3a3edfmr12628365wru.517.1653475362422;
        Wed, 25 May 2022 03:42:42 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b24-20020a7bc258000000b003974ba5cacdsm1750495wmj.35.2022.05.25.03.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:42:42 -0700 (PDT)
Message-ID: <e2845be6-6759-5330-7d79-77c733af22b1@grimberg.me>
Date: Wed, 25 May 2022 13:42:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20220518112234.24264-1-hare@suse.de>
 <20220518112234.24264-10-hare@suse.de>
 <e13a0c12-362d-e4b6-c558-03367815264b@nvidia.com>
 <903b586c-b539-c4e5-9233-7e24aa55f11b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <903b586c-b539-c4e5-9233-7e24aa55f11b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_034244_403465_903578B5 
X-CRM114-Status: GOOD (  18.26  )
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


>> Hi Hannes,
>>
>> On 5/18/2022 2:22 PM, Hannes Reinecke wrote:
>>> Implement NVMe-oF In-Band authentication according to NVMe TPAR 8006.
>>> This patch adds three additional configfs entries 'dhchap_key',
>>> 'dhchap_ctrl_key', and 'dhchap_hash' to the 'host' configfs directory.
>>> The 'dhchap_key' and 'dhchap_ctrl_key' entries need to be in the ASCII
>>> format as specified in NVMe Base Specification v2.0 section 8.13.5.8
>>> 'Secret representation'.
>>> 'dhchap_hash' defaults to 'hmac(sha256)', and can be written to to
>>> switch to a different HMAC algorithm.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/target/Kconfig            |  12 +
>>>   drivers/nvme/target/Makefile           |   1 +
>>>   drivers/nvme/target/admin-cmd.c        |   2 +
>>>   drivers/nvme/target/auth.c             | 367 ++++++++++++++++++
>>>   drivers/nvme/target/configfs.c         | 107 +++++-
>>>   drivers/nvme/target/core.c             |  11 +
>>>   drivers/nvme/target/fabrics-cmd-auth.c | 491 +++++++++++++++++++++++++
>>>   drivers/nvme/target/fabrics-cmd.c      |  38 +-
>>>   drivers/nvme/target/nvmet.h            |  62 ++++
>>>   9 files changed, 1088 insertions(+), 3 deletions(-)
>>>   create mode 100644 drivers/nvme/target/auth.c
>>>   create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c
>>>
>>> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
>>> index 973561c93888..e569319be679 100644
>>> --- a/drivers/nvme/target/Kconfig
>>> +++ b/drivers/nvme/target/Kconfig
>>> @@ -83,3 +83,15 @@ config NVME_TARGET_TCP
>>>         devices over TCP.
>>>         If unsure, say N.
>>> +
>>> +config NVME_TARGET_AUTH
>>> +    bool "NVMe over Fabrics In-band Authentication support"
>>> +    depends on NVME_TARGET
>>> +    depends on NVME_AUTH
>>> +    select CRYPTO_HMAC
>>> +    select CRYPTO_SHA256
>>> +    select CRYPTO_SHA512
>>> +    help
>>> +      This enables support for NVMe over Fabrics In-band Authentication
>>> +
>>> +      If unsure, say N.
>>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
>>> index 9837e580fa7e..c66820102493 100644
>>> --- a/drivers/nvme/target/Makefile
>>> +++ b/drivers/nvme/target/Makefile
>>> @@ -13,6 +13,7 @@ nvmet-y        += core.o configfs.o admin-cmd.o 
>>> fabrics-cmd.o \
>>>               discovery.o io-cmd-file.o io-cmd-bdev.o
>>>   nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)    += passthru.o
>>>   nvmet-$(CONFIG_BLK_DEV_ZONED)        += zns.o
>>> +nvmet-$(CONFIG_NVME_TARGET_AUTH)    += fabrics-cmd-auth.o auth.o
>>>   nvme-loop-y    += loop.o
>>>   nvmet-rdma-y    += rdma.o
>>>   nvmet-fc-y    += fc.o
>>> diff --git a/drivers/nvme/target/admin-cmd.c 
>>> b/drivers/nvme/target/admin-cmd.c
>>> index 31df40ac828f..fc8a957fad0a 100644
>>> --- a/drivers/nvme/target/admin-cmd.c
>>> +++ b/drivers/nvme/target/admin-cmd.c
>>> @@ -1018,6 +1018,8 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>>>       if (nvme_is_fabrics(cmd))
>>>           return nvmet_parse_fabrics_admin_cmd(req);
>>> +    if (unlikely(!nvmet_check_auth_status(req)))
>>> +        return NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>>       if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
>>>           return nvmet_parse_discovery_cmd(req);
>>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>>> new file mode 100644
>>> index 000000000000..003c0faad7ff
>>> --- /dev/null
>>> +++ b/drivers/nvme/target/auth.c
>>> @@ -0,0 +1,367 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * NVMe over Fabrics DH-HMAC-CHAP authentication.
>>> + * Copyright (c) 2020 Hannes Reinecke, SUSE Software Solutions.
>>> + * All rights reserved.
>>> + */
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/err.h>
>>> +#include <crypto/hash.h>
>>> +#include <linux/crc32.h>
>>> +#include <linux/base64.h>
>>> +#include <linux/ctype.h>
>>> +#include <linux/random.h>
>>> +#include <asm/unaligned.h>
>>> +
>>> +#include "nvmet.h"
>>> +#include "../host/auth.h"
>>
>> maybe we can put the common stuff to include/linux/nvme-auth.h instead 
>> of doing ../host/auth.h ?
>>
>>
> Yes, we can do that.
> Will be fixing it for the next round.

We already do that in nvmet-loop, I don't think it is really needed.

