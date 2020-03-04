Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ACDC3F2CE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:36:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D06D21739
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gLRCh3Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D06D21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zvI2mgy+6YHYSrXSCoH8Y4N1oe7LjTLtFyhExNNP0YA=; b=gLRCh3SyBEM0FUsCpMsL8WmXD
	qBBX0JYBJhGgk9pdBwpicT+TgFu2lu7JdR+mI39s434eknLUbyHA2BiNg7XX95/eYsuYmDy0yvOeb
	ADKeCwwtnD0SgJmmo2A0y8P+jbjTVJO5WdbZnR5vBB/F6/4o+lYipcNylp+/72pvStxw5WEGM/1UX
	M6ZNulZd2OM3zSLGdA0hppO/slQgHwQw5x2s54qlyN9FGk7mXk/QDW66/LvZ8FtNY1gQFkgbfWNmb
	OWGOpnIX8ga0MhzDEykz0olnJdvSXLY94bd6ePrgP2i3u7x+2KKGnaZWdDDTsoPxleCH1kHesHDgb
	cG37PL1Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9X0G-0003lB-09; Wed, 04 Mar 2020 16:36:12 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9X0C-0003ko-L2
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 16:36:09 +0000
Received: by mail-pf1-f196.google.com with SMTP id l184so1217826pfl.7
 for <linux-nvme@lists.infradead.org>; Wed, 04 Mar 2020 08:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qTZ+RpPfYiIMfLIUMw/kd3DuMdy+0J8QzewChj6xPME=;
 b=rL7YQd/gRZ52BvULa8NeVd5UDlGmHUXA7bdRHV63KaySA5oEH82S4SZkvN7+riFE9V
 9irz3/VXlu5e1blMwKm/xbgqYdVKN4zrL/jUvXw9kiBUE6toiNKmPFNXjIsIVuGTAhPV
 e1Nqrb3AxYPTMZEGgymu3klECgEir1v9xIMchLmE96vcIUxOj8vC84PgLwX+WANfBftT
 nrjGpAMxoWUCkU+eoepiPpZtU8J5PYHqWVhQxZ1EjcOZOHZpcS7MBGX8o7gERUzA2O+C
 yVWbz5NHbEpew8QUqcPD/sgpMDo2JMdqKCoodQZS1fm4k++MO+uEAwkW7AVuUE8vU1HY
 XkGw==
X-Gm-Message-State: ANhLgQ0iwdaR4VOogeRO4Db8JoqQ5T4UREL4qaFLYWrig4OcEVf2wfmm
 WikPRwb+gIfBf1YIaIiKNjadX2tWBuA=
X-Google-Smtp-Source: ADFU+vuhjW1RSQ1WSZoJKbulRsfjXLMcBlK7IUaworCXCxlmA2gIQ/4M6U9rapRgrK5rmDNekhY9AA==
X-Received: by 2002:a65:5a8a:: with SMTP id c10mr3397206pgt.315.1583339767620; 
 Wed, 04 Mar 2020 08:36:07 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com
 ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
 by smtp.gmail.com with ESMTPSA id c7sm21275475pfp.98.2020.03.04.08.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 08:36:06 -0800 (PST)
Subject: Re: [PATCH 1/3] nvmet: Add mdts setting op for controllers
To: Max Gurtovoy <maxg@mellanox.com>, jgg@mellanox.com,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com
References: <20200304153935.101063-1-maxg@mellanox.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <2063651c-47d7-6b79-215f-7367e27202bf@acm.org>
Date: Wed, 4 Mar 2020 08:36:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304153935.101063-1-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_083608_689887_62A27A78 
X-CRM114-Status: GOOD (  20.90  )
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
Cc: krishna2@chelsio.com, bharat@chelsio.com, nirranjan@chelsio.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/4/20 7:39 AM, Max Gurtovoy wrote:
> Some transports, such as RDMA, would like to set the Maximum Data
> Transfer Size (MDTS) according to device/port/ctrl characteristics.
> This will enable the transport to set the optimal MDTS according to
> controller needs and device capabilities. Add a new nvmet transport
> op that is called during ctrl identification. This will not effect
> transports that don't set this option.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 8 ++++++--
>   drivers/nvme/target/nvmet.h     | 1 +
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index c0aa9c3..bbbb502 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -369,8 +369,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   	/* we support multiple ports, multiples hosts and ANA: */
>   	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
>   
> -	/* no limit on data transfer sizes for now */
> -	id->mdts = 0;
> +	/* Limit MDTS according to transport capability */
> +	if (ctrl->ops->set_mdts)
> +		id->mdts = ctrl->ops->set_mdts(ctrl);
> +	else
> +		id->mdts = 0;
> +
>   	id->cntlid = cpu_to_le16(ctrl->cntlid);
>   	id->ver = cpu_to_le32(ctrl->subsys->ver);
>   
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 42ba2dd..1ae41fd 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -289,6 +289,7 @@ struct nvmet_fabrics_ops {
>   			struct nvmet_port *port, char *traddr);
>   	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
>   	void (*discovery_chg)(struct nvmet_port *port);
> +	u8 (*set_mdts)(struct nvmet_ctrl *ctrl);
>   };
>   
>   #define NVMET_MAX_INLINE_BIOVEC	8

Please document the semantics of set_mdts. Is it assumed to return an 
MDTS value or is it assumed to modify an attribute of 'ctrl'? In the 
former case, how about renaming 'set_mdts' into 'get_mdts' and declaring 
the 'ctrl' pointer const? How about documenting the meaning of the 
return value?

Thanks,

Bart.



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
