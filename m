Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41781C25B10
	for <linux-nvme@archiver.kernel.org>; Mon, 13 May 2024 07:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1FjB0AqB0xUJdRaA1Y/pkrd5humBzFSEH7+VKWGyYFg=; b=Ox9eK0tPKL0n947xRaAj9/biTO
	eMmcncvzd2mcvDtyJhyRT+mINjmIbbzJ+thnfGACVhpHEZre2oMmnRn7L+kT0pSkVvd9ZVQK+kZWb
	FVQyPg4Kmc4za/JAjLu+kOoO1XCH+T0F6DHc/LMZFocgNR2gtBh9Ls5T80agTyRy8qufiBDVL0kyf
	m0fF4GQY985xHvnIPtnXdArRY7CaQThiJPHTPptuGXstKsYtDn5fjehDi3OEytcHJJZzakXpomhBP
	EOFQmtrf+t1V5WGOKn+bdWz+79ZqLcpyoetJ/SnjfVHvVcd73BA78cGZSrvc8x4JFIj4EK31pIIxY
	XGf7DnZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6QBh-0000000C2hf-2630;
	Mon, 13 May 2024 07:33:33 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6QBe-0000000C2gF-2g76
	for linux-nvme@lists.infradead.org;
	Mon, 13 May 2024 07:33:31 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so782395166b.1
        for <linux-nvme@lists.infradead.org>; Mon, 13 May 2024 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715585608; x=1716190408; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FjB0AqB0xUJdRaA1Y/pkrd5humBzFSEH7+VKWGyYFg=;
        b=gYT1ZhX3nPbmJWlEFHGdEuHvDZECVCtqmcpKlvgkiZvXmZpRMcfgGWuPkW+ndwyFPn
         LI/mjYJsM96kmNqNVNV3gvmjkR/2PUVXqtk8fHnIvCLwY4g7IPvLVaw4sGAs/5MvxzT1
         dQkXkSvW9CYF46kS3PcS4nHYbpI6X1UbqO8OfsFKCPrZA5QDLRN83eSOMNKiEbbkcsbb
         UEuTdC4jlO/32a/g2UVQrEv65k6qusuZ9b41T++nWYu3Om27NZOwXkRJrU2Z/nKE0lkM
         o2uiimRZASUcYKY44EfoanqF569uP3YqlFITwIVND1TSAPBQR8dH2bVjMcQKPnZtBduk
         DC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585608; x=1716190408;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FjB0AqB0xUJdRaA1Y/pkrd5humBzFSEH7+VKWGyYFg=;
        b=aJOsJzw1lsz/AwC9KqRYa9N/PP4m53MAMXyvwFv/Q+EnqiGIGEUIz/8KcxytsHQQUN
         h2Y+h2Rpujm6oGMkHhBnJB4dQIIE2ymc8MnfSUAHEHtENjvR6xIjbRR5Q5e615HepGv9
         ZohVeYDS2gVV7GcMS1IOaIxH2sOM/HSnfdNtUnTzrQhRHA5rcHIM/z9RR2ixlVkhqFbP
         ovMxodLOtELwn0xh2cVTxoIeHzswHr2xe7Gy2MkbY5omNLOli2/jeBPAGtpiSLDDfXvo
         BrhVLkpU2WOWsxgmtI9UIxR7boAmC+QgWYJPe3LFWxQPDovaoWpMnH4+GfstIigwexzj
         jiBw==
X-Forwarded-Encrypted: i=1; AJvYcCXGF7a3M2wj9EYcnJDNG1tcDFDqf3Dqyv6jp5ay/I2n6zWd26/hktdX41SJx9XpR0z5OMtJpxtS3lHaAwGPsUE2o9nSmQwZpvUD9kmb9dQ=
X-Gm-Message-State: AOJu0Yy1nv3oebkwDEEQ7pd8dz0qkRjaWUPIDkfi5wDC41nounxGrrPk
	foqwmTcSE+cZEy5kzEFPUcZf3pKbBj+KQynuAp4TbWRaHoe8Kv+P
X-Google-Smtp-Source: AGHT+IHfShkpwIQtxfMZfMFtl72ZkhgBpxD+MXVqbPfZBd3R/y17q4h10iZi/Dp0FW+Dbmab51haGQ==
X-Received: by 2002:a50:9fc9:0:b0:56e:24a5:587a with SMTP id 4fb4d7f45d1cf-5734d5bec0fmr7275204a12.11.1715585608180;
        Mon, 13 May 2024 00:33:28 -0700 (PDT)
Received: from ?IPV6:2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751? ([2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65b5sm5844039a12.6.2024.05.13.00.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 00:33:27 -0700 (PDT)
Message-ID: <26d4ad30-c0fe-4286-9802-aa6afbd8074a@gmail.com>
Date: Mon, 13 May 2024 09:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: hch@lst.de
Cc: kbusch@kernel.org, kbusch@meta.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com, tglx@linutronix.de
References: <20240510151047.GA10486@lst.de>
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Content-Language: en-US
From: Benjamin Meier <benjamin.meier70@gmail.com>
In-Reply-To: <20240510151047.GA10486@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_003330_714814_98C16ED2 
X-CRM114-Status: GOOD (  11.87  )
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

 > From: Christoph Hellwig <hch@lst.de>
 >
 > So let them argue why.  I'd rather have a really, really, really
 > good argument for this crap, and I'd like to hear it from the horses
 > mouth.

I reached out to Keith to explore the possibility of manually defining
which cores handle NVMe interrupts.

The application which we develop and maintain (in the company I work)
has very high requirements regarding latency. We have some isolated cores
and we run our application on those.

Our system is using kernel 5.4 which unfortunately does not support
"isolcpus=managed_irq". Actually, we did not even know about that
option, because we are focussed on kernel 5.4. It solves part
of our problem, but being able to specify where exactly interrupts
are running is still superior in our opinion.

E.g. assume the number of house-keeping cores is small, because we
want to have full control over the system. In our case we have threads
of different priorities where some get an exclusive core. Some other threads
share a core (or a group of cores) with other threads. Now we are still
happy to assign some interrupts to some of the cores which we consider as
"medium-priority". Due to the small number of non-isolated cores, it can
be tricky to assign all interrupts to those without a performance-penalty.

Given these requirements, manually specifying interrupt/core assignments
would offer greater flexibility and control over system performance.
Moreover, the proposed code changes appear minimal and have no
impact on existing functionalities.


