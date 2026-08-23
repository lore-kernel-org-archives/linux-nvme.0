Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0422C5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MVufe+rG+M5z7KhaToqCxTOVwgom3Qp1/8NNcDgkxd8=; b=A4+BekF4gkXz/v0n7F6Wlke8WM
	CNnC+yV7i+fa8zDeX26xU69CbEjge7SyAkmIa7J7Vm7vh0v3f3y1dgz+PFxNEVD8Yw6yzptEYiNJH
	csgeg8J4jRNnFsvmq6NKH7z1qLzKZFtauXfW4svCV21F4xLDIUSmlN84vfJvJFS3AI/gmfU4S4NFa
	y1bNxMXdvc3ZcWbGiCtOeyprjXxvqExHHywjCWoA8GPsuKqgv9Ft2e3Sf9EtP9mIZxjoiOkSQ9+0W
	JrJJLSojLiagAnO+TrNtMUSogvoe0rjOsmogA3Wj5hIZ9HTQquk45cmx4fjMic/j3zxAMubGv74oK
	bKWQ2ghg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwSV-0000000EwQx-3mYi;
	Sun, 23 Aug 2026 00:53:11 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwSS-0000000EwQZ-3yjG
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:53:10 +0000
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so6119986a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446386; x=1788051186;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MVufe+rG+M5z7KhaToqCxTOVwgom3Qp1/8NNcDgkxd8=;
        b=aZwFBRdkJGsilirQGoyZAe0q92kdieliDKO5d3ukJxK45go33G/3EgHcjh4pFscuSg
         Oli8AkMfQt85/Gy7WaYOn6dBP/WaYx3jIgWaezscljamnSQPuy24ssaY7+TIsbtx/5iE
         G5kToIUR3KHl8C4tQrHrv7dzd7w7aVyS6L2ZfCaLAdU/NtmGZKbE0ay6ODPi1tVuFTQb
         WXWXkkRJHZ0zQFSli2JJhwKihukcEDO0A2ov9vm9uOkWUhTXnVUX6MaT77XP0nrpqTFZ
         UwsQpBjffl52Oj68H1qf84rNyMaIjbSgzLdW9xavJsS8AUNKoVaIhXxbz14RAuTvDyfi
         pgzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZxDlbTXbaPxge93ImLrGlT6kuk5K3XSNx1OhvpumcZ2pbX8CrSX8TjA3UW2HnJ0ZIibZS+mBsKjyh@lists.infradead.org
X-Gm-Message-State: AFuF++m62BU4joHa/bzfIGg/JPIQ4fIpfBePghQ03B34/tnV4eoxwjFC
	8WQsPRn1bfgGPqJxDEAlX4TMiLxPqJTnM56eqn/yZUzsKGaBvn5ehn/9
X-Gm-Gg: AR+sD13O+WiiuxiY5jpZrVDvgdoK4Y3Yju5+lLVOAdEi3vACsSbhDEtkjRqgVJqMqNf
	t645rXiluC/qHKhYPhwtZOJeRBaa7mJMFOOGNjOa7P4rQVvTEwRmvGxG503hEPsH7e4rTLuLzHr
	qosVl6JkLe4X4WP+m0LwqNL8SfwCzHS2OH8SqNBoL7IiDposmywYo5A9Bv6Zlwd0boPRSBMhCnJ
	7V2Bnq6hM2dY3xRVgA46t2c2CaEScFixmQBfK3CL3l1TLJjFgQrZ1DmoX9W1l4CoHmVh3/Y7V2r
	WvM+jy/1CV65V3aZIUGi4R6K068dStJUvpfkVeHAHhvzfyJE0nlK3kDveUY27HwzPUjFpf4O49L
	/BZ1SN7YOedD7wDypbcbpwc0mgfCmtkGaeWjKsC9DRev9dhKZKnaYfeD9DvQA+4riLlOiKpH6JE
	92yWKNJu/4NI7Cr4DPmihrZyXOmCyyPKTrqjfneoAR8BZbz9e/LzeEEWvtYILzKw/8lw0dqCAuk
	+wkTRgiQgctFx5Cm3h16A7G57kX06s0OQ==
X-Received: by 2002:a17:907:9481:b0:c0d:7c31:26a9 with SMTP id a640c23a62f3a-c246d58210bmr1522650766b.2.1787446386151;
        Sat, 22 Aug 2026 17:53:06 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b431sm450519966b.1.2026.08.22.17.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:53:05 -0700 (PDT)
Message-ID: <6562686c-1a38-45da-9d99-bfa9a9736fc8@grimberg.me>
Date: Sun, 23 Aug 2026 03:53:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/16] nvmet: Implement CCR nvme command
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
 <20260712022437.3743117-4-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-4-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_175309_865276_0C765A27 
X-CRM114-Status: UNSURE (   5.44  )
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

Would still like to have it simple where nvmet allows a single ccr command
per ctrl such that we don't need to build a list of waiters.

Otherwise,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

