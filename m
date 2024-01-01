Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4967AC4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2jWggRmK6E8ICNF9npS7fguitS
	NsJnBOLoYnkJR23h457ZPD7UALmEaGhA4m8EdF0EVMeYZNJyaIbqf34z+6qPD3IPLOPCS4VdddVJs
	PG7bVnN0V0LAd1V8U1CYdPJuj0Iq8PQLiuCesLLzgShm53IbgD02V1NaIulpiQbVJkhJuDuQaYwgq
	ej41xMmusbtUGT6dmZ9BpIzwz4iJtkwB3zQb3vpaqDG0xy4tEEQK0bub6pgo8Vq+JBeCzX2hzvS8r
	DGa89yjDu+MDPBhhId8VMSGi+m7Jnz9YYei4liLGlWoLbw4MAUuJUUOu/8Ntc/Uvj2SzIPJHXzY7M
	LwcE64QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEYU-005oyZ-2i;
	Mon, 01 Jan 2024 09:25:54 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEYR-005oxx-2X
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:25:52 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3367f8757d0so1080685f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101150; x=1704705950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=aiLzVXJ85TbZqD1GjA0Fo3HWk354jRBWnDiMNyYnqvUIk8Dhtvyml1/aeRA3r3sGMa
         l+2jnRxSIvey95N/KgXcPrgeoMhU7cZ5yqDHkgKwu6ZlqCnhVhBUFt/jURymwXoyuc0i
         WWFc+FhAX3eJtYVMHfSl3ESeGgMRnRRCtBc93EtgXfWEfREkFjnCYchYEwrWz2da45rL
         cGyMiFgqctpn39A7DWZm2JOZ8YBC9pylFZNHwN3gu9xkphvXc+rekCya4YRKL0ecl+Tw
         0hqmskWC8HQ+hA2mPM9nLTMW+NreS0/fDR4S6jB6MnSGpoSS8k1cz/HUOARA76hqrS8t
         li7w==
X-Gm-Message-State: AOJu0YxjcmlrVXympIsiLTQlchAv5dnsLH69q5oOUvw6PoiG1HJm4lUE
	Vf3burI0QfDPf1Pg6fSqhZc=
X-Google-Smtp-Source: AGHT+IEI+I0sNRC3M58eK6kDsNgH2DIgMnM7PPJ0SvPaCq+aQPSBQWl/GBULjtLiHwHqfZ6y++bHRg==
X-Received: by 2002:adf:ce06:0:b0:337:3904:9a2b with SMTP id p6-20020adfce06000000b0033739049a2bmr2807024wrn.0.1704101149898;
        Mon, 01 Jan 2024 01:25:49 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m17-20020adffe51000000b003364a0e6983sm25316648wrs.62.2024.01.01.01.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:25:49 -0800 (PST)
Message-ID: <da3c353e-91fa-493a-95c0-5d25966eba92@grimberg.me>
Date: Mon, 1 Jan 2024 11:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] nvme-rdma: move NVME_RDMA_IP_PORT from common file
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-3-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231005249.18294-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_012551_830063_360A014E 
X-CRM114-Status: UNSURE (   4.85  )
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

