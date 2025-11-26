Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677C8D10387
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 07:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=xuSsHJVRJ8MA2xOeHbN/q49QQF
	CInePpREnFqdOFxX3qxUguVmIhWIbEsD1FeCRhGCByA7kAIcY1DowGOWu9BhG5EF0YKbPRxHcwBUj
	GEjdpPqsGLGssp+fN1YmkOY3Yeg6pLWSt+R91oQFiT3xA1IUmDktzf3y6MEVfdFD0B16bqaEt+6S6
	B7fyOEv5ZibJNOVS4hh2+UKnt1h6BkpA3AEqgCSUfBXy4y4vjwif7hINARLBpEFjfIZ3DuERelNPF
	mKBdOZKJIVCjWbEPiKNb77xktuX0kMqbGWWVXB9JqEcWtrKpgoPpY0T9Z4FnauDgHoXLob6vFkq9l
	onodkO0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO9lu-0000000EV7s-0Gvf;
	Wed, 26 Nov 2025 07:17:02 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO9lr-0000000EV6k-2lrA
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 07:17:00 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso30357325e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 23:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764141417; x=1764746217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qVTaDxW6Rz9u+fZa/qsPDO6rgpgX3aa8OzRZ+4g6CgkuPAvMzsGhRWi3Gt7zQZTsYP
         XHnlEMh8DvOFqG54nNozPKlxSu1ZemYSNrTghtDjZthK0k+OspE/fU1YXzYaTRq81esQ
         0I/PgCpzCrIZu7L3jmCXx0JATL6wJRGcYSBiTo0L3Enapmo64MXx0O7f6z0xwhMfxaCs
         GCtVLDia5nt3X8X90ZVNSEhg2wSARf5hW88gMrdWi/Q0NbrbPIvTTxpL5gwtSfD4ht7e
         UAFuGF/K2yjnlKom46gaauBDm5IZ1mlidb0UpdK3WO5CjgpBdKpbqu+yvmeczspSPtJZ
         t4GA==
X-Forwarded-Encrypted: i=1; AJvYcCUFJsX3jzkyiknTxMu0B3F22zslmnc0Qr3URNGOM0adgsRPWF4MFcV72dmnLABzoAT305P5GqP6opnE@lists.infradead.org
X-Gm-Message-State: AOJu0YwYqPCABCT0Z5V4PgHHPjl0bFVilebQ7EThfs50Mc5Fa6v7O9ku
	X030LMpe1gGq95JFN3Z73t6bxCn7dkHmT706ZKKFOc+UwLf01NsIg0tS
X-Gm-Gg: ASbGncugE0P3qTM8cc2OGTlHOeY7trEiPgNkdDsbEm2kYhapNKYyc2PjuGowtMf2HXa
	HBhf2GAzrcTszn+mCLykUfKJX2fe17THA0hTok1bHWe2gzD5TxT6E4jM6jYL6vKINzRYBS9vSS6
	XjMdXWVbcBkHeX8tB8rgW63Hx6SyMUE1FDmxUyoePuQfKG56HUzsORlfbdsTeS2Vp/t6qsFg8SJ
	ItSGiG4FZOrfe5C+UCDmVjj+SwMQ1P5faJKSyFDY7UCwjBJwb5d5O9696lEChPLT9cGa4G1B8jr
	jCVhsSig14y24PBHtPXOjv/x70Ye6S/2jhM06jgWrzcKWF0pkGO/ej1U9OPl5Mp1T+K9wkcPg6n
	ZKaoiO301f268EkCzwTEog5yB6qLr1SadAaZgd7JUIywU+YKFCTx7QqHlSAbyG4O2G2+WZGy6aT
	jFlRS6EKl1caBwJrxrpp9LAIf2yLe5p08McZSfqEvjhRYhTvl9UOXN
X-Google-Smtp-Source: AGHT+IHHPJ66Laa23/37KdvCt2D64HYXBBwNra2lAe5QRQyjZRhbseX/6HKsfaSc1fhW6Q4YmIwjGw==
X-Received: by 2002:a05:600c:3ba3:b0:477:aed0:f403 with SMTP id 5b1f17b1804b1-477c110d91dmr169244165e9.8.1764141417336;
        Tue, 25 Nov 2025 23:16:57 -0800 (PST)
Received: from [10.50.4.190] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790530113esm33056305e9.14.2025.11.25.23.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 23:16:56 -0800 (PST)
Message-ID: <7cd1d403-f446-4367-ac1a-9a75df53d43d@grimberg.me>
Date: Wed, 26 Nov 2025 09:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: update sc_c in host response
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20251022075924.117162-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251022075924.117162-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_231659_749877_9EBE40DF 
X-CRM114-Status: UNSURE (   5.78  )
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

