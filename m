Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E65C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=YCEqEEnS0XiHsL3UIT9OfrTK53
	c3CaawqKFGBpUd6Jikd4MMOhPI6MXn7fRVyQCO4RnpiEnpIjAB+3juyHGs+b6/DfRz6krq86RXrgn
	MFfhxc9gYCn3SYI0hlzlvLTvxcSWVdp7J7I4EDhLfyX+7pP2LRVSQt20BRMxLw4x/AG+KN98qw8di
	6CBDkun61VfCMKsQBOwAzISt2q5AWlm0uqls4XteREP0vBxEa3DUrcZgwnTjEHS/LcmrDMMvX7nY7
	BTmEIToFrOIVG2eKvVIvvgCvmJ0Lved2Y5gX/ISzZpxSs+l+6ReoXrxLR3X7174+roWjL15P19Fd6
	mg+ECy6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCVH-0000000F1KR-3miy;
	Wed, 17 Jul 2024 21:48:03 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCVE-0000000F1Ju-1tlw
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:48:02 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-426593b99daso209435e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252879; x=1721857679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=HbGn/nmcUQipTvhbu23vGO4YCks3gVc2yZFHnrnLDsyHt96JaoLv1f7/pyJBoDMCWI
         kyoUgzqP4c8CTtxfjSTXT8GU8ac0pDFZMhbDV0KChfNemJ+Fmod84XTH9XdCWYJ5oWCQ
         8xPLF4aWFcbtf3NU+ibxvf8HIimBlSoTOPwqSKQD/K0tKphQ5qOFHejVtDpRpspg/5ce
         cXndar2/d6WORQETGyJ0uXYecLpR5jA54rCatzbSuZtz/Cqwy+ZVghg/8bTgcq8MMemT
         /4OX2BH9QyHEp0u+0tfZMA0p5VA8MLpuCaRdU1XMaOTlGkJkRul01oXuM0br7X3kJea7
         Ruuw==
X-Forwarded-Encrypted: i=1; AJvYcCWHDJNE8kiuGdEB700HKXX37i+lUF0ZMCxl2QxcdDHLQHR0XDJs6ThZNaEcphtJYTtysSpO6vdP22v5lCX+0/ZJShyDhodrvsiodRPRmyg=
X-Gm-Message-State: AOJu0Yz2PlWwzz0wxOAzTAPit8MuUedJrAoJSnfVl5P/+dCPFvn/lvwf
	Q8eWY0eLmsfJiVjjC2SM9ho5U++bGJOvh8IIuyDQfoCF2DEKxtqSTByYXg==
X-Google-Smtp-Source: AGHT+IHmGdlGUxTGJU01UWF3qldsVWB9mctU04DpPSGtvNt7WOfTJZw/68K+N5pIO0HQC4ItF1cwow==
X-Received: by 2002:a05:600c:1f89:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-427c2cc81damr14356465e9.2.1721252878780;
        Wed, 17 Jul 2024 14:47:58 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7859131sm11231135e9.47.2024.07.17.14.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:47:58 -0700 (PDT)
Message-ID: <2582d357-1be1-4659-a8cd-92ac6482916b@grimberg.me>
Date: Thu, 18 Jul 2024 00:47:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] nvme-keyring: restrict match length for version '1'
 identifiers
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_144800_497737_C2537C7B 
X-CRM114-Status: UNSURE (   5.60  )
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

