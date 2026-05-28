Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F14CD4F54
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 21:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RLQSByfIHrlmu4ZNGYVAnyzAj/lZvc3hvm3PC2InVrE=; b=1HYP2eLzxGBaaxOPET2P0+Lul7
	TYVDY4L3EeVwc58tyQk42qrRKVY5RiTkyXDG1gKVhWWnUwlSsVTk2uXVovqJMVpexWuFEBthab2aw
	HrHm35lJcfo1yIAqRKwCu9yqQ0ycue8xv3T88J+Hw958h3D42kgC4Sll95zug5CUpkgC8h77hEGJB
	Ff9/BgKNMILQVtAmV5KPcA7uuCIW61clt2HKPOwHp4Ak3oU0iCC/ipoJf5823pPEyJs9+2ENGwOU7
	FecZ8XEP69EaPugRWdg5hMEToFUKaib91HLXC6Yv9rW0J20HNlzZ9LjSocYG+unNbk81iiCiIt4XO
	PteY8AxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSiXT-00000006Q1L-3jj9;
	Thu, 28 May 2026 21:45:15 +0000
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSiXS-00000006Q0u-1Db4
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 21:45:15 +0000
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-43acb9730f4so8427880fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 28 May 2026 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780004713; x=1780609513; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLQSByfIHrlmu4ZNGYVAnyzAj/lZvc3hvm3PC2InVrE=;
        b=TdVJjX11uIrH4aN1YBFQ7012GY8yX6/4kx54/3p7CL64DrltnRVaBUnfp+duEodGc1
         QC9mi8rAVL+cH7+U4U9gbvwRUGG8iyiyC20iwxKDr/m8gKIvATRC7hpSC6RwvhAlQnN/
         P6xhCyDiRYgYKxa1rVg/7ty/sSbo45HgOBV4/EqrwZqcD7c7RWJPUg4uOrJrC4u9msVR
         v085nbID/ui+ltuZN+epwy9CnQZluySp5+J8Ly6QmhAiZ93qLNv+m4ih9BSgrbr5Qkfl
         H4JldR9p23r0btT5j2P2ib8DuU7VgAH7ALGJaUkMOaBoj3g7rLTbemxNld1aPAQhj3X8
         dewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780004713; x=1780609513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLQSByfIHrlmu4ZNGYVAnyzAj/lZvc3hvm3PC2InVrE=;
        b=JbvNYVY2greN++hKwSNJek1A8Y0VQ7HDcG7zLVh/pCWQFdYeY68ZOQnk67iWVaGwjr
         +RIz1nEeiq1oMzug3WE/PVWQ3FRV71FfDdNUHIjWiTgzqxna92n8OG7K8vXh/mc3uFSr
         mYSvmanIEW360V9WZ4R7WBkUZJ92BH1/AmeNTBb32fzqqdARu5neMDV0yLO5i0kPf5m0
         Iey5YmIBjaQ0gLmpbrIIgicTZmQKZ7NKo6A5xhp/TAcekiH0Rru+dqqxU/MKQQKNddm8
         iXtjRfN5ThnWsXhrF/cQ7LUVo+G3gyu50Id8DLfPbMPjhWDI/RsPSJlZzY1JDTKOZ9WU
         aQ7A==
X-Gm-Message-State: AOJu0YyGSjsRiPTouuiMl7Q32Swk8Te+rZQswQYyL6MJeg4zw5oCNeCc
	j/ppNBlYajsl6yp0bz3MJHrep1a3XNdFwkgriTX/O3aokwdynDWEeSNqG2FKuQ==
X-Gm-Gg: Acq92OFbSaR8MIhHI1RXO8C5usFOkNDqdW61atNfl3UVQ4zzRj6g6wsEGCWx7FlcSih
	5FhzuB3Rn3GrIQPnScl/33jM4aMsXAxEVs8bAHCxRCbfoHLLZKK0wK2GymiN1y2FqbmJam4toOE
	f16lgx9Ee6Pf4KKp14PcAQRoWxvOur2ag2NAXIeWD9NagKpKYwMbnlr0OPsUKiZ5l6NQhvxJEs1
	6590x9GSp4Jegr7whzZt3VVMj9+mtZ/ATgGR5mAbuQS1p5DG2i6IoMx5JU1MDTvjWrrsqS2npdB
	17iP+x/BR/9TPFgsbgka+3oaURayoaBUOqBYxguAx5UH13xbfua3fNkIsrFrPef4XIhiqLrL7yW
	wY+ufIv/KT5tlG1DkqhrST0EovDhTUS/1+6VwErs5TWBlMhXOVJ6fQs4EdTiri0IJpJ+0ctXj4x
	C/GRDCL5QbIKzNQznFwrbhsv0/ULi3VvqQmH+qQvsw7FDz2XiM4lMtAhKLHrZUltgd/5XztM+oS
	wwcyoc0ihYChShLP6f9mzM=
X-Received: by 2002:a05:6870:b60e:b0:422:ff63:9a6 with SMTP id 586e51a60fabf-43c8633fd01mr355445fac.34.1780004712807;
        Thu, 28 May 2026 14:45:12 -0700 (PDT)
Received: from ?IPV6:2605:a601:aab9:5000:242b:bfa1:6aa7:4d01? ([2605:a601:aab9:5000:242b:bfa1:6aa7:4d01])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c896b8558sm146362fac.16.2026.05.28.14.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 14:45:12 -0700 (PDT)
Message-ID: <236bf316-edf2-4273-9dea-8b82235b9d22@gmail.com>
Date: Thu, 28 May 2026 16:45:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbft: use the correct interfaces for NBFT connections
To: linux-nvme@lists.infradead.org, Daniel Wagner <wagi@kernel.org>
Cc: stuart.hayes@dell.com
References: <20260507202345.277280-1-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20260507202345.277280-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_144514_336371_D4D2FE90 
X-CRM114-Status: GOOD (  13.15  )
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

On 5/7/2026 3:23 PM, Stuart Hayes wrote:
> The NBFT specifies which network interface should be used to connect to
> each namespace (using the HFI descriptor), but that is currently ignored
> when "nvme connect-all --nbft" is used. If there are namespaces on
> different interfaces, some namespaces can fail to connect, unless the IP
> tables were already set up to route these in the desired way when the
> interface isn't specified.
> 
> Add a bit of logic to look at the HFI descriptors in the NBFT and find the
> network interface to use when connecting each namespace.
> 
> Signed-off-by: Stuart Hayes<stuart.w.hayes@gmail.com>

Should I submit this as a PR, rather than sending the patch to this list?

Thanks!




