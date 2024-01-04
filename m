Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7995AC47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 13:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1YPKwF8GcGkEYVhfX3EiAkxozmZKy/I9U+GDmlmIrm8=; b=yFrlBIQw6hM341WXKPt8xdr0Im
	m0gpH1Z5d3dXKOyULozRPbhyDy1B8kiBzBPZmTcAtMEz6XMovv6PT7CAXu4/rfOuAGIjw6tl93hU6
	05nuSJLv+82sTuf8tEsi1i6Ye9cPw5eCZLGKsDXn4zPg9C1PUM+G5vZd1APIL9fidIbCCR60afG2X
	ZwV8nvld6qIUtlzGWhi+g7ZbjisCE1/0d8WVRW7yIab6FuEqi2nnglXQ1VlJD6xAb3Syq2xVrYJpt
	SRSadtV8JmXShF3N+izTJmooWf2ybHroTQrhMl/8oowrNtP4MkSQoccHltzTPg+sAI7NK8NTmqkhP
	rw+uOBBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLNYI-00E6gi-0V;
	Thu, 04 Jan 2024 13:14:26 +0000
Received: from mail-vs1-f41.google.com ([209.85.217.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLNYG-00E6fj-0j
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 13:14:25 +0000
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-466efea9c10so69306137.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jan 2024 05:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704374062; x=1704978862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YPKwF8GcGkEYVhfX3EiAkxozmZKy/I9U+GDmlmIrm8=;
        b=f6gIKuiYfzPuVhf9Im44ll16M8X6bbAQO1gbZj3qarI3e7fNjJ2QMu+nOUJr5v/l9D
         y6nbo2PXuTa0jVllD9tRcba8+C1jsiur5Ib/B4s3iBF4MtA0Cm0gdOx9UN/0pvZQQwVQ
         r2QDlCHzC2/3ESs+3XOH+daoHk15OY5ooelylfwW8xYS/nLw7q4arH2ZhofeqAGlS7AY
         K/J5P/VrqXDs/ZH359iDFZjM7rI6F/30ufIf/ZCZTZUeh2sheI7URWvsnRRakhQTeS4a
         HEJBVDhCPTV8iSwEwOUXNuRV/FkwI1VtkRhJMPnlXTe/UtSxTFXkOsNCTcmS8WQauc2Q
         nfBQ==
X-Gm-Message-State: AOJu0Yy35NI2Y4lIu2Ap+A/vaDpBbziRQO+ciupxVtF0GWIShfAUWszz
	QbkWKkoiBxwW5+YGHpulRIo=
X-Google-Smtp-Source: AGHT+IG/rLsS3fIJwVSlzFWzsv+nQGropuk+xpE5CTKgBTiHlsAN2Pxzlhe1sk/nPNoRXayyuk5fOA==
X-Received: by 2002:a05:6122:912:b0:4b7:3417:b5a4 with SMTP id j18-20020a056122091200b004b73417b5a4mr884972vka.1.1704374062567;
        Thu, 04 Jan 2024 05:14:22 -0800 (PST)
Received: from [10.100.102.14] (46-116-232-10.bb.netvision.net.il. [46.116.232.10])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a22d500b00781a147e444sm4304224qki.92.2024.01.04.05.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 05:14:22 -0800 (PST)
Message-ID: <f5451c8e-1ea4-41ee-9bb4-cf88f6fc3db7@grimberg.me>
Date: Thu, 4 Jan 2024 15:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvme: Add two-pass shutdown support.
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
References: <20240103210405.3593499-1-jallison@ciq.com>
 <20240103210405.3593499-6-jallison@ciq.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240103210405.3593499-6-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_051424_263119_503BF070 
X-CRM114-Status: GOOD (  11.96  )
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


On 1/3/24 23:04, Jeremy Allison wrote:
> This works with the two-pass shutdown mechanism setup for the PCI
> drivers and participates to provide the shutdown_wait
> method at the pci_driver structure level.
> 
> Adds the new NVME_DISABLE_SHUTDOWN_ASYNC to enum shutdown_type.
> Changes the nvme shutdown() method to set the
> NVME_CC_SHN_NORMAL bit and then return to the caller when
> requested by NVME_DISABLE_SHUTDOWN_ASYNC.
> 
> nvme_shutdown_wait() is added to synchronously wait for
> the NVME_CSTS_SHST_CMPLT bit.
> 
> This change speeds up the shutdown in a system which hosts
> many controllers.

I think that patch 4 can be folded in here.

> 
> Signed-off-by: Jeremy Allison <jallison@ciq.com>
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>

