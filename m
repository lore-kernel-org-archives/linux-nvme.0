Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14B7C25B75
	for <linux-nvme@archiver.kernel.org>; Mon, 13 May 2024 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BONZtFMhDCloXM0WBlDley3CFN32CciOiMdKuHxFfJM=; b=z99+Ss+/B5JATM0/T57rqJZ+Sf
	PzloC7h2LVWzUditLlH9Scg3sCD8NOCHv1WnZFgHsezIM1BbJ2krVU4Xw++9R25ou2wBliviHcbal
	KutfB6gr0RGnRgEDHI6+b3M+73E0JUrzQfBmq7sMVVn0o+oy5Vuc4NPmTW2spVFCRUcnEOomoIvC9
	pGZ93Ur212un2J+4TDT7sbWIXseWnxO19pPRcNE2mgOxCEi2BqBGVjWRxCvMvGQ4ibdBwnYaNrzIJ
	f93Pxmt4wk6yBfcuoJRgQk10Bx5VtsybsdtVr2PGAU+RQa9CRzyQpkaKWIEb/a9FnteKS1s4gfaDF
	wmzrNtaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6RWb-0000000CIrC-12Vw;
	Mon, 13 May 2024 08:59:13 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6RWY-0000000CIpj-1MYQ
	for linux-nvme@lists.infradead.org;
	Mon, 13 May 2024 08:59:12 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a59a609dd3fso699700966b.0
        for <linux-nvme@lists.infradead.org>; Mon, 13 May 2024 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715590744; x=1716195544; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BONZtFMhDCloXM0WBlDley3CFN32CciOiMdKuHxFfJM=;
        b=PcvTeaurk+Ax930S3JRrPWpt1WJ3h36uALSUdyn3yBwf6c5vv6/Y5fRQoiw1WQU2pY
         76HJOl289JcptC+MCZ6zLLYCfG2k7GYx9FRwjbzlnl3BGlaQRcDkb5Di7IpNajGzfmEr
         E4b06+TBZw1YqUR7wRSB6ksudsBiqV0rq4gqxKPsvMIMF5W5YWIp27JsLJwcvXMINxU1
         VpX7bw9ZS+nJVmY9kalKsDSYXZ7UCnVlRlUE1y0nntn+pVizwRDlBlqxuriQ0esz0NzQ
         kZYUBgHK8kMN71SxHqg7EKF87yi2B5x6PU0T5EIQhXJlN3NiKGTx7CG66QTcZFKHAS0K
         lR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715590744; x=1716195544;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BONZtFMhDCloXM0WBlDley3CFN32CciOiMdKuHxFfJM=;
        b=czya4vf0pDoAQjcRzy6IPnW70KqLfjgIeyV54i/hQgxM+Ypz7YNQKmtQLAn/bdNqaf
         t3N7E9e4nraWOQZenYcRsYOVYfOpTPr5MT2PwGm9TDbSSz0TL9NQSIak6oh+c2UN8U6s
         H2TJr+Dam1duPleyrdNnb5z1Qyp56jnWjJKp4ce04R8F6ms1549e+HhnFJZvDenfjNUQ
         BXWSFG0nrqZgcrN1FM4G6pATUdZJHg+IpHFz09x9CpSAyzCFKfqXsauPrHhM+3TNmENG
         82H2Y72EmkWxgh2jl3oHgWeOWXJar2jFNspcIol2Ikz4++4JkWMqH/FJzT8X/tmm675u
         kuBA==
X-Forwarded-Encrypted: i=1; AJvYcCXcC+lI/aMrPi6nOLnTz4/8reomeybR1aRZTqKFDKxzYS6MC1nocdXYtvB1ea0LUhQKpAKZSN8hH+t0ygK9oDKVhTrF22in55mmA5kZWCo=
X-Gm-Message-State: AOJu0YxC+46ES/v84XzhC1FvBBrwtAaF4SIWfVav1LxyZ4FCrnjoUNdU
	Ns8x8wAwVdmBa739BuWaXDPDYait/mejt71UM/lbJp95s+EVy3iF
