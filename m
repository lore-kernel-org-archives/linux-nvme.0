Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B7EC54E67
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=67ophD0ceAVc0eL2UPEw+cBF8mLQk9godscjrIx1b98=; b=h9r5BQS6JGm5BBnb6Ocj+mIPex
	HC3/rlk6fed9Ha8PbDldnFOBi6O/7wmZktS6tyvXyGQfNY9zhfks+cipeHeJkOJfYtGHkhjr2RBqS
	rJR2LyTfwGWwabIRl4/U5mKcK/bwzZxcijKkE8wvb638LUP4CkLcjgl6gLPAj8gHHZD/iOiDtyfwm
	MUBY1W3E/lT1qmjjml07yLUPRp9f84WeAJvt4+8i7QPaw65selefn9phgIuyPHvTfFKW2JD8ymcnw
	2kIl6KapGMxn1ySQucPJFq66b80jkcYEdCpCg5O4dIYJg2g85I7MKQ8R3SQYY0cvUGP0CC2Li3OVO
	z8DdxWyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8Dl-000000051V4-2Aj8;
	Tue, 26 Mar 2024 14:56:13 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8Di-000000051UM-1KMi
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 14:56:11 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1dee5daa236so42043595ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711464969; x=1712069769; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67ophD0ceAVc0eL2UPEw+cBF8mLQk9godscjrIx1b98=;
        b=RoWARB8wSqJ+hpYaEhufX5Gl2DbMyMOrTdmbMTGZJj8PhA8kElaRz+7B++NYn667EH
         Ve/+5qO6m6kGlO81wUaluwduwzYWm+pacxP06//M+b42Swy0Xb7Kv7UjFZw6ftXP1O3u
         pyFW5OQr3zYLQyEhSNFoQakEpGim4f8m81Pksmv34VNf/2ky11Qw1hvxTMWKErw4csh2
         8YhK2+sw622UqBrqTOgcAZgGT1NtBpg6PKcI6dPSTWIESALTBcjZqr0RVixMc8C/pH++
         mFJkPm4pvUIxPn2X+5BSlFRC70V6E0dbKBp+lyOkH51hcb0zEGUeIi6afSw/1BMM7C4a
         U/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464969; x=1712069769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67ophD0ceAVc0eL2UPEw+cBF8mLQk9godscjrIx1b98=;
        b=Ap50T6Ht2m59wq0QejKeDr6RuB7WYhbFyZkN548XlgAo/2yNRnWZJ4s93sh76onwSk
         5qRyglBiKkBSzOmrcGmYwJDgnUuT3OyoHVSkv7HUmLj5b2MSVirz4TCplEsJVoZRsf9M
         PrimEmf8YqZ/2SWzj43a+FpZ/ngNPub2ARTMi49U5uB7g4IU0ObvxX1+tmZly4/vAISw
         u1GCN482ZiBYDrzlG/rfJoq2tGFmOtulpGOqkJv/HshrVDo1eMl76+ckh6h2sZ+5j/qQ
         xaj8FoE23w2fHjT2Cj1h2dfvKgjQ1C8wWgClx4RTCwAC5d+/pf5pG0nQ58qAslJL+S8o
         Vhdg==
X-Forwarded-Encrypted: i=1; AJvYcCUikU2ftDjiJiKDrImHrO6hkpF0wU8lVN5wzBG5nvroIg72l93P2q70izTr5jzenb3uxXfleQSnCxiu7O6kL7tGGIOYwHOI3cKcHCJM1WM=
X-Gm-Message-State: AOJu0YyQ400Q5FsYPpllcnfR00XSbFBLu03z3SZm0hrmh1S+PonKRZow
	yPs/v7KtG4FqgG8QaLB+5j5l4X70z6LafBSSlKcLinXU41ZEfAC/PmFxchzJ
X-Google-Smtp-Source: AGHT+IHsK4npJG0Hoftbc4RyoInA/Pd1pLWq+tEO9FJ0x32NvOLnNf9p8dHno9uEytKyd8jewSGlWg==
X-Received: by 2002:a17:903:13c8:b0:1e0:bc33:d with SMTP id kd8-20020a17090313c800b001e0bc33000dmr8128562plb.31.1711464968900;
        Tue, 26 Mar 2024 07:56:08 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:ad8c:fe86:c9db:d9cb? ([240b:10:2720:5500:ad8c:fe86:c9db:d9cb])
        by smtp.gmail.com with ESMTPSA id c3-20020a633503000000b005dc36761ad1sm7720764pga.33.2024.03.26.07.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:56:08 -0700 (PDT)
Message-ID: <cf2d212a-49bb-43e6-8ab5-e46e18626a43@gmail.com>
Date: Tue, 26 Mar 2024 23:56:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: initialize identify ns data to NULL
To: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <CGME20240325154544epcas5p4acf7f376241637872a433314489586fa@epcas5p4.samsung.com>
 <20240325154503.11510-1-ikegami.t@gmail.com>
 <dee7f8a3-34af-e12c-ac7d-721960fc0744@samsung.com>
 <a92a1493-29ae-4f89-b17b-54d03ec0becc@gmail.com>
 <3efcf01d-e83a-e5ad-d335-7516b857eef0@samsung.com>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <3efcf01d-e83a-e5ad-d335-7516b857eef0@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_075610_395260_B4D944F7 
X-CRM114-Status: UNSURE (   8.18  )
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

Thanks for your comments. Understood them so let me abandon the patch. 
By the way I thought also the nvme functions allocating memory handling 
is not unified for example the nvme_identify_ns_nvm(), etc. about this I 
will do consider more. (The nvm version function caller seems still have 
a similar issue.)

On 2024/03/26 23:02, Kanchan Joshi wrote:
> Not a compelling case of future convenience, IMHO.
>
> In the current scheme of things, the assignment to NULL in all the
> callers of nvme_identify_ns (there are few more than what this patch
> covered) is redundant.

