Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB5CC5DF97
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 22:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=oUJUuvsbsZ3wz8Qs1SHCrUNRLI
	IDWGT+bCQ3QAijDXlrHsQgVjpWG89DLfZLyf6hO4Fy6r6L9/1rMJPo0+0rqD/wqRd/ucbwo0UwjOn
	3/+rKY4zcvfhJGgCTv3NaMbRkpgwVkbstPAHhM17CI9Zgbb6wfRSiYDepnipWvDhnnewnF7y02rdn
	9O2s2+o62FVomyGnnwzpTp5vmKUPM1ZcxR/KotKOmjSlqUXyXJQAj7zx4+stmBRgHaaxEZ+jYbST0
	1Xq9wfFYK3L93rgQKD81SDCUhB2ujfT4wjldan4ssouOzBWaWFZKytqljfNcbOuwKm7rOpbrR0M5n
	YB7nCXbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtwq-0000000Ephe-2AxG;
	Sat, 22 Aug 2026 22:12:20 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtwo-0000000Epga-0WkV
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 22:12:19 +0000
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c207cb16cf5so351377266b.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 15:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787436736; x=1788041536;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KkgM3vardj/2TodxnauRJIXJiAUgRs6bdB9JCju4K1PjerZ8/HsK7F/ZtO22Wl1Mzf
         Q/RI23uKAbzE8WeZKUS9D8xCnW47Q80Lm63ti/CsiRajWxS2yIRtM9CLQWuJqzhBz37R
         lQ3rWsXOOErm4fvYO5M5R1HbwVRS8a17ID30yhiycD02IjZn4Yw/nEk7+TroF0U1QVWB
         qDg9O8PTmHYqPHDiD1IaGiM2TiyBuuatbLkAhTNMfzAUFsq15B8DkIcM5Qx8RUiwHLgw
         KJWMGSpKygeIYwIEpOlyUKwIbpSX8GTNsZaZYv3He/z7OJM+79XctvcHSYlms4z/qhiu
         SvDw==
X-Forwarded-Encrypted: i=1; AHgh+RohY+JzE/kZY6U4H/VMpcQaliFNPOlNQio+EaPXGoid9LJ6UGroY1KXHTenCBzi5krJqTRdOjhYLR/W@lists.infradead.org
X-Gm-Message-State: AFuF++khw9UceLQ9Z3DQW+wuV4+EJKvjX5ydKG643Cje4diPqYs590eN
	YkHU/8yh0MCAlu5VnUvNgj/cGxkYE+oxaXW5U/VjUPCtOPgRS2E3yEEv
X-Gm-Gg: AR+sD111o1ods6MnqApBCaAJzaHZMWM3zueifdlH0wXZrQcNDTZeZvYJ3Q2bAMEFisc
	GJeBekS/aOTpAvAxQ1Ru4GxAkNmhP92EG1ufhZl/g0GuwVHg23nZ1qt4nOw0M+/WYFXjzWgtzYI
	W1gDVQjiBAX8Ouh4J+Mk1rOvh2dJNcDCp+xGU/nveDmjvOSbXDzDoS6A4kC2E4CC7IajUjpVBCL
	0vTEHtgwczVOaHwkwXaFR87oTw4WYjWSFBcwGFoHtn80wv7gTRTFaB2rRo6j05tJFkxo1/PdyBD
	+MDJ7Kc905VYfmvsWFxQR6WEj0/6bB0gyn3zFpb8sT4zN3X1DWxFYSbnqBpDOHZcDwmAdc/n8P9
	gPF0W1wEPalbq1Qsl4iVu7j0pilkFi8K5LaYGgVXFPUaujDsAeIhsjJMLkiG1C6Sxjk0Ha2W1AT
	XAIrlSHFLy51ybBXXu+Ne1K2QLHQfWpHT5zzlX+e2ao4KEZc+DIvLaifHqCo0odrxnPoJyWlK0k
	7nCF9gh6O9luiHcPBSbpcQ=
X-Received: by 2002:a17:907:6d1d:b0:c1f:983f:d8a with SMTP id a640c23a62f3a-c246a6b2c64mr1801220566b.24.1787436736195;
        Sat, 22 Aug 2026 15:12:16 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9c9fsm487834666b.39.2026.08.22.15.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:12:15 -0700 (PDT)
Message-ID: <5e703147-88fe-48f5-be0f-58e1e0c3beb8@grimberg.me>
Date: Sun, 23 Aug 2026 01:12:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-7.3 2/4] nvme-fabrics: add helper for owned string
 options
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
 <124D3A0A7C82160A+20260821062512.1936554-1-raoxu@uniontech.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <124D3A0A7C82160A+20260821062512.1936554-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_151218_169975_57D16DEB 
X-CRM114-Status: UNSURE (   4.06  )
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

