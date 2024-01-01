Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB089C4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=wlyYy2kZPwKWODfbywm264ajuH
	Pc5dLqa2SxGvKE0/MU5E8fUNEh3egqnP7951B0z5diw3RK03u0nBJ1m6rS8i7IuSuq6tyNLZbi9VZ
	Ujil1CTYnO6vAMd14e1r1RiCpBawHPDlYzVSQeAXP+YoyGLWVCqWvEjbDnTJ/5akd3fQEOnVIweiH
	wskirN2eH5CVWXFHaNlGXAtuWaXAYXl6HDSFOlOLFNOnyccKWElOfNUX7iM+74yky2f4gUzLDKFPL
	BchSTm8m/rP2boO2fN0iV+7+zfJ2nfqqzzGUGoVzMKwaO8dQgKGJEapLgz5UECss8IodYHtuvhtBi
	W3vLVGsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEqr-005qhJ-0w;
	Mon, 01 Jan 2024 09:44:53 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEqo-005qgF-27
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:44:51 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d855d0e40so2704605e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704102289; x=1704707089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=NcIf8fkULfq48ZPN1HHaY5GanC1/HfZXYvNcQ6FoHW/IVri/AzVDjyCkzZowdQibRm
         5GlhXSIX7g72xSgUbebgj1w8P46tNSLYAmiiKCazG1YTplJrzBe2tqu66jZG82k9tsQ4
         ueokoQoTZ9+xqetQHMutdGmXLkSQwmBGKNKWehexSIbYOM6ZF+An+a4bYVvUjNU2F27W
         oOtmxLHpPx/Ow8zKcDMWqlK9nsXmWpwEQYe31aegLnFb2yYJ+edj6vl2S1gQSHmYudnE
         h9i+cquJOtHH5+7cibY9i82FsUvEDTmSc2gDxsZB5eSKktxEx6NHQJO8hxP4FwManrDj
         IgdQ==
X-Gm-Message-State: AOJu0YzExD2/WPh8HP8uhKbUiRmqSWTCatgpK0mitXo68p4W/ktaiRsF
	f7c1svRIrS5AVmJI1v3OH6I=
X-Google-Smtp-Source: AGHT+IGvvGnc/5VXk20PjhGqNhsv9jiiWSojPLIpXIyyGFjJgDTBhY2LcQ6RUqtmfXZJFZOjs+m3mw==
X-Received: by 2002:adf:ce06:0:b0:337:3904:9a2b with SMTP id p6-20020adfce06000000b0033739049a2bmr2830645wrn.0.1704102289225;
        Mon, 01 Jan 2024 01:44:49 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d5652000000b00336ca349bdesm16258370wrw.47.2024.01.01.01.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:44:49 -0800 (PST)
Message-ID: <b323b1bb-4e63-4989-a791-f1d1878228d3@grimberg.me>
Date: Mon, 1 Jan 2024 11:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] nvmet-tcp: fix a crash in nvmet_req_complete()
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: zahavi.alon@gmail.com, hch@lst.de, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20231222151750.655751-1-mlombard@redhat.com>
 <20231222151750.655751-3-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231222151750.655751-3-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_014450_703044_2C85D62D 
X-CRM114-Status: UNSURE (   5.35  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

