Return-Path: <SRS0=Qd0E=EY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24087C63777
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2020 16:51:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABB324858
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2020 16:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gMsCJXNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABB324858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bVwOCL0khzXCMF3sB6sG9qZ9QojLHVayUNuDsXg9+1Y=; b=gMsCJXNjzNjx8b/QgxnK6GoqQ
	cN53QZMkjBqWARTxkUxP14/lM2cm3J45TGqsxHAHnlTI4Dr7eAvcPUVBOlnyNlGY9xkR4RthXRekU
	nRpVxqfaY+0307pNvFfuCAA/7uox59gskPFvbbfrb5nEwqc53yJbrjbyVF725N9mayc2ts0W3GvhL
	J0ya0E5BbYV0x07p+R/S2H9KtVVj+BYmDa8wSEs9qA2xaJz+KMTARwKxQDicz6gSnqyctcwUzHvAW
	JrgdiaPi6YNPAiqBRoGNJ6vQfYcxe0sZcva6s6CtS/wsneSfBpIk0KYjTKpHezzTzkUaNbXL/j0v7
	EoOLe7m2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfQgG-0006dM-G6; Wed, 18 Nov 2020 16:51:40 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfQgE-0006cD-54
 for linux-nvme@lists.infradead.org; Wed, 18 Nov 2020 16:51:38 +0000
Received: by mail-wm1-f65.google.com with SMTP id a65so3362517wme.1
 for <linux-nvme@lists.infradead.org>; Wed, 18 Nov 2020 08:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l6hhIQV3DCQTMfJfKVMppOLtWaOxrG7NhcybmjDmnZA=;
 b=Kj8xTZLuaYzCMnO3MW2uD5Tmx45MzMzki/d8IulXIc08AEF2KduPNoJCyGWWFG0hWd
 ZLFcuy68qMrzHTnLDAyDO6y1CLjnum59C0rArrKTbOgXyJ2GPq05B2P2irx/aYIKbdZk
 sFrqTOCCetRngMFi2xqeSHTB0wvnWjhHJZzlxNi4pMsea9dcFMWd6XrvaqdaZTrPjzcj
 NYSCvXmfXo9WibqSJ/LfrCQNUCAIymWI6y/6AoFJcaqoEPmIEwOl4liJSMksdUJqWLMB
 +Q+Olm6rHLJPSz5GpwmVM1bLQPWJe+/qzwKYut/9o9AXVRiZP27wVsRkaNXnLaRTKPJu
 uy+g==
X-Gm-Message-State: AOAM530CvBL10SwBOaI/v7xqXWUqB5PDg865C8VgQ3vN8Hn39ZqaXXNL
 u4EvFRABlVy+9GGQPk5PUy4=
X-Google-Smtp-Source: ABdhPJzY58PcZaZZeBKDlK21h8kwiPHL/Hnfk3b84jhCJzfw8eRxyADva/OhhZ82UBS7/8EhNRtr1Q==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr1034593wmj.112.1605718294816; 
 Wed, 18 Nov 2020 08:51:34 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:fda7:fe85:91ac:dbe7?
 ([2601:647:4802:9070:fda7:fe85:91ac:dbe7])
 by smtp.gmail.com with ESMTPSA id z6sm4950269wmi.1.2020.11.18.08.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2020 08:51:34 -0800 (PST)
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
To: Martin George <martinus.gpy@gmail.com>, hch@lst.de, kbusch@kernel.org
References: <20201118114859.7985-1-marting@netapp.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cc8f2a9b-43cd-7921-ac97-1d1d899748a5@grimberg.me>
Date: Wed, 18 Nov 2020 08:51:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118114859.7985-1-marting@netapp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201118_115138_215127_85C7AF69 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: Martin George <marting@netapp.com>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Fix this by reading the ANA log page as part of ana_work so
> that ngrps gets updated, prior to invoking nvme_queue_scan().

Nothing guarantees ordering here..

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fff90200497c..749d45c207f7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4315,6 +4315,10 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>   	switch (aer_notice_type) {
>   	case NVME_AER_NOTICE_NS_CHANGED:
>   		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
> +#ifdef CONFIG_NVME_MULTIPATH
> +		if (ctrl->ana_log_buf)
> +			queue_work(nvme_wq, &ctrl->ana_work);
> +#endif
>   		nvme_queue_scan(ctrl);
>   		break;
>   	case NVME_AER_NOTICE_FW_ACT_STARTING:
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
