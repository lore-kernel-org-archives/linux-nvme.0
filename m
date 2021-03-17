Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2515EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 19:00:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7241264F53
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 19:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7241264F53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wgu1b0Rnko4/EFG/KKFr2lzfzRBkyuKRh1KXTOeNnpE=; b=TmZ1krmSQXvdMC58ojuNxi8wb
	0K0o/hoPxKh+dZ/TLnC5lvUX/SCFXW70e96Eb52oW4SP+cQtrilUEnPY0IWVsg5Im7adHrtTV8vDP
	KYXpRsXXcghMoYqbrvBauKHisUTy6L+FVSegJY1JdjhcID1JGHTx6wHwupfGm06xvSDp3hU2lHF00
	MT9K3OjrNGP70fu9FDJmDs79ZX7s0siHIBPx8Kv1HrKe0xwQUKMvgADI2sotGHS2orP056+T8u3lx
	oqXdaXuedWeTM/FI6sZATeDCjj1sFmF6m9oxz8Oz4AGizOA8qi4gp1QeVFQX5pVqoCBvQHa44d4Rh
	diieKWLgQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMbOs-003mSE-2u; Wed, 17 Mar 2021 19:00:10 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMbOn-003mQI-1S
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 19:00:07 +0000
Received: by mail-il1-x12c.google.com with SMTP id m6so2541300ilh.6
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=24epm+HLwoWEEH5mLWqlHEJ7HnczD4429RGvWkKWVyk=;
 b=Ybh7rru3SgKj/NlvUpPhRNJuVh3sqSr08l9YAuKoT4GsSdX3Uy3x0yhH+z4YTqvZ94
 lt0WDS4plq0fzWSQlpkMRx6VHeLGpMv5raM0ObfugRRpKahUTlAljN9mWy4HwVRMnD69
 7lSMtq63k7OyWbhGyjnb0C0wh4UxlHIytQbmYk0bIfbC8URDrgSyEF6Lq+s1J8HFtcjZ
 SUU0RwEXeNun0BrRHcleU266YUuiS+f1NruLe6vJ1PrZaNFaBR576qMqPhtlY+f3g0g0
 Ph8ldT0rJaGBoq0RZnSCiesgm50SjheFfy2rUfsXOlC93TqGH4Xq8jTGYT0yVb/2GQ2n
 IFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=24epm+HLwoWEEH5mLWqlHEJ7HnczD4429RGvWkKWVyk=;
 b=CDoYXjgR5/dWzjFbdQPZsYEz/PZSVBVBMmzl0HKx+3Eg/nPC8Wz9ktw31Lou8UsGVc
 ZgHZceIj8U/HWhfIS59TrnKc+yy+JifwoE5o8HOL/RPnvMKNonncU0yeNrSWl9iLyhFk
 TWpOaCtakjy6vvPxqbfkk8/RwoLyju2c+8bIyO0HDE+NZPZAyWitrsGkbEb4dXsBVNMk
 Rqm+GEVLKrLhKxmEUWABzJACyLsvPuEz1Fp/RzdzL14/ljygHvsO/dLAA3ljdES78ELk
 R10bTN7cmR1MXF7XuJLTkZAvoAf+neMgdSWAAfTpsbM4HBBxn+RuSzX1tgvUk03zl1S0
 v65Q==
X-Gm-Message-State: AOAM5337WUcsMbBMYftl8q2icii57zD3L6DXeblNZ34laR0OQ+28uQRo
 BH8o4IbEIBADDxppUDb88ZBm5A==
X-Google-Smtp-Source: ABdhPJyaMfuu7Q/FfalIzvc9n1/4D+00TyuDpDLhuUZvfSBAnK8XP1a3xlNZgyi6Z7BtuiyndZjUcw==
X-Received: by 2002:a05:6e02:190a:: with SMTP id
 w10mr2732777ilu.39.1616007600092; 
 Wed, 17 Mar 2021 12:00:00 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id v17sm10623728ios.46.2021.03.17.11.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 11:59:59 -0700 (PDT)
Subject: Re: [RFC PATCH v3 3/3] nvme: wire up support for async passthrough
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
 chaitanya.kulkarni@wdc.com, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
 javier.gonz@samsung.com, nj.shetty@samsung.com, selvakuma.s1@samsung.com
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140240epcas5p3e71bfe2afecd728c5af60056f21cc9b7@epcas5p3.samsung.com>
 <20210316140126.24900-4-joshi.k@samsung.com> <20210317085258.GA19580@lst.de>
 <149d2bc7-ec80-2e51-7db1-15765f35a27f@kernel.dk>
 <20210317165959.GA25097@lst.de>
 <3b383e8e-b248-b8c4-2eea-6f5708845604@kernel.dk>
Message-ID: <acf7cbd4-3db1-2c53-2ba4-67a396f39053@kernel.dk>
Date: Wed, 17 Mar 2021 12:59:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3b383e8e-b248-b8c4-2eea-6f5708845604@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_190005_298797_F28D02AD 
X-CRM114-Status: GOOD (  25.76  )
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

On 3/17/21 11:21 AM, Jens Axboe wrote:
> On 3/17/21 10:59 AM, Christoph Hellwig wrote:
>> On Wed, Mar 17, 2021 at 10:49:28AM -0600, Jens Axboe wrote:
>>> I will post it soon, only reason I haven't reposted is that I'm not that
>>> happy with how the sqe split is done (and that it's done in the first
>>> place). But I'll probably just post the current version for comments,
>>> and hopefully we can get it to where it needs to be soon.
>>
>> Yes, I don't like that at all either.  I almost wonder if we should
>> use an entirely different format after opcode and flags, although
>> I suspect fd would be nice to have in the same spot as well.
> 
> Exactly - trying to think of how best to do this. It's somewhat a shame
> that I didn't place user_data right after fd, or even at the end of the
> struct. But oh well.
> 
> One idea would be to have io_uring_sqe_hdr and have that be
> op/flags/prio/fd as we should have those for anything, and just embed
> that at the top of both io_uring_sqe (our general command), and
> io_uring_whatever which is what the passthrough stuff would use.
> 
> Not sure, I need to dabble in the code a bit and see how we can make it
> the cleanest.

How about something like the top two patches here to kick it off, then
build on top?

https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops.v4

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
