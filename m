Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3AEC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 04:35:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E7822C9F
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 04:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E7822C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NVgt3eI+jlqjddg3DQkD3HohqqXGh1C46Ek+vGQZLP8=; b=FZLAVd8SSWEmy4emXMn5p9yyW
	aHQEcJ61dMgePOQdSWHvUek45x1e+kioSuVw6WjIR3X/rNuU5HOYXvixvbgbQHx9lAUwbop4HTmz4
	yPC7hkrTHe+Kvee12K+foiqLdAveQ4Hv1/W31s1WTclOR09Zv+9hf/ij8flEILk9E+LfEqBIuhD+n
	hlVyzqdAv96GN6Dt8MtWY7NrkfIPuN1fdVevX4tnug06W83hJyvzgaxyq3Y+m5LL3NaNrelcJy9ep
	YJGF08uEqH3McrZSrqQCSuDMtyvzBmsDfXKV+4JjNW4iRWhfj+D7hY/Ig34xC4tpt7qff0XMx2OPK
	GnsdqGF8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l3taw-0002Zu-O3; Mon, 25 Jan 2021 04:35:18 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l3tau-0002Yu-9U
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 04:35:16 +0000
Received: by mail-pl1-x633.google.com with SMTP id r4so6804906pls.11
 for <linux-nvme@lists.infradead.org>; Sun, 24 Jan 2021 20:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RF+U31mjU+vQtmYKwQP7k4EqO/12hyWNFfFTp846sxc=;
 b=CfOwQ7limljMA7zl/lIAXVsTIKtNDlhwsicqotNl3TtlKhEjyZeIlEEJtHYW4c2U31
 UY4hC8hbmTVMaTURi/h7AUevTqeIqn+Q1FFnUUJ35BV9ke4apIRUY5I8NbeB8KXYicfU
 +trWj06hwAqSeMB9yfxG8wvJYR9/caMYTWeGkZl5KTSBZfynGCBz84SyjX0hbk7AWcGA
 /222IeHt9HOYYROpDQ0wb25k1uTdAAL1nhrslb3U6So17SP9tJY8mfEDx1CUbEE7qC63
 qpRcjNyJveRtr7uQu1UM1fJCkiAbkBaCmTSnXoAaT+i+isB4hYXJxGmrbyMs7d8MUbF7
 BPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RF+U31mjU+vQtmYKwQP7k4EqO/12hyWNFfFTp846sxc=;
 b=SjNZhtHpulC5Q48uWRfadPZc3o+kvwFGctrC8rwmMTAbcw2OyDZiX5bUfT9jBCCMGO
 CsY7CGBt0ej/EnQxHrbzqEiciO/44xWJ7vufvSD1+NDrXWKmP2+9HtRW2u+oYjtU4ROs
 w+5LxUipRHSXhZi6N9uJDfPW1AyurAh6Tmn2HYyFfkmmB+Z6a+EvWFSFARjbrrTvtX1J
 hxlzihcOYmkrwhBp6ZeGzcDG7F4py5ycQ3xY5kyBCImJJoxElyQUeu98+m4HSnZ21hgF
 qOtytF2CcrLdfrlttRO7+53GqHMDZJu4vIkZiL1meM0f3kVSgvY1zqM04XfI8ms1oKi9
 A7YQ==
X-Gm-Message-State: AOAM533nMI3un4KjqLNXs6u5bXxgH5uTg0XO1aJ1TBHVacuT9ZaPj4Fm
 is2iP/SNGDFCOUColqkCrPvr9Q==
X-Google-Smtp-Source: ABdhPJwcVIfcZhKpz36wBWgY9pEAr1Osy03vWby4EQev/6n4B5mRbyHylHT/8WSUq/UooHKSU12Q8g==
X-Received: by 2002:a17:90a:1c09:: with SMTP id
 s9mr6518112pjs.83.1611549310994; 
 Sun, 24 Jan 2021 20:35:10 -0800 (PST)
Received: from [10.8.2.15] ([185.125.207.232])
 by smtp.gmail.com with ESMTPSA id x21sm15191515pgi.75.2021.01.24.20.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Jan 2021 20:35:10 -0800 (PST)
Subject: Re: [PATCH V2 0/2] remove unused argument from blk_execute_rq_nowait
 and blk_execute_rq
To: Jens Axboe <axboe@kernel.dk>
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
 <683e16be-1146-e60c-cfea-e4606844f080@kernel.dk>
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <73fd70be-90bc-9c6c-dcbe-7981f8fef4f5@cloud.ionos.com>
Date: Mon, 25 Jan 2021 05:34:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <683e16be-1146-e60c-cfea-e4606844f080@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210124_233516_363355_7F85EFB4 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: hch@infradead.org, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, target-devel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 1/25/21 02:24, Jens Axboe wrote:
> On 1/22/21 2:28 AM, Guoqing Jiang wrote:
>> V2 changes:
>> 1. update commit header per Christoph's comment.
>>
>> Hi Jens,
>>
>> This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
>> Also update the comment for blk_execute_rq_nowait.
> 
> What's this against? The lightnvm patch doesn't apply.
> 

Sorry for that, will resend against for-5.12/block.

Thanks,
Guoqing

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
