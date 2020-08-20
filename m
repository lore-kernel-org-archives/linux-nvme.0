Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036E3C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 08:03:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74BB2080C
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 08:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0QNOPx2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="KwsteLEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74BB2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ql/ZGqtPAXD+loYOCEPoRk8FVBufp0ZOZhLkIm9ZBwE=; b=i0QNOPx2YCw6Qh/VgRgmnqd0y
	MUjUaqRMz8CpKh8aumoEm+/CJ9Nze0Rfm48RQknRNETfRBBZelPmKhSYV0aZprDVyJo2afFHJTaMB
	2XREOYLIpjq9TR52zzgQbVjD8qGEr2h6cmXaZDuqX8+MU818YEPSEbHJ3Ss5ZZZ4EPnEFwTZLvxtt
	S6hMyiDzPsxTOsIQhY66iyPeHUi/YO6PO3D/eZg2Uv8xleojMuwsLD96MbMUEU+OaaNGVfIqeizNF
	t6YwQnZEpw9NEcxaJqSwxkTbqlip3YtZXXtP4c3HnpHg+HC+AEz0/yPg6XeaD6wu8wChzSTPf6s/c
	JiypnhhDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8fXa-0003jm-Gu; Thu, 20 Aug 2020 08:03:18 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8fXX-0003jD-9f
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 08:03:16 +0000
Received: by mail-ej1-x643.google.com with SMTP id d11so336945ejt.13
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=R8fk87r2NB5AfCq6Eih8WnPcjOrj6NaIDnoUfvFvZuc=;
 b=KwsteLEUTu5af/PUU3LB9WbBpqWYT9Or3Fm6fZFPCrqnKu2VPmUx8Ie6wDvdE0pNKe
 Z7/viAz840rUFRXrziTkhOYiQej7+UDJYB9rMBcFujtp5Ywv2qEV9GaenWvdfxqmNn8x
 yIU84VtWVRR3mCdtC4Yg8RHo2YRwCt+piymIaJ/+DQwDUUNSsqhOv1HuBYBlOGZuV4hs
 22fnLpHR+SeeUPOp4QAJbjIqRm8zw9W06+KE/I0bkc4JI9HDwi3zGWitpfVL4g3r1XMk
 C5vKm72BxyaM6Hk/goLK8oNZtuyPkRR0gDmvuae0WmpW0WynR5oCjBiAe2l4SlqdavQr
 kcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R8fk87r2NB5AfCq6Eih8WnPcjOrj6NaIDnoUfvFvZuc=;
 b=ZJsuupuD4hG7IS5WyG/PBfkGPRMJwb8wajdpKzxqTQ89MdjHeqMK1+WB6c2wbEhuLt
 AHqhRPWZcGWT2WqhABQ7xZpgEv1YhK/wLGSTBXDd0JTg+E2AEA65tnOMUII1bBmnIXAF
 eZOHA2JPE/tURe0mB44MtQGw4w8rsF2qwzXITeJYnnUC1FLnAbqwWNUl/hEaHAaf0xQD
 4K9nMpBDQee10gpUjDRuvOwdRD7xkKSVEfhZgkTRDelWXxEjfTW1iJr/K0IZadyOt3aN
 rZ0/Hb69y3M7RQOgcFJZLeNQHyWSNzU7hxw2WpmmTwJko8gPj4qpxtf3spbvUMG8k+Et
 SNKg==
X-Gm-Message-State: AOAM530MlgilXF5AGDYACLXygPMka3DH8b3TOlKZ7qVyX/IJeRbEjH91
 T2zLdzgkUcFGPgjlGzT03kZZUg==
X-Google-Smtp-Source: ABdhPJxaazq3f/bU/Ux+ct20z483SNcc8H8VttXDhliGkBkB3jKQqOtusyU3lgxf80JjEr9OoII+bA==
X-Received: by 2002:a17:906:9592:: with SMTP id
 r18mr1989603ejx.464.1597910593863; 
 Thu, 20 Aug 2020 01:03:13 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id v7sm890198edd.48.2020.08.20.01.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 01:03:13 -0700 (PDT)
Date: Thu, 20 Aug 2020 10:03:12 +0200
From: Javier Gonzalez <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820080312.oxsnsedn6rqf3rcx@mpHalley.local>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
 <20200820063719.q6wftb23op45wigk@MacBook-Pro.localdomain>
 <20200820065250.GA6885@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200820065250.GA6885@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_040316_091504_D80023EC 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 david.fugate@linux.intel.com, "kbusch@kernel.org" <kbusch@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 20.08.2020 08:52, Christoph Hellwig wrote:
>On Thu, Aug 20, 2020 at 08:37:19AM +0200, Javier Gonzalez wrote:
>> We will stop pushing for this emulation. We have a couple of SSDs where
>> we disabled Append, we implemented support for them, and we wanted to
>> push the changes upstream. That's it. This is no politics not a
>> conspiracy against the current ZNS spec. We spent a lot of time working
>> on this spec and are actually doing a fair amount of work to support
>> Append other places in the stack. In any case, the fuzz stops here.
>
>FYI, from knowing your personally I'm pretty confident you are not
>part of a conspiracy and you are just doing your best given the context,
>and I appreciate all your work!

Thanks Christoph.

>
>I'm a lot less happy about thinks that happen in other groups not
>involving you directly, and I'm still pretty mad at how the games were
>played there, and especially other actors the seem to be reading the
>list here, and instead of taking part in the discussion are causing fuzz
>in completely unrelated venues.

Yes. Hopefully, we will start keeping things separated and using this
list for Linux, technical conversations only.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
