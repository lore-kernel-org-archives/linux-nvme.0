Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61758C4742C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:44:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E612224F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NO6OWnLz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gr4rBDYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E612224F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IlNHc55ZwsVJ11Tmt+tthjUtKq9uYyvxR/Pqyp6Mmmc=; b=NO6OWnLzxlhEzfN8S9WCA645d
	zXWkL8KI0mkf1llU+D0x9uei0IrF9AQelA2hLGm5i8TLUQsOljSpOdftxryKtsCxXxDYzp1+bq3Tv
	z25ghthrozWXMm4NEnz73ozz6hgsVz3WtSRp1hkJiLetd5DsiwIyrgNuaC7xY3r0V6qm2pWDG3VSF
	6f3MfSWpRGXu0ao+6uEBivJS6EprXaQWTKSj6HjH02C9d6g4VBrbM9tvGeXRFKgNKbkEzOVCeCtTj
	3kvbZvEOh5bsfu9VrufuRJIoBV2nG1YqMpphjsdjqXjt6VyzHJ/mNm8M7+RfDHIo699JvRNMVA409
	fTfrClwcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdgrp-0006Ah-CI; Fri, 13 Nov 2020 21:44:25 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdgrm-00069v-66
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 21:44:23 +0000
Received: by mail-pg1-x542.google.com with SMTP id f18so8149478pgi.8
 for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2020 13:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jBsaCjpf4fscNVFcDQCUrtRqqAxNkOKkyOP/x0Yudbc=;
 b=Gr4rBDYmhAURHlZdqniWVzqgh0UPjNiLW5C7SZjZo6+m3uzG+myWFHJpukpFg1hZGC
 DBkt8YetnAu+1tlaW8pONEoyptygCmDHHeVcTmvuSXrG1x4GM5XEn1+KXtNDO97Erp7v
 lEAfkw91U9TIceWHaRlW3v34f+6VCYbZiv6f7N/5xa7ZSGfVidyR0Pe2zOcxkIUOxkGp
 yi6Xs18gY6D9XAcMEUKilBgjkfxljkAHUTDrFsRIzMlqWalwJin6OgKQbED41DTnQ1xX
 zjlLu6y2PtnP4QWpF9XtCmNYTJE2xHINHxT8ilUlMg+J8JPUQaWxf9EFpMRHBKz9HmUz
 gEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jBsaCjpf4fscNVFcDQCUrtRqqAxNkOKkyOP/x0Yudbc=;
 b=E4qifVnTT+lZh4ghtYzzve4u7DNszPM6jJJD6IASPtcQQ+bc7qykYzPBFc/SfY2qsa
 nLltXfa7NLr6n3wJJ3WbD+GYVsmdfxp+2BaVlR+XuHFQfp4MBGoVyswQvMhXy0DxNgYy
 Q4xBbUHmrof14Exu3BwpCzRS3k2u1bratRYOJUGKBz45RcJK2thmaSx3563YNiWfkS5V
 wLCqKshvVUg08Irm19dTNGWGbFpJ9z2VM4XQMoAR4f0YUmWcCreq5aRDVkdpFyx+kP8t
 gpDj170RGGFHIx0fYsB85+odxmwM1x9sAOgbx+M2u5lZqFDLawJS6sj7xecqWN83qGrc
 +o2g==
X-Gm-Message-State: AOAM53165peoHy4i8yjp2U2FvY7F5DR2Fdu46/v5W1MEBoKDQe6ro7B3
 T3+RX0iCOdGY7DUYHbzC5JAFiw==
X-Google-Smtp-Source: ABdhPJzCyynwsxcziuAqEG55g3gd7FIeqfF7PAuUNlkzvPcZ1Wg+ErlM+sNy+2DMiwCJ9g1Hh4W94Q==
X-Received: by 2002:aa7:959d:0:b029:18b:5b6a:2553 with SMTP id
 z29-20020aa7959d0000b029018b5b6a2553mr3649463pfj.47.1605303860256; 
 Fri, 13 Nov 2020 13:44:20 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id i29sm9621029pgb.10.2020.11.13.13.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 13:44:19 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To: Sagi Grimberg <sagi@grimberg.me>, Rachit Agarwal <rach4x0r@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
 <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
 <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <26a1cd20-6b25-eaa6-7ab6-ba7f5afaf6dd@kernel.dk>
Date: Fri, 13 Nov 2020 14:44:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_164422_309743_76ABB890 
X-CRM114-Status: GOOD (  19.50  )
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
Cc: Qizhe Cai <qc228@cornell.edu>, Rachit Agarwal <ragarwal@cornell.edu>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Midhul Vuppalapati <mvv25@cornell.edu>,
 Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
 Rachit Agarwal <ragarwal@cs.cornell.edu>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@lightbitslabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/13/20 2:36 PM, Sagi Grimberg wrote:
> 
>>> But if you think this has a better home, I'm assuming that the guys
>>> will be open to that.
>>
>> Also see the reply from Ming. It's a balancing act - don't want to add
>> extra overhead to the core, but also don't want to carry an extra
>> scheduler if the main change is really just variable dispatch batching.
>> And since we already have a notion of that, seems worthwhile to explore
>> that venue.
> 
> I agree,
> 
> The main difference is that this balancing is not driven from device
> resource pressure, but rather from an assumption of device specific
> optimization (and also with a specific optimization target), hence a
> scheduler a user would need to opt-in seemed like a good compromise.
> 
> But maybe Ming has some good ideas on a different way to add it..

So here's another case - virtualized nvme. The commit overhead is
suitably large there that performance suffers quite a bit, similarly to
your remote storage case. If we had suitable logic in the core, then we
could easily propagate this knowledge when setting up the queue. Then it
could happen automatically, without needing a configuration to switch to
a specific scheduler.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
