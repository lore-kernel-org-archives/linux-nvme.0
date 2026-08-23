Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA52C5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 01:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cm7d2G2/PVJZDJdrCJoII5lO+Fohpqd4Ay3ivQAJAyc=; b=P+xFodXyf9AvLuJ8McPuZk41al
	CbI6fTtcNLIbkL55wiy3GlRD3KUzJlcobMlqfIdqRpN7uiDb8xCj9GSaB/0XCSgyhQBbD67nm23Nd
	EoeCMYSSyMi0YtkOcGvOXry7/G2NcF4bHOeYeu3EF903/dC/yXeBCHQfmcTcJ065Ap37aC2OoF9MY
	FCfQigW1JXhpcAzv4m1LPGBP2UGh6QfTiEIy5KpD38Ms7j5qNe8RbKp3aZVAIdTkK/aiwXq3vQ7tr
	Omvw7dzImGk74RDtFerai6nBtVDBzG+oqlr5FfdgKJ8wuydSbsOWaBlVBY89CoJiBgYfdnvxPpy+b
	CDixw1fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwZ5-0000000EwrF-3QoK;
	Sun, 23 Aug 2026 00:59:59 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwZ3-0000000Ewqw-0AKi
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:59:58 +0000
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a378f90555so3837226a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446795; x=1788051595;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cm7d2G2/PVJZDJdrCJoII5lO+Fohpqd4Ay3ivQAJAyc=;
        b=MlrFP56PCkMDN192nH8mq8dBshrrg0QPIy9fU4qP88et7RRVEUkWsCEzNwA0NtGaez
         d7rh5jvZkNlak7q8AB/u5mC3tDPFwwkT1qrMJfzPPoYMM0h6h+Pg4f4CV+yBqFuh4k4v
         tNaSEZMK6JiqQhdt+/tgYufxYrEuVlZdhqt0LdcXXS4/Er+v4Iu4SoB2RvzVkYg9jEOn
         ASndIUhcpjseYPJMDKoqXkTGsVfVFayARelhsewLBUSXKy0uIDACPLZODRCmiJS2MmCG
         vCdKSFbyrch1V+pbOE9SkFwfnNU4I9/QTUNQWJYpYVTR+xFatTdFHX/mP4zqVuExtQIt
         bkng==
X-Forwarded-Encrypted: i=1; AHgh+RqREkkS7pzDeUGATWdBmJd7QbBYM04ylhF5Km7zC7didU4VKH/h+UDwHfmF35YQWmhdl+kfJfXNl/ZA@lists.infradead.org
X-Gm-Message-State: AFuF++mQ0IjcyV4r7HhnyqZZMNNidK+Y4Qfbe/l2wrpssCWCL7HjZIVu
	YvhxBzuumS4RwCaPhuwPX74jZGuLLdznROc5kihXyruyKDYr6al/YF9OZLWP8w==
X-Gm-Gg: AR+sD12U4LzS7GApZ0Zec3NzLop86xqBnuOW/bHyQYgMcrzfnyUUtcuVmZpg+7e/l7+
	9lK+kio3OgcYKqZrPIVXLxjUp87PvKiI5YTQsbDo0qZV1xKJ+GNU2Zc1jPikFxmi+MwTjEJUmBj
	Z0baEt5FZXW4mzTpeYTtOSU9PxF9QeHa1O29RKSLa66JYhyHV7FnTVQ0pV+WNaR8asxe+k7ay5h
	57/LnRlTJmBlK4h40Tm2FzagcmG7MP5F1FicvNJ5e8VZSrqgC7dkcLlaK5wQ7CiPft19elqSlJM
	ZN0T506QlncSCmrzMF6/6rD2vJgxB+8OTLFwp15GU5xep1+j55DUnOKf79PPB6UpScpuSgpgE6j
	Al+KCAB1hcONlTOGuKrwAElNmQuB65T2UY1rTm0+NTfu9p8EzWClpNpc2JHWEZMTEhBqWuzdUZG
	88wcUj+N3c1OpC8Rzj14rvNiep0gz77A5SMoBJys5oGfgIsm99XVu16kz6aKrVyMRNNRb+VNMPw
	EcuqMFpP5sEDZdOyUY5dhoobCd7VQFwPzQ=
X-Received: by 2002:a05:6402:4607:b0:6a0:e963:f546 with SMTP id 4fb4d7f45d1cf-6a42f27960bmr16858079a12.15.1787446795019;
        Sat, 22 Aug 2026 17:59:55 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0228f0sm554859a12.10.2026.08.22.17.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:59:54 -0700 (PDT)
Message-ID: <3da7392a-bdc8-4aeb-bc37-0670e64f5f4f@grimberg.me>
Date: Sun, 23 Aug 2026 03:59:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/16] nvme: Implement cross-controller reset recovery
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
 <20260712022437.3743117-9-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-9-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_175957_200819_A963CB32 
X-CRM114-Status: UNSURE (   4.60  )
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

This looks fine to me

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

