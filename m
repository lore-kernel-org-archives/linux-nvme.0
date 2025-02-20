Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00FEC021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x8uxDiuJb+FtwnSdvnxhyDNV/h2/dsyLMYaCTue1E1s=; b=J9QrPvou6ripM0bYvU/t7+XOBM
	Avt9G1UrFb+ycR2aVQiqLiZXL3EI6Fi96TFmsd9G4NSf3vjTvJ2pSs6ZjWhkSLNFxNETZWkZUXo26
	xP1Abi+d7PPvYrjnzTSz1pwHf3eDkuvelT6gUbpp3azBG+1L7wurkAT7MqsqRgp9eCZ3bsfyP+T0K
	HbBp63QZoVqechhNi0S3lJyvdnlRp9XdAZFsXtHy00See17McbMwrucqBOlxjRBffs7Tp7PWMnUb1
	P5qYPK7YtEuSfP0y3Vvxo/sPCKbg2W2YW/qtAykmyG3TMp6NCT6HEg0Jtd41m62AFL2okoDkwDzQn
	U/1YYujg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl4Mj-00000000RbZ-09pw;
	Thu, 20 Feb 2025 11:05:13 +0000
Received: from mail-lj1-f171.google.com ([209.85.208.171])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl4Mg-00000000RZt-0x8y
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 11:05:11 +0000
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30762598511so7360261fa.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 03:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740049508; x=1740654308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8uxDiuJb+FtwnSdvnxhyDNV/h2/dsyLMYaCTue1E1s=;
        b=Pvwr4qW9OC6JJK0x3OoEIGmRESA+R2XOolH6HzbCtYTYAbo0p08zx9qS5dYzWciq2O
         v/1GpJtGBe2VSPHM1KcbUN8LtdrgkNJoX0bctEVE2qzgQytyJngZJPSxlp7V1L59UF79
         +V+hNtso8RVgA39vSmNrdndpiC8dPj5b1To98ZuvK8Gbz1yrQTOQAu53IkDXBhxzq3i2
         Sn2uWtWTCovm5vSc443mzCOkrv+J8LpnOpr00d/MQstA0wcvZv3oP90ztVCS8VuKMdKW
         1mVRE9M8nefLkrQlCgkTMuWDHm4z5HclDqaYTTRe1WVS6vpUC9LmBHnnRxGrMywsQUS8
         hHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVllDyZEKxXyllVkvh207v0oAxQC96IB7gs2yvFsWaqEdKd3krfhRtRyXIj4YRmnBVpFjm3Q+jR4xFs@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1fWf4+w02myvvrUSTCMDHNIXlpnMdgQYeQnChPYi7LprBZYlf
	QFzxB4ra8fNlQJP3GWzoxW+lKKBcoxusr9/0zk9hzVjCgQnvhb3D
X-Gm-Gg: ASbGncvir07wjWvSs/ycfvY+7NNgRDLhgmD+92UOHZtwQOt3WHtvuMrlMfxywpbxSk5
	MpgPtCQXsb7yDDvc3WqaEgrIsrWc1nt7M7BEbEUd7+L3VXIMgbNZ5RsK/Zme7sgcH1T+qFqtbS/
	qLvkkLmrpYDLubYO2YoRzZoJbAJm+YKv/P8BvoApgVCKMOWPNhl1xnwgTp6A0NcZCbbz15depgX
	hDizNKllNeLsCW9P8mNZsHIWqumcSitjWeMrUMYZfL0m4BCQvmi6T21dxohiRV+ApCZmg4H/acZ
	s/p9jfulMWz9ycPeH5LS33/TupAtvehnulIds6NLFhoCymt99qM=
X-Google-Smtp-Source: AGHT+IEDAzNSU4M6N6+sNoHRKE34zjwzmrWG8rZXC43x/q/qFTR8i6SDYVfamfd05Dg4BOm0XvFkhg==
X-Received: by 2002:a05:6512:2342:b0:545:fad:a757 with SMTP id 2adb3069b0e04-5452fe56d47mr6947117e87.29.1740049508045;
        Thu, 20 Feb 2025 03:05:08 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54531afdbdcsm1647220e87.247.2025.02.20.03.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 03:05:07 -0800 (PST)
Message-ID: <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
Date: Thu, 20 Feb 2025 13:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
 John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_030510_276794_18C2B32B 
X-CRM114-Status: GOOD (  27.62  )
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




On 19/02/2025 16:47, Nilay Shroff wrote:
>
> On 2/18/25 10:45 PM, Keith Busch wrote:
>> On Tue, Feb 18, 2025 at 11:31:58AM -0500, John Meneghini wrote:
>>> On 2/18/25 10:06 AM, Keith Busch wrote:
>>>> On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
>>>>> Keith, Christoph and Sagi,
>>>>>
>>>>> This patch has been fully tested and analyzed by Red Hat's QA group and no
>>>>> unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
>>>>> have been tested. Our QE engineer has asked me to report this upstream.
>>>> What's the harm in leaving the parameter? *I* use it so I can test both
>>>> ways without needing to compile multiple kernels.
>>> LOL.  We've been talking about this since 2017. The goal has always been to remove support for DMMP with NVMe.
>> I understand that disabling nvme native mp it is required for device
>> mapper, and I get you want to prevent the possibility of anyone using
>> dm-mp with nvme, but that isn't the only user that wants to see all
>> namespace paths.
>>   
> Agreed! I do have nvme multi-controller disks and I toggle multipath module parameter to
> test it both ways. One with each individual path to a shared namespace and another with
> a single head node path and then let IO policy determine which path to choose for sending
> IO to disk.
> In fact, we have few nvme blktests which only runs if device is configured with single path
> and so testing it on multi-controller nvme disk would require us to turn off multipath module
> parameter. In that way this parameter is very handy. My typical way of
> toggling this parameter is:
> 1. disable multipath
> # rmmod nvme
> # rmmod nvme_core
> # modprobe nvme_core multipath=0
> # modprobe nvme
>
> Now I could run all nvme blktests which require us disable multipath.
>
> 2. enable multipath:
> # rmmod nvme
> # rmmmod nvme_core
> # modprobe nvme_core multipath=1
> # modprobe nvme
>
> Now if we get away with multipath parameter then it means we have to re-compile kernel
> disabling CONFIG_NVME_MULTIPATH option and that's something we may want to avoid,
> if possible.
>
> Having said that I'm not against this patch however we certainly have users who would
> be using multipath parameter and taking away this parameter may break those user
> application.

Sounds like the user application is already broken. This like any 
modparam is not guaranteed
to stay, and we already have been warning users this is temporary and 
will be removed for years.

>   So I'm wondering why is it not possible for RedHat to let their customer
> know the fact that starting with RHEL-10, we don't support DMMP for NVMe device even
> though the multipath module parameter is present?

I get the testing argument, but I don't think its sufficient to keep 
exposing a user facing
modparam.

This discussion is not specific to RHEL, if there is a real use-case 
that we are interested in supporting,
we can change our minds and keep it (and simply remove the log msg), but 
I haven't heard any real
life use-cases thus far.

