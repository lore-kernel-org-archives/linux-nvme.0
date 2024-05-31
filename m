Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8D3C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:Subject:MIME-Version:Date:Message-ID:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n05EtFe3sdj15ew6SLWTU1Vrct7rRtquCuzOf+gCyVM=; b=gPTY9HfPEIh6JiYAwWshP6GGvH
	fXjxaparYZ2coaBdYxO8kEpOZQtFuo6mqeiUQaO6mOe4VW0CcRPTSQm+uaSasYv1PS4iJ6DrPty0h
	d8KN6i9oP6/8oV4j0bOqqCB1KLw5t3noDS0BIC5+H4rBbt87imBvWiBl5rfzyWo+BLKyhF+R02R2S
	OVUs/fQXkYJ8fkHfavadOhT5tgTGeqKm1x3DBwycl+8ZZHaKXcxHeVNwtdLdmj3Gw1GAZNp74q0TP
	zaI2ecYWQhXdOpFLEZFuCffD7nz8+/zJ+itDw/yxap1p3HC80ZuU1wG/ARSjvVZLcOsn4f7piaMRO
	MEVEAE/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD3Lw-0000000AWrt-18Ym;
	Fri, 31 May 2024 14:35:32 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD3Ls-0000000AWql-3jTX
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 14:35:30 +0000
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso22706271fa.2
        for <linux-nvme@lists.infradead.org>; Fri, 31 May 2024 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717166125; x=1717770925; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n05EtFe3sdj15ew6SLWTU1Vrct7rRtquCuzOf+gCyVM=;
        b=APH438CugT2CcAHtnDtdGg5uqHklE93r7VNik2ogrk4x9dNcp1dCa+JW9lQBPmzXJF
         EIW7V7WfzmGVbssIJhSf3BMVVtNPwFn64OBgkF2WtmdFdAARaL6S3lZZyamSewCcZTtP
         xjPPc+ZUlLKl31Xk/mylQ4GJ66J6FhBPpoVcDzRuQ8Sw+wUZ6QYAJfwu3B3MM4AqlFMl
         byBzsQa8FB1xhphgdmN8LuraM6EVgPMfDF8fNJUSDhBQGyKraBnvEDxIq6aP3zV7C6o2
         o/mkoBmla6KC3ibPh8c4Q0u5mrP++ZPfF8LdgSIlTIDzH2eJspDxZSVggxOY8ou4cgJH
         zjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166125; x=1717770925;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n05EtFe3sdj15ew6SLWTU1Vrct7rRtquCuzOf+gCyVM=;
        b=Y8TQewVUzjuJBjQTinZ9E4rK8Gwiz6HJ+5bE/rLKwwmEJ1vUSGzKUJb0fWHIshsAia
         V8teN3//yXWDszGCXlbRrKqvHOsP2QmW74RST4/B/m6OmSGFukqaF1fM5OY81ynTGrcx
         vIkp0fcaE9Nwhhw01EBmXv58SuCQI+zxcuQTkFD05dd3nOE/yVg2SNOe2jNozg4FJF16
         YVExRMvqzoA0q+V0l/QRsvIQ8Z4PpWheVnIBtnNwwSH55Vbbfol+62WJJax7YgL3H2T4
         rsg6ONyc9qWDnOg8bXUNtOemCRGdwGUXC4oAq8a0G7JShYNX41/Y9aVvjxyi+SzXY5Ve
         0efQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0LFZVzxHnNmfTTCDJhpy3cdnvYkI1/sxEADzC74c7vf1f6z4CPbRLntKIg6W1cw2iXKH3wM6E4rfrJSXYudqlaT+FcmVtXzxANCNAxrM=
X-Gm-Message-State: AOJu0YxMuQW/H937+9KMM97KK6hlRtHQieuZoh7THA9aA5qh4ZW0wOlw
	Xc2Dc9O976CXgvHrC0e5EI45wfM4qtjbp17svB4q0BY/ex27evnu
