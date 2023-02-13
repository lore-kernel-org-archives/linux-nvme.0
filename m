Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C652C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0qI2nxC2GwdBe1FeuHgVOSwdHlKow3w8x3iJz9rKug=; b=V/NZzjwG5HaoFEGMZtIPTk8nbo
	1I3pYKH5hnBTS5bei2rjKqSUnYYXW07Xl5JXKknWV4b52ZR7iZyu2dPPupsTxRFltAwQxG4cy+XHU
	sWZhLZZKXME/jSM83S2Us4TRMsaZvTHQ9NswiMl4Rm29CSqloTXVp3NYVHK6deGU28W0MXCZyxB9B
	l2WO1CtA6ARCCy0YzQxOyGT7UzHVlohRQmPeRfDnCDe/V6RIqz1ObS26cvXKkgD9PUSPPDOp9qY/J
	M9wuYN2/pvufRl8JSmfBqQvGa1wZ3Ym5TDJ0hrPEoZ6QHu95ipmoqltGek5bEacyL72pWqB/n1j3N
	d9mjWNnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVrP-00E3qS-EZ; Mon, 13 Feb 2023 10:14:59 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVrL-00E3nv-Ck
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:14:57 +0000
Received: by mail-wm1-f49.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so8574875wms.1
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 02:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0qI2nxC2GwdBe1FeuHgVOSwdHlKow3w8x3iJz9rKug=;
        b=fTb5E6ACgwvbq8iWGmfm+vilhutNa09Zhr+97B59a66r6TkXlP1zSm81jQgbt5PDGM
         fqGAR2ceFNyuveF34IlpmTObA2TYMWA3L6zIdS6YYSF/jMNCz96aLHX/rROyq8YQBfM4
         cRig9bHXbaKlyGuIR5HU8pKCkyLrEsWfVnG/ba3uwkm/S4Rhxfqx+nmmfuOZh7APzL1n
         cbNsjVVlwvtFDKaPQUP7G46OkJdgK1hVRMnEDLWXMaVEguidBDK9TN1D/vZh5tA9K+qi
         XQPKy60Tow8issrzHMDWh8pEcu7unwmdz+5nb4/dJ70hykAv273qsBU1+nFKa4T7t4OY
         02VA==
X-Gm-Message-State: AO0yUKVgrBzgYdJKzoF2edsqqSCAWACoZD8qOIGI3cpJYo/fT4MZqe1G
	1dfC56Xk+j4ShVr3nXwSQDc=
X-Google-Smtp-Source: AK7set/N5AUfpfFoY2omeBtaDgjvntdPpvZvyJAcUpWVsVZgQZqP/09egJjlgdi7WqgLBocg4vCTCA==
X-Received: by 2002:a05:600c:1d06:b0:3db:2063:425e with SMTP id l6-20020a05600c1d0600b003db2063425emr22578044wms.1.1676283292019;
        Mon, 13 Feb 2023 02:14:52 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003dc47d458cdsm12848024wmg.15.2023.02.13.02.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:14:51 -0800 (PST)
Message-ID: <43e6c4b4-cb58-0873-2d0e-48499fcc1e31@grimberg.me>
Date: Mon, 13 Feb 2023 12:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/5] nvme: retry authentication commands if DNR status bit
 is not set
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-6-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230209143820.118097-6-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_021455_586181_518A8E94 
X-CRM114-Status: GOOD (  18.24  )
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

> Clear the FAILFAST_DRIVER bit for authentication commands
> allowing them to be retried in nvme_decide_disposition() if the DNR
> bit is not set in the command result.

Can you please explain what is this fixing? and is there a test
to reproduce this?

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/auth.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index ef5dcd885b0c..935f340607a7 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -87,6 +87,8 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
>   			"qid %d auth_submit failed to map, error %d\n",
>   			qid, ret);
>   	} else {
> +		/* Clear failfast flag to allow for retries */
> +		req->cmd_flags &= ~REQ_FAILFAST_DRIVER;

This should come right after the allocation.
But what makes this special than any other fabrics/admin command?
Why is it different than connect for example?

