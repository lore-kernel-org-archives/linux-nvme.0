Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A41C636CD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CuIV2ZniuR6JiN7/4weCn+3flzvSdKoSszT4evfBW74=; b=2IzqIlYB49e3FC2g9UIxx7biD0
	0KJ+ZQQDFWBBH11QBpQqbc7AXG9QitoP12/Hs9uiw53p39ZCXd+N3sLmaRXkZ3nSFqg0vIehgIsH3
	wpR+f49SEbps5tpa9ZIEIFLxyfKzm6hay3w/0AgCuDZQTpUW7kMATFqQRSr1pjELDKET+whuQ6afj
	jehwWbku29eTu3NlW6FOUqvJIfFfdx/kNMZFQL05N/8gogSVb/5nUi8EJvdMZeFpyqjJh7cTZ8qVZ
	7z70yAAY8txZfkot4HwLEMzxQMsImG6TdESa9Yk0EUadFwJU9K+ps15Vk74lwPJdIUFbjx37NAV4S
	P7a6ZWZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQXyS-006sob-6O; Fri, 10 Feb 2023 18:18:16 +0000
Received: from mail-pg1-f180.google.com ([209.85.215.180])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQXyP-006smT-Qv
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 18:18:15 +0000
Received: by mail-pg1-f180.google.com with SMTP id c29so161479pgm.5
        for <linux-nvme@lists.infradead.org>; Fri, 10 Feb 2023 10:18:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CuIV2ZniuR6JiN7/4weCn+3flzvSdKoSszT4evfBW74=;
        b=ff0pcRAzVIVhPKeowUwfVgmZkafiTLUSU44jQ9D70n9dR1gMVhe0NjZkC/TBekUY8R
         3oknSuzsgeEmIVS3OLHeIEPA9B3Vev/9hzgrDj1MQUYRIZUeBMzLagwcA2ITmIyI2AGx
         XTx+b/IaQF59/CgQ3PPC8KxCmAQj1honMYXkNWFNREDk+A/+YqTV+OU6wYUO6+h9wOKI
         Qc0aPCIIZpXq1TOqY8pe/P3RQyqICGad8AoesBpHRlls0BHEc6DJo5VA0zbLBTNuTamX
         aILR7lKgE8eDebgnSiyfK51lLBlMnVrquM/HA9xnSg7PEk1Dj5jj4j2d9W0zB4T51ueh
         ydbA==
X-Gm-Message-State: AO0yUKW9lf2l4gazlQ8ZBLhFbTRQiQeE86Djg4HWe+NkBWLtHWK7zZLf
	uC8HSFQh6bn7ORHBiz8aXxY=
X-Google-Smtp-Source: AK7set9N6MjmZsXjybdAr+hJoPFSqTEoYhUaKedYxqLCBx2V8yPx0GxWd7g+wUZ3hObnC7poWBjmIw==
X-Received: by 2002:a62:14d0:0:b0:5a8:5dcb:b775 with SMTP id 199-20020a6214d0000000b005a85dcbb775mr5120458pfu.14.1676053090955;
        Fri, 10 Feb 2023 10:18:10 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id v9-20020a62a509000000b005941ff79428sm3645099pfm.90.2023.02.10.10.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 10:18:10 -0800 (PST)
Message-ID: <69443f85-5e16-e3db-23e9-caf915881c92@acm.org>
Date: Fri, 10 Feb 2023 10:18:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 ming.lei@redhat.com
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230210180033.321377-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_101813_890438_43D2489B 
X-CRM114-Status: UNSURE (   8.98  )
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

On 2/10/23 10:00, Kanchan Joshi wrote:
> 3. DMA cost: is high in presence of IOMMU. Keith posted the work[1],
> with block IO path, last year. I imagine plumbing to get a bit simpler
> with passthrough-only support. But what are the other things that must
> be sorted out to have progress on moving DMA cost out of the fast path?

Are performance numbers available?

Isn't IOMMU cost something that has already been solved? From 
https://www.usenix.org/system/files/conference/atc15/atc15-paper-peleg.pdf: 
"Evaluation of our designs under Linux shows that (1)
they achieve 88.5%–100% of the performance obtained
without an IOMMU".

Thanks,

Bart.


