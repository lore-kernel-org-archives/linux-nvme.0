Return-Path: <SRS0=3UZ0=PO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D3AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 13:24:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16EE960FC2
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 13:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16EE960FC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CWbG7RwkYrtqahrnk8B/6MRCp+jmPdA3NWjWYZXy4FY=; b=a+4FVRDSBf7veJQ6CakA3WD/4s
	HC93AmSPdG6O0tXteiXW6Bq302S7NtcM52MzaW14UOuFp/ZQjwAPrkdSpSs5r9E2THPj1U3Jnljue
	7o5AawH0A8X8GSiO/MmsAG6OVUcvk+bBNaHzD8lbNhlk6CE0s8IANaikTcI4+fnIOo17U/juBHi3P
	nICO6PLwZYiLdKAaXcHtP07T58ISrwGlytaCmdnxJRGz/2XD/0qdmHAeyPQeHGA7DNHTQSGY6J8gK
	7qd1lTrzumYRsrm+GmA1/Fi+hDk5B4MKyW7rz5ivhDheQlGKBLw5dVwU6L0Bh/Wkx0ZEXLCR9vZWE
	WuRlnKsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfMRC-001sfp-37; Tue, 26 Oct 2021 13:24:22 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfMR9-001ser-P2
 for linux-nvme@lists.infradead.org; Tue, 26 Oct 2021 13:24:20 +0000
Received: by mail-wm1-f41.google.com with SMTP id v127so14079118wme.5
 for <linux-nvme@lists.infradead.org>; Tue, 26 Oct 2021 06:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CWbG7RwkYrtqahrnk8B/6MRCp+jmPdA3NWjWYZXy4FY=;
 b=DsG/ehFOKxWCLGBTvY1ke11f7WczTBGccrfMSlJGVizb0evWQhajptfM9tAFsbDgKD
 PZB89fPSu1W8KrIRX2jksnOA4b+3J2rBimAgL/1behcwCyrr+D1QuopXTaah6RU3eWp+
 Ps0YMKlqXAO/eX9EJoDDp9bhd6flxCLa09A0ZXzTBjfI0YaS0DOn7TgbF1TEVNxWZ4iK
 JELKZyto28aUoWbCn0M62vIz2dWwMOstJ0qWqDrKNY3AF6IcBLiXuN0bhHD0OWt4feyU
 KZw6y+m2XGZchp9GarSjOcG6O4vUCKQvYxcs9ztsXOVHWqDREIky45O+3fxF3Gy4L76l
 rPBQ==
X-Gm-Message-State: AOAM530V3hWebsv3EVYhKFgFSaJaqBikSx3tVsquPdI1nt9Ijqcy/Nz4
 GP3Pdcq/XsIdp6oE6obxpmM=
X-Google-Smtp-Source: ABdhPJz7vyiuOcOiXYykpUWSzifbeYxM4RGciIqnUwU3GpcC0dazKpYgrj9z7yjliebiL+qFQ+p8yg==
X-Received: by 2002:a05:600c:1990:: with SMTP id
 t16mr28321891wmq.124.1635254656109; 
 Tue, 26 Oct 2021 06:24:16 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n11sm9541725wrs.14.2021.10.26.06.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Oct 2021 06:24:15 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Fix H2CData PDU send accounting (again)
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20211024074331.546635-1-sagi@grimberg.me>
 <20211025143838.GA2335106@dhcp-10-100-145-180.wdc.com>
 <20211026084310.GA5270@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f3356734-1e2d-8bcf-baeb-b515aa3281d7@grimberg.me>
Date: Tue, 26 Oct 2021 16:24:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026084310.GA5270@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_062419_844747_34752D5E 
X-CRM114-Status: GOOD (  13.80  )
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


>> I'm not sure why you opted to change the name of this variable here, but
>> the patch is testing successfully: no observed r2t errors since apply
>> this, so I think we're good to go for that regression.
> 
> I've dropped the variable rename and applied the patch to nvme-5.15,
> thanks.

Thanks!

