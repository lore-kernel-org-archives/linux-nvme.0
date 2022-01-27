Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA7AC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Io3l3GRr8DtmjVYORe9Ppe0IV+1vX/kINYox0n0YcFM=; b=b1KQb0P8+KUEfe32Tp/AjTFQPF
	i2f7jB0/1uYFbpcscR5nVoQDfz0dh9ooH9pnM6xkmkGQNX+bEx+DpIbcbPsFew5grov16yAFpEOjB
	EbU6ooLYtRa9AcdaYHvfVE63A7DlxwELdGnsijPK3HZLzUTRsAFcETIqJEFSHwEyyJU0bZ1i91yyg
	OfszrUfQNwe1ww3h+GmMa5ZEDtoiHxp/Q2kxAcGnZ7xB8AOFxLb4m6vnz8Md10xUBoqeFv+MbQiq3
	6sMsGhsGCdTN+GpqkPESbDNSp2RoZDjCKwVNMcRAiUIKU5evr5h9hg2baYOq6OzZDLLp+gpBwMq13
	DVSVrz5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD4bM-00Fqt0-Cr; Thu, 27 Jan 2022 13:14:12 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD4bJ-00Fqrw-DF
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 13:14:10 +0000
Received: by mail-wr1-f54.google.com with SMTP id l25so4633816wrb.13
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 05:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Io3l3GRr8DtmjVYORe9Ppe0IV+1vX/kINYox0n0YcFM=;
 b=SRJB6z3GXCoraGSFjHZE4NYDrv2ZsJA78i9/I+PGMoN9eaJFGRvAaM2DEi2dP2aaFQ
 ht9zG/p77mNUigty+QbW/BFIE/eGUfNKdmKbdmvLGcAFyje2d52ZcXxmDV0CrHU4S6CI
 nv54a/7j42cDw3OB+O6kH2JLkhMzIIAKr8SaPwfnWvGSdKpwiZbJlGttZyIXje9GpR0w
 C+EBcos5LAAf2gjKbwS+WVmELzICBl3t3K0P5yOPHE6wf2Bsm9mGogjfxVMpbXaqJ53z
 iICkwDVu7/vfY00C+CT6WXLRQys8gY4kEZb39H2ITbWGdYjHOzioqZQRhu00FLkDMP4W
 IHHA==
X-Gm-Message-State: AOAM531GOjzjcz/TMW8psjNJeDZRwVtbmTfrbmYs29fAO6qrKBSajVRA
 OjOcMv6ZfRzwbAQZHBpg6qY=
X-Google-Smtp-Source: ABdhPJyZuZmkIAArE8qMVTpbeU/u4AWltse/nsXUkjbFQHlljjjBYX5aXPAahoIJLM/W/oQBY3DhuQ==
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr3109242wrc.138.1643289247409; 
 Thu, 27 Jan 2022 05:14:07 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id b2sm2575823wrd.64.2022.01.27.05.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 05:14:07 -0800 (PST)
Message-ID: <da60fada-087e-6b12-ae37-15f88d967f11@grimberg.me>
Date: Thu, 27 Jan 2022 15:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] nvme-fabrics: add explicit deregistration on
 disconnect.
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291B32271567EB19DC312B79C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <ca31d387-f113-bbdd-9e3e-ce42a1cee934@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ca31d387-f113-bbdd-9e3e-ce42a1cee934@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_051409_477236_5E4090FE 
X-CRM114-Status: GOOD (  14.33  )
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


>> Per TP8010, a host explicitly registered with a Discovery
>> Controller (DC) must deregister on disconnect. This patch
>> sends a DIM PDU to DCs to deregister the host on disconnect.
>>
>> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
>> ---
>>   drivers/nvme/host/tcp.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 970b7df574a4..804d927b4b81 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2176,6 +2176,16 @@ static void nvme_tcp_teardown_ctrl(struct 
>> nvme_ctrl *ctrl, bool shutdown)
>>   static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
>>   {
>> +    if (ctrl->opts->explicit_registration &&
>> ++        ((ctrl->dctype == NVME_DCTYPE_DDC) ||
>> +         (ctrl->dctype == NVME_DCTYPE_CDC))) {
>> +        /* Deregister from discovery controller */
>> +        union nvmf_tsas tsas = {.tcp.sectype = NVMF_TCP_SECTYPE_NONE};
>> +
>> +        nvmf_disc_info_mgmt(ctrl, NVME_TAS_DEREGISTER, NVMF_TRTYPE_TCP,
>> +                    nvme_get_adrfam(ctrl), "", &tsas);
>> +    }
>> +
>>       nvme_tcp_teardown_ctrl(ctrl, true);
>>   }
> Similar argument to the previous patch: Does this need to be in the 
> kernel? Can't we delegate this to userspace?

Same agreement here. we shouldn't add any of this to a transport driver.

