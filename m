Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6B2C4707A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 18:04:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2C660FDC
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 18:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2C660FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ijw3I9WgQWfDIXLncCRpcvh4CmdTtmtJaCfPeUF1opM=; b=hUg1LxuoelgFvH9Yi8DfOsJs9t
	UjwuiGrs9xucQdKZCSPRKRwY5sWgZd3Yws2OSdw0GocxjsNnYZqY5EThdn98t9jgEViPvs1jBcz0e
	KO4pQA64d9y/o2shOS6rLdrqCFZy76XlsBDEoBOesy+o2NKkJSiXbmRDXDC70mfLLumCx8+f/Fedl
	Q8PvqWtLYDLGFat/tFO5IKIZla6nuRuEPE4aMSbe0nhfzAMU8yeiL+xNFBak3DO28a8VvysdpeVRE
	2jBsDn94Wp13j/8jPU3V9YFDvgdhOuWo/lUVk7Fo9WI64yP87LHVYr6m7LK1mXJtZfChKPc58hNyO
	fhLRcNUQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk9Vi-000egN-Ao; Fri, 21 May 2021 18:04:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk9Vg-000eg7-HU
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 18:04:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=IPCfgRc63YGpcjwCQoNBJKQG9HOEA+TQ6KPWTmKtH0g=; b=ueyZDtt6h8bf2e1zzwFVxCQUTj
 eCRVelgypzYOY+Vmk5JiqBtusnlMUPr1b2Z0uTPZXoS3MmDRyvoYBUe5oLqDzY/ST/HaFqRQNvO/N
 LO8syADWPWmSgn0b2kz6XRuBE0sjVdIbS6UyAKEj8sl83V8qHkZnqEmgW8FKcEKcrjb3y6FDb03zV
 PLsicic4MAwJ/r3NboturKl6ydOoyfz4w/tf3EO4Zw5zxrF0AcXrgmGLeED0tiGoq70eTP8eDVPOq
 mNAYeMZEwipIOlooo5B/OlZ46nQ4SGSG5S5okMnyl57ipO1QdgCR8g7Y/7s5nrhP5V8IpGzB3UBe+
 n2XGz0qw==;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk9Vd-00HLE2-UG
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 18:04:31 +0000
Received: by mail-wm1-f52.google.com with SMTP id t206so11603145wmf.0
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 11:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IPCfgRc63YGpcjwCQoNBJKQG9HOEA+TQ6KPWTmKtH0g=;
 b=JFL6NQgIOUcV4BJhSwe8D8SySndCs39xeAP4TalWOkfqy1+79GLxAnnKxjXCFNyRZy
 jBF2GDcBuUROtrv2u8Jc9z2O48AdjIGE8b+GE+q5Lv3gXxzoSYEnMA5X1HJscFcNjFy4
 nBbV8jAzWEGCKJkPEWnCbXyWCaRxvtQ59gTIlR1zVDil1qEh1ChqZbmrVJhun0zJ1SYv
 nVk5Fk3kxAlhAJ7uuGSfiXP+ml7XZ25qjsg2Q0O+L6j5NCKoUAc2LXJO9R2tLJvjvj7h
 +pl9uV3cKToxFlx8X/j6OraO26KIEEjRbEa22LJA755IImdfdyqx59AaRLsk8UkWeg/8
 mO7Q==
X-Gm-Message-State: AOAM531cEJ3v+R6EgYOLKjR9tyB0LOWHvXFSbVasoeonxdV2u5GZJyND
 YnHXTerJO3hMWbtpPNY+L7g=
X-Google-Smtp-Source: ABdhPJwapNdgpcMBJ2T04yVw6gaeA4duJJbKqX3DARZvOsMi+mjuNYkTzPwuVDG/XxeJY5rWXkweHQ==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr10443675wmc.31.1621620268025; 
 Fri, 21 May 2021 11:04:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id z17sm3258037wrt.81.2021.05.21.11.04.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 11:04:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet-tcp: fix connect error when setting
 param_inline_data_size to zero.
To: Hou Pu <houpu.main@gmail.com>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, larrystevenwise@gmail.com,
 maxg@mellanox.com, "Grupi, Elad" <elad.grupi@dell.com>
References: <20210520113046.27821-1-houpu.main@gmail.com>
 <20210520113046.27821-3-houpu.main@gmail.com>
 <417493d4-a78f-ea89-8536-0b391ef95f08@grimberg.me>
 <CAKHcvQgYDcS4sOZ9SBaZ_9gK2EHz5LwLHXo77UDqDTyjjNJzZw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2d4ae6a7-72f1-4dd4-df58-366e6f53c5cf@grimberg.me>
Date: Fri, 21 May 2021 11:04:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKHcvQgYDcS4sOZ9SBaZ_9gK2EHz5LwLHXo77UDqDTyjjNJzZw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_110430_004293_93AF7841 
X-CRM114-Status: GOOD (  17.36  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> +static inline int nvmet_tcp_inline_data_size(struct nvmet_tcp_cmd *cmd)
>>> +{
>>> +     struct nvmet_tcp_queue *queue = cmd->queue;
>>> +     struct nvme_command *nvme_cmd = cmd->req.cmd;
>>> +     int inline_data_size = NVME_TCP_ADMIN_CCSZ;
>>> +     u16 qid = 0;
>>> +
>>> +     if (likely(queue->nvme_sq.ctrl)) {
>>> +             /* The connect admin/io queue has been executed. */
>>> +             qid = queue->nvme_sq.qid;
>>> +             if (qid)
>>> +                     inline_data_size = cmd->req.port->inline_data_size;
>>> +     } else if (nvme_cmd->connect.qid)
>>> +             inline_data_size = cmd->req.port->inline_data_size;
>>
>> How can a connection to an I/O queue arrive without having the ctrl
>> reference installed? Is this for the failure case?
> 
> Hi Sagi,
> AFAIK after the host finishes setting up the admin queue,
> it connects to the io queue and sends the io-connect command. At this
> point the nvmet_tcp_queue is firstly allocated and does not have a valid
> queue->nvme_sq.ctrl. It is assigned after io-connect in nvmet_install_queue().
> So this function tries to find the correct queue number before or after a
> fabrics connect command.

Why do you need the inline_data_size before the connect? its only
relevant for nvme I/O..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
