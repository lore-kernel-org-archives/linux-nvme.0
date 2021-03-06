Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5FEC433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 19:26:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA6464E0F
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 19:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA6464E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rPlPXeTExI9UgEe2z5eXor3COoJZEca+kcmiIqtYxh8=; b=GXOVFQ3yqOxQCYkyVgc1mOHt+
	f8kOd9WxHa5KH/H4ImwAFP4vQ5OJXL0HwvV8FJys4HaFlJD1iRuhhS9gNzhgX85ONvXix+nElot8d
	uiQWBicSIikcE3QmioM07urUMbjBF1zK1QSz8kjVKHhTf+1p87vuwP4mE83j7DI5RiRVU1TaYB40v
	YufBS51v71vTnTjbV2VnKIeNco+kaWd5XzYm5QlU2Q4iBzF4/OgHhPPe8yZmVq6YeP+djXRSXqtTQ
	Zfk/Da9Ip/SO468m1u5yuG/EPIl9SfLRMlkMCh81U0bEQ3TVYt+qRXoQQZeoKvaV/GMJFwJdBk/Q6
	bsDSfywKw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIcZ6-004OkI-Gx; Sat, 06 Mar 2021 19:26:16 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIcZ1-004Oif-RU
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 19:26:13 +0000
Received: by mail-pj1-x1035.google.com with SMTP id
 nh23-20020a17090b3657b02900c0d5e235a8so972904pjb.0
 for <linux-nvme@lists.infradead.org>; Sat, 06 Mar 2021 11:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=EkbGFzH2/VWLBUFV7zOsp5o1Zm73y/3SY23TVtZ6yuE=;
 b=d/NmnOVsnf8/z3W39ogeD3VwaH2isTClILKrevM2D01dVvfZehbVofyT53lRDYqJzq
 ng8d/gO/EOaaQBKF2WD9LO6fA5trsbFAthvWbm0HKhMTbesuLxZKxpE5dx3gCvW57rx7
 r35wrGdSNvGp/TwQ5NORAPC3j9V7hhYCJkwCOKM1aEIOLDapiphVWtLPtfGlKVyRq7H8
 /SdAnVtFoxAT5oOMQ+MdB7yoUTGt7PfszSsTmPUqLjCF8jxJ6kCww0gT18sr0MTRifoJ
 QfKo0OdWvQ5q852jWcngw59ECuC1ij6PWSFi5YPvvjiy98YyaxOJRb9aXngEbPIVFN/U
 5zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EkbGFzH2/VWLBUFV7zOsp5o1Zm73y/3SY23TVtZ6yuE=;
 b=j1Pku9wYdilRX66Qw3Naf/DYBNPDIkcV6DTT6a4xdM6+kUAowzMHaOwndTDAIXACqz
 mVT2cW0blyf+tMR/S1NF3VRtTjiXuDa6nCyIsW/bHtB6/vSpWdoZHNvjKbMWuLJm/GoR
 3TRUGVBIaxa6XMXHXs+XUSe7MvxelGjh6VqqHuSiqGvOl995dG1kpncOjfZB9sEjcY9Y
 puDMoD5Ss4UEnKZwh/DdPL+vo6KO2fM/nJk63Ywe0ytxM4+g3k7p0luz4DhPJME1sdmt
 wjjqMvaPRzibl2aF5jKrVLH+fLLIeK3N/t0vpgck9cjhaI2MFTY47B+0MuzDxxOKrEqE
 0iuA==
X-Gm-Message-State: AOAM531+SkM0ULyA/rLWs7vxr1PfJ2o31pmxmmtlYTT+d417b3BFEehV
 W1yCUeobGcDAtvWo6s0AZLWj/oqqv1g=
X-Google-Smtp-Source: ABdhPJykN4RqPdVuIVsFAB+vq8LgTMU2sxITIyBONTBy5QQa692e7avYDw1ovC6NmeFN9+ZDW8zd2Q==
X-Received: by 2002:a17:90a:b392:: with SMTP id
 e18mr16549220pjr.66.1615058770388; 
 Sat, 06 Mar 2021 11:26:10 -0800 (PST)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id s11sm6366959pfc.87.2021.03.06.11.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Mar 2021 11:26:10 -0800 (PST)
Subject: Re: [PATCH] nvmet-fc: simplify and fix nvmet_fc_alloc_hostport
To: amit.engel@dell.com, linux-nvme@lists.infradead.org,
 james.smart@broadcom.com
References: <20210304081215.21042-1-amit.engel@dell.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <f2144d4e-247a-34ed-c428-eee8194f2400@gmail.com>
Date: Sat, 6 Mar 2021 11:26:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304081215.21042-1-amit.engel@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_192612_109031_D08DCC91 
X-CRM114-Status: GOOD (  11.78  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/4/2021 12:12 AM, amit.engel@dell.com wrote:
> From: Amit Engel <amit.engel@dell.com>
> 
> Alloc newhost only if no host has been found in host_list
> Add a missing tgtport release reference
> 
> Signed-off-by: Amit Engel <amit.engel@dell.com>

I don't see a reason for this change...   The whole point of allocating 
first was to ensure you had memory if there was dynamic change of the 
host_list while waiting for memory to be alloc'd. Also not nice to be 
holding the lock while allocating.

It's very possible for there to be other requests for possibly the same 
remote port as well as other remote ports on the hostport as LS requests 
are receive and then posted as work items, allowing them to be run in 
parallel.

Is there a real issue to be resolved ?

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
