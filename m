Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F18C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97mmcdfAW7v0o2d6+0NLqAndzZOQYhaRI72KRFTxUEo=; b=au1Y1Blpr0pRbyBZ2O7UBQBRP4
	dE4qk00n+Aai5rnQQWHH7NMiy1QEmBGrPinos39lzuOIJ7w1EMVT1GYGQV0W/GHo9vypMufWcCp7d
	Vjitda8F3pCDepBpBCcuUBz/jMXg95g64Ppw4g72Ch7EHYUHaLY3ltqIbssEvR1kdJRpthEVaAVpq
	Uq6jmFu7bi6zGQVemKq+kEfT2vctK4IcmmWATPwlWxo7dqB9PGxq/gYzN/GttYHrXzE62B8V23ZK7
	OAGiuKeIUpeLCxwY1UQNTUB65UMi4lyrYEgjllfPOkxRyEpNGWLEbI1if7uqYNH/rTCrjJrZlj/+2
	kb7K948w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndrUo-008R7R-TW; Mon, 11 Apr 2022 10:42:10 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndrLz-008Mus-CO
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 10:33:04 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 u17-20020a05600c211100b0038eaf4cdaaeso3124162wml.1
 for <linux-nvme@lists.infradead.org>; Mon, 11 Apr 2022 03:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=97mmcdfAW7v0o2d6+0NLqAndzZOQYhaRI72KRFTxUEo=;
 b=C66ViyAw+h6FMgEDUzZk1x9WalMlYdfqT8c3YicaFDnfsLkhBspqQoGEHFy1noi545
 x/qkOS1MKIsRM2OhNBgtURSTIfju6I+nmNg/nuhgWFwN6FthysB2THXImg3pQrXrGk4V
 MDaM5w0kjS3IIeOl4ylMN0Y2JcfLmcmVt96GddDMqLGscfQ8haSgT7L6blccLdlZfi/W
 Cs/qJZPeRMG5NBPMuge5dnoGVinirdL0+hvP/Y0fqNp+l7p9xXhoi8w4rFKLl/mLAgTT
 Wb7xFF4BUEnioiknAqnh4nvBwXGh29Iz8GKOOEbokamyXgDeGbqJkcCtOE7HGvRNY+7H
 Yofw==
X-Gm-Message-State: AOAM531voZpyFLlHJ+nhAELsQ5LXDkrxZT7NH5lGyeFFBJSbqSSC1Q5N
 /dAwGFXSgdW9eXBQCPPxJJE=
X-Google-Smtp-Source: ABdhPJyP1vDWkXhn9ejH73b/Vfcg85IgpCZLr362diYSUza0MvuLXsMj+82dotefuoASOGLFrVI7NA==
X-Received: by 2002:a7b:cc0d:0:b0:381:220e:a3a0 with SMTP id
 f13-20020a7bcc0d000000b00381220ea3a0mr28395364wmh.59.1649673179688; 
 Mon, 11 Apr 2022 03:32:59 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c4fd100b0038cd5074c83sm18264994wmq.34.2022.04.11.03.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 03:32:59 -0700 (PDT)
Message-ID: <ba21622a-9a81-867b-91e0-3a8d4bf13e70@grimberg.me>
Date: Mon, 11 Apr 2022 13:32:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] nvmet: make the subsystem type configurable
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220408065930.123015-1-hare@suse.de>
 <20220408065930.123015-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220408065930.123015-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_033303_471031_82C389E0 
X-CRM114-Status: GOOD (  16.27  )
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



On 4/8/22 09:59, Hannes Reinecke wrote:
> Make the subsystem type configurable to allow for unique
> discovery subsystems by changing the subsystem type to
> 'discovery'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/configfs.c  | 60 +++++++++++++++++++++++++++++++++
>   drivers/nvme/target/discovery.c |  2 +-
>   drivers/nvme/target/nvmet.h     |  1 +
>   3 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index e44b2988759e..38b0ab9fb721 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -834,6 +834,7 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
>   	}
>   
>   	list_add_tail(&link->entry, &port->subsystems);
> +	subsys->port_count++;
>   	nvmet_port_disc_changed(port, subsys);
>   
>   	up_write(&nvmet_config_sem);
> @@ -862,6 +863,7 @@ static void nvmet_port_subsys_drop_link(struct config_item *parent,
>   
>   found:
>   	list_del(&p->entry);
> +	subsys->port_count--;

minor nit, the decrement should go before the list deletion (although
it's safe this way as well).

Otherwise looks good,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

