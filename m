Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB65E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XsDlj0gvyC99LUQZdQWG7tIxniMybqQqFfHmdkkItZU=; b=i8k/GUjyBzzoguP1angS+tuQSu
	lv4RbhloHkCdkGRc/myXOTVCpeQ2L5ylegDi1Nj5uoI9J8Qxs4e2e7X8unr7z8JuewgCogiYDBgop
	J1CdSTYwzg+XPIzMNfRlZcHpzPKs0cgvn7jtY1ISnxmjrq5z8n8Jzj+9ILzlIBvYWgEvgGXFWcMb2
	fQENQHlYxplXOlkacEkRAblZJ5r90oqGvt2EGaMEPby4vwQKJY7wOGQLwiqeRKw0Tu0lqI5PqSe7P
	8Snt+kgyQz5H8Bpi1aqA5luWZelFjI4KiWgB256X9fwnwdn43tB02sPojeHvIFxyMOAFxQ6iv7ICB
	O5kQwj2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3DE-0000000BsSJ-21XS;
	Tue, 24 Dec 2024 11:36:32 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3CP-0000000BsPF-0mpM
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:35:42 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3863703258fso3656338f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735040140; x=1735644940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsDlj0gvyC99LUQZdQWG7tIxniMybqQqFfHmdkkItZU=;
        b=AlpgLyo8CflxDgIgmbSoQFWuujfbpFpaBYHT+GCh1jUPiUewjaUq07Ptqcn7a/9HOv
         k5Tv+qiF7PSsXdK8RZmcINZcIEYy4JzBmaRsC27t/76tIr3QZddcvyeQ6k+XthVo3IVD
         gKeplk2SufMGyTzI+/NH6JJbBpFyBPRYQQAPNxOMaf5YgVpxGE8L8CBZKF3w2cjjdN7m
         qAHVWC4G6PWes5+gZLB+HyobXEbWuESHqiCow3op2y+Y0wgeaImztQCZ038yvWrhRx7v
         GjPKs5N+NmDRP74riG2Otwz9Xg9G7sb4vfa3kwUUL/P76yW18MIm8AeHDSxyrlBOSnnO
         sV+A==
X-Forwarded-Encrypted: i=1; AJvYcCUjsera9bIXRD1v61mJfuuRTRSHVr1O7uqv2ff7C1z88ZcMPKojahQm0guzqiPwwV9SyTqAaHn49KqD@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+NU68e4vRX2hz5qmRb99SL3kdlb2P3hul6DPS+WxwKisS4krr
	rmlcQ8+aLQ7I5h0umJmhgw24QwZNF+2kpRU91G5laajOEiZOos3E
X-Gm-Gg: ASbGncsBoP/tZrDPtjd5ZmsILq3ie2ioR0X3mVbZOK/LXEwub9zeKD4/W5/ZMlFTCIu
	YKWjs3SNUHqS/fYa0wevAgoYEYIyWl+Ic+Z8VfOGGVDjUMxizFzVvGn6GkPrzrKVjIWD26GGh7k
	z3kCR3KPWUnuewofc6hXfcABytAglVQDF4mx6Kk9Re7ZWohoXWb16ihsHlPQ89qsBp5QBKyB1sf
	RMhoTrVnu0caNStn0EXhJGqKm97fMiHS29dd+VYgHpA6+cGc5X99CCyjJ/5khsW5phYr5jc+Qgw
	rEZht9+w8nyuwwGd4Ni02tM=
X-Google-Smtp-Source: AGHT+IF4DntLfD/chCP55HsFiTCh0JVCA4v95w6WQPE+yHEJTNqCsWAvZDP2QtvecCOkd+ohMaVXYg==
X-Received: by 2002:a05:6000:2a5:b0:386:3d27:b4f0 with SMTP id ffacd0b85a97d-38a1a221da1mr17711499f8f.14.1735040139622;
        Tue, 24 Dec 2024 03:35:39 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6e19sm13845493f8f.100.2024.12.24.03.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:35:39 -0800 (PST)
Message-ID: <249d91b2-9115-40fd-8676-f96297f547b8@grimberg.me>
Date: Tue, 24 Dec 2024 13:35:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241129140608.115282-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_033541_231562_4D706378 
X-CRM114-Status: GOOD (  11.64  )
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




On 29/11/2024 16:06, Hannes Reinecke wrote:
> When a namespace gets unmapped on the target during scanning
> nvme_identify_ns_descs() returns with a non-retryable error.
> With the currrent code we will ignore that error on the grounds
> that we failed to get information, and hence cannot make any
> decisions whether to keep or remove that namespace.
> But a non-retryable error implies that the namespace is _not_
> present as we cannot retry that command and will never get
> information about that namespace.
> And we need to remove the namespace during scanning, as otherwise
> the AEN informing us about a namespace change will find the NSID
> present, but nvme_validate_ns() will fail, and the namespace
> will never be updated with the correct information.

Hannes, can you please describe your test case?

