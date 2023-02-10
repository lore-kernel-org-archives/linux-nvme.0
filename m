Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BE4C636D4
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 19:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fYTx4XvBOSsueNyLOIdpWr5U8lWZijTLj9xr3oRSm+E=; b=PMkl/baAC2uSMYvpetizplTNTP
	kEPEAma7oDkDQ8CHzmjDGoRo+n5xHA4DL+ASHjRvgYi+ImRanlOKSPZesS+I5tbQtkeNilzSjGPMt
	z4ISqYyV8qgICtsjMSx4rynoPh8Uageeo2bUz5UA7w5MTgOeFhYQhGnEcuu7Zy7zQgWKJicsu8TS9
	0wooIgWaZh/W5D4Ft5dT+nOMShgDS79umUxIjHBi3cwDGtNwLAI6/jrgCKcq2hwCS+WK0F+MKuhY+
	6K1MK8NiTEUcasoHdzGvq2GFlgfHnXniel4TQPVt/nO0cYMR6rmEzJwud5QGDrIvBTW8J4ShVyU2r
	rJUbwuJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQZN7-007D8I-HE; Fri, 10 Feb 2023 19:47:49 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQZN3-007D7N-Mn
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 19:47:47 +0000
Received: by mail-pg1-x533.google.com with SMTP id x10so4439402pgx.3
        for <linux-nvme@lists.infradead.org>; Fri, 10 Feb 2023 11:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYTx4XvBOSsueNyLOIdpWr5U8lWZijTLj9xr3oRSm+E=;
        b=caDtprRmnqs7qjEJ6kuMrvA/jDCyeZfB15SohMIO11wYpHzx62as+u5JQYI2u8AyB5
         Xy+Cbgas/SllQ49rHZGqZ952xfhRW8KVMEdF736i8OexY8hCfb4e1xdgsATLWS0RK4Kt
         eZT539S2+7Ctfd2bMX5zIoYvyC2VPadGHS4LvuEUrpPgAr0XkNEfzv4BZPg4cyxvJiPq
         u+dBlBtOF37BpWhhMeiqIs//A5phJdaENmeLY6IZaNxyQIbYbMujFXtSAoW3WHXjUkAm
         Aa6LgYyf2X1n6yPcFH46Q/xCsKI+wkJ/8N8J31Zl8NCUFcZ/Zsf1E1XN1JZqiw+LH00S
         YZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYTx4XvBOSsueNyLOIdpWr5U8lWZijTLj9xr3oRSm+E=;
        b=WSTsS14rM2VIGQAtTmzsjaryXj+2APaEohHbmtmfmDhTLaTWb0n38JzwAtsAWqvAlp
         OFQECto0DSGoSPVhhTKGEZ0aBFEo83qsfWaJ/jEwCNJQugTRU/FqAA9fPA4LREoQN2rc
         VwgjWHy5Br2h01x+fXyg1Nne2zEuO8dxFSWp8qK7/v3QCa9DNJND+8pRwHO2G5KWDnH7
         XOzxO8p+5p1Q5ol6PXeQYJUxmyU8kdsu9nmia8wANnVQElKl8ATpQE0vOBJmA3nrPyM0
         wLPokCC00e2q/jmuANv4ilKevQefsaf6p8M1Pa2Nwed1Epq7iEIgphte/y+eWyjL6C23
         kgtQ==
X-Gm-Message-State: AO0yUKVmUc8uUFijKM8KYE9nqVE03McW9oB/E7fKBQ0NVcsmVJkjMEuh
	UJVGZEhjp1Hw3IBDfoY1JayI6A==
X-Google-Smtp-Source: AK7set9l6RI7OIoQT77hlj4mEluI9EtAV/yEoHCems8NI36dW4yRIG5NRmi5GwoSrWnitnWNFBRhoA==
X-Received: by 2002:a62:86c1:0:b0:5a8:5166:ca40 with SMTP id x184-20020a6286c1000000b005a85166ca40mr6298398pfd.3.1676058463120;
        Fri, 10 Feb 2023 11:47:43 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t18-20020a62ea12000000b005a851e6d2b5sm3584532pfh.161.2023.02.10.11.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 11:47:42 -0800 (PST)
Message-ID: <8b1c3057-cc74-6169-c59a-283595eb46f0@kernel.dk>
Date: Fri, 10 Feb 2023 12:47:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
To: Bart Van Assche <bvanassche@acm.org>, Kanchan Joshi
 <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
 <69443f85-5e16-e3db-23e9-caf915881c92@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <69443f85-5e16-e3db-23e9-caf915881c92@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_114745_965521_A824CA06 
X-CRM114-Status: UNSURE (   9.53  )
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

On 2/10/23 11:18?AM, Bart Van Assche wrote:
> On 2/10/23 10:00, Kanchan Joshi wrote:
>> 3. DMA cost: is high in presence of IOMMU. Keith posted the work[1],
>> with block IO path, last year. I imagine plumbing to get a bit simpler
>> with passthrough-only support. But what are the other things that must
>> be sorted out to have progress on moving DMA cost out of the fast path?
> 
> Are performance numbers available?
> 
> Isn't IOMMU cost something that has already been solved? From https://www.usenix.org/system/files/conference/atc15/atc15-paper-peleg.pdf: "Evaluation of our designs under Linux shows that (1)
> they achieve 88.5%?100% of the performance obtained
> without an IOMMU".

Sorry no, IOMMU cost is definitely not a solved problem, it adds
considerable overhead. Caveat that I didn't read that paper, but
speaking from practical experience. Let's not be naive here.

-- 
Jens Axboe


