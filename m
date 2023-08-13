Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA276EB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ho9M+QIpxFVOyVryHz2z5eekEwVYbb6+iJszSSz1hsU=; b=INFS/Edg7HrfI/bWz16Gl1oDYX
	UadPDGBL1+s6etXy+oTqWYX+ps0LqewZurOCU0d/nxmDHx2JfgcK8JdR0ea9LTyZEaKazhqJ9emV3
	/FsjYTXm06GvT1MpRNKl9e9lhe1iCne1ylh6+sQH4JNd0Qv1HCYkWzy/fljk3Up6psQHndIhJvf56
	9qc9K/MscT3hhTXZD/QB3SKluP3lXTZ10UlAag6F7N/lUBzMxBPq5u8q2kwBwvhjs8hCDb0ExDLQ4
	VUrBH1wK1owO5KDXhoa32u2SnQrR1Af1E2+iiPAbYXbDaq/v1g6iN++AOE7fnqQKWTJgh5Wn852ko
	Te1NE1WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVAcG-00F7M1-14;
	Sun, 13 Aug 2023 12:54:44 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVAcD-00F7Kz-13
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 12:54:42 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe1b6192e8so10081375e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 05:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691931278; x=1692536078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ho9M+QIpxFVOyVryHz2z5eekEwVYbb6+iJszSSz1hsU=;
        b=Oi9CChMgPral10Ln2z5DL0Ewjyw5D77/Rn0vxE3ii7BuYLgPPemYH8xn5W6IeYhhU0
         fqYpCxEs6Mm9pMlc+J1IrVTIZUyxpcVUOKWNQF7ufzj55FBeZW5NVgpBmyL/whdxo6Gi
         Oa0oiJX617kLN0HWZVw7qGUiRcAyO2r7SskPJ6diwjpet8b8a6meVqZZpW90I/pBCMPI
         /UYd96gcI2G3xQ4GPQ3/CtPocwxl5pjBZzjBcTP1RQypmFqLsyBxeMHheV645XbKyWoH
         N4mjooS+RWaTPCYWlYF5Fa2sma4V0l87waStCy2WJpKxa1XAX6FEF9bTTvWB2dji/l9h
         qUYQ==
X-Gm-Message-State: AOJu0YxlyXlZ9iF8Fy800Ws59u408DBIeoHCyJm196En1g/zgytiejf8
	2zbFeDkW6lwq1UUTBgIJrIE=
X-Google-Smtp-Source: AGHT+IF+9w7oBaAFEkzj9FuB8nAheCRMY3dfB0WgLsd8x4NSOwarJvRVSIi82535yaJF1ClRsaf5sg==
X-Received: by 2002:a5d:6142:0:b0:317:e9c9:5951 with SMTP id y2-20020a5d6142000000b00317e9c95951mr4586727wrt.7.1691931278046;
        Sun, 13 Aug 2023 05:54:38 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id bh12-20020a170906a0cc00b009888aa1da11sm4549195ejb.188.2023.08.13.05.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 05:54:37 -0700 (PDT)
Message-ID: <ee0d283a-22f5-c644-70ba-66714f815e71@grimberg.me>
Date: Sun, 13 Aug 2023 15:54:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rfc 1/6] nvme-fabrics: add helper to resolve ipv4/ipv6 or
 dns name
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-2-sagi@grimberg.me>
 <667f8993-c087-43ec-a7f4-a379c5dcc54a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <667f8993-c087-43ec-a7f4-a379c5dcc54a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_055441_363791_AA86B141 
X-CRM114-Status: GOOD (  16.91  )
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


> On 7/24/23 11:20, Sagi Grimberg wrote:
>> Allow userspace to pass in traddr as a dns name as well. This may be
>> useful for a discovery service that may have a dns name, that may also
>> change in time (with an updated dns record).
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/fabrics.c | 28 ++++++++++++++++++++++++++++
>>   drivers/nvme/host/fabrics.h |  2 ++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 8175d49f2909..fadd25538d1b 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/mutex.h>
>>   #include <linux/parser.h>
>>   #include <linux/seq_file.h>
>> +#include <linux/dns_resolver.h>
>>   #include "nvme.h"
>>   #include "fabrics.h"
>> @@ -1133,6 +1134,33 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>>   }
>>   EXPORT_SYMBOL_GPL(nvmf_ip_options_match);
>> +int nvmf_resolve_ip_address(struct nvmf_ctrl_options *opts,
>> +        struct sockaddr_storage *traddr)
>> +{
>> +    char *traddr_str = NULL;
>> +    int traddr_len;
>> +    int ret;
>> +
>> +    /* first check if traddr is ipv4/ipv6 address */
>> +    ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
>> +            opts->traddr, opts->trsvcid, traddr);
>> +    if (!ret)
>> +        return ret;
>> +
>> +    /* second check if traddr is dns name */
>> +    traddr_len = dns_query(&init_net, NULL, opts->traddr,
>> +            strlen(opts->traddr), NULL, &traddr_str,
>> +            NULL, false);
>> +    if (traddr_len < 0)
>> +        return traddr_len;
>> +
>> +    ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
>> +            traddr_str, opts->trsvcid, traddr);
>> +    kfree(traddr_str);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(nvmf_resolve_ip_address);
>> +
>>   static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
>>           unsigned int allowed_opts)
>>   {
>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index 82e7a27ffbde..603d8d176168 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -222,6 +222,8 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char 
>> *buf, int size);
>>   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
>>   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>>           struct nvmf_ctrl_options *opts);
>> +int nvmf_resolve_ip_address(struct nvmf_ctrl_options *opts,
>> +        struct sockaddr_storage *traddr);
>>   void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 
>> nr_io_queues,IS
>>               u32 io_queues[HCTX_MAX_TYPES]);
>>   void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl 
>> *ctrl,
> 
> dns resolver is a config option, so we would need either a '#ifdef 
> DNS_RESOLVER' or if (IS_ENABLED(CONFIG_DNS_RESOLVER))' somewhere ...

Probably will be hidden in nvmf_resolve_ip_address, which will else
just perform inet_pton_with_scope...

