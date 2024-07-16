Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F56C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 06:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=JQVzaMYp20oX9FH4Dq1eFAk76r
	v5R/oYN+EoH0dKK/cFCytWXgFQL2u5tFpkU+WZxyk7ZgvUFYEaOpPNx8wcMKOTKFsGJC7yo7LCrog
	OjRaka61NOJBPv4fr6s95goiZH1kkUdT3FwFlXrIbeHXMQXoor6ucrHCBOxGfOj8rs1SVFFldGbXe
	uxszTfyixCuktN5zdD0pQI6cO3IUQvmpxTv5SqFEYzwcREIHX2zss0kLyGiZeHbe1FTDU+7eCYd0R
	G9IjgGKuQGeahvwVrzQuC2eIIBynf16GecPxc/1UsJRLY99TfoPDbaBt/87rDLSCqe52oFY2yWacV
	D/4dAlqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTbgJ-00000009T2R-2Pof;
	Tue, 16 Jul 2024 06:28:59 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTbgH-00000009T1r-1Dxa
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 06:28:58 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36788bf97d4so145414f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jul 2024 23:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721111335; x=1721716135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OEiElqUzqRv12kvXN2MCYStL4rn3j54YdoHvN7r2vHf14SpVQ7bM0lyJP1DMCT8NLp
         EYUUU//aXsPgcvPqirqqckmI3nTvN3wcbNu8IuTgREACdvzzVFsgD6oWaeWfLr19NfPz
         VIWYMbkr2j3rQ1hbHrwIG4iAN05YdcBr7jVcHzpVniGVVu8VVgog6HSzRgJNyGR9agtP
         TON9c5VA7+0VPUpzgpxOLicitsR87zw2yU41dZrRAk5CoXnSU0n3i0c2MJR3qwHjyu3T
         gYWEhZJk6rr2/KX7fOMPTk4TJgwwBZjzGwC9tij79p/U341lbtMtfFHEyPUi4JU3e7Bt
         gczw==
X-Gm-Message-State: AOJu0YxXw2GR+9B7MaWTyldlFk7C271l5rS1208w8t5kcE9L3QvHX3hn
	L4eIfzp/tkaAcVkqUmUvuQAieix+M8RRv80RxTmlSDtw/5Z8uJam
X-Google-Smtp-Source: AGHT+IGJ7LEWWei4WFzOL1qpqLzgOB65QOFV0z7j9HxkeK8KLUQG4fr0uKDJgpYgQGLHIT+fkUs/9A==
X-Received: by 2002:a05:6000:154c:b0:368:4c5:12ed with SMTP id ffacd0b85a97d-368240cd607mr758034f8f.9.1721111335345;
        Mon, 15 Jul 2024 23:28:55 -0700 (PDT)
Received: from ?IPV6:2a01:73c0:66f:53e1:9a5e:260b:a701:b780? ([2a01:73c0:66f:53e1:9a5e:260b:a701:b780])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3d58sm8162119f8f.6.2024.07.15.23.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 23:28:55 -0700 (PDT)
Message-ID: <0c2d61a9-6684-4cf0-b125-a1fb36a96bfb@grimberg.me>
Date: Tue, 16 Jul 2024 09:28:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-core: choose PIF from QPIF if QPIFS supports and PIF
 is QTYPE
To: francis.p@samsung.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, anshul@samsung.com,
 jg123.choi@samsung.com, prakash.bv@samsung.com, d.palani@samsung.com,
 sathya.m@samsung.com
References: <CGME20240715063116epcas5p1d5653ed4b1f71c1a4542f9315a62b6db@epcas5p1.samsung.com>
 <20240715010157.2909958-1-francis.p@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240715010157.2909958-1-francis.p@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_232857_349752_0A419491 
X-CRM114-Status: UNSURE (   4.43  )
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

