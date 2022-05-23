Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920DCC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 08:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JLMWRQbvtYko+FdD+5V/cDbb1tg5HgSK7m/BIo8u5Fk=; b=vhDSOjnZmeH1opiDZ7K91NeyL+
	jUamY4WHwqisyYvJ3iFFX8KCW+H1AsJRIfgqEw9AE1vbSVM0g9YZ1Ajc016d6L1/w6xpKWr53RpVx
	7c8mLkQAyb6h+Y73wyUT2Ou4uoSloB/wgRJLqSTvt9danl/4fqZjdRK/phwLkVWCVHobRlySTlEdv
	Fkgy/eo8YD1MKwa4kFQjBWRu+BP0zW4ExXr2kebhGmWg6p+MY+FLRMsBo9oDq/v/yXIKpHKGvLQ5L
	mmgIdOLG+R6n96XcqG3nr6TdaGFpkigvxPrHjiZKVrZaHSCS85fQ61zaukHvZQafeqEHBHfiYI1QO
	i0ORDcVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nt3jc-002Z22-UM; Mon, 23 May 2022 08:48:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nt2ok-002AAA-1w
 for linux-nvme@bombadil.infradead.org; Mon, 23 May 2022 07:49:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=JLMWRQbvtYko+FdD+5V/cDbb1tg5HgSK7m/BIo8u5Fk=; b=ddrf8vWFACsJPA7ISnsbbH8kh1
 uCAjYxpcTnsWqOH1BSjxyToeRy4sCDzdhYOasACUvyZ/Pr9L7pQgIGeV4cjETJCzgI3NeEU9c2iMl
 apWXq7zj0qhYLKuUk3qAf/9X7gNlEvW0cMbMuJEm4EvQouM9Ltrk/B9iLUzgf+DmycrRMLetvAGM3
 8UCR8iUM6mVy6KZVjpCEdWRUYW43EhMAygirv8VKbnyHv+ig3e8DQKYSzfA7c/8voQQ8XTss8hXzn
 94bHIhBTTrgMG8sl0XZOKyKPMzyndSkv4GPVDjs9rLTDgguz4uqnAcHKv1AvfyxaGxCnXTrRT2GZg
 oycpQ3rw==;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nt1AW-000skS-RD
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 06:03:55 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8954219E9;
 Mon, 23 May 2022 06:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653285786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLMWRQbvtYko+FdD+5V/cDbb1tg5HgSK7m/BIo8u5Fk=;
 b=ryxniUq193oWU6pMdhZted0WY6RQLycCB0iiLQezzp8jMNqsDY1XjxT12kwdZAKGfM8QLd
 ccltel4blW35LP0FuXYhN875erWmPe5YGh6H+IKTeHomKQtNt6ClD5WV4uHvmL/8e5XN4M
 ArrmpHoVMa0ki7aj0SpnU1AEwyotxPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653285786;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLMWRQbvtYko+FdD+5V/cDbb1tg5HgSK7m/BIo8u5Fk=;
 b=h6pe1Ss7YyDo8PwYGaCSUfDoiJRrQFU7lh5mhnrljZ5VLTDjXk8vbCVjWn4lC+34txxNi5
 EzRO9LbEOWCU7YBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 525D113AA5;
 Mon, 23 May 2022 06:03:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HEEdBpoji2J4dgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 23 May 2022 06:03:06 +0000
Message-ID: <903b586c-b539-c4e5-9233-7e24aa55f11b@suse.de>
Date: Mon, 23 May 2022 08:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
References: <20220518112234.24264-1-hare@suse.de>
 <20220518112234.24264-10-hare@suse.de>
 <e13a0c12-362d-e4b6-c558-03367815264b@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e13a0c12-362d-e4b6-c558-03367815264b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_070353_242812_70BC184E 
X-CRM114-Status: GOOD (  21.38  )
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

