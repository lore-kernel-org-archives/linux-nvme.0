Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D80C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 18:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wokerGmckRYYAuG7vnvwFGdqzKxOeMPs8itH9toPUxU=; b=iv9V1oCTVq8UJl7uQA9VhQVDEo
	jyCGlqbFIuU4cqHJ633rVjI4fpJRhpQWWKd18UfPkpBYB/f9cb4ZqK3vXmoCWPOkK17b5oNLTOALm
	/gtB7d3aRq13bFEEsSDI70eGjZP+Ps8BShD2ab3lrOWMbIYFLtzal94r3RYKN3a/G0XDcij9S7l1T
	FVRcwGb94eiIT2shIBcd07Ga3O6CI8NUCL1apHI9G+wjquotmm8iGdbGXWN160qFmf62u/DnxKfWg
	0W7dS5XfW65SOj1hzWV0FvSklLPOQYGhW0pvJ8LBAMvBFLQp0rTCgWf4Uwbizee7eoq0LqptmCR7T
	w8QdndJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngsf4-005hue-Kd; Tue, 19 Apr 2022 18:33:14 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngsRO-005bEh-Qy
 for linux-nvme@lists.infradead.org; Tue, 19 Apr 2022 18:19:08 +0000
Received: by mail-il1-x129.google.com with SMTP id y16so11066343ilc.7
 for <linux-nvme@lists.infradead.org>; Tue, 19 Apr 2022 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=wokerGmckRYYAuG7vnvwFGdqzKxOeMPs8itH9toPUxU=;
 b=5AkJjFoLG48rzJfkn9rUwXkrViq/pEHLu/h2dyriVkRddxacAw04AnV751XlATXYOV
 rrQTK0efnIZxBekjz9efpA8deIP2/EV5wUdDYTszpehfFohq/LAqKJJHBklKgM3gcPGk
 zArXxopunBkFaC4RWFJmQILQggYpyVNyhgRa18K4p7UmSeHs+53NOMTqXZiGf0R4Azxm
 D4l9hWJDkk7e+3YfkDz9m4TxKyQ+vCCzYxmH9sWCfl2s0+5oY/9wGbxb3fHRHUNCX9d2
 bUziMkCj/WTpLK2YfXmZY6dDZSRRPnbFo6WFxOvIOCckVGqTRj7G7e4S2h2jvzAbzP+B
 pAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=wokerGmckRYYAuG7vnvwFGdqzKxOeMPs8itH9toPUxU=;
 b=XJ2u5OMpAQMv2f4V1+bQHui6DRvYa+yxk8DMclPiUNHwx9DP7Bih2dqoV2UTK2OMC2
 TEH92ILTX5GeDpPhITL6qEe2mJXLUtAuJzIdzdVcr9RYI41k5oiJlq6AhT/ZcT5LHr0c
 ZllfOL8MpKvdxNZViHGx20PMOuRhuqf7f44sfR5yHRIxpPeiKIY6R8S8+G2YIzz4tyrs
 RWrjLhnEWbAMKc1BJTZwBrglJYUrTxjTqDzGv5sqCWoWUZpOmdCbYCQqXqkDy1cfTyeL
 UrLg2CkefxyHqwL+QHtZkbtwirGU0fwkqGM4s9Y/ANiw41YfCTbQH+DnAVoYLpqp14In
 r8tw==
X-Gm-Message-State: AOAM533eQ/RldQb/ai6VaPGEWZkIEtJQGy/ktEgcFisUacv9vMQRQ/uK
 5MBuP9tN06qr9VbVKSfL7z91iQ==
X-Google-Smtp-Source: ABdhPJwkDanwvNiImGwk18e3bS6pqNiYmqfNcUDzvNso7qtDM5g7c1/buvdEr7oCYUwpJW5k8RTCww==
X-Received: by 2002:a92:c561:0:b0:2cb:d912:bc83 with SMTP id
 b1-20020a92c561000000b002cbd912bc83mr7308075ilj.81.1650392343046; 
 Tue, 19 Apr 2022 11:19:03 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a5d85d2000000b00649254a855fsm9592310ios.26.2022.04.19.11.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Apr 2022 11:19:02 -0700 (PDT)
Message-ID: <586ec702-fcaa-f12c-1752-bf262242a751@kernel.dk>
Date: Tue, 19 Apr 2022 12:19:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
 <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
 <20220324063218.GC12660@lst.de> <20220325133921.GA13818@test-zns>
 <20220330130219.GB1938@lst.de>
 <CA+1E3r+Z9UyiNjmb-DzOpNrcbCO_nNFYUD5L5xJJCisx_D=wPQ@mail.gmail.com>
 <a44e38d6-54b4-0d17-c274-b7d46f60a0cf@kernel.dk>
 <CA+1E3r+CSC6jaDBXpxQUDnk8G=RuQaa=DPJ=tt9O9qydH5B9SQ@mail.gmail.com>
 <f3923d64-4f84-143b-cce2-fcf8366da0e6@kernel.dk>
 <CA+1E3rJHgEan2yiVS882XouHgKNP4Rn6G2LrXyFu-0kgyu27=Q@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3rJHgEan2yiVS882XouHgKNP4Rn6G2LrXyFu-0kgyu27=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_111907_131391_2A72448E 
X-CRM114-Status: GOOD (  18.97  )
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

On 4/19/22 11:31 AM, Kanchan Joshi wrote:
> Hi Jens,
> Few thoughts below toward the next version -
> 
> On Fri, Apr 1, 2022 at 8:14 AM Jens Axboe <axboe@kernel.dk> wrote:
> [snip]
>>>>> Sure, will post the code with bigger-cqe first.
>>>>
>>>> I can add the support, should be pretty trivial. And do the liburing
>>>> side as well, so we have a sane base.
>>>
>>>  I will post the big-cqe based work today. It works with fio.
>>>  It does not deal with liburing (which seems tricky), but hopefully it
>>> can help us move forward anyway .
>>
>> Let's compare then, since I just did the support too :-)
> 
> Major difference is generic support (rather than uring-cmd only) and
> not touching the regular completion path. So plan is to use your patch
> for the next version with some bits added (e.g. overflow-handling and
> avoiding extra CQE tail increment). Hope that sounds fine.

I'll sanitize my branch today or tomorrow, it has overflow and proper cq
ring management now, just hasn't been posted yet. So it should be
complete.

> We have things working on top of your current branch
> "io_uring-big-sqe". Since SQE now has 8 bytes of free space (post
> xattr merge) and CQE infra is different (post cqe-caching in ctx) -
> things needed to be done a bit differently. But all this is now tested
> better with liburing support/util (plan is to post that too).

Just still grab the 16 bytes, we don't care about addr3 for passthrough.
Should be no changes required there.

-- 
Jens Axboe


