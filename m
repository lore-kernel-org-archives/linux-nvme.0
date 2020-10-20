Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC030C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:18:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A062225F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RJaQ3i/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A062225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ARitmEvlgnDqXjiUxh/1zpPmri8FbalPMuxXFjplXY8=; b=RJaQ3i/NY7GAjX+VSCP0K3N/3
	asOd5RBF3ozE4BRN1/G2zOnkkOqgjMrYhtsJCRE0SmA5vu/an4NJTd5/4ONfGUohZGnK/vDAHC9fN
	xYklR+3//eIlef4IpfHOrnQwqcfpWRIgSCfjHQ3tEl5Q2ZdsNDxu2+M/Hp/XlPq6r0sRD3txREQ/b
	UEpdL3C5GKGgmpoJcultbc5CMlKlTiS6MavQhWIBSISvK3j/gxLbJ+a2puxfaKuDChXeY+bbkh/2B
	LpRprRKMTUwcgS5EbScMH/NpYoTFjahmqB7rLq9iTAHIR5P2UY7WvZWtMicR9jMV6tVKwrsufnodM
	5kI9uEk3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUmqR-0006wC-6c; Tue, 20 Oct 2020 08:18:11 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUmqO-0006vn-BV
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 08:18:09 +0000
Received: by mail-pf1-f195.google.com with SMTP id b26so754299pff.3
 for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2020 01:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9a+6sKAmBV43LprSEvx2bnxI5tahKLOoWlLatsiZeb4=;
 b=rKb4eowHROrdjKE/GDxB5tRbv7380sSW5brEDkJA3G5y6F84P7tzwd0PiRu2tN1Cnx
 zabUcyAYTZiXQkcByH8zMeYFjaQLGiYLvDx41dvf8/JUJgDUN1hVOyoLYE6qJRYkEPNC
 jv4y1i7OCgDyXrHH2lqvxRe75XB+BKLLE1hz2ojZNRhz0DrL3aa38ll6b8RnS7bLnglU
 t1W024K7h6qB38Jbf45SJ0OFkFgDBzkH6m7sv8sXyQW832GbxuvaHp6WcM7ArLMQBlKG
 iPNt9VtzViY9Hb4CqAX0oKbJE/+qVg6SiATyQPz8KD+X7bj86qyl1iwF+dKwi5ZJlCW8
 DRRw==
X-Gm-Message-State: AOAM533T/4mV00ZD0Q5c2ZY8HaLkDYLO5eiKBx9iZZ1S2WBhx5paj01r
 MrFr4sMQEHRv0PbAQo5XpSA=
X-Google-Smtp-Source: ABdhPJwGu/vU8qRrDOpjqBHR6iTTiRT8ydcD6MSgihrtLdaEg3MzX/hOgdfKyCPnUyewxf9CylSxWQ==
X-Received: by 2002:a63:5c5e:: with SMTP id n30mr1727860pgm.54.1603181887134; 
 Tue, 20 Oct 2020 01:18:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:104e:47d9:f0fe:a697?
 ([2601:647:4802:9070:104e:47d9:f0fe:a697])
 by smtp.gmail.com with ESMTPSA id z10sm1311270pff.218.2020.10.20.01.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 01:18:06 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] nvmet-passthru: Limit mdts by BIO_MAX_PAGES
To: Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org
References: <20201019220406.19708-1-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <55a1515e-6051-c7d2-dc7a-003a0f61f98f@grimberg.me>
Date: Tue, 20 Oct 2020 01:18:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019220406.19708-1-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_041808_422145_3ED4167C 
X-CRM114-Status: GOOD (  17.10  )
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index dacfa7435d0b..ed6b0586173e 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -22,11 +22,12 @@ static DEFINE_XARRAY(passthru_subsystems);
> 
>   static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>   {
> +	const int PG_TO_SECTOR = PAGE_SHIFT - SECTOR_SHIFT;
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>   	struct nvme_ctrl *pctrl = ctrl->subsys->passthru_ctrl;
>   	u16 status = NVME_SC_SUCCESS;
>   	struct nvme_id_ctrl *id;
> -	u32 max_hw_sectors;
> +	int max_hw_sectors;
>   	int page_shift;
> 
>   	id = kzalloc(sizeof(*id), GFP_KERNEL);
> @@ -45,9 +46,16 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>   	 * which depends on the host's memory fragementation. To solve this,
>   	 * ensure mdts is limited to the pages equal to the number of segments.
>   	 */
> -	max_hw_sectors = min_not_zero(pctrl->max_segments << (PAGE_SHIFT - 9),
> +	max_hw_sectors = min_not_zero(pctrl->max_segments << PG_TO_SECTOR,
>   				      pctrl->max_hw_sectors);

I also liked the previous one better...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
