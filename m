Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AA8C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 18:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X4suCYoTkOhA/y9CtI2+k7lafooesVm/iMzGyZoXydE=; b=xzFKmkHaCNzoGendEKfD60q+9k
	Jt5ce/b9ih8gnVtUpEHx2NIom2UtVKJNhCXoMUlDSDUr5XSS8oFLVnFIZFxKcxMDHNf/UiQ7zswfj
	jj7XQP/xPhpI4J5+pNiL5vVxfFhONiIpDqOSziLGp8CFp/YIEPEOU0YP3tMTRohDBtapS9CGSKdcb
	3+40eDNu/+WQnenjtjXBya8UZJh5RK80MSsh/bu0HlOrI4w3UPTCbgya/Xa+K3FZtdl4Nsj7qNMme
	WZPD3QSHOGDK+9OYrDq7WFdhvCw0oszHPS7zyE/Hl1HrVfgLr+aFhbK3pZzO8QPJg8R31NmmGYwGR
	RBvd5scQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noUiS-003ey3-Qf; Tue, 10 May 2022 18:36:12 +0000
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noUiQ-003ex8-Q5
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 18:36:12 +0000
Received: by mail-pl1-f177.google.com with SMTP id j14so17511795plx.3
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 11:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=X4suCYoTkOhA/y9CtI2+k7lafooesVm/iMzGyZoXydE=;
 b=xXjAolgmNgFsgyNeU/EVJQv4O462/D78BZWEwkbf6LilnSTnVG7j3hsG0Z2Svo5bDf
 g48stdnW3Qz+uH6l3gb5aFrGlsP68EzkFtcEOlX5anGcutAjdG3raYJdedNkMzddm+s9
 1U0mZIpv9hGQE5mpD1UgAeHByrr2QKk0zstaWPmObP3NgeHnXf/4SYEv0b70w1vmIxXR
 xUbLahJfD/8s4F74GTYy9boAkrBguVBooi0mhtilTA8oRutRtfG+kubYPumOk8jKQRlj
 w30FNzK5cpdhB1+URnDY8Be3nLbYtDRtmXrSESMdQ/d8rHlCKGcdJgY1FP397UvVXHZy
 oyNQ==
X-Gm-Message-State: AOAM5310up2y9T0yb3P4jq7LZRCr9lQ8qUNY9kjeHZ0P+eeM0dg8cPQe
 JLRzVrCzvm7l5xyr2iBWFd8=
X-Google-Smtp-Source: ABdhPJyz5hVQnUkOGyuCP44uFvnxVxaFjmHdtoNk1VVdMYYmGBjMjJCTGsbmc0gwMr9UTqkecfxUiw==
X-Received: by 2002:a17:90b:3b81:b0:1dc:32ac:a66b with SMTP id
 pc1-20020a17090b3b8100b001dc32aca66bmr1206798pjb.49.1652207769449; 
 Tue, 10 May 2022 11:36:09 -0700 (PDT)
Received: from [172.16.228.60] ([65.122.177.243])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a170902c94700b0015e8d4eb229sm2502000pla.115.2022.05.10.11.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 11:36:09 -0700 (PDT)
Message-ID: <63c7d338-8b03-a753-2dbd-31394335c798@grimberg.me>
Date: Tue, 10 May 2022 11:36:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] nvmet: make the subsystem type configurable
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220420092730.35101-1-hare@suse.de>
 <20220420092730.35101-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220420092730.35101-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_113610_890502_505F466D 
X-CRM114-Status: GOOD (  19.72  )
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



On 4/20/22 12:27, Hannes Reinecke wrote:
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

Didn't we agree that the internal enumeration would be different
than the content of the log page? It is just confusing reading it this
way...

