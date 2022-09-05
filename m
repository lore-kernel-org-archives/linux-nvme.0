Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE92ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qscvAHqHICGOPtxLQQYke7ZUtU0zLWIlnxXCXxC+B4A=; b=I7DMF3XtIR+HvTtLBRXU1ubIeX
	GL4d2d+zHwpO9JoYn4OfMUx4Lvus9fQDECTY6297DAJJZlM2vmL2126x5MPrfi5Qax3XhUZxBfquA
	4puvmlow6kImPsLY0UkRmV9qaKVdQxeepDVpisg8Lh8c3KfOCtq2tfmqAnkBMWofKJdn5iEopAYkX
	3lAHeYd0gtBOo9LSKIrXObxZ1o2Wo9WinxiIRhZgrvNsjmeV4lMwBhyiDVb0WqZNz7mci0uiY3jSd
	B7JNPsYszYCh0JvhYMvmvSrL2XbrWsZxOJ1M2w6q60Ei5DsAUMYyUjQrJFjtnnJ8u5Ojy3ZuKt48o
	7D4xKG2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9LQ-000G2F-Qy; Mon, 05 Sep 2022 10:28:44 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV87h-00Fe3P-W7
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 09:10:39 +0000
Received: by mail-wr1-f46.google.com with SMTP id c11so6201544wrp.11
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 02:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qscvAHqHICGOPtxLQQYke7ZUtU0zLWIlnxXCXxC+B4A=;
        b=iah2iM+RFzUTtplPpiWsxhTTIiIix98A24uAwkOWVdrmEYPZ1RM+ztUpaNDw/vE4JM
         bjceXzeDwB5JYtIoUET7P/tgHfjFnjaGMbXKoLwE9rjIst7Edm/ZzcN2OkTk5LAIo8Tp
         N5Vym2nzY2lUzYX5Y2Hq1i9Fd9UCQWkGiKbtnQw5iTbRqJmdcHAhuOFG+cpxxh9h+8KI
         DjGpt2Ict3xmJ91Aqte3rL893I8i1jIwoh84XSz9e/47FsoRJAUhW3Qc/IFiGptCktGZ
         kTvpV1ABNVbz0Px3ox90MpCWAGIEKSA7I1VK8GrhRGHklyWLcmNVJb01/3Va91S2pzB1
         deeQ==
X-Gm-Message-State: ACgBeo1nOO1uUwzKtBjM82Do/O0ysp7CKx4nYbYH/1AOP7RhCUytH8X+
	2hWMZg5Df9iX5ov2DVL3g40eIdVYXcI=
X-Google-Smtp-Source: AA6agR5Gz16QfM6aBvOfgoutbO6m/XiCRz2Rv8OgSMM8g/XTdP+K2qU2OkwfAU448ZCQnPI/V/PV5Q==
X-Received: by 2002:a05:6000:1f03:b0:228:6c98:b01 with SMTP id bv3-20020a0560001f0300b002286c980b01mr3107297wrb.250.1662369028353;
        Mon, 05 Sep 2022 02:10:28 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm16458160wmk.22.2022.09.05.02.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 02:10:26 -0700 (PDT)
Message-ID: <0a040337-4be7-f57b-597b-a90afd4206cf@grimberg.me>
Date: Mon, 5 Sep 2022 12:10:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: requeue aen after firmware activation
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20220901153039.4162460-1-kbusch@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220901153039.4162460-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_021030_846736_E52B5298 
X-CRM114-Status: GOOD (  15.26  )
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



On 9/1/22 18:30, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The driver prevents async event work while handling a processing paused
> event, but someone needs to restart it after the controller returns to a
> live state.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216400
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index af367b22871b..66446f1e06cf 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4703,6 +4703,8 @@ static void nvme_fw_act_work(struct work_struct *work)
>   	nvme_start_queues(ctrl);
>   	/* read FW slot information to clear the AER */
>   	nvme_get_fw_slot_info(ctrl);
> +
> +	queue_work(nvme_wq, &ctrl->async_event_work);

Why is the rest below needed? why is this not enough? Also a code
comment would help here...

