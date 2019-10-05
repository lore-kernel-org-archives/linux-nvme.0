Return-Path: <SRS0=LrAE=X6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A3AC47404
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 00:02:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4601420830
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 00:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hl6/bgLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4601420830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q+4yK6xUuvLoyrRwz1tFc3UVqw+nDAY/NzQxwADUpLI=; b=hl6/bgLHlSls3GH1NGofCCLzw
	WL61HdGo95+MgN5FDGJqBATNTu56TZ12uZ1eBh1HTF2Cz/PkBGQtZN7JyzqumvlMWQ62Q2rynTl9e
	JZWsKh1FX9fFVCOLq48mqtFBoNi4OS/1rS+t4zmog0cruF7qyzgoZWQJIPsidwclMQxi2nvljYmbn
	nuy78XhKNT3raUdTWoimFlXvTNazOz6gsDIBmbPKsA45LOUwX2l7lf+koeGT6r8Ev6HohhUrQ/YAc
	/OStO3VyXbVCOiWWQCHXX8k/QkYkzKeeKyILX5BhAJ0m/Gux3W5xG4Dvbm+niki4sjkxQNDuuqQTi
	sVV1YChyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iGXWu-0003iq-VO; Sat, 05 Oct 2019 00:02:36 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGXWs-0003iK-ES
 for linux-nvme@lists.infradead.org; Sat, 05 Oct 2019 00:02:35 +0000
Received: by mail-wr1-f65.google.com with SMTP id q9so9012033wrm.8
 for <linux-nvme@lists.infradead.org>; Fri, 04 Oct 2019 17:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nJY323ptNq5iteV7TuRcRazZgxFU0ETiSK6yIFchgJ0=;
 b=G7HkzHid42PxxADTCYt6QAYC4T+mlU5j/yhzrV1OzVP9Ii5s8OwHv+OXsZuwsNj9V1
 WOel8HTSK/D03cZZcgppu68A1dABsjF79I0wuu1m09Tf5yyMfxVNbhE8oXUjeeNPu2Ah
 6gQw5XQZTPMnw69pAin2LXTfYW+Kr3wpq/W8LYrDP5OXYEBPtuAyJ9oS+bXv0jpIgoO0
 tvFVdDnrgqKXlG1yZwnvHwdJz7BngmG2Iojh6yE2YvMMeyPvGCB7+QZR1RPPQbXJVz+w
 6f9tl9NCXlLBkWbkNw5n0BUhUCDG9g6eo/Jn1ao2PmoxVrwJHfnzyqYuBzJGRgYPPCle
 P+6Q==
X-Gm-Message-State: APjAAAWm9Xk/nafUEmF7ygupanMPFpnAuv3X8j0ekIaDBVJGmndG0bHN
 IRCFYeeJxX1KsIPs+4YFSm4=
X-Google-Smtp-Source: APXvYqywzxXdSMIcTUOp2QhVjpd6bCxB+ayx1RxNoyn2judgDukJITAS5OAEsB61xQ+0L5JjfhjuKA==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr9287812wrp.191.1570233752675; 
 Fri, 04 Oct 2019 17:02:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id a4sm6583334wmm.10.2019.10.04.17.02.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 17:02:32 -0700 (PDT)
Subject: Re: [PATCH] nvme: fix uninitialized return of ret when
 sysfs_create_link fails
To: Colin King <colin.king@canonical.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20191002124328.17264-1-colin.king@canonical.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <17e3dc55-6e6e-a4e8-f082-4b57144467af@grimberg.me>
Date: Fri, 4 Oct 2019 17:02:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002124328.17264-1-colin.king@canonical.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191004_170234_480679_A6327ECA 
X-CRM114-Status: GOOD (  18.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This was already fixed and merged (by Dan)

On 10/2/19 5:43 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call to sysfs_create_link fails the error exit
> path returns an uninitialized value in variable ret. Fix this by
> returning the error code returned from the failed call to
> sysfs_create_link.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 32fd90c40768 ("nvme: change locking for the per-subsystem controller list")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/nvme/host/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 63b37d08ac98..f6acbff3e3bc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2540,8 +2540,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		list_add_tail(&subsys->entry, &nvme_subsystems);
>   	}
>   
> -	if (sysfs_create_link(&subsys->dev.kobj, &ctrl->device->kobj,
> -			dev_name(ctrl->device))) {
> +	ret = sysfs_create_link(&subsys->dev.kobj, &ctrl->device->kobj,
> +				dev_name(ctrl->device));
> +	if (ret) {
>   		dev_err(ctrl->device,
>   			"failed to create sysfs link from subsystem.\n");
>   		goto out_put_subsystem;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