X-Google-Smtp-Source: AGHT+IH1XPGeEvCa1Jj/xKONwcdbsf4R6tlnSM/deBFWW5SD0Gs5spOwdhlOp5STcOkXh7eIxaxVBA==
X-Received: by 2002:a17:906:548:b0:a59:a01e:825f with SMTP id a640c23a62f3a-a5a2d292a95mr683570866b.29.1715590743914;
        Mon, 13 May 2024 01:59:03 -0700 (PDT)
Received: from ?IPV6:2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751? ([2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a3c8724edsm399452266b.34.2024.05.13.01.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 01:59:03 -0700 (PDT)
Message-ID: <0ed958b4-cbc9-4136-9113-e7a43a3f91e6@gmail.com>
Date: Mon, 13 May 2024 10:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ming.lei@redhat.com
Cc: benjamin.meier70@gmail.com, hch@lst.de, kbusch@kernel.org,
 kbusch@meta.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, tglx@linutronix.de
References: <ZkHR1L/cJesDEn60@fedora>
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Content-Language: en-US
From: Benjamin Meier <benjamin.meier70@gmail.com>
In-Reply-To: <ZkHR1L/cJesDEn60@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_015910_409464_6490B620 
X-CRM114-Status: GOOD (  26.66  )
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

 > > The application which we develop and maintain (in the company I work)
 > > has very high requirements regarding latency. We have some isolated 
cores
 >
 > Are these isolated cores controlled by kernel command line `isolcpus=`?

Yes, exactly.

 > > and we run our application on those.
 > >
 > > Our system is using kernel 5.4 which unfortunately does not support
 > > "isolcpus=managed_irq". Actually, we did not even know about that
 > > option, because we are focussed on kernel 5.4. It solves part
 > > of our problem, but being able to specify where exactly interrupts
 > > are running is still superior in our opinion.
 > >
 > > E.g. assume the number of house-keeping cores is small, because we
 > > want to have full control over the system. In our case we have threads
 > > of different priorities where some get an exclusive core. Some 
other threads
 > > share a core (or a group of cores) with other threads. Now we are still
 > > happy to assign some interrupts to some of the cores which we 
consider as
 > > "medium-priority". Due to the small number of non-isolated cores, 
it can
 >
 > So these "medium-priority" cores belong to isolated cpu list, you 
still expect
 > NVMe interrupts can be handled on these cpu cores, do I understand 
correctly?

We want to avoid that the NVMe interrupts are on the "high priority" 
cores. Having
noise on them is quite bad for us, so we wanted to move some interrupts 
to house
keeping cores and if needed (due to performance issues) keep some on those
"medium-priority" isolated cores. NVMe is not that highest priority for us,
but possibly running too much on the house-keeping cores could also be bad.

 > If yes, I think your case still can be covered with 
'isolcpus=managed_irq' which
 > needn't to be same with cpu cores specified from `isolcpus=`, such as
 > excluding medium-priority cores from 'isolcpus=managed_irq', and
 > meantime include them in plain `isolcpus=`.

Unfortunately, our kernel version (5.4) does not support "managed_irq" 
and due
to that we're happy with the patch. However, I see that for newer kernel 
versions
the already existing arguments could be sufficient to do everything.

 > > be tricky to assign all interrupts to those without a 
performance-penalty.
 > >
 > > Given these requirements, manually specifying interrupt/core 
assignments
 > > would offer greater flexibility and control over system performance.
 > > Moreover, the proposed code changes appear minimal and have no
 > > impact on existing functionalities.
 >
 > Looks your main concern is performance, but as Keith mentioned, the 
proposed
 > change may degrade nvme perf too:
 >
 > 
https://lore.kernel.org/linux-nvme/Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com/

Yes, but for NVMe it's not that critical. The most important point for us is
to keep them away from our "high-priority" cores. We still wanted to 
have control
where we run those interrupts, but also because we just did not know the 
"managed_irq"
option.

Thanks,
Benjamin

