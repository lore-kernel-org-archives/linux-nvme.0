Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D27C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeoNHRdTi75bvN7yIK3qjR8vRNZkI9OKUG3gsroE1Cs=; b=RZLv8co37SE19LC/x06mFkS9VX
	LRgBEeNK/vB2xzgEUn0tdm8o2PTBz1npb3PZqHb/FlevEDARHiGPVehZ013JlyUUM6O9UFqlVIgqU
	reZB/T7hLtf0woYVK+NFzEd4vyy1LuJVXz6in7Es/5x2eoPKp5pMYuaj7IFkAhuA1YMewyINdJlHm
	zdfKTyHbJGo+H9QMbJ4B8GBxsLq8L8bEywZvIFd1OC3kg+vwTxirANZV4MRje/ozKFPrevFZZhf8r
	5a7l7rYiDR/8ZrZQFNhfGLcsJbgCd225XgmYL4xeQAuYJIf/QBgmt+YNyH2Wv8dOd30MymwuKjSBs
	5ekxL2rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRfNs-00GAGf-W5; Mon, 13 Feb 2023 20:25:09 +0000
Received: from mail-pj1-f48.google.com ([209.85.216.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRfNl-00GAEd-VR
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 20:25:05 +0000
Received: by mail-pj1-f48.google.com with SMTP id nh19-20020a17090b365300b00233ceae8407so5837205pjb.3
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 12:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeoNHRdTi75bvN7yIK3qjR8vRNZkI9OKUG3gsroE1Cs=;
        b=tUCb+sXMrTd2QAJ+LR8+vFDWvxb5JcSDRiCmOqYIwzv92N0hT2kr+vrj7pKp/WW0rO
         vFag5Z7SXut0LEH6nAQ44Up5o3u0127iAtI08rhoNXv3F/vZ0CV1QBvUKN2KBWw5CdIe
         WtK9fEopdwNNCgxlsfR0yUFSUXjI31+2C7SGPhLblh4XdrG3NUobIdgCOFGxhvHpzyKo
         5sq7MkIqBPOBp+YoatVxBYlnpDrlaOTAbDyyl7qqAVS3X60Q7z9qsuJEpRtCVeRg7EjL
         GZ+KriZxV8DLdd/sJ4pdEKwW2X93Qfi2h1Cmh9cwePucv/adN2eaaXhPpMZ+h1wplHs8
         ncgA==
X-Gm-Message-State: AO0yUKWMdwl4cuxIXXxk0j0DEJ6qNox17PJ5c4+A8HDbS6da0xnhbMt/
	9862ao0xBf5vtkxpt6fwwkDhCZfmwXE=
X-Google-Smtp-Source: AK7set8spO+RK9kUMn3B8mnPoUYkvSz0i20QutEqmbE0WX0LAzgs+gTQ6F8WD1wPrvXw2DamckMIhA==
X-Received: by 2002:a17:903:32c6:b0:19a:9686:ea87 with SMTP id i6-20020a17090332c600b0019a9686ea87mr115904plr.55.1676319895980;
        Mon, 13 Feb 2023 12:24:55 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:dc5c:7c61:93f2:3d3d? ([2620:15c:211:201:dc5c:7c61:93f2:3d3d])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b0018544ad1e8esm8663247plg.238.2023.02.13.12.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 12:24:54 -0800 (PST)
Message-ID: <d69f0203-2eff-e2c2-0a6c-ed341bdb1896@acm.org>
Date: Mon, 13 Feb 2023 12:24:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org, axboe@kernel.dk,
 hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
 <69443f85-5e16-e3db-23e9-caf915881c92@acm.org> <20230210193459.GA9184@green5>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230210193459.GA9184@green5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_122502_238965_84F76DE7 
X-CRM114-Status: GOOD (  11.92  )
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

On 2/10/23 11:34, Kanchan Joshi wrote:
> On Fri, Feb 10, 2023 at 10:18:08AM -0800, Bart Van Assche wrote:
>> On 2/10/23 10:00, Kanchan Joshi wrote:
>>> 3. DMA cost: is high in presence of IOMMU. Keith posted the work[1],
>>> with block IO path, last year. I imagine plumbing to get a bit simpler
>>> with passthrough-only support. But what are the other things that must
>>> be sorted out to have progress on moving DMA cost out of the fast path?
>>
>> Are performance numbers available?
> 
> Around 55% decline when I checked last (6.1-rcX kernel).
> 512b randread IOPS with optane, on AMD ryzen 9 box -
> when iommu is set to lazy (default config)= 3.1M
> when iommmu is disabled or in passthrough mode = 4.9M

Hi Kanchan,

Thank you for having shared these numbers. More information would be 
welcome, e.g. the latency impact on a QD=1 test of the IOMMU, the queue 
depth of the test results mentioned above and also how much additional 
CPU time is needed with the IOMMU enabled. I'm wondering whether the 
IOMMU cost is dominated by the IOMMU hardware or by software bottlenecks 
(e.g. spinlocks).

Thanks,

Bart.


