Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E1AC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 01:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JqzlBlmuscHVnNnPYh/b4FXO/hWZSCec4wgmjvC92Jo=; b=V0HyT/KqKaAzOVJOa0e7l54wx/
	jSFD8uu9C0z0XouhSp3rezpvRLiCp1TFguSVM/kuuy+jND1qauuyUOb6CpTVSgs22FNBKzPFsQgoF
	OX2B5hTQsRjiSphp0Q10bAQkdJzKr+djY9anqomlCTn68i5mjvQor4HJkGM1S2O1MEc5+/EsdQu/S
	bAZ0cD3iBmmXdyviKiRdV5Yo/lXc5P038FDrYJzjwrr3bk8w8zlGkctF68E9LILJoEZp1Bek25XYm
	4f+qrWRnXxj1z6w8D2pbKkwd2Zcela6WRsxnTEmsAJm/qD7/ftfarLB3rclLXx1y7IXqMHpfU5OfO
	G7863g5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1na5zv-0049St-Bw; Fri, 01 Apr 2022 01:22:43 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1na5zr-0049Qv-M2
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 01:22:41 +0000
Received: by mail-pj1-x1034.google.com with SMTP id
 h23-20020a17090a051700b001c9c1dd3acbso1088529pjh.3
 for <linux-nvme@lists.infradead.org>; Thu, 31 Mar 2022 18:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=JqzlBlmuscHVnNnPYh/b4FXO/hWZSCec4wgmjvC92Jo=;
 b=RVEsEQROdKrOtmuldgRa/PvAwe+jXLwDuENO6CLXw/FiINEJ2W3a0yi0925jx/MLia
 4RQiMO0g09YbbYmNnKMEqiiIA3fgP4bxLn2aCN8W/+gZANXPCAO64tzDgahR17mX/FPC
 8deLSNbM1nINSB9O+Zt3W8QmiEMN+WPmndJe7BYCuL2wMiOOzuN8AuV5gZJZKcr+vaCM
 Sf0UuNxnbI891NPM5xo1i4N4sVk8KAECSNaO9rKpQI4uvt2MJrzFA3ghdNh3ARmXwiiR
 24V0782Tbleh3JOkq6yUsnpH9gZoCjRZsyQGK5hWY77UAxGHyhEPMTaAaeBAwMke3ST/
 8xuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JqzlBlmuscHVnNnPYh/b4FXO/hWZSCec4wgmjvC92Jo=;
 b=IJZWzmGu16+0noGWg4AGoNgX3ParvSZM0N0IkS2MPCFnvSo8iAcvbBCdrqGIhzWW6J
 Vjecv7l5NCaOkKyksWt8J8bxh5tL4jko/rF8DJeKm0ylLRuxQ1cxL/IS5Du9ZqErPifj
 Bq7MAarUCavsgDYypV0jN7vl6c9qzN89VKJM8+2QAwChZ7k7mwTM9YV6z7VjJsKPp3t/
 5XJxcb64YtV7cbYmlt4gqe0XH8j5H9nJer23BEA3ithFWzlm6Stae+yl4fkfGGm9JCkM
 35Tso2uz8/8Ig7Lf5nmzmjMsU49Vv0qb8rGZgYTVzX6aqSTbQDnNXX6FsXP8qdpMznf0
 +3lw==
X-Gm-Message-State: AOAM5304yFniE1+MN9jEnHCC2y7MRyIeLDjhPeU6KBu2Bm4W4i5ef0MT
 KlSHhvaVBEYffwe4FAlzBkxOnCMQ7W3oH42Y
X-Google-Smtp-Source: ABdhPJwoohPEsfOaUYXtn0uGcWPKVWgHksrPhLg73D4Ij9RANYSEV1jYZJzcq4SC73s2yoUDnieM0Q==
X-Received: by 2002:a17:902:6845:b0:153:9af1:3134 with SMTP id
 f5-20020a170902684500b001539af13134mr44235505pln.169.1648776156095; 
 Thu, 31 Mar 2022 18:22:36 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a17090a02d700b001bf6ef9daafsm530640pjd.38.2022.03.31.18.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Mar 2022 18:22:35 -0700 (PDT)
Message-ID: <910afdf8-ec01-90b2-b7ec-a7644e53259e@kernel.dk>
Date: Thu, 31 Mar 2022 19:22:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav
 <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
 <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220331_182239_747267_A113D55F 
X-CRM114-Status: GOOD (  21.42  )
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

On 3/22/22 11:10 AM, Kanchan Joshi wrote:
>> We need to decouple the
>> uring cmd properly.  And properly in this case means not to add a
>> result pointer, but to drop the result from the _input_ structure
>> entirely, and instead optionally support a larger CQ entry that contains
>> it, just like the first patch does for the SQ.
> 
> Creating a large CQE was my thought too. Gave that another stab.
> Dealing with two types of CQE felt nasty to fit in liburing's api-set
> (which is cqe-heavy).
> 
> Jens: Do you already have thoughts (go/no-go) for this route?

Yes, I think we should just add support for 32-byte CQEs as well. Only
pondering I've done here is if it makes sense to manage them separately,
or if you should just get both big sqe and cqe support in one setting.
For passthrough, you'd want both. But eg for zoned writes, you can make
do with a normal sized sqes and only do larger cqes.

I did actually benchmark big sqes in peak testing, and found them to
perform about the same, no noticeable difference. Which does make sense,
as normal IO with big sqe would only touch the normal sized sqe and
leave the other one unwritten and unread. Since they are cacheline
sized, there's no extra load there.

For big cqes, that's a bit different and I'd expect a bit of a
performance hit for that. We can currently fit 4 of them into a
cacheline, with the change it'd be 2. The same number of ops/sec would
hence touch twice as many cachelines for completions.

But I still think it's way better than having to copy back part of the
completion info out-of-band vs just doing it inline, and it's more
efficient too for that case for sure.

> From all that we discussed, maybe the path forward could be this:
> - inline-cmd/big-sqe is useful if paired with big-cqe. Drop big-sqe
> for now if we cannot go the big-cqe route.

We should go big cqe for sure, it'll help clean up a bunch of things
too.

-- 
Jens Axboe