On 5/22/22 13:44, Max Gurtovoy wrote:
> Hi Hannes,
> 
> On 5/18/2022 2:22 PM, Hannes Reinecke wrote:
>> Implement NVMe-oF In-Band authentication according to NVMe TPAR 8006.
>> This patch adds three additional configfs entries 'dhchap_key',
>> 'dhchap_ctrl_key', and 'dhchap_hash' to the 'host' configfs directory.
>> The 'dhchap_key' and 'dhchap_ctrl_key' entries need to be in the ASCII
>> format as specified in NVMe Base Specification v2.0 section 8.13.5.8
>> 'Secret representation'.
>> 'dhchap_hash' defaults to 'hmac(sha256)', and can be written to to
>> switch to a different HMAC algorithm.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/Kconfig            |  12 +
>>   drivers/nvme/target/Makefile           |   1 +
>>   drivers/nvme/target/admin-cmd.c        |   2 +
>>   drivers/nvme/target/auth.c             | 367 ++++++++++++++++++
>>   drivers/nvme/target/configfs.c         | 107 +++++-
>>   drivers/nvme/target/core.c             |  11 +
>>   drivers/nvme/target/fabrics-cmd-auth.c | 491 +++++++++++++++++++++++++
>>   drivers/nvme/target/fabrics-cmd.c      |  38 +-
>>   drivers/nvme/target/nvmet.h            |  62 ++++
>>   9 files changed, 1088 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/nvme/target/auth.c
>>   create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c
>>
>> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
>> index 973561c93888..e569319be679 100644
>> --- a/drivers/nvme/target/Kconfig
>> +++ b/drivers/nvme/target/Kconfig
>> @@ -83,3 +83,15 @@ config NVME_TARGET_TCP
>>         devices over TCP.
>>         If unsure, say N.
>> +
>> +config NVME_TARGET_AUTH
>> +    bool "NVMe over Fabrics In-band Authentication support"
>> +    depends on NVME_TARGET
>> +    depends on NVME_AUTH
>> +    select CRYPTO_HMAC
>> +    select CRYPTO_SHA256
>> +    select CRYPTO_SHA512
>> +    help
>> +      This enables support for NVMe over Fabrics In-band Authentication
>> +
>> +      If unsure, say N.
>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
>> index 9837e580fa7e..c66820102493 100644
>> --- a/drivers/nvme/target/Makefile
>> +++ b/drivers/nvme/target/Makefile
>> @@ -13,6 +13,7 @@ nvmet-y        += core.o configfs.o admin-cmd.o 
>> fabrics-cmd.o \
>>               discovery.o io-cmd-file.o io-cmd-bdev.o
>>   nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)    += passthru.o
>>   nvmet-$(CONFIG_BLK_DEV_ZONED)        += zns.o
>> +nvmet-$(CONFIG_NVME_TARGET_AUTH)    += fabrics-cmd-auth.o auth.o
>>   nvme-loop-y    += loop.o
>>   nvmet-rdma-y    += rdma.o
>>   nvmet-fc-y    += fc.o
>> diff --git a/drivers/nvme/target/admin-cmd.c 
>> b/drivers/nvme/target/admin-cmd.c
>> index 31df40ac828f..fc8a957fad0a 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -1018,6 +1018,8 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>>       if (nvme_is_fabrics(cmd))
>>           return nvmet_parse_fabrics_admin_cmd(req);
>> +    if (unlikely(!nvmet_check_auth_status(req)))
>> +        return NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>       if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
>>           return nvmet_parse_discovery_cmd(req);
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> new file mode 100644
>> index 000000000000..003c0faad7ff
>> --- /dev/null
>> +++ b/drivers/nvme/target/auth.c
>> @@ -0,0 +1,367 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe over Fabrics DH-HMAC-CHAP authentication.
>> + * Copyright (c) 2020 Hannes Reinecke, SUSE Software Solutions.
>> + * All rights reserved.
>> + */
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/slab.h>
>> +#include <linux/err.h>
>> +#include <crypto/hash.h>
>> +#include <linux/crc32.h>
>> +#include <linux/base64.h>
>> +#include <linux/ctype.h>
>> +#include <linux/random.h>
>> +#include <asm/unaligned.h>
>> +
>> +#include "nvmet.h"
>> +#include "../host/auth.h"
> 
> maybe we can put the common stuff to include/linux/nvme-auth.h instead 
> of doing ../host/auth.h ?
> 
> 
Yes, we can do that.
Will be fixing it for the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

