Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9D8C021A0
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 07:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O9vXW+hFgz4re0s7Lrs7wDAWNEioN8ZXvFnQIDRoQHA=; b=pTZUjEwFB2J7w7gkyGaqT5hGFS
	CToEO2kuLsQPfI5GY7Q3YO0OPWMIbOpvjVXO0TsjakCSLso3XKHbxVqd7YenXy+gCRQV9peUvBUPB
	yZtbwEUIaPRl/vlcWrRS38vxnQ86aAZjEpXtfRFDQXxQoMcWjMfPmvd3P9XIEIw/I8k9qNYDAdeTh
	jo0Ptk98P7T4m3RYVp8UBSCNwkSBoS3tADPNg29nX7p+fwU5AT9YNHHY60euXw4XaaP0TLBLEpGIq
	mhjj678gyiawjs9twbofzN8G7FLTlBDiEGVzspWSfc49c8VGMa5+xfRzCfXBJoAMUYZkwFgK+49VM
	n0/z/1kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvtN-00000003fCj-45WX;
	Mon, 17 Feb 2025 07:50:13 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvtL-00000003fBa-3JsZ
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 07:50:13 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43971025798so7683295e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 16 Feb 2025 23:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778610; x=1740383410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9vXW+hFgz4re0s7Lrs7wDAWNEioN8ZXvFnQIDRoQHA=;
        b=bIGtALhlJ7PzlRxCzjYS2RUZy+ZY255lYJ5U97IpdD8wbqQS3iIjJjGDR3letGtOMD
         tyKFnC1koh4t8v0NO7e/wAYDnhh6XLLNzRZLK5ZUazZBrN7osvbZmWhskzzZ5i7WE1f9
         5b8h+Y2qeEawaSF+bZCpM2k5j75/DbvUcrqXnKDEyMJT9+GTmMwJ3ZPnH06JuP+zyb08
         1ZWqn7ajyE665qtn7FdcOeUm6vcrX9+E8Hu0MukHMW6KGe5pNeGsvMA+71jd/JU4/q9c
         lIjRUNvt9nmez7sBorrQocgbyiuVADm5DReB8NDiuw2YhMU2JcOvVj7qnUhgCRdYkclI
         aKCA==
X-Forwarded-Encrypted: i=1; AJvYcCX0hX0IgrsOLA/8V9ylY1HlDZxyx/fxrld16HIj3CGf74lpI4G3z1DKNv2X4J7ZkUvoc4VSy9lj69F4@lists.infradead.org
X-Gm-Message-State: AOJu0YwoUEZjl9v3KPh5vuskwQdghKauPZs0z1Wdd10Yy6gTFa5Wzicf
	pbrEJTL2oRhROtcsaPGdRBEnOn3K3ElxhQEMePKJ2QUSlklW5ghK
X-Gm-Gg: ASbGncvzBFfnw15OxSRJoaDVFs4v8AiOrTGXT/25kTDPBFaQJXd5TT7qV+1g/Bk3ehG
	F/NZesBjY9zZuldb8PiPaibakYkvcGbwMuMs+ooBMbAr8n92BY3oAjFL3XgJEi4ND73CvkDBb96
	6Z7em+hOXJbP0FwNACx73L9mQBkIBiheLLabldg9nADO2Mnu+XnTKytZxAwgbNdmxeo2w+/BSN8
	lPYgT8aIt44rrMr0mWbbsObPPRucA/JSK/E3aqmFCuDAuJe/Q5EWTKzXnpIyxeZwvf0AHJY5jK2
	DcvMA4k8SW/Ev3hRKy99cyi+11XyiFFQXlEQFGxlXFxfSqjjJbsVIjey3Q==
X-Google-Smtp-Source: AGHT+IFI1RQUhA785JtH2ji3ru2RwKfwm03Gyahhlr9vykhBm+cvgNYzLGyR7Kmey4eY+glpniPfJA==
X-Received: by 2002:a05:600c:1d23:b0:434:feb1:adcf with SMTP id 5b1f17b1804b1-4396e75022emr54890255e9.25.1739778610124;
        Sun, 16 Feb 2025 23:50:10 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a055859sm145461585e9.10.2025.02.16.23.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:50:09 -0800 (PST)
Message-ID: <dd74c433-bd6a-47a8-9d6f-91ce843ef9b0@grimberg.me>
Date: Mon, 17 Feb 2025 09:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] nvme pci-epf target and tcp host fixes
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20250213065231.598527-1-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250213065231.598527-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_235011_837408_074EE712 
X-CRM114-Status: UNSURE (   4.64  )
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

Again, for the series

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

