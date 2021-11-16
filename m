Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59427C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 09:07:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101EC63214
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 09:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 101EC63214
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PGjfQznZ8qNc6C14+V9C0RspLils9VNjcSRRAtVY7b0=; b=cRsZxxMHwxOGTU7VFoSbr9NAbF
	lvlxISiFi6kLE1omUeXX8QI9hkaRD6xo6UjoKVd9ukeGHVn3wCppOTWRz+eoc8JE79IAD/JCYL9vL
	8zWtldb9wWA/t22bsul0RQjkPmtgXphNaDIaimp6cmCwUmu1ebkJMfx7gJGFE33eWbXUVy8DOxNOl
	oWdR/A7BuQY8vYNeev13r0Tjd0UoqL99Fkeh/6jwcwK77iZLDgBuVSnFYq58RHZaakc4XtPmiy7mu
	LM6jvvvTs6VMax2ydarEYvri7u++9ItU47lAachjVk0f3zrWsgnz0ZApY+6gbhFG8dV9LFD42hWxP
	w8YmN6LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmuRE-000qoA-6S; Tue, 16 Nov 2021 09:07:36 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmuRB-000qnV-H7
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 09:07:34 +0000
Received: by mail-wr1-f53.google.com with SMTP id w29so36055394wra.12
 for <linux-nvme@lists.infradead.org>; Tue, 16 Nov 2021 01:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PGjfQznZ8qNc6C14+V9C0RspLils9VNjcSRRAtVY7b0=;
 b=uJ13nvyt+o8qeJ2AzFCvnwGm2B1zm3vfrYRcZmDBddzZbq0c91yrACbbxygHkKYCsW
 cUEpjPGdyYLrZmlfv2+HSU8jkFnnYmSNmdnwfT0wWjkHPfOjM10jjeY/Dz3WK5EBCLrN
 rRSXWoXsGxw/yITGSZvdvfIow20a7dQjdofiLcqRIVCmEXCZFuzkHTQqhCaTsCGuk78l
 6gyEFuCGjJnbjeYdO9rtqTGKLriCs+XVyw6G6ljNTI/1x3bJFKDPqKQxa55YN0s/WpcN
 /39U+kwqNWPrGhBbvF5NNLL0e23WTYam4UNtlUt+LhQV2SOVD+xCGKA17BbVmK4Qp0bI
 inRg==
X-Gm-Message-State: AOAM532neR0L4B3YlvjTfrDrDg52+nmqtDYNOuzIYqSV8W1632+08TYk
 be6WBD7sbmRD8sSPhNplbUo=
X-Google-Smtp-Source: ABdhPJy6MTIPQW72x04uieVRO4Vey1eLOZKoOUv+klhGouIM0ZlovcmZKqux/UjhsYT3DHubhUqyEg==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr7514896wrs.435.1637053651300; 
 Tue, 16 Nov 2021 01:07:31 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id r62sm1734247wmr.35.2021.11.16.01.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 01:07:31 -0800 (PST)
Subject: Re: [PATCH V2 3/3] nvmet-tcp: fix memory leak when performing a
 controller reset
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, chaitanya.kulkarni@wdc.com
References: <20211115163114.48716-1-mlombard@redhat.com>
 <20211115163114.48716-4-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6f864cab-8460-3956-5784-2c3669069028@grimberg.me>
Date: Tue, 16 Nov 2021 11:07:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115163114.48716-4-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_010733_610220_85C377BF 
X-CRM114-Status: GOOD (  21.17  )
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


> If a reset controller is executed while the initiator
> is performing some I/O the driver may leak the memory allocated
> for the commands' iovec.
> 
> Make sure that nvmet_tcp_uninit_data_in_cmds() releases
> all the memory.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 028b47ff0f0f..5a238fa067cd 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1427,7 +1427,10 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>   
>   	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>   		if (nvmet_tcp_need_data_in(cmd))
> -			nvmet_tcp_finish_cmd(cmd);
> +			nvmet_req_uninit(&cmd->req);
> +
> +		nvmet_tcp_unmap_pdu_iovec(cmd);
> +		nvmet_tcp_free_iovec(cmd);

I understand how unmap_pdu_iovec is re-entrance safe, but sgl_free
called from free_iovec is not. What prevents it from being called
for commands that have already freed their sgls?

