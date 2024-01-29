Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42462C47DA9
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 20:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=YsGNYf4i7lMQ1PhSixPTXblyRX
	dJYbQmDHc09TKSEWncEjHohdwySMgWoxwAvLbqaUF9oeH8iaofnnBIKUrT9s8sooK0GJ+oWrt5PuA
	DbHQS3dZMDa1A/DK14qI2WL+hWOgmTYL6heiVzFgpRx/MCQgbmmyH0TahTNmoVNnnQao0CcDn5rEs
	WZ7/gGsp1l7K903aIresIbSpsOUvdPiBIn5UyUlgHoT80eHf6V5W3lE3ogvBXDEsFEeqO9I8pfrn+
	Vuc/j0VCH/WHwJ67Q46Rc7LdCMwtQfv4RwLK23QIcuN1HNkgA2CdK3BCUa2lbeVSznjJ1ndByDeoC
	OFtRb/Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXtp-0000000ECd4-3SF2;
	Mon, 29 Jan 2024 20:06:33 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXtm-0000000ECc3-3DBB
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 20:06:31 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40efc5e838bso898875e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 12:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558788; x=1707163588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=e5uZVg2ZrSSro5w8KSXSY8o1PbZ3OFqTgETce2cVKdPE3kzkczcDjK+I8mCyXEKA8A
         JC6u1dyW/+0F+JN5OPtd/zgn9l98YhqM+QyTI+LXxVkU7GJw1MUoFbcVlCBte96qG5UH
         oPI1es+dPl3VJB2Eh8ASc6mbJOvrCbUlLjWiCURCEN9Vsioayc/MaAXcMF3mRzioSiZA
         hYyF5nfc4dEUUyUVJFkQ9CtmkRzgAS9v0PvSiO8rLCfDn2ra4jnqxU869A9Hr/JcPUk3
         512Sgi4FM1fFCvXShoiKDCl6B5T1fq40qVkETIzcEBw1GgKW9Yf+1449TyHH4Iza49sR
         UyZw==
X-Gm-Message-State: AOJu0YxoXMCKuz2nJlgV0U3G4ASnkBTiOx5K3+xbq8ourDphCBrtJbnI
	vAwnx462ncaTpUGkRrXkBeYLtDAu0S/HsYqDcUHbRx90kN6clE/8
X-Google-Smtp-Source: AGHT+IHbLdjkBuMGCy39kTSUbBUUGn7D2WOwm5Yat6WUhQxcKNREcxHOgqH5+z5QMVfpFiH4f9XY3g==
X-Received: by 2002:a05:600c:1f06:b0:40f:ae:11d7 with SMTP id bd6-20020a05600c1f0600b0040f00ae11d7mr34062wmb.2.1706558788151;
        Mon, 29 Jan 2024 12:06:28 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b0040eb0fd9295sm14916833wmq.44.2024.01.29.12.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:06:27 -0800 (PST)
Message-ID: <bddadef3-78f7-4b46-8dcd-933abda0ce32@grimberg.me>
Date: Mon, 29 Jan 2024 22:06:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/3] nvme-fc: show hostnqn when connecting to fc target
Content-Language: en-US
To: "Nitin U. Yewale" <nyewale@redhat.com>, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, jmeneghi@redhat.com,
 loberman@redhat.com
References: <20240129110639.45542-1-nyewale@redhat.com>
 <20240129110639.45542-3-nyewale@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129110639.45542-3-nyewale@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_120630_811549_4CC90922 
X-CRM114-Status: UNSURE (   4.20  )
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

