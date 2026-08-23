Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC99C5DF81
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQiELkebPQsa4teNGioOnmp2bdecpMGlUV1ID9pf4MQ=; b=YQFtJ3mBvU8szsF9sRfOinBUd+
	mILt6d5fcB/vq+ks7iLgfkD4yUoKIty7c2wPM9jAlvi24FxAUQqH07Ut45BgK0+U6CkpTCwPrGGjp
	kWuYHKyf5rSydEWK83IrhEG+kFK6rnhjsmFsy1A48qyO/4qYeKISzFhXHDZoOCGmGioQ81/+0wbi7
	AUj6i7q24cXvRZGlgYoX871cXc/j6j8TndpC3f5VHTDrXPlQL3oUvtOK6CaYrPbfHfimYzvsKMeoS
	/17LH9b++eDl4j2xNJiE/hqqNy5RmMs6ih9ZgjEqSMuzlWbakAMJI6EgTang87SrsPN35Oe6cfokY
	BEikrYIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy4Pl-0000000FDII-3N5u;
	Sun, 23 Aug 2026 09:22:53 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy4Pj-0000000FDHl-3gft
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 09:22:52 +0000
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso5805810a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 02:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787476970; x=1788081770;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQiELkebPQsa4teNGioOnmp2bdecpMGlUV1ID9pf4MQ=;
        b=LKOOmkfTky2hYKLJq7gxf1H4QNJuTqgouVlk2cMZ2IsoabWSqZ/XXayZKvm9SaAqNC
         1NRS7W0mf615Cz9NxNZOaT2c/VbPpaLmTmgOLfJEWpaL91de2Ok0hldqpR8hGSYNr1PN
         FInRkGI5cMpPzt5SCMejjblrx2tU+Q7TTtn6/eLmmufQaB1UUBIYrcfXnVivQLaTHT0w
         4GQ5u/9S5l8xWr2ckOd/dKaRni52x0P1HOEFrurEDEew0g4STRDLqnoQyG2eJ8BqZz8u
         O8ZrUoVksourOfvL/im5edkN87s4Kn5JgiB4sLX0+xDo2VOdZAJ2m0w8jJOJhDG5pGAf
         YXqw==
X-Forwarded-Encrypted: i=1; AHgh+RpuV1DbsDtE4J5849xfyNhgsyyfAaAV35/vRY2Q1seFpBnynA/07eAwK3NiHV/LeS/zOdSaMa8F8XLA@lists.infradead.org
X-Gm-Message-State: AFuF++kSB9wnMw1MPH0wLsEGPFUoA+N423WN4LOG7PY9GJlzpq98m+OW
	sPaa1F/fGTZmzBRhjpoRcwJsFztT1NPK6wzfBGTk/0bIcNzUMZuINrG0
X-Gm-Gg: AR+sD13leOJrIBy8YtUCvbG4b7Hfj0k3yn6sEW7UL1gjT+uzKykwRShU/FJJAXK2bLt
	nu3RGKYKsgSRwkl1FukdtFNSO4SyUjJVxQsyy9lznViWqVgB5sUhidU6hlKeygKCgunsLvmhjcY
	6Z+X9atQ52MSGqUvw91BXM8OiFuAJvIgejbOFXhm5nXS6nMm/bDOT/W7kUv3whgi6MJhox6Nqke
	aw6LaAmGhwlS/RoUuDvDxafqngdqNExjkYTAHJJTvt3xjJHogl/7YW6lFBocoOkeEzRCPc7l0RK
	O5jh3KLBcV719eann4oXssMmaxs3HedJcE73pNMxgtXaH9l3wy170fCTNrL/y3xNFHvsDMTwBeB
	haRzTqHkCLlzg71fYqItLVJLud89pphDLNI/A217EgInKxPsNqv2RrY5D+qGu75IyM2OPs4x7w6
	wO8pHsMzupQH4i+uh0A2fsnfa/SefDFK1aalkafcopzOPaX4uEuUKvfteYpCksMiVyiQ5qJpW1m
	oCfAQqf+0TurBKAf+9j/+zYwR4V3g==
X-Received: by 2002:a17:907:a606:b0:c20:7166:cc16 with SMTP id a640c23a62f3a-c244d86531amr2601546266b.15.1787476969598;
        Sun, 23 Aug 2026 02:22:49 -0700 (PDT)
Received: from [10.50.4.207] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1aeab9sm2629558a12.22.2026.08.23.02.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 02:22:48 -0700 (PDT)
Message-ID: <cc507305-faa6-44ff-b830-72b8de023a8c@grimberg.me>
Date: Sun, 23 Aug 2026 12:22:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/5] block: validate bio bounds in the queue entered
 context
To: Keith Busch <kbusch@kernel.org>, Chris S <coshi036@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 tom.leiming@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org,
 Weidong Zhu <weizhu@fiu.edu>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-4-kbusch@meta.com>
 <CACd_6n2jNS9Msd_N-idPx3ijgN8NUxT1U1m2OrJu=e+GToB+ZA@mail.gmail.com>
 <anpBQXfo7eGNU2-v@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <anpBQXfo7eGNU2-v@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_022251_928841_A53DFA2F 
X-CRM114-Status: GOOD (  14.31  )
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



On 11/08/2026 0:23, Keith Busch wrote:
> On Mon, Aug 10, 2026 at 05:12:45PM -0400, Chris S wrote:
>> Keith, I checked this patch against the nvme_setup_rw() WARN I reported
>> (the second link in your cover letter).  __bio_split_to_limits() is
>> called from blk_mq_submit_bio() after bio_queue_enter(), on both the
>> cached-request path and the newly-allocated-request path, so the bounds
>> check is now serialized against the freeze window in
>> nvme_update_ns_info_block().  With the capacity forced to 0, the bio is
>> failed here and can no longer reach nvme_queue_rq(), which is exactly
>> the race I hit.  Thanks for picking it up, and sorry for the slow reply.
>>
>> I'll drop my own "nvme: don't WARN on I/O to a namespace revalidated to
>> unusable metadata" patch in favour of this.
> I'll need to revisit this approach as it is dependent on something in
> the stack calling the split to limits functions, as well as the upper
> layers error handling for a catching the end-of-device condition later
> than before.
>

Perhaps moving it into __bio_queue_enter would be appropriate... It already
does disk state check. Perhaps introduce bio_post_enter_checks() for checks
that need to serialize against queue enter?



