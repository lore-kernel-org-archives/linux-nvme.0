Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31417C2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8S3zGrE09GQSNNYzwxO+94ABm1FSvgozUpr3sLBGlvM=; b=E/G7OUzEta3MhCgq1Lma2ALiCa
	VMsWQvlgAn++C7zdVbFaZ/aJbjSaVkCJBS6qF+I7J9U1X/JnSF+E/Mbc4W5ehxLp/IZq2JSvzPtK2
	Dk5vw1EyQwmUBfqoI55N2y7uLzrAL4wBkLcIAyFQOEuE1ZXN4CbJtXaD4E528oquRMT0Qtc08Lgvw
	3EHmcnUT+FXdHJSwppDDNtRqL1O1b+DIX3g0yR0M4WU9/JjzZDgKf16iudyLNHEc8CzRRKXXP6fED
	v4hOAqcWHKA5CRJdZfLcPD0Q2cAQk0L8psxeDkL/bW2xf7iN9DPVLATyQQMnOF9oybKNEhKz4p03T
	4YRlBeyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r55O8-00CIfq-0I;
	Mon, 20 Nov 2023 14:36:36 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r55Nj-00CIfE-2B
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 14:36:16 +0000
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9c40c3814a8so138408666b.0
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 06:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490969; x=1701095769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8S3zGrE09GQSNNYzwxO+94ABm1FSvgozUpr3sLBGlvM=;
        b=r4hP9r+++8bkuzHBRCFj+yjbejiyXCaLoN2gWQ7DTRChN1kghz9hEbYliXJRh//8/U
         ONERHg9aRPZZDV2JBSBbudSO50gPFRD9Oy84aICCwnZ+FciM43GyIwrqiHCRiT5OLyTF
         gzo6grd68198Wrrn9hTzTcpz96TibOesmy4/4AXELj7wCe5VH87SxqmfQ/hmQYQv3O3k
         pttM5LZsKuUjiQMkn3jCQ8EOCPWGr8aIpXiF0zmZOSZqi5TlVqCao5t0Lu/xxN9HpjZD
         tM1kLp9D8bZbbaXREv3VeP/lqRrhmNX3qqVMN87GjuZRHglvaGDG887uuVhEhizb7fC7
         6Fmw==
X-Gm-Message-State: AOJu0YzM7hycPwmnaIcj6rjZFX9IQnpA67HjVkSBiUPlJFz/bpaXV9ku
	p1xrlEEAwOAVmlgwaBVjZ/U=
X-Google-Smtp-Source: AGHT+IH4Yt24cdh5NAH1X/GHTU40+ENfB+mZah8wukNQevh9xD6Z7PzB6C/dK15Sf4xPDVIzXA91cA==
X-Received: by 2002:a17:906:51d5:b0:9c7:5db4:8080 with SMTP id v21-20020a17090651d500b009c75db48080mr4742356ejk.7.1700490968824;
        Mon, 20 Nov 2023 06:36:08 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709060b4c00b009b928eb8dd3sm3915723ejg.163.2023.11.20.06.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:36:08 -0800 (PST)
Message-ID: <78394d52-cdff-474b-a538-2b4cf50c637b@grimberg.me>
Date: Mon, 20 Nov 2023 16:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: ensure reset state check ordering
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Minh Hoang <mh2022@meta.com>
References: <20231027180752.2527653-1-kbusch@meta.com>
 <20231030132738.GB21741@lst.de>
 <0e19bd16-a544-457e-aecd-70b7ff6433cc@grimberg.me>
 <20231120142648.GA7139@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231120142648.GA7139@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_063611_789520_B3BCC7B3 
X-CRM114-Status: UNSURE (   8.29  )
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


>>>> From: Keith Busch <kbusch@kernel.org>
>>>>
>>>> A different CPU may be setting the ctrl->state value while flushing the
>>>> reset work, so ensure proper barriers to prevent reading a stale state.
>>>> Reading the wrong state can report unexpected ENETRESET errors when
>>>> everything was successful.
>>>
>>> smp_load_acquire needs to be paired with a smp_store_release.
>>>
>>> We should either always hold the lock or use WRITE_ONCE/READ_ONCE
>>
>> which lock?
> 
> in this case: ctrl->lock.

Yes, we can do either. READ/WRITE_ONCE seems more appropriate. Worth
a comment because we don't use it in other places where it is advisory.

