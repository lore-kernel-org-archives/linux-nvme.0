Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3944CC47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bf739Spfk5M0azOgnIa/HJK/8Ggj6Uh+iXHzdY1P/HM=; b=O2AHrtUBgxL35096Rkp54EAWW2
	QwIRZZkILoFVf5m/6egV8EM6yFKOj7Kv7stCDnK29/dRqmy+Y9yOB1XLYaHMk6tr0Yq49YsZnHm3N
	xgiTJTABk66LG9ArZF8dKw+wJnxib3/hhKM2vFWoez6ZjWI0z9SMbFGLtngcGRfy9lrHBcBEtU2Uk
	B2sjjOGL1ksCOu/jnr/r7ZorA9DYj5RneB4o8f+tCki4s9GrUB93H0xQexD3GyQhdTZ3TPnI++R1q
	kSIJmdt6R5dNZZ4lBmQ7Tj0kUHIlAD/YxYTf1fjF8+8CErLqtaFTWSth+4ncc1OhBJNH4OJZYHkmA
	NRbIKVGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEZu-005pC6-06;
	Mon, 01 Jan 2024 09:27:22 +0000
Received: from mail-lj1-f170.google.com ([209.85.208.170])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEZp-005p9x-2Z
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:27:20 +0000
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ccb6ddf651so23824951fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101235; x=1704706035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf739Spfk5M0azOgnIa/HJK/8Ggj6Uh+iXHzdY1P/HM=;
        b=kcuzu3iYZkIeqvoV3bphj7B/UksF1jThzfm7Eb2CYkOBTxrMXLC3QK+iP7x2CELIeN
         qtSxcg/kyU+PxPuXS8w2ShoqQmH55gY7b4W2Plh0r9044LHndMFDdw+gqrTiGi2KuUxD
         KgtObW/1H3KnAvpylW3AvnMdAV6WIaqDadYf41qJSSEY5qa2DjxxUL08D1HzZEo8F00l
         75JVV/tcjGTOrBPWP1nPmp5s8Q0OnJHzeaNTE3ggWQQYZGQtPnVulyUn8s71Dx9IuyTW
         zXhp+XwY+W6X54twC4FiCXLX2yMtO4epqmCzG3DpFGpwrnzgvWNI5itTW20bVyhjqCDm
         r8rw==
X-Gm-Message-State: AOJu0YxF72y0KfrfN3HpaT6ZJ4msid4XuOM+rE5Jy4uIYwV917CJtc1o
	L+wJsTNvbr8/J6qFUoKJYAA=
X-Google-Smtp-Source: AGHT+IEYrTdSS1nQiTFjjUgJH1T5yxJaHD7GYXqN9eHSUcbYo2171oohsmnCtNPJJvMpTB8/qCeMFQ==
X-Received: by 2002:ac2:43ca:0:b0:50e:6b45:c91a with SMTP id u10-20020ac243ca000000b0050e6b45c91amr10773211lfl.4.1704101235375;
        Mon, 01 Jan 2024 01:27:15 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m17-20020adffe51000000b003364a0e6983sm25316648wrs.62.2024.01.01.01.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:27:15 -0800 (PST)
Message-ID: <41e49eb9-24e5-47c8-96a9-12d47cfe3367@grimberg.me>
Date: Mon, 1 Jan 2024 11:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] nvme-fabrics: move queue size definitions to common
 header
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-4-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231005249.18294-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_012717_845238_73AA2FFF 
X-CRM114-Status: UNSURE (   7.67  )
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


> These definitions will be used by host and target fabrics drivers. Move
> them to a common place.

Don't see why these should in any way be common.

> 
> In the future we can introduce a common nvme-fabrics header to ease on
> the maintenance of the global nvme.h header.

nvme.h is the wrong place IMO.

