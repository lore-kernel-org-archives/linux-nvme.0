Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074ABECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Sep 2022 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYqBd4r9IK6UEYhDzrdv9tFwcDed0lkfMRygODMDI9M=; b=4VTc1hmf3YEGID3gsSZvBStq1V
	jaayRPHg9oCt3roJMIKDIRR2Vj2pN67Vwa2V3IfOijZ/2CErKW3JJnNIxMY6RsTWrv93R1PCfEY4E
	vDeqAuFrfZCs1WII4NlQRKtSrMeDTk9FbqJAH7nxTZBUgIl+uz3YIUllz9/O/cs0tUODJP+dVX2/G
	Y+lC7PVgRjmRTmZS4ONhwrBhbsA7LFPcTBMVqTxgeXxQvV31Pav3ambnuJoJlx4B1FyACM8o74CY/
	ZfEWn6TAlb70xSuyOG2x9g4GmFGR+mNU+Nl9pfiB1DtHjz0bQun7u84JQo7Z9H3SFU98tsy7Huj/D
	Lr+nVU6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYPe4-00F8yh-8M; Wed, 14 Sep 2022 10:29:28 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYPe1-00F8sO-4a
	for linux-nvme@lists.infradead.org; Wed, 14 Sep 2022 10:29:26 +0000
Received: by mail-wm1-f43.google.com with SMTP id ay36so1673993wmb.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 Sep 2022 03:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HYqBd4r9IK6UEYhDzrdv9tFwcDed0lkfMRygODMDI9M=;
        b=IT665jxNlbzVo1W+M8OW38J68PbAYQd+jrdCYXJSL0vly1lmHBBAykPiXV/0rW6xF7
         FO3Csnps4+58BhdAaoLrKRK+gZ3xBiv3IWn7/xBR2ykvfgYAHW78EnvX7WTW7HC5dvJM
         j/yFoP0TDEQJKgEjX9hz0UTPlBzT2u+IAcT2VP/TsFerqW13QPjYRdOA4Rz/DRZ0DQ2U
         ga8T51aVZT4ih5wwLeXNbfgnm2fyULZKA89espjCPpwM0XT/hWoQ0GEdJzhZMw4F3j6k
         kOh/guBjK2J//L+KoaL6HWjsBbo9b5yfohFJMtxvMpa0KqViz6ADeXU+KmEQeY/4sSY/
         4SaQ==
X-Gm-Message-State: ACgBeo3jrFt2qQjWjEsYe6ZJ/fTLoJrm9t89n3Y/n8zWE2ZvXUOm8js8
	kUI0L8Z5vNT2ycYttjEmLGdzZb5LT1Q=
X-Google-Smtp-Source: AA6agR6j3hoZoerzYeXWZFenkL2ka3vfApH2hnGRJKP2+1lROe6FZjZ9liJ6FKSdSy+//Yq1/vhKTw==
X-Received: by 2002:a05:600c:20b:b0:3b4:86ff:ce with SMTP id 11-20020a05600c020b00b003b486ff00cemr2437981wmi.179.1663151362361;
        Wed, 14 Sep 2022 03:29:22 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b00228692033dcsm12993634wrr.91.2022.09.14.03.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 03:29:21 -0700 (PDT)
Message-ID: <bf83b747-e6b5-57fb-0de7-e2fb646633aa@grimberg.me>
Date: Wed, 14 Sep 2022 13:29:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc 0/1] Fix missing AENs when discovery controllers are
 disconnected
Content-Language: en-US
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Belanger <nitram_67@hotmail.com>, Hannes Reinecke <hare@suse.de>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <9eb798de-149d-a56d-ac00-dd6b7ae79a81@gmail.com>
 <403e19c8-fec9-2d5c-157c-cdcb4fc2fbf0@grimberg.me>
 <27194422-3759-928e-c88e-c5d10feeba5b@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <27194422-3759-928e-c88e-c5d10feeba5b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_032925_198827_67A5F642 
X-CRM114-Status: GOOD (  16.40  )
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


> I was thinking this rather than the new option... The bit would only be 
> set *after* the first successful link-side connect, thus the initial 
> nvme_start_ctrl would not send the reconnect event. Every reconnect 
> thereafter would.
> 
> -- james
> 
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2429b11eb9a8..43c8b6590164 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4814,6 +4814,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
> 
>       nvme_enable_aen(ctrl);
> 
> +    if (nvme_discovery_ctrl(ctrl) &&
> +        test_bit(NVME_CTRL_FABRIC_CONNECTED, &ctrl->flags))
> +        nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
> +
>       if (ctrl->queue_count > 1) {
>           nvme_queue_scan(ctrl);
>           nvme_start_queues(ctrl);
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 127abaf9ba5d..ff1dd8f999b0 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2947,6 +2947,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>           goto out_delete_hw_queues;
> 
>       ctrl->ioq_live = true;
> +    set_bit(NVME_CTRL_FABRIC_CONNECTED, &ctrl->ctrl.flags);

Isn't this set before calling nvme_start_ctrl()?

But this is orthogonal to the user argument, is there a specific
reason to why not add an explicit argument requesting that?
Because every userspace that will setup a persistent discovery
controller will need this event?

