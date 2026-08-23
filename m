Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AE6C5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 01:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12AZZedWH6nMSxAx+6ASndeh1Ztb0Fq/rG8ZzP1jJTo=; b=ydRV5/B/Kt+2q+LXVMubHUbAvA
	CqOrn9E4A0XRwALfAtTmndarbUewh9yoLMDtj19rbOt435GI45oLVjqMmWLhGi5hyqhGOrJCcoh3m
	JXgqYZUTDZN3xELsx2ZrE1zd6ZZvgwyypyG6uW0pDKoT3dbxMJuMgmYcUeZx08fa3j3bKKbSCwGvS
	pKKfeb8Uxgb0/RtrlJPSTiOhsFta8zudqoyOAh6MGVnsY42BgHqPmg2FV0OXHhvM+1wD2xPgiPP5N
	6eZiAQxWGVRHKTeAxZ0UEo7awg8DWBVLCcb7EX31G/X4QY/Pzg37S3BQR+fg3Sz5qpfuXQ49BxE4p
	YQgUhCoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwaH-0000000Ewwq-09E0;
	Sun, 23 Aug 2026 01:01:13 +0000
Received: from mail-ed1-f50.google.com ([209.85.208.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwaD-0000000EwwX-0s8Z
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 01:01:10 +0000
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a10d02ff43so4721014a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 18:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446867; x=1788051667;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12AZZedWH6nMSxAx+6ASndeh1Ztb0Fq/rG8ZzP1jJTo=;
        b=Q5lOEYcMAyEr1GeOwRpYULN/N2FsUho05ue4GU1Izi0S9MVMYpPgKTzg5G+/74rNZX
         Cp5vA49qRdvU+8To+RRCwFwgNzCcxU83cC0QsTnjH+u0JBAksAjzGX61Yd1Uo0DCBeYe
         AM9xIzdW4QBm9fx5Z92aes9c9zs5C4+bGjSGaRDJqts41JYniobuH8d/eKzJyp4OpupF
         ovowBRYZz4EH1G+IEzrKlbijbuT6PQdqAVBbVE8E0Lq4VrH26qc0JqMo7VxiB/yV1OdY
         siUYAIiIagtdmgTdB4d9YxMi5jQ0a9bDKEJt9HRrHMPG4JUPnhex4/WpLu/JlXE8X4Gb
         gjQw==
X-Forwarded-Encrypted: i=1; AHgh+Roww3kh8LGGOMk4tIJ2gNkAw+WkarWw2zgT7x/lXgYxXUwVyFetJfXHYvOpKz5vRsc+6KX+ZPV1XCgC@lists.infradead.org
X-Gm-Message-State: AFuF++mbqAzhfFpvktC17vxMhF4zRKbMr8j9pnk4MciYG4tMcpaLy2zy
	/quBoUqYPmZIGFs6+REZZZryAShq6MIMnWGDKzQ9cCNnQsGV10ZF1/ji
X-Gm-Gg: AR+sD13Qi6iqm0Va12shz/eVPlIdHEP8268/YC1FRKd8e3yQ1d3nuF03/Efj6mJ4lP4
	0AQYTB9bE15N4jPe31v/3VGaRdKPnubA98feRDrHaAj+SWgMegwAiws6J/nOUaXj2DBGKrMqCSX
	ju45q53m6g/dbkHPg2UNFLTpNKzJp0ZY+G4354OUZXKCfOKrpZzx6rE5HfsES6LyxMeu8bT72q8
	lJHf9TMUaSkNlk79nBzm5YkIy9Mx4DqeV/EcYYrqD27lSm17WOuiXe6r+GTVj6twX8U3v+F0Q79
	V9RRPz0S41m8l3xWVApC75QiYK0w2IZ+4Nz7FkGjQ2XzqYBZmfb1L5jxY7W3bQo6SDk5tS1yuON
	asUdly++WLWOrcjXll3efQw7dGsY5pw/hLD+J5yoJI85TZSgaLI1pSYo0Np0rykZPxytSLAYiMD
	4LkLjl4wQabtJMezen7Lsya+RK5kg/ndi7abnu2c5HjQTvzegsMNbXyqHOvZOTVKGxoyWba28qb
	DOVV0q93zvrB+PADSFwtIc=
X-Received: by 2002:a17:906:f049:b0:c16:126b:98b4 with SMTP id a640c23a62f3a-c246a2ef584mr1752911666b.3.1787446867037;
        Sat, 22 Aug 2026 18:01:07 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bd8fasm763691366b.28.2026.08.22.18.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 18:01:06 -0700 (PDT)
Message-ID: <af51005f-a03d-475f-909d-5d7d0f2275ff@grimberg.me>
Date: Sun, 23 Aug 2026 04:01:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/16] nvme: Implement cross-controller reset
 completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, James Smart <jsmart833426@gmail.com>,
 Hannes Reinecke <hare@suse.de>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-10-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-10-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_180109_790087_2018400F 
X-CRM114-Status: UNSURE (   4.42  )
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

Looks fine to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

