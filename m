Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6020EC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:38:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AFE64F4F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AFE64F4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s7xTOThw97O+tCeF09WEvKkD59SycLJeyl/xYoJjCH4=; b=q1vmY8JpSuNSeaYxBy06oA82X
	UveNVyVGFLKkYBw+pkL9bk3G3P9o5ihnkbA+d2olwyI7igAFeyKfhu2teaFHBovjFDkpTXDRnKzox
	GdzNC2WaPUajrGpuWH+h/Dyj3e97qzNgD+fzCb0vBeAQ+GTTedo48lJI14Bh7bL75E3NVDrEGg35N
	7hwJLG95Rm5JC4LXUqqMW9n3pX4+eRBBZ+HOG+ct93/HZovalnAolNLSTJHY2r5jjG1s9+A+MO8S7
	1v/sPGXMNtRb9U1Jh7BLVJ34sPl2up20hlBasnaDiXpSuoz1+XiGhr1eVfa9e/JxcmJSfOW9pxaE8
	L0ptVioPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKoXy-00CLyF-FO; Fri, 12 Mar 2021 20:38:15 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKoKc-00CLAX-HM
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 20:24:45 +0000
Received: by mail-pg1-x52e.google.com with SMTP id o38so16585765pgm.9
 for <linux-nvme@lists.infradead.org>; Fri, 12 Mar 2021 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0rrz1OkFnDG76ppSWsMYGxkmvRNkriiw8EQXDC7K90U=;
 b=MjDYsUyPBGgpS+I0/bYEa8L6Sr9ip/qfqAO6wyPehjrfrnloMnpvPMy5fu5uCOp4rd
 lPZi+Hf/AUIFiAQ8E1cTtKFFjyKae9Sm2sXbO/YO0wgDpGaejP3KXzzHEhp/1pwd3lvI
 LKoN3w36Qu90GVRSStMfAB350F54Yvcfiu9vYohzxAWM7SOKpj/7Qq08eeBNZXp74+SF
 bN4N99A4YkqyQMYuJZW3RSCC3dxS5pUz8VCxgHdjt2oWVvDFCH+LxYLmiEps5Ep23ebs
 Fq1w3F7f5YF+RsG/46VXL7CtLBXNx35lvlkufDhei2MXbeV8WuBCnfbtc1SWXyiE1YY0
 RyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0rrz1OkFnDG76ppSWsMYGxkmvRNkriiw8EQXDC7K90U=;
 b=Ng1MiSYjH5FGhL1TLC8XiqAxwq1HFJgX8y0IsqspYiS05BGwa/O3va7cffkFPszYrL
 mjugQpB8CmPXKlulBLZum1QeRnYTX1Va8NAQw/l0oRI0WxgNd1ZBkEUTBCjY8pzdkftp
 Cq8faaQDts3ll4wHc+Ag6C130ZmN3sXre01Gzp+icK3/shkOzgfthHZBIIboyyqX5yiO
 mSk0IZ7WVB9DePl0zboLomWganaqnTgBVFlzSURkMznoL9qv26ednMeUp5PCBomRdUR1
 CBirmRQKEFkYLjN7FHJR2yuZWzV+fhnIDWjbEyJoNJthoLafi2YuII4d6fnu1nPKZ9Lj
 Hikw==
X-Gm-Message-State: AOAM532s/8iqhHcsmhtKOhKIp+sxkow2zJXt6E1OuWRik1YRli1ieuRN
 mAjp3VQPkmANBxXn5A3hJGufLW9U9q5sPyB3
X-Google-Smtp-Source: ABdhPJzdBAPae1dbHiJvNI/uxj63FFKd5pwOULA/kRE+ix1Jl1gjRIngIMQDQWaxqliEoCi0tzEViw==
X-Received: by 2002:a63:e808:: with SMTP id s8mr13357517pgh.101.1615580660920; 
 Fri, 12 Mar 2021 12:24:20 -0800 (PST)
Received: from ?IPv6:2600:380:b46b:1540:2a49:5dda:db8:a2f8?
 ([2600:380:b46b:1540:2a49:5dda:db8:a2f8])
 by smtp.gmail.com with ESMTPSA id y4sm6234523pfn.67.2021.03.12.12.24.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Mar 2021 12:24:20 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YEszeMEAQyfTPgHH@infradead.org>
 <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
 <20210312195932.GA2766489@infradead.org>
 <7d7e0f1d-649f-e977-f65a-e0a6ae69d327@kernel.dk>
 <20210312202033.GA2778279@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <de1fcc6c-1e8e-e7c9-d04c-2128c2506f59@kernel.dk>
Date: Fri, 12 Mar 2021 13:24:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312202033.GA2778279@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_202443_456642_8AB4736F 
X-CRM114-Status: GOOD (  15.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/12/21 1:20 PM, Christoph Hellwig wrote:
> On Fri, Mar 12, 2021 at 01:01:18PM -0700, Jens Axboe wrote:
>> On 3/12/21 12:59 PM, Christoph Hellwig wrote:
>>> On Fri, Mar 12, 2021 at 07:21:39AM -0700, Jens Axboe wrote:
>>>> On 3/12/21 2:25 AM, Christoph Hellwig wrote:
>>>>> The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:
>>>>>
>>>>>   block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12
>>>>
>>>> Pulled, thanks.
>>>
>>> I just sent you another one liner fixup on top of this directly.
>>
>> Where? I didn't receive any.
> 
> "[PATCH] nvme: fix the nsid value to print in nvme_validate_or_alloc_ns"
> 
> I just noticed it went into your facebook address as I copied and pasted
> from MAINTAINERS..

Yeah, that's why I didn't notice... In any case, I queued it up now.
Turns out I botched the pull request I had already sent out anyway,
so doing a v2 with that included.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
