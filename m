Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2990C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 10:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MQm4IUi4lrNhhncAvmfKM92mM6zQ0G9B3hreNLcMkeI=; b=DyKhADyd6ByEp2sKJvdVdXqX5L
	zojoDvK/x9CBNlFP73Zqip5MzwgUWyFh0SnW5REq9BKmTXIR6S7gdUgGBThexmD+mLi0SUsfuxYj7
	G5JcAbGNVUoMy2dZvpKfxKSKRDcqr/bPOLs7fKCSNSsGxdJiT+wjnMMuyVdlTqZvqLbUKJgkyygoa
	VFKLu+LqvgGxTiLGja7jGHnwuVHjbGegY4GYAjX4Fx3xE2P7SV3WpbTzmsG1DN+bSgPBaKaiRTrEC
	3oGHjlx4ZEE7aTH9oIn53GAuwLIEG8U0213MJu9kjSjGdCQUfbhH1bCDbxo4va4CLwR2QiAetvoqQ
	/ZgThO9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndrW4-008Rkv-9p; Mon, 11 Apr 2022 10:43:28 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndrPp-008Omr-NR
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 10:37:03 +0000
Received: by mail-wr1-f44.google.com with SMTP id c10so1216156wrb.1
 for <linux-nvme@lists.infradead.org>; Mon, 11 Apr 2022 03:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=MQm4IUi4lrNhhncAvmfKM92mM6zQ0G9B3hreNLcMkeI=;
 b=hY4Qg6d6vvkhc+pFfh76ubvVs1PnExo3Uh6r/QObDN4b1RJLn0jTZbMCcYwoso9msa
 hE5tnXODqXpDWxqxREppTg3MGV8DRJTwhBJEQgGcL9ARyaUNjRy2kr952bksZerrrm5H
 xHoDgdkg7jmI+c3zsUmLbXyPBGb4xTG9BQ6/zIyCIeDxjoMILXd2QVNKpS5C2I7ESSYC
 bjK/ShAPpnzRTRC2tw6mEApaZGK2yX6+UNRKmMU/+InU3cV9QDMrSmAFeFzlzdgwMHYW
 eIrN3tQtiyncgDLWZbGXs4tv+Usex4C6DgEo+RJX65ElQ07j0VfxA8lSlyxvo5t6+zvr
 vwiA==
X-Gm-Message-State: AOAM533Ja4nuI3dr3AT6rmoUK3Oec1mawD22nOzaRBV8yMkS8lTTxWr1
 RwC11zwwv8jXeWyRbXuAUqY=
X-Google-Smtp-Source: ABdhPJwqBGV1fx7zDFYgw4dMzNnMqBLBVoIabus0P/Feiy8eJZR3MpBtAUG0V4Rh+RqV5IgG7/nUqw==
X-Received: by 2002:a05:6000:1881:b0:204:1ebc:26ea with SMTP id
 a1-20020a056000188100b002041ebc26eamr25393110wri.205.1649673419006; 
 Mon, 11 Apr 2022 03:36:59 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 u11-20020a056000038b00b00203e5c9aa09sm36792813wrf.27.2022.04.11.03.36.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 03:36:58 -0700 (PDT)
Message-ID: <4858437b-7a1e-026d-d92f-dafe1309281c@grimberg.me>
Date: Mon, 11 Apr 2022 13:36:57 +0300
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
X-CRM114-CacheID: sfid-20220411_033701_834614_8CFF8880 
X-CRM114-Status: GOOD (  17.75  )
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
>   	nvmet_port_del_ctrls(port, subsys);
>   	nvmet_port_disc_changed(port, subsys);
>   
> @@ -1234,6 +1236,63 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
>   }
>   CONFIGFS_ATTR(nvmet_subsys_, attr_model);
>   
> +static const struct nvmet_type_name_map nvmet_subsys_type_map[] = {
> +	{ NVME_NQN_DISC,	"referral" },
> +	{ NVME_NQN_NVME,	"nvme" },
> +	{ NVME_NQN_CURR,	"discovery" },
> +};

Wait, what does this mean? I don't understand how the type maps to
the string?

