Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76E3C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:30:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3E8650F3
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3E8650F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jB6wGWKcDIkVgC1VfGinBsJ+iZgq8sTXjc02cyrwWmM=; b=muyziZnw3CEUC5osp7OF1661y
	CiNwXLxVAu9bAzR3/J6uOHJxGRIn0/evEFKwaCq373h9YG4ROsanp2pD9Pmvgpuz/Quw4EZaJRf5G
	Hifc2Z93VCSvMmQVbKdI2h8JNZc8zBsdQLAFVxGcPaSMvajaYoxZ8DarumVkn/FtITkAUkRtLmpl8
	YbqD8NcuxqndGFqgovKjOrxFJ+mR7C6YNn3hkMN195x67/amj5ASwYBqf9nBPYvkKc+cE9tOiQj8r
	tkSIx+s5BUMeEZWcKrPeQAFyDXfyTr02TJBfTA5lF2/Odjoxei1Wt0aKgfZeC0Jo9KR28kVQNfBAL
	h2LlqciBA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMESc-001cd3-MI; Tue, 16 Mar 2021 18:30:30 +0000
Received: from mail-pg1-f176.google.com ([209.85.215.176])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMESW-001ccG-Ok
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 18:30:26 +0000
Received: by mail-pg1-f176.google.com with SMTP id l2so23186533pgb.1
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 11:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hZuFJ4GtGEIiz6wducRUoeSWbFrYNQlRpSlAPFI3wyM=;
 b=jBZHttDh6SsW4IQiljuDr+ZCOGKxrk1X6Ub/gnw4LzXj8EzwwKktYdIiU9r7fPAl62
 OOJjBX+5q6GbZwPHX1dPOcOFo3wjMXpuJoa7QJpM+DIU61jNBNYFL4MrRZ6sJFlE6bKN
 A9fXzvxbzqWmkWjZcwowAAAk+slhOj5IDSQPY8jkWKCzv4wizom117jVV7tG1MxjRq6y
 SAMN3OYxyfKlG0MRVKuK09fCpC70BMD6T7z+dw91VFOkDOCNUmLJazmYH2uyqlGb4zVx
 zi+dBeDHkK/1h4LSzSvyO+5+/VgSFEoK//umW0m6TB0Lc1ZmPgN/Py0syNYUcPCKUYoM
 l/aQ==
X-Gm-Message-State: AOAM5320WtdI8wbK8zsp6BhmaSm4rZCoBkhM2aJwuuvze+K7NL2qQ952
 mdn3b2XVCzBw+yr8iquyE2LKzg5ppIY=
X-Google-Smtp-Source: ABdhPJyYLeXcf/WZhw3AefvZVao2u8TcbxjFqUek3bspy/5LVhsvGjVlBKrGuRvJTYRG9/SiMIG6Zw==
X-Received: by 2002:a63:e44a:: with SMTP id i10mr864332pgk.404.1615919423064; 
 Tue, 16 Mar 2021 11:30:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:52e4:89ef:d916:a3a6?
 ([2601:647:4802:9070:52e4:89ef:d916:a3a6])
 by smtp.gmail.com with ESMTPSA id l3sm117289pju.44.2021.03.16.11.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 11:30:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvmet: do not allow model_number exceed 40 bytes
To: Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "ngottlieb@nvidia.com" <ngottlieb@nvidia.com>, "hch@lst.de" <hch@lst.de>, 
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210315145611.155972-1-ngottlieb@nvidia.com>
 <BYAPR04MB49657B5E84CDE72510A5AB77866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <4a4a2b20-af9c-0474-a5b6-734158dafcb7@grimberg.me>
 <BYAPR04MB496523CA274146559560AFF1866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <0b645d22-4787-e4c6-6872-c840ac7ed39f@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <15ec53c7-4920-54bb-136a-1af652f13f47@grimberg.me>
Date: Tue, 16 Mar 2021 11:30:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0b645d22-4787-e4c6-6872-c840ac7ed39f@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_183025_241804_7B915C66 
X-CRM114-Status: UNSURE (   8.88  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> I guess for Fixes tag we can use commit "013b7ebe5a0d70e nvmet: make 
> ctrl model configurable" , right ?

Yes

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
