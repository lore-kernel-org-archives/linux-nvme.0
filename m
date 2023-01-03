Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB56C46467
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 16:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yTCzos/oFHvMGuBuF6qILAIhEwPf2eI8gK8h70uNdlY=; b=rrNS9g6+mgx5b45KdIZTkhGJRc
	VfLOo+K8dhLH5MyynzdVKDdD8zb9m/oEraeANOrTAWkdO/5v1YxeF1qPo/Ti+OHOcyUT3H+mmDK79
	IJ1cDILuCnq0Er6OnEAC2DRPGT8ZyqHT4VkAxhXT8S8pMdFAD98s6cE8nRoUgsH3ZLEV0YZitrS0P
	oqwSJnS4WKIDd3YoWXWHTi4UO00pOJtsXE1Cvyltunm5e8t5OgNOIxWzh3UjJ6JYmRAIV54/yA66c
	i5sAyhMVJttV7uVVjdi3Cl8/ZLkbQQtQcaLNlzT3CNqQPtzhepm3Wxh/H/4zCpHY+ujS0z4yGykZQ
	kDBoPlxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCjp9-002lnb-ST; Tue, 03 Jan 2023 16:07:36 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCgzM-001O6q-6O
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 13:06:01 +0000
Received: by mail-wr1-f45.google.com with SMTP id w1so17235146wrt.8
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jan 2023 05:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTCzos/oFHvMGuBuF6qILAIhEwPf2eI8gK8h70uNdlY=;
        b=FJCrsdjKhjOlu+M7yR/UUr61sF8vFQTg9XiBB+QkG1AOiW93OIjeNsOkeI7GyLStU9
         duW5XRcZxiXJyBfSDfBfC1sMU4HSZI6+YAEagfGYaWWeWpDcl2WzGpwYLGASZ+EPUj9E
         eINwkQxzGgSWoHiPAhqPlCMzLwUnX0vEyXlqziJ8+d4slxrDaQ+ukCqCsPhenUILFZsp
         NtgP/BVGd0h7aS3nFZvsSmx2gf/eii7syfPsRHZUdfQiMcPtXg9uvT8kpC/OAzsY/0FT
         sBKBJ8mAMTcWS/AW2FkHwkpjrOVVUlK1s1k1U0SSsOtaNpwWD4uut8UP1uWfTASMkUXP
         uOrw==
X-Gm-Message-State: AFqh2kqlNRvGqTAYdXGF8hPMB+MLwBLu6h1A/AyEHa9Zn2Wjo2yO5nve
	UhWenj5RSHYS/chY2BxEN9g=
X-Google-Smtp-Source: AMrXdXvP4Te/mZVvnrZOKVX5l85cJIjrVBOlJOm2ZaOgASsrlCmB5VhfosuU5iqOMf4crlGnph9hSQ==
X-Received: by 2002:a05:6000:49:b0:242:6777:c7e2 with SMTP id k9-20020a056000004900b002426777c7e2mr25596154wrx.31.1672751151139;
        Tue, 03 Jan 2023 05:05:51 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d6510000000b002755e301eeasm29147211wru.100.2023.01.03.05.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 05:05:50 -0800 (PST)
Message-ID: <b8154d21-d009-1077-e07d-980b249a56c3@grimberg.me>
Date: Tue, 3 Jan 2023 15:05:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: nvmet_check_data_len() wrong behavior for nvme admin set features
 cmd
Content-Language: en-US
To: "Engel, Amit" <Amit.Engel@Dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Grupi, Elad" <Elad.Grupi@dell.com>, "Zinger, Eldad" <Eldad.Zinger@dell.com>
References: <CO1PR19MB48850262EAB600869034D420EEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CO1PR19MB48850262EAB600869034D420EEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_050559_335471_DE8B0024 
X-CRM114-Status: GOOD (  13.72  )
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


> Hi Sagi et al.
> 
> We see a wrong behaviour in nvmet/core.c  nvmet_check_data_len() function for nvme admin set_features command:
> Current nvmet_check_data_len() code is checking if data_len != req->transfer_len.
> 
> There are some feature ids which the transfer_len that is being sent by the host is larger than the payload itself.
> For example:
> fid 0xE, the data_len that is sent by the host is 8.
> fid 0xC, the data_len that is sent by the host is 256.
> 
> In this case, the error that is returned to the host is ‘NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR’, which is not accurate.
>  From our understanding, the host is allowed to send sgl describing a beffer that is larger than the payload.
> 
> We thought to change the condition in nvmet_check_data_len() to check if ‘data_len > req->transfer_len’.
> Only in this case, the expected status code is Indeed NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR

We already have a handle for that in nvmet_check_data_len_lte() that is
used by dsm handlers, it should be added to the specific places where
it is appropriate.

