Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8B6C4363A
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 14:57:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12BA20708
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D35r217j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZP7L2UYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12BA20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IAB6Bg5KyrjnWoEC+WE1fWQ0flpc+0zgHarvZLiLq3Y=; b=D35r217jFsRq2ySYG7yrZHgMD
	uv6VKl1uAsXPRbb7CQ17Mt5iwD+fRzKf2BJXEl89px3zxqMXgUVdtP4L8nW8lk/vRjDWrK4EoqrFU
	49nBxAkHjU2QGfI4O+MIr4gEovlTr95kbD6ouQeE5YirhSRQyZQ1eB7c6ai2HusvFNkxt4anzGZTo
	gwg8pX+I29JinRdzA5PxnqQvJ37V/2JdeWxPpbDorqlSkscV4fHLSCWcQG+iSoCH6kUoGwr1i8r3T
	O9JCbL3/6/vOlYe0v4Eu4FSknjxYh+avjWaYTnFMnNjElCWAXc/fSah4U+2+HDordMqXjlk4UWhhk
	luhOToGVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQXMJ-0002v5-Tl; Thu, 08 Oct 2020 14:57:31 +0000
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQXMH-0002tq-Jb
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 14:57:30 +0000
Received: by mail-il1-x141.google.com with SMTP id o18so5971695ill.2
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WlXN8GZZvwGGopMxWEZM0u0z3USDzyayHMITdJDCfGk=;
 b=ZP7L2UYXtx7aixSt3DiKikqsTNSzMo3zbeosCxtEudHK8rqiwh8QWkbZaSy5dcBFhj
 w27F9MohU14oH0VCtsBgIlUTQ/uQdz7+WcYwxci7+r/uf7BrwkSCy06a/KPyxd8ffRPZ
 dIlwfOlM499CDNRpD/KQEB4Lib0tg/VTIbjjlWKM+O1/hOP2Hb/ezUPFtsea75GlAbdh
 t6HOYUUAM2jXPcS9U9F9eYnj5rK7Lv5CaTulOLx0UTTEpsvsH+P2qyxUFmqPIePALdZW
 9MPrAE3eCzYpsnJftuu20QCBJdJGjS9QR8UpUYRJHAXQK73w/vXsQoo575airyFnzJ17
 LJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WlXN8GZZvwGGopMxWEZM0u0z3USDzyayHMITdJDCfGk=;
 b=Fr2okaH3KgIjPhmiBWbsvWRMx4U2nOl2572/osKSUkEv8RiAQ40mFm0db2Gu3Tm18R
 vvdXVQwspO/CY8ENhbY5fSdkaUAVuiq5D8N4ceWvI8wSADL5oxrY389ENwwtXINmYRfw
 M23FRgkp2qhJDYmprUApLpU6RBo17NDeQz7F5QoarrWQP8BSWliOewaY1fYe71qj8bAq
 COCbuGrWAmpnfINgMDiatCvrM8xkSMw9wbJp2mB8iGykrIEHRXzccBU6uI9pc67CA/OR
 Gt7qMOL3S8vlr/a0nlj9z2ArLkJnnxo6jJO/UnrvYbMek1JA7ZXGf87Z2+hNKC2a/qjs
 8Oug==
X-Gm-Message-State: AOAM533zlQspMV2e3RYarfqM8zDN8NTdGr2/j1ljhaWe+C73ZMf4ZEhA
 KYhLBiYtUmLuSC7+AAW4nCtURzut481iOg==
X-Google-Smtp-Source: ABdhPJzZZ+V9efisgmMyAO3oDI+WBPt0+snsianMHoV0AyqRCDmP/vePGjFA5vRhXqN9n5Px5XYwqg==
X-Received: by 2002:a92:3501:: with SMTP id c1mr7256723ila.146.1602169047657; 
 Thu, 08 Oct 2020 07:57:27 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id d6sm2711297ilf.19.2020.10.08.07.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 07:57:27 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.10
To: Christoph Hellwig <hch@infradead.org>
References: <20201008141041.GA1493538@infradead.org>
 <2b4ad1d6-3d77-d14e-2275-0f9326b19514@kernel.dk>
 <20201008145614.GA23622@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6c77e5f5-0316-9893-1c8a-8fe25bbbb506@kernel.dk>
Date: Thu, 8 Oct 2020 08:57:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008145614.GA23622@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_105729_644712_0DC4CCAD 
X-CRM114-Status: GOOD (  17.46  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/8/20 8:56 AM, Christoph Hellwig wrote:
> On Thu, Oct 08, 2020 at 08:52:50AM -0600, Jens Axboe wrote:
>> On 10/8/20 8:10 AM, Christoph Hellwig wrote:
>>> The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:
>>>
>>>   scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08
>>>
>>> for you to fetch changes up to c4485252cf36ae62c8bf12c4aede72345cad0d2b:
>>>
>>>   nvme-core: remove extra condition for vwc (2020-10-07 07:56:20 +0200)
>>>
>>> ----------------------------------------------------------------
>>> nvme update for 5.8:
>>>
>>>  - fix a controller refcount leak on init failure (Chaitanya Kulkarni)
>>>  - misc cleanups (Chaitanya Kulkarni)
>>>  - major refactoring of the scanning code (me)
>>
>> Seems to be a typo here, 5.8?
> 
> should be 5.10 of course.
> 
> Do you want a resend as this is also in the tag?

Yeah I think that'd be best, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
