Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA223C43603
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BB12077B
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H7MY+dSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BB12077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=11Vrivi4AkmtD9ilSaTgjaX1W88Rhw9CcEj5VM2T9Hk=; b=H7MY+dSnc6lG0iye6nIXrq7er
	vhoWHr89IIxOrw+oPIzaUvAtxJ6V6EoWGCfYJCSYDPFuKQJ3wkJA2biFiGNYiTNGj+fIjRyzFTiO+
	zyro0uxdYFQbAVY/LL8XMPyhRAN3pYB/c8bM/UKoEn0IgU9XLASXQ59VO8tthHDuYytyc+6/Aj/Q3
	o1CNjWnT2mXsikT4mxUo48B6V1U5dWCQBi4x/Ehqx9LPLzYQj6Lg8q6qXila4bi5DBWBihzfGqJcn
	E7Tsf/FSmuYO4Y/QRfnY8RgyHrk6Cl0cXHGdIHKKvvX0KfWxD3XrHUs3Pj4Cb//SiJzHgy9TwspC+
	+k21r7/Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ielgI-0003Ia-L8; Tue, 10 Dec 2019 20:00:26 +0000
Received: from mail-oi1-f180.google.com ([209.85.167.180])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ielg4-0002YR-1Q
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 20:00:13 +0000
Received: by mail-oi1-f180.google.com with SMTP id c16so11021052oic.3
 for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2019 12:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BGVMjNlmsJD/ij6xM2GryRmY26x/WqAzpUpp2NWQNXM=;
 b=aSPXV+FpOV+RLRQI1RkfO+G/dKzLGAzR/N+L7ESUu5blnE7EwyuhfQZ90Du/Vn1kZ8
 OyE71eCFVoSWH582R6BIQbSbutozgypNtOD+HX2lYP5z1VhJA5ixQZ73euaQvYaHGxTt
 YcAJSrSqTjyv5IGk1r/j6wb5V3VdrLD6XgAyjVwGKAfC5l8VG3TzU+Qdcu3WQsL3zdjK
 yZMCazGhN2DJoYdlfYVK/Gc3cOOpxLNUoBGN4F4Lt/s7rlSn8Obt+GEef/CBEf50/VDi
 PRNSUhoZm+92EVuCvp6B54uBQdeZ6zCXwR349N9To7iQ0hHwJXgEGldhsB3XOfYY/Lxp
 cfrA==
X-Gm-Message-State: APjAAAXqVKLRDJRXLpMOW4gCx6R2VM/ZvBn6GIxlmzykWGT8RwiQZj5A
 CkSLeZxHAgzVIaRf8STOfpc=
X-Google-Smtp-Source: APXvYqz8O20xTMg+v9SVdjcM7TbG/D4KLwdT00x00T8a7Dy0xQUdfXnCQN5AEioB2CyiVIlfBRyT+A==
X-Received: by 2002:aca:b844:: with SMTP id i65mr606277oif.56.1576008009661;
 Tue, 10 Dec 2019 12:00:09 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id i20sm1736493otp.14.2019.12.10.12.00.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Dec 2019 12:00:08 -0800 (PST)
Subject: Re: [PATCHv3 2/4] nvme/pci: Complete commands from primary handler
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-3-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6d55a705-6a43-5b47-166c-5d2b458fd6a5@grimberg.me>
Date: Tue, 10 Dec 2019 12:00:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191209175622.1964-3-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_120012_128794_89EC0CFC 
X-CRM114-Status: GOOD (  12.60  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: bigeasy@linutronix.de, hch@lst.de, tglx@linutronix.de, ming.lei@redhat.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a0138e3ca0b9..e415fadf7331 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1055,6 +1055,10 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
>   	if (!nvme_cqe_pending(nvmeq))
>   		return IRQ_NONE;
>   
> +	nvme_irq(irq, data);
> +	if (!nvme_cqe_pending(nvmeq))
> +		return IRQ_HANDLED;
> +

Question Keith,

If I have say 24 (or more) devices with a queue mapped to a cpu, and we
happen to just reap in the primary handler for all devices, all the 
time, are we safe from cpu lockup?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