X-Google-Smtp-Source: AGHT+IGVcCUHaZnpv1MwLaF6IIx1BsHReM37tDQicYsLW0v+utsuiS5MmlTY3NO6OJjjjtHmAt8QVg==
X-Received: by 2002:a05:651c:1402:b0:2ea:7def:46d0 with SMTP id 38308e7fff4ca-2ea950c896emr12043811fa.9.1717166124628;
        Fri, 31 May 2024 07:35:24 -0700 (PDT)
Received: from [10.16.155.254] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04da603sm1988134f8f.57.2024.05.31.07.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:35:24 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev>
Date: Fri, 31 May 2024 16:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.10-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
Content-Language: en-US
In-Reply-To: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_073529_027412_06F6F361 
X-CRM114-Status: GOOD (  20.48  )
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

On 31.05.24 03:54, Shinichiro Kawasaki wrote:
> Hi all,
> 
> (I added linux-rdma list to the To list since blktests nvme and srp groups
>   depend on rdma drivers.)
> 
> I ran the latest blktests (git hash: 698f1a024cb4) with the v6.10-rc1 kernel,
> and observed a couple of failures as listed below.
> 
> There are two notable differences from the result with kernel v6.9-rc1 [1].
> The first one is srp/002,011 hangs with the rdma rxe driver, which was discussed

IIRC, the problem with srp/002, 011 also occurs with siw driver, do you 
make tests with siw driver to verify whether the problem with srp/002, 
011 is also fixed or not?

Thanks,
Zhu Yanjun

> at LSF 2024. I no longer observe these hangs with v6.10-rc1 kernel. Great :) I
> found Bob Pearson made a number of improvements in the driver. I guess these
> changes avoided the hangs. Thank you very much!
> 
> The other difference is nbd/002 failure. CKI project still reports it for
> v6.10-rc1 kernel [2]. Recently Josef provided blktests side fix [3] (Thanks!),
> and it has not yet applied to the CKI test run set up. The fix was made for
> nbd/001, but I expect that it will avoid the nbd/002 failure also.
> 
> [1] https://lore.kernel.org/linux-block/m6a437jvfwzq2jfytvvk62zpgu7e4bjvegr7x73pihhkp5me5c@sh6vs3s7w754/
> [2] https://datawarehouse.cki-project.org/kcidb/tests/12631448
> [3] https://lore.kernel.org/linux-block/9377610cbdc3568c172cd7c5d2e9d36da8dd2cf4.1716312272.git.josef@toxicpanda.com/
> 
> 
> List of failures
> ================
> #1: nvme/041 (fc transport)
> #2: nvme/050
> 
> Failure description
> ===================
> 
> #1: nvme/041 (fc transport)
> 
>     With the trtype=fc configuration, nvme/041 fails:
> 
>    nvme/041 (Create authenticated connections)                  [failed]
>        runtime  2.677s  ...  4.823s
>        --- tests/nvme/041.out      2023-11-29 12:57:17.206898664 +0900
>        +++ /home/shin/Blktests/blktests/results/nodev/nvme/041.out.bad     2024-03-19 14:50:56.399101323 +0900
>        @@ -2,5 +2,5 @@
>         Test unauthenticated connection (should fail)
>         disconnected 0 controller(s)
>         Test authenticated connection
>        -disconnected 1 controller(s)
>        +disconnected 0 controller(s)
>         Test complete
> 
>     nvme/044 had same failure symptom until the kernel v6.9. A solution was
>     suggested and discussed in Feb/2024 [4].
> 
>     [4] https://lore.kernel.org/linux-nvme/20240221132404.6311-1-dwagner@suse.de/
> 
> #2: nvme/050
> 
>     The test case fails occasionally with a QEMU NVME device. The failure cause
>     is the lockdep WARN among ctrl->namespaces_rwsem, dev->shutdown_lock and
>     workqueue work completion. After LSF 2024 discussion, Sagi and Keith worked
>     on the solution and Keith provided the fix [5]. Thank you!
> 
>     [5] https://lore.kernel.org/linux-nvme/20240524155345.243814-1-kbusch@meta.com/


