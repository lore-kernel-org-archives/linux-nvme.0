Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4130C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 22:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D1+5qikX2ir52v5cFPQzviZWhv2cTy/FBndpbZSN3DM=; b=i8GGVKaTaEi066/VPZhF5wTfCj
	hRKObA+OWYEXr+GWagH60afNtWCY2yIEIkgFjVAxVAy5owgXh/lLWvB4NhJb1er0ZXFRyc5eu46ID
	T7+NkOMPz9aM/rZH49pkmdgKHPEpAREaLDVg+obCXvLRtHNPc1+lSQnBixdTUPFKFDHArp+GLwrMG
	xpyL0p7GyWjCXUUGZ6Nty4m7Y+PRQm0funDVxuJkc8BaNnWLoCZfeBuZpxWFTOJDiVlBygM5YxunK
	sUiOhbPETe4ms24rO7w/GiLiDnGp3xJQ6iGytvAPAVPUyL0z1N1ECRbo7ADhs5ce1nBGlydca6LIE
	MyFj47fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeUR-00ClA8-VS; Thu, 21 Jul 2022 22:17:52 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeUP-00Cl8m-EU
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 22:17:50 +0000
Received: by mail-wr1-f52.google.com with SMTP id bv24so4170519wrb.3
        for <linux-nvme@lists.infradead.org>; Thu, 21 Jul 2022 15:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D1+5qikX2ir52v5cFPQzviZWhv2cTy/FBndpbZSN3DM=;
        b=Qjs2ubBlJCqxVeCX9jx+F8NGgBJ4iPc+OOuyroFIdcR4bpb/nmqBJJth5KDlaaNBKB
         J1ni2FhD5yHk3uxZeGbhk4irgtiopmdSbmAOmTjyb91KZCt5E0AIHoXF4X1jDdVRyta4
         JiqhV7ZOxjvnsCSSZ6zMH19LPFVky1Dyoruw230JHnypGM14UBtlzHfQO0dGZz33jptd
         PFfM7G4JLfO+lwbBt9wPnYm43da0KstsIbBdVIGPoa++P61MBPMzB4B7xogfHx5W59Ou
         lpdNe1L1FuZnI0JAHHAcKByT5keQ/yS0DGMc0emkp1eH5qlqCP2JY43p38JWtFO6VyLB
         R+VQ==
X-Gm-Message-State: AJIora8DEQj3vwCGEKRJdsHU+Jm5HgcDTZUNXua9ZXQ9pCpAQQ1jYN7H
	mKkQAGyaK2Wq2qI1UOwSlHg=
X-Google-Smtp-Source: AGRyM1v7KKpUazUBLUueXhMVskCKDkitKzVnjPVRAfkyzzeMpIfo9GTQmF4mXvc7UdlPViqqxaQEhg==
X-Received: by 2002:a05:6000:1863:b0:21d:bdb8:5f64 with SMTP id d3-20020a056000186300b0021dbdb85f64mr348988wri.446.1658441868164;
        Thu, 21 Jul 2022 15:17:48 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id a8-20020adffb88000000b0021d73772c87sm2982672wrr.91.2022.07.21.15.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:17:47 -0700 (PDT)
Message-ID: <26e71950-4ec3-3847-2e48-4eb95f331db2@grimberg.me>
Date: Fri, 22 Jul 2022 01:17:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: enable generic interface (/dev/ngX) for unknown command sets v3
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Joel Granados <j.granados@samsung.com>,
 kbusch@kernel.org
Cc: joshi.k@samsung.com, linux-nvme@lists.infradead.org,
 gost.dev@samsung.com, k.jensen@samsung.com
References: <20220721060320.1704646-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220721060320.1704646-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_151749_510490_DA23B96D 
X-CRM114-Status: GOOD (  10.71  )
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


> Hi all,
> 
> this is a version of the patch from Joel rebased on a bunch of cleanups
> from me that I think make the layering a lot cleaner.  Let me know what
> everyone things.
> 
> Changes since v2:
>   - add a patch to fix a previous regression in handling of unsupported
>     ZNS configs

Woops, just noticed this one...

Still,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

